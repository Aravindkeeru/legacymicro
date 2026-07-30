DELETE FROM inventory_imports WHERE id IN (9001, 9002);
UPDATE inventory_imports SET status = 'ACTIVE' WHERE supplier_id = 6;
UPDATE inventory SET is_active = 1 WHERE supplier_id = 6 AND import_id NOT IN (9001, 9002);
