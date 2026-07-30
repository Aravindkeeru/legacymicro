const { execSync } = require('child_process');

function queryD1(sql) {
  const cmd = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="${sql}" --remote --json`;
  try {
    const output = execSync(cmd, { stdio: 'pipe' });
    const jsonStr = output.toString().trim();
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

async function run() {
  console.log("Querying for INDUS-MPN-1");
  let res = queryD1(`SELECT i.quantity_parsed, imp.status FROM inventory i JOIN parts p ON i.part_id = p.id JOIN inventory_imports imp ON i.import_id = imp.id WHERE p.mpn_search_normalized = 'INDUSMPN1';`);
  console.log(res ? res[0].results : 'No response');
}
run();
