const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

// Configuration for local testing
const DB_PATH = path.join(__dirname, '../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/db.sqlite');
// Note: In a real Cloudflare environment, this script would generate a .sql file 
// to be executed via `wrangler d1 execute` or it would use `better-sqlite3` locally.
// For this Phase 2 architecture, we are producing the structural logic.

const SUPPLIERS = {
  'EMS Fabienne.xls': { id: 1, internal_code: 'EMS' },
  'New XS_EU OEM_low prices.xlsx': { id: 2, internal_code: 'NEW_XS' },
  'RA Componenets latest.xlsx': { id: 3, internal_code: 'RA' },
  'STOCK_AGS200226.xlsx': { id: 4, internal_code: 'AGS' },
  'XS_03.26.26.xlsx': { id: 5, internal_code: 'XS' }
};

// 1. Identify Supplier & 2. Load Mapping
function getSupplierConfig(filename) {
  const supplier = SUPPLIERS[filename];
  if (!supplier) throw new Error(`Unknown supplier file: ${filename}`);

  // Hardcoded mappings for Phase 2 validation
  const mappings = {
    'NEW_XS': { mpn: 'MPN', mfr: 'Manufacturer', desc: 'Description', qty: 'Qty', dc: 'DC' },
    'RA': { mpn: 'PART NUMBER', mfr: 'MAKE', desc: 'ITEM DESCRIPTION', qty: 'Stock Qty', dc: null },
    'AGS': { mpn: 'CF.CPU DC#', mfr: 'CF.Brand Name#', desc: 'Description', qty: 'Stock On Hand', dc: 'CF.Year#' },
    'XS': { mpn: 'MPN', mfr: 'Manufacturer', desc: 'Description', qty: 'Qty', dc: 'DC' },
    'EMS': { mpn: 'Part Number', mfr: 'Manufacturer', desc: 'Description', qty: 'Quantity', dc: 'Date Code' } // Assumed mapping for EMS
  };

  return { supplier, mapping: mappings[supplier.internal_code] };
}

// 7. Generate search-normalized MPN
function normalizeSearchMpn(mpn) {
  if (!mpn) return '';
  return String(mpn).toUpperCase().replace(/[\W_]+/g, '');
}

// 8. Parse Quantity (Conservative)
function parseQuantity(rawQty) {
  if (rawQty === null || rawQty === undefined) return null;
  const str = String(rawQty).trim();
  const num = parseInt(str.replace(/[^0-9]/g, ''), 10);
  return isNaN(num) ? null : num;
}

// 9. Parse Date Code (Conservative for Semiconductors)
function parseDateCode(rawDc) {
  if (!rawDc) return null;
  const str = String(rawDc).trim().toUpperCase();
  
  if (str === 'N/A' || str === '' || str === 'NONE') return null;
  if (str.includes('MIXED') || str.includes('MIX')) return 'Mixed';
  
  // Explicit year with '+' (e.g. 21+, 2021+)
  const plusMatch = str.match(/^(?:20)?([0-9]{2})\+$/);
  if (plusMatch) return plusMatch[1] + '+';
  
  // 4-digit codes (e.g., 2334, 2033) are highly ambiguous in electronics.
  // Could be YYWW (Year 23, Week 34) or YYYY (Year 2033).
  // Safest action: preserve raw, normalize to NULL.
  return null;
}

// Main Importer Function
async function importInventory() {
  const dataDir = path.join(__dirname, '../');
  const files = Object.keys(SUPPLIERS);
  
  let importResults = [];
  let sqlStatements = [];
  let currentImportId = Date.now(); // Simple unique ID for this import run

  for (const file of files) {
    const filePath = path.join(dataDir, file);
    if (!fs.existsSync(filePath)) {
      console.warn(`File not found: ${filePath}`);
      continue;
    }

    console.log(`Processing: ${file}`);
    const { supplier, mapping } = getSupplierConfig(file);
    
    // 3. Parse spreadsheet
    const workbook = XLSX.readFile(filePath);
    const sheetName = workbook.SheetNames[0];
    const rows = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName], { defval: null });

    let rowsTotal = rows.length;
    let rowsImported = 0;
    let rowsRejected = 0;
    
    // Log import start
    sqlStatements.push(`INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (${currentImportId}, ${supplier.id}, '${file}', ${rowsTotal}, 'IN_PROGRESS');`);

    for (const row of rows) {
      // 4. Validate required columns
      const rawMpn = row[mapping.mpn];
      if (!rawMpn) {
        rowsRejected++;
        continue;
      }

      // 5. Normalize Manufacturer
      let rawMfr = mapping.mfr ? row[mapping.mfr] : 'Unknown';
      if (!rawMfr) rawMfr = 'Unknown';
      const mfrCanonical = String(rawMfr).trim(); 
      // Safely escape quotes
      const mfrSafe = mfrCanonical.replace(/'/g, "''");

      // 6. Preserve original MPN and Canonical Safety
      const mpnOriginal = String(rawMpn).trim();
      const mpnSafe = mpnOriginal.replace(/'/g, "''");
      
      // 7. Generate search-normalized MPN
      const mpnSearchNormalized = normalizeSearchMpn(mpnOriginal);

      // 8. Parse quantity
      const rawQty = row[mapping.qty];
      const quantityParsed = parseQuantity(rawQty);
      
      if (quantityParsed === null || quantityParsed <= 0) {
        rowsRejected++;
        continue;
      }

      // 9. Parse Date Code
      const rawDc = mapping.dc ? row[mapping.dc] : null;
      const dateCodeNormalized = parseDateCode(rawDc);
      const dcSafe = dateCodeNormalized ? `'${dateCodeNormalized.replace(/'/g, "''")}'` : 'NULL';

      const descSafe = row[mapping.desc] ? `'${String(row[mapping.desc]).trim().replace(/'/g, "''")}'` : 'NULL';

      // 11. Generate SQL for Manufacturer (UPSERT pattern via INSERT IGNORE / ON CONFLICT)
      // SQLite syntax for upsert:
      sqlStatements.push(`INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('${mfrSafe}');`);
      
      // 12. Generate SQL for Part
      sqlStatements.push(`INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, '${mpnSafe}', '${mpnSearchNormalized}', ${descSafe} FROM manufacturers WHERE canonical_name = '${mfrSafe}';`);

      // 13. Generate SQL for Inventory
      sqlStatements.push(`INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, ${supplier.id}, ${quantityParsed}, ${dcSafe}, 'NETWORK_AVAILABLE', 'IMPORTED', ${currentImportId}
        FROM parts p WHERE p.mpn_original = '${mpnSafe}';`);

      rowsImported++;
    }

    // Update import status
    sqlStatements.push(`UPDATE inventory_imports SET rows_imported = ${rowsImported}, rows_rejected = ${rowsRejected}, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = ${currentImportId};`);
    currentImportId++;

    importResults.push({
      supplier: supplier.internal_code,
      filename: file,
      rowsTotal,
      rowsImported,
      rowsRejected,
      status: 'SUCCESS'
    });
  }

  // Write SQL to file
  const sqlFilePath = path.join(__dirname, 'import.sql');
  fs.writeFileSync(sqlFilePath, sqlStatements.join('\n'));
  console.log(`Generated ${sqlStatements.length} SQL statements in import.sql`);

  // Execute via Wrangler
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

  console.table(importResults);
  return importResults;
}

if (require.main === module) {
  importInventory().catch(console.error);
}

module.exports = { importInventory };
