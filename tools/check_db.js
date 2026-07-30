const { execSync } = require('child_process');
const cmd = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="SELECT COUNT(*) as cnt FROM inventory" --remote --json`;
const r = execSync(cmd, { encoding: 'utf8' });
console.log(r);
const cmd2 = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="SELECT COUNT(*) as cnt FROM inventory WHERE quantity_parsed=5000" --remote --json`;
const r2 = execSync(cmd2, { encoding: 'utf8' });
console.log(r2);
