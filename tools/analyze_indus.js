const xlsx = require('xlsx');

const file = 'INDUS_Inventrory File- 14th Jul 26.xlsx';
try {
  const wb = xlsx.readFile(file);
  console.log(`\n=== FILE: ${file} ===`);
  console.log('Sheets:', wb.SheetNames);
  const sheet1 = wb.Sheets['Sheet2'];
  const range = xlsx.utils.decode_range(sheet1['!ref']);
  console.log(`Sheet 1 Range: ${sheet1['!ref']} (Rows: ${range.e.r + 1}, Cols: ${range.e.c + 1})`);
  
  // Look at first 10 rows
  console.log('--- First 10 rows ---');
  for (let i = 0; i < Math.min(10, range.e.r + 1); i++) {
    let row = [];
    for (let j = 0; j <= range.e.c; j++) {
      let cell = sheet1[xlsx.utils.encode_cell({r:i, c:j})];
      row.push(cell ? cell.v : null);
    }
    console.log(`Row ${i}:`, row);
  }

  // Look at last 5 rows
  console.log('--- Last 5 rows ---');
  for (let i = Math.max(0, range.e.r - 4); i <= range.e.r; i++) {
    let row = [];
    for (let j = 0; j <= range.e.c; j++) {
      let cell = sheet1[xlsx.utils.encode_cell({r:i, c:j})];
      row.push(cell ? cell.v : null);
    }
    console.log(`Row ${i}:`, row);
  }

  // Physical row metrics
  let physicalRowCount = 0;
  let mpnCount = 0;
  let qtyCount = 0;
  let bothCount = 0;
  for (let i = 1; i <= range.e.r; i++) { // skip header
    let rowHasData = false;
    let hasMpn = false;
    let hasQty = false;

    // Find MPN column (assuming col 3 based on earlier mappings, but let's check header)
    // Wait, earlier I mapped INDUS:
    // MPN -> mpn (Col 3 in synthetic)
    // Descrition -> description
    // Qty -> quantity
    // Let's just scan all columns for data
    for (let j = 0; j <= range.e.c; j++) {
      let cell = sheet1[xlsx.utils.encode_cell({r:i, c:j})];
      if (cell && cell.v !== null && cell.v !== '') {
        rowHasData = true;
      }
    }
    if (rowHasData) physicalRowCount++;

    let mpnCell = sheet1[xlsx.utils.encode_cell({r:i, c:3})]; // MPN
    let qtyCell = sheet1[xlsx.utils.encode_cell({r:i, c:5})]; // Qty

    if (mpnCell && mpnCell.v !== null && mpnCell.v !== '') hasMpn = true;
    if (qtyCell && qtyCell.v !== null && qtyCell.v !== '') hasQty = true;

    if (hasMpn) mpnCount++;
    if (hasQty) qtyCount++;
    if (hasMpn && hasQty) bothCount++;
  }

  console.log('\n--- Metrics ---');
  console.log('Physical data rows (non-empty):', physicalRowCount);
  console.log('Rows containing MPN:', mpnCount);
  console.log('Rows containing Qty:', qtyCount);
  console.log('Rows containing Both:', bothCount);

} catch (e) {
  console.log(`Failed reading ${file}:`, e.message);
}
