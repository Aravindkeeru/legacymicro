const { execSync } = require('child_process');
const xlsx = require('xlsx');

// 1. Get all INDUS active inventory rows from D1
console.log("Fetching active INDUS inventory from D1...");
const d1Output = execSync('npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="SELECT p.mpn_original, m.canonical_name, i.quantity_parsed FROM inventory i JOIN parts p ON i.part_id = p.id JOIN manufacturers m ON p.manufacturer_id = m.id WHERE i.supplier_id = (SELECT id FROM suppliers WHERE internal_code = \'INDUS\') AND i.is_active = 1" --json --remote', { maxBuffer: 10 * 1024 * 1024 }).toString();

let d1Rows;
try {
  d1Rows = JSON.parse(d1Output)[0].results;
} catch (e) {
  console.log("Failed to parse D1 JSON:", e.message);
  process.exit(1);
}
console.log(`D1 has ${d1Rows.length} active INDUS records.`);

// Build a map of D1 records to count occurrences
const d1Map = new Map();
for (const row of d1Rows) {
  // Use a composite key just like import_inventory does: mpnOriginal + mfrCanonical + qty
  // Wait, quantity_parsed might not be unique, let's just count MPN + MFR
  const mpnSafe = String(row.mpn_original || '').trim();
  const mfrSafe = String(row.canonical_name || '').toUpperCase().trim();
  const key = `${mpnSafe}|||${mfrSafe}`;
  d1Map.set(key, (d1Map.get(key) || 0) + 1);
}

// 2. Parse the Excel file
console.log("Parsing Excel file...");
const wb = xlsx.readFile('INDUS_Inventrory File- 14th Jul 26.xlsx');
const sheet = wb.Sheets['Sheet1'];
const rawRows = xlsx.utils.sheet_to_json(sheet, { header: 1, defval: null, blankrows: false });

console.log("Excel physical rows (including header):", rawRows.length);

const excelMap = new Map();
let excelParsed = 0;
for (let i = 1; i < rawRows.length; i++) {
  const row = rawRows[i];
  const mpnRaw = row[3];
  const mfrRaw = row[4];
  
  if (!mpnRaw || String(mpnRaw).trim() === '') continue; // Skip invalid
  const mpnOriginal = String(mpnRaw).trim();
  const mfrSafe = mfrRaw ? String(mfrRaw).toUpperCase().trim() : 'UNKNOWN';
  
  const key = `${mpnOriginal}|||${mfrSafe}`;
  excelMap.set(key, (excelMap.get(key) || 0) + 1);
  excelParsed++;
}
console.log(`Excel parsed eligible rows: ${excelParsed}`);

// 3. Compare the two sets
console.log("\n=== MISSING FROM D1 ===");
let totalMissing = 0;
for (const [key, countInExcel] of excelMap.entries()) {
  const countInD1 = d1Map.get(key) || 0;
  if (countInD1 < countInExcel) {
    const diff = countInExcel - countInD1;
    totalMissing += diff;
    console.log(`Missing ${diff} instance(s) of [${key}] (Excel: ${countInExcel}, D1: ${countInD1})`);
  }
}
console.log(`Total missing instances: ${totalMissing}`);

console.log("\n=== EXTRA IN D1 ===");
let totalExtra = 0;
for (const [key, countInD1] of d1Map.entries()) {
  const countInExcel = excelMap.get(key) || 0;
  if (countInD1 > countInExcel) {
    const diff = countInD1 - countInExcel;
    totalExtra += diff;
    console.log(`Extra ${diff} instance(s) of [${key}] (D1: ${countInD1}, Excel: ${countInExcel})`);
  }
}
console.log(`Total extra instances: ${totalExtra}`);

