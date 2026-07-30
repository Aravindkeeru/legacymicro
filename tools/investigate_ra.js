const xlsx = require('xlsx');

const wb = xlsx.readFile('RA Componenets latest.xlsx');
const sheet = wb.Sheets[wb.SheetNames[0]];
const rows = xlsx.utils.sheet_to_json(sheet, { header: 1, defval: null, blankrows: false });

console.log('Total parsed rows:', rows.length);

let rejected = [];
let seenMpn = new Set();
// RA is using `header_row: 1`
for (let i = 2; i < rows.length; i++) {
  let row = rows[i];
  let mpn = row[1]; // PART NUMBER
  let qty = row[5]; // Stock Qty
  
  if (!mpn || String(mpn).trim() === '') {
    rejected.push({ index: i, reason: 'missing mpn', row: row });
  } else if (qty === null || qty === undefined || String(qty).trim() === '') {
    rejected.push({ index: i, reason: 'missing qty', row: row });
  } else {
    const norm = String(mpn).toUpperCase().replace(/[\W_]+/g, '');
    if (seenMpn.has(norm)) {
      rejected.push({ index: i, reason: 'duplicate', row: row });
    }
    seenMpn.add(norm);
  }
}

console.log(`Found ${rejected.length} rejected rows`);
const byReason = {};
for (const r of rejected) {
  byReason[r.reason] = (byReason[r.reason] || 0) + 1;
}
console.log('By category:', byReason);
console.log('First 5 rejected:', rejected.slice(0, 5));
