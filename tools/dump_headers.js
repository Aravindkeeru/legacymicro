const xlsx = require('xlsx');
const path = require('path');

const files = [
  'EMS Fabienne.xls',
  'RA Componenets latest.xlsx',
  'STOCK_AGS200226.xlsx',
  'INDUS_Inventrory File- 14th Jul 26.xlsx'
];

for (const file of files) {
  try {
    const wb = xlsx.readFile(path.join(__dirname, '..', file));
    console.log(`\n=== FILE: ${file} ===`);
    for (const sheet of wb.SheetNames) {
      console.log(`Sheet: ${sheet}`);
      const rows = xlsx.utils.sheet_to_json(wb.Sheets[sheet], { header: 1 });
      if (rows.length > 0) {
        console.log(`Header (Row 0):`, rows[0]);
        if (rows.length > 1) {
          console.log(`Row 1:`, rows[1]);
        }
      }
    }
  } catch(e) {
    console.log(`Error reading ${file}: ${e.message}`);
  }
}
