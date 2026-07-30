const { execSync } = require('child_process');
const cmd = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="SELECT p.mpn_original FROM inventory i JOIN parts p ON i.part_id = p.id JOIN suppliers s ON i.supplier_id = s.id WHERE s.internal_code = 'INDUS' LIMIT 5" --remote`;
const r = execSync(cmd, { encoding: 'utf8' });
console.log(r);
