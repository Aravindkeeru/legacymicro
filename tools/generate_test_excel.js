const XLSX = require('xlsx');

// Create USA Inventory
const usaData = [
  { "Part Number": "STM32F407VGT6", "Manufacturer": "STMicroelectronics", "Description": "ARM Cortex-M4 32b MCU", "Date Code": "2245", "Quantity": "2500", "Condition": "New Factory Sealed" },
  { "Part Number": "LM7805CT", "Manufacturer": "Texas Instruments", "Description": "Linear Voltage Regulator", "Date Code": "2310", "Quantity": "10000", "Condition": "New Original" }
];
const usaSheet = XLSX.utils.json_to_sheet(usaData);
const usaWorkbook = XLSX.utils.book_new();
XLSX.utils.book_append_sheet(usaWorkbook, usaSheet, "Inventory");
XLSX.writeFile(usaWorkbook, 'inventory_usa.xlsx');

// Create Europe Inventory
const euData = [
  { "PN": "IRF540N", "Mfg": "Infineon", "Desc": "N-Channel Power MOSFET", "D/C": "2108", "Qty": "5000", "Condition": "New Boxed" },
  { "PN": "ATmega328P", "Mfg": "Microchip", "Desc": "8-bit Microcontroller", "D/C": "2302", "Qty": "1200", "Condition": "Factory Tube" }
];
const euSheet = XLSX.utils.json_to_sheet(euData);
const euWorkbook = XLSX.utils.book_new();
XLSX.utils.book_append_sheet(euWorkbook, euSheet, "Stock");
XLSX.writeFile(euWorkbook, 'inventory_europe.xlsx');

console.log("Excel files created!");
