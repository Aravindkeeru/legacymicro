const xlsx = require('xlsx');

const wb = xlsx.readFile('STOCK_AGS200226.xlsx');
const sheet = wb.Sheets[wb.SheetNames[0]];
const rows = xlsx.utils.sheet_to_json(sheet, { header: 1, defval: null, blankrows: false });

console.log('Total parsed rows:', rows.length);

let rejected = [];
let seenMpn = new Set();
let dupes = 0;
for (let i = 1; i < rows.length; i++) {
  let row = rows[i];
  let mpn = row[0]; // ItemName
  let qty = row[2]; // Stock On Hand
  
  if (!mpn || String(mpn).trim() === '' || !qty || String(qty).trim() === '') {
    rejected.push({ index: i, reason: 'missing data', row: row });
  } else {
    const norm = String(mpn).toUpperCase().replace(/[\W_]+/g, '');
    if (seenMpn.has(norm)) {
      dupes++;
      rejected.push({ index: i, reason: 'duplicate', row: row });
    }
    seenMpn.add(norm);
  }
}

console.log(`Found ${rejected.length} rejected rows (${dupes} duplicates)`);
console.log('First 5 rejected:', rejected.slice(0, 5));
console.log('Last 5 rejected:', rejected.slice(-5));
