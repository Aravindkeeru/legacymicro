const XLSX = require('xlsx');
const fs = require('fs');

const files = [
  'EMS Fabienne.xls',
  'New XS_EU OEM_low prices.xlsx',
  'RA Componenets latest.xlsx',
  'STOCK_AGS200226.xlsx',
  'XS_03.26.26.xlsx'
];

files.forEach(file => {
  if (fs.existsSync(file)) {
    console.log(`\n=== Checking: ${file} ===`);
    try {
      const workbook = XLSX.readFile(file);
      const sheetName = workbook.SheetNames[0];
      const json = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName], { defval: "" });
      if (json.length > 0) {
        // Output the keys of the first row to see header structure
        console.log("Headers: ", Object.keys(json[0]));
        // Output the first item
        console.log("Sample Row 1: ", json[0]);
        // Search keys for Part Number variations
        const keys = Object.keys(json[0]).map(k => k.toLowerCase());
        const pnMatches = keys.filter(k => k.includes('part') || k.includes('pn') || k === 'mpn');
        console.log("Likely Part Number columns: ", pnMatches);
      } else {
        console.log("File is empty.");
      }
    } catch(e) {
      console.log(`Error reading ${file}:`, e.message);
    }
  } else {
    console.log(`File missing: ${file}`);
  }
});
