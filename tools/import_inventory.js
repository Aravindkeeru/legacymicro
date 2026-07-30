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

// 9. Parse Date Code (Conservative)
function parseDateCode(rawDc) {
  if (!rawDc) return null;
  const str = String(rawDc).trim();
  const regex = /\b(1[0-9]|2[0-9])([0-5][0-9])\b/g;
  let matches;
  let maxYear = -1;
  while ((matches = regex.exec(str)) !== null) {
    const yy = parseInt(matches[1], 10);
    if (yy > maxYear) maxYear = yy;
  }
  if (maxYear !== -1) return maxYear + '+';
  if (str.length < 15) return str; // Pass through clean short strings
  return null; // Flag as requiring review
}

// Main Importer Function
async function importInventory() {
  const dataDir = path.join(__dirname, '../');
  const files = Object.keys(SUPPLIERS);
  
  let importResults = [];

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

    for (const row of rows) {
      // 4. Validate required columns
      const rawMpn = row[mapping.mpn];
      if (!rawMpn) {
        rowsRejected++;
        continue;
      }

      // 5. Normalize Manufacturer (mocking DB lookup)
      let rawMfr = mapping.mfr ? row[mapping.mfr] : 'Unknown';
      if (!rawMfr) rawMfr = 'Unknown';
      const mfrCanonical = String(rawMfr).trim(); // Basic for now

      // 6. Preserve original MPN
      const mpnOriginal = String(rawMpn).trim();
      
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

      // 10. Pricing is parsed internally (but not exposed publicly)
      
      // 11/12. Validate & Insert (Simulated DB Insertion)
      rowsImported++;
    }

    // 13. Record import result
    importResults.push({
      supplier: supplier.internal_code,
      filename: file,
      rowsTotal,
      rowsImported,
      rowsRejected,
      status: 'SUCCESS'
    });
  }

  console.table(importResults);
  return importResults;
}

if (require.main === module) {
  importInventory().catch(console.error);
}

module.exports = { importInventory };
