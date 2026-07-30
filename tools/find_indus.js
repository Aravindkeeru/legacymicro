const fs = require('fs');
const xlsx = require('xlsx');

const files = fs.readdirSync('.').filter(f => f.endsWith('.xls') || f.endsWith('.xlsx'));

for (const file of files) {
  try {
    const wb = xlsx.readFile(file);
    console.log(`\n=== FILE: ${file} ===`);
    console.log('Sheets:', wb.SheetNames);
    const sheet1 = wb.Sheets[wb.SheetNames[0]];
    const range = xlsx.utils.decode_range(sheet1['!ref']);
    console.log(`Sheet 1 Range: ${sheet1['!ref']} (Rows: ${range.e.r + 1})`);
    
    // Look at first few rows
    for (let i = 0; i < Math.min(10, range.e.r + 1); i++) {
      let row = [];
      for (let j = 0; j <= range.e.c; j++) {
        let cell = sheet1[xlsx.utils.encode_cell({r:i, c:j})];
        row.push(cell ? cell.v : null);
      }
      console.log(`Row ${i}:`, row);
    }
  } catch (e) {
    console.log(`Failed reading ${file}:`, e.message);
  }
}
