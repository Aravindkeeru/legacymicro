const { execSync } = require('child_process');

function queryD1(sql) {
  const cmd = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="${sql}" --remote --json`;
  try {
    const output = execSync(cmd, { stdio: 'pipe' });
    const jsonStr = output.toString().trim();
    // wrangler prepends some logs, so find the array
    const jsonStart = jsonStr.indexOf('[');
    if (jsonStart !== -1) {
      return JSON.parse(jsonStr.substring(jsonStart));
    }
    return JSON.parse(jsonStr);
  } catch (e) {
    console.error("Query failed:", e.message);
    if (e.stdout) console.error(e.stdout.toString());
    return null;
  }
}

const queries = [
  { name: "Total Parts", sql: "SELECT COUNT(*) as c FROM parts" },
  { name: "Total Inventory Records", sql: "SELECT COUNT(*) as c FROM inventory" },
  { name: "Active Inventory Records", sql: "SELECT COUNT(*) as c FROM inventory WHERE is_active = 1" },
  { name: "Active Records by Supplier", sql: "SELECT s.internal_code, COUNT(i.id) as c FROM inventory i JOIN suppliers s ON i.supplier_id = s.id WHERE i.is_active = 1 GROUP BY s.internal_code" },
  { name: "Import Snapshots Status", sql: "SELECT s.internal_code, imp.id, imp.status, imp.rows_imported, imp.rows_rejected FROM inventory_imports imp JOIN suppliers s ON imp.supplier_id = s.id" }
];

for (const q of queries) {
  console.log(`\n=== ${q.name} ===`);
  const res = queryD1(q.sql);
  if (res && res[0] && res[0].results) {
    console.table(res[0].results);
  }
}
