const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { FEEDS } = require('./supplier_profiles.js');

const DRY_RUN = process.argv.includes('--dry-run');
const REJECTION_THRESHOLD_PERCENT = 20;

const SUPPLIERS_DB_MAPPING = {
  'EMS': 1,
  'NEW_XS': 2,
  'RA': 3,
  'AGS': 4,
  'XS': 5,
  'INDUS': 6
};

function normalizeSearchMpn(mpn) {
  if (!mpn) return '';
  return String(mpn).toUpperCase().replace(/[\W_]+/g, '');
}

function parseQuantity(rawQty) {
  if (rawQty === null || rawQty === undefined) return null;
  const str = String(rawQty).trim();
  const num = parseInt(str.replace(/[^0-9]/g, ''), 10);
  return isNaN(num) ? null : num;
}

function parseDateCode(rawDc) {
  if (!rawDc) return null;
  const str = String(rawDc).trim().toUpperCase();
  if (str === 'N/A' || str === '' || str === 'NONE') return null;
  if (str.includes('MIXED') || str.includes('MIX')) return 'Mixed';
  const plusMatch = str.match(/^(?:20)?([0-9]{2})\+$/);
  if (plusMatch) return plusMatch[1] + '+';
  return null;
}

// Safely normalize headers for matching ONLY
function normalizeHeader(str) {
  if (!str) return '';
  return String(str).trim().toLowerCase();
}

async function runImport() {
  const dataDir = path.join(__dirname, '../');
  const filesInDir = fs.readdirSync(dataDir);
  
  let importResults = [];
  let sqlStatements = [];
  let currentImportId = Date.now();

  for (const file of filesInDir) {
    if (!file.match(/\.(xls|xlsx|csv)$/i)) continue;

    console.log(`\nAnalyzing file: ${file}`);
    const filePath = path.join(dataDir, file);
    const workbook = XLSX.readFile(filePath);

    // Find matching feeds for this file
    const matchedFeeds = FEEDS.filter(f => f.filename_pattern.test(file));
    if (matchedFeeds.length === 0) {
      console.log(`  No feed profile matched filename. Skipping.`);
      continue;
    }

    for (const feed of matchedFeeds) {
      console.log(`  -> Feed profile matched: ${feed.feed_code}`);
      
      let sheetName;
      if (feed.sheet_name_pattern) {
        sheetName = workbook.SheetNames.find(sn => feed.sheet_name_pattern.test(sn));
      } else {
        sheetName = workbook.SheetNames[feed.sheet_index || 0];
      }

      if (!sheetName) {
        console.log(`  -> Sheet not found for feed ${feed.feed_code}. Skipping.`);
        continue;
      }

      const sheet = workbook.Sheets[sheetName];
      const rowsRaw = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
      
      if (rowsRaw.length <= feed.header_row) {
        console.log(`  -> Not enough rows to reach header_row ${feed.header_row}.`);
        continue;
      }

      // Map headers safely
      const headerRow = rowsRaw[feed.header_row].map(normalizeHeader);
      
      // Build index map
      const colIndexMap = {};
      for (const [key, expectedName] of Object.entries(feed.mapping)) {
        const normExpected = normalizeHeader(expectedName);
        const idx = headerRow.indexOf(normExpected);
        if (idx !== -1) colIndexMap[key] = idx;
      }

      if (!('mpn' in colIndexMap)) {
        console.log(`  -> Required column MPN (${feed.mapping.mpn}) not found in headers. (headerRow was: ${headerRow})`);
        continue;
      }

      if (feed.feed_type === 'INVENTORY' && !('quantity' in colIndexMap)) {
        console.log(`  -> Required column Qty (${feed.mapping.quantity}) not found in headers. Skipping feed.`);
        continue;
      }

      const dataRows = rowsRaw.slice(feed.header_row + 1);
      
      let rowsTotal = dataRows.length;
      let rowsImported = 0;
      let rowsRejected = 0;
      
      const supplierId = SUPPLIERS_DB_MAPPING[feed.supplier_code];
      const importId = currentImportId++;

      if (feed.feed_type === 'CROSS_REFERENCE') {
        console.log(`  -> [ANALYSIS] CROSS_REFERENCE feed detected. Persistence is deferred (Phase 2.7 logic). Validated ${rowsTotal} rows. Skipping D1 generation.`);
        continue; // Option B: Defer persistence
      }

      if (!DRY_RUN) {
        // Stage Import
        sqlStatements.push(`INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (${importId}, ${supplierId}, '${file.replace(/'/g, "''")}', ${rowsTotal}, 'STAGED');`);
      }

      const duplicateCheck = new Set();

      for (const row of dataRows) {
        const rawMpn = row[colIndexMap.mpn];
        if (!rawMpn || String(rawMpn).trim() === '') {
          rowsRejected++;
          continue;
        }

        const rawQty = row[colIndexMap.quantity];
        const quantityParsed = parseQuantity(rawQty);
        
        if (quantityParsed === null || quantityParsed <= 0) {
          rowsRejected++;
          continue;
        }

        const mpnOriginal = String(rawMpn).trim();
        const mpnSafe = mpnOriginal.replace(/'/g, "''");
        const mpnSearchNormalized = normalizeSearchMpn(mpnOriginal);

        const dupKey = mpnSearchNormalized;
        if (duplicateCheck.has(dupKey)) {
           // Allow multiple lines for the same MPN (different conditions/batches)
           // Do not reject.
        }
        duplicateCheck.add(dupKey);

        let rawMfr = colIndexMap.manufacturer !== undefined ? row[colIndexMap.manufacturer] : 'Unknown';
        if (!rawMfr) rawMfr = 'Unknown';
        const mfrSafe = String(rawMfr).trim().replace(/'/g, "''");

        let rawDesc = colIndexMap.description !== undefined ? row[colIndexMap.description] : '';
        const descSafe = rawDesc ? `'${String(rawDesc).trim().replace(/'/g, "''")}'` : 'NULL';

        let rawDc = colIndexMap.date_code !== undefined ? row[colIndexMap.date_code] : '';
        const dateCodeNormalized = parseDateCode(rawDc);
        const dcSafe = dateCodeNormalized ? `'${dateCodeNormalized.replace(/'/g, "''")}'` : 'NULL';

        if (!DRY_RUN) {
          sqlStatements.push(`INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('${mfrSafe}');`);
          sqlStatements.push(`INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
            SELECT id, '${mpnSafe}', '${mpnSearchNormalized}', ${descSafe} FROM manufacturers WHERE canonical_name = '${mfrSafe}';`);
          
          // Insert STAGED inventory (is_active = 0)
          sqlStatements.push(`INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id, is_active)
            SELECT p.id, ${supplierId}, ${quantityParsed}, ${dcSafe}, '${feed.default_availability}', 'IMPORTED', ${importId}, 0
            FROM parts p 
            JOIN manufacturers m ON p.manufacturer_id = m.id
            WHERE p.mpn_search_normalized = '${mpnSearchNormalized}' AND m.canonical_name = '${mfrSafe}';`);
        }
        
        rowsImported++;
      }

      const rejectRatio = (rowsRejected / rowsTotal) * 100;
      console.log(`  -> Validation: ${rowsImported} imported, ${rowsRejected} rejected (${rejectRatio.toFixed(1)}%).`);

      if (rejectRatio > REJECTION_THRESHOLD_PERCENT && rowsTotal > 10) {
        console.log(`  [!] WARNING: Rejection threshold exceeded (> ${REJECTION_THRESHOLD_PERCENT}%). REQUIRES REVIEW. Snapshot will NOT be activated.`);
        if (!DRY_RUN) {
          sqlStatements.push(`UPDATE inventory_imports SET status = 'FAILED', rows_imported = ${rowsImported}, rows_rejected = ${rowsRejected}, import_completed_at = CURRENT_TIMESTAMP WHERE id = ${importId};`);
        }
      } else {
        if (!DRY_RUN) {
          // Atomic Activation Sequence
          // 1. Deactivate older snapshots for this supplier
          sqlStatements.push(`UPDATE inventory SET is_active = 0 WHERE supplier_id = ${supplierId} AND import_id != ${importId};`);
          // 2. Mark old imports as superseded
          sqlStatements.push(`UPDATE inventory_imports SET status = 'SUPERSEDED' WHERE supplier_id = ${supplierId} AND id != ${importId} AND status = 'ACTIVE';`);
          // 3. Activate new inventory
          sqlStatements.push(`UPDATE inventory SET is_active = 1 WHERE import_id = ${importId};`);
          // 4. Mark this import as ACTIVE
          sqlStatements.push(`UPDATE inventory_imports SET status = 'ACTIVE', rows_imported = ${rowsImported}, rows_rejected = ${rowsRejected}, import_completed_at = CURRENT_TIMESTAMP WHERE id = ${importId};`);
        }
      }

      importResults.push({
        supplier: feed.supplier_code,
        feed: feed.feed_code,
        rowsTotal,
        rowsImported,
        rowsRejected,
        status: (rejectRatio > REJECTION_THRESHOLD_PERCENT && rowsTotal > 10) ? 'REQUIRES REVIEW' : 'SUCCESS'
      });
    }
  }

  console.table(importResults);

  if (DRY_RUN) {
    console.log(`\n[DRY RUN] Generated ${sqlStatements.length} SQL statements. NOT EXECUTED.`);
    return;
  }

  if (sqlStatements.length > 0) {
    const sqlFilePath = path.join(__dirname, 'import.sql');
    fs.writeFileSync(sqlFilePath, sqlStatements.join('\n'));
    console.log(`\nGenerated ${sqlStatements.length} SQL statements in import.sql`);
    console.log("Executing via Wrangler D1...");
    const { execSync } = require('child_process');
    try {
      const output = execSync('npx.cmd wrangler d1 execute legacy-micro-inventory-staging --file=tools/import.sql --remote', { cwd: dataDir, stdio: 'pipe' });
      console.log(output.toString());
    } catch (err) {
      console.error("Wrangler execution failed:", err.message);
      if (err.stdout) console.error(err.stdout.toString());
      if (err.stderr) console.error(err.stderr.toString());
    }
  } else {
    console.log("\nNo SQL statements generated.");
  }
}

runImport().catch(console.error);
