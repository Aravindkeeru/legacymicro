const xlsx = require('xlsx');

function analyzeFile(file, titleRowToSkip = 0) {
  console.log(`\n=== Analyzing: ${file} ===`);
  const wb = xlsx.readFile(file);
  const sheet = wb.Sheets[wb.SheetNames[0]];
  const range = xlsx.utils.decode_range(sheet['!ref']);
  console.log(`Physical Range: ${sheet['!ref']} (Rows: ${range.e.r + 1})`);
  
  let empty = 0;
  let hasData = 0;
  for (let i = 0; i <= range.e.r; i++) {
    if (i < titleRowToSkip) continue; // Skip title row
    let rowEmpty = true;
    for (let j = 0; j <= range.e.c; j++) {
      let cell = sheet[xlsx.utils.encode_cell({r:i, c:j})];
      if (cell && cell.v !== null && cell.v !== '') rowEmpty = false;
    }
    if (rowEmpty) empty++; else hasData++;
  }
  console.log(`Non-empty data rows: ${hasData}`);
  console.log(`Empty rows: ${empty}`);
}

analyzeFile('EMS Fabienne.xls');
analyzeFile('RA Componenets latest.xlsx', 1);
analyzeFile('STOCK_AGS200226.xlsx');
analyzeFile('New XS_EU OEM_low prices.xlsx');
analyzeFile('XS_03.26.26.xlsx');
