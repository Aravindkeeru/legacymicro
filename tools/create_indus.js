const xlsx = require('xlsx');
const fs = require('fs');

const filename = 'INDUS_Inventrory File- 14th Jul 26.xlsx';

const sheet1Data = [
  { "Raw Part": "RP-001", "Descrition": "Resistor 10k", "UOM": "EA", "MPN": "INDUS-MPN-1", "Make": "Yageo", "Qty": 5000 },
  { "Raw Part": "RP-002", "Descrition": "Capacitor 100nF", "UOM": "EA", "MPN": "INDUS-MPN-2", "Make": "Murata", "Qty": 2000 }
];

const sheet2Data = [
  { "Item Code": "IC-101", "Item Code-MPN": "IC-101-MPN-1", "Item Description": "Cross ref 1", "Mfr. Part No.": "INDUS-MPN-3", "Make": "TDK" },
  { "Item Code": "IC-102", "Item Code-MPN": "IC-102-MPN-2", "Item Description": "Cross ref 2", "Mfr. Part No.": "INDUS-MPN-4", "Make": "Kemet" }
];

const wb = xlsx.utils.book_new();
const ws1 = xlsx.utils.json_to_sheet(sheet1Data);
const ws2 = xlsx.utils.json_to_sheet(sheet2Data);

xlsx.utils.book_append_sheet(wb, ws1, "Sheet1");
xlsx.utils.book_append_sheet(wb, ws2, "Sheet2");

xlsx.writeFile(wb, filename);
console.log(`Created ${filename}`);
