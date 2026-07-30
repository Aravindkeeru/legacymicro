const { execSync } = require('child_process');

async function runTest() {
  const STAGING_URL = 'https://legacymicro.pages.dev/api/search_v2';
  
  function executeD1(sql) {
    const cmd = `npx.cmd wrangler d1 execute legacy-micro-inventory-staging --command="${sql}" --remote`;
    execSync(cmd, { stdio: 'inherit' });
  }
  
  async function querySearch() {
    const res = await fetch(STAGING_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ query: 'SYNTHETIC_TEST_MPN' })
    });
    const data = await res.json();
    if (data.results && data.results.length > 0) {
      return data.results[0].public_quantity;
    }
    return JSON.stringify(data);
  }

  console.log("=== Setting up synthetic test data ===");
  executeD1(`DELETE FROM inventory WHERE import_id IN (9001, 9002);`);
  executeD1(`DELETE FROM inventory_imports WHERE id IN (9001, 9002);`);
  executeD1(`DELETE FROM parts WHERE mpn_original='SYNTHETIC_TEST_MPN';`);
  executeD1(`DELETE FROM manufacturers WHERE canonical_name='TEST_MFR';`);
  executeD1(`DELETE FROM suppliers WHERE internal_code='TEST_SUPP';`);
  
  executeD1(`INSERT OR IGNORE INTO suppliers (internal_code, internal_name, trust_level) VALUES ('TEST_SUPP', 'TEST', 1);`);
  executeD1(`INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('TEST_MFR');`);
  executeD1(`INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) VALUES ((SELECT id FROM manufacturers WHERE canonical_name='TEST_MFR'), 'SYNTHETIC_TEST_MPN', 'SYNTHETICTESTMPN', 'Test Part');`);
  
  console.log("=== Creating Snapshot A (5000) ===");
  executeD1(`INSERT INTO inventory_imports (id, supplier_id, status, rows_imported, filename) VALUES (9001, (SELECT id FROM suppliers WHERE internal_code='TEST_SUPP'), 'ACTIVE', 1, 'test.xlsx');`);
  executeD1(`INSERT INTO inventory (part_id, supplier_id, quantity_parsed, availability_type, verification_status, import_id, is_active) VALUES ((SELECT id FROM parts WHERE mpn_original='SYNTHETIC_TEST_MPN'), (SELECT id FROM suppliers WHERE internal_code='TEST_SUPP'), 5000, 'NETWORK_AVAILABLE', 'IMPORTED', 9001, 1);`);
  
  let qA = await querySearch('Snapshot A Active');
  console.log(`[TEST] Snapshot A Active -> Query Result: ${qA}`);
  
  console.log("=== Creating Snapshot B (3000) ===");
  // Atomically switch to B
  executeD1(`UPDATE inventory SET is_active = 0 WHERE import_id = 9001;`);
  executeD1(`UPDATE inventory_imports SET status = 'SUPERSEDED' WHERE id = 9001;`);
  executeD1(`INSERT INTO inventory_imports (id, supplier_id, status, rows_imported, filename) VALUES (9002, (SELECT id FROM suppliers WHERE internal_code='TEST_SUPP'), 'ACTIVE', 1, 'test.xlsx');`);
  executeD1(`INSERT INTO inventory (part_id, supplier_id, quantity_parsed, availability_type, verification_status, import_id, is_active) VALUES ((SELECT id FROM parts WHERE mpn_original='SYNTHETIC_TEST_MPN'), (SELECT id FROM suppliers WHERE internal_code='TEST_SUPP'), 3000, 'NETWORK_AVAILABLE', 'IMPORTED', 9002, 1);`);

  let qB = await querySearch();
  console.log(`[TEST] Snapshot B Active -> Query Result: ${qB}`);
  
  console.log("=== Rolling back to Snapshot A (5000) ===");
  executeD1(`UPDATE inventory SET is_active = 0 WHERE import_id = 9002;`);
  executeD1(`UPDATE inventory_imports SET status = 'SUPERSEDED' WHERE id = 9002;`);
  executeD1(`UPDATE inventory SET is_active = 1 WHERE import_id = 9001;`);
  executeD1(`UPDATE inventory_imports SET status = 'ACTIVE' WHERE id = 9001;`);
  
  let qA2 = await querySearch();
  console.log(`[TEST] Rollback A Active -> Query Result: ${qA2}`);

  console.log("=== Cleanup ===");
  executeD1(`DELETE FROM inventory WHERE import_id IN (9001, 9002);`);
  executeD1(`DELETE FROM inventory_imports WHERE id IN (9001, 9002);`);
  executeD1(`DELETE FROM parts WHERE mpn_original='SYNTHETIC_TEST_MPN';`);
  executeD1(`DELETE FROM manufacturers WHERE canonical_name='TEST_MFR';`);
  executeD1(`DELETE FROM suppliers WHERE internal_code='TEST_SUPP';`);
}

runTest();
