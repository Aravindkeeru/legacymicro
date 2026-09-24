PRAGMA defer_foreign_keys=ON;

-- Recreate parts table
CREATE TABLE parts_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id INTEGER NULL,
    mpn_original TEXT NOT NULL,
    mpn_canonical TEXT,
    mpn_search_normalized TEXT NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(id)
);

INSERT INTO parts_new SELECT * FROM parts;

-- Recreate inventory table
CREATE TABLE inventory_new (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    part_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    quantity_parsed INTEGER,
    quantity_raw TEXT,
    date_code_raw TEXT,
    date_code_normalized TEXT,
    unit_cost_raw TEXT,
    currency TEXT,
    packaging TEXT,
    condition TEXT,
    moq INTEGER,
    spq INTEGER,
    availability_type TEXT NOT NULL,
    verification_status TEXT DEFAULT 'UNVERIFIED',
    is_active BOOLEAN DEFAULT 0,
    import_id INTEGER,
    source_updated_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    manufacturer_raw TEXT NULL,
    manufacturer_resolution_status TEXT NOT NULL DEFAULT 'UNRESOLVED' CHECK (manufacturer_resolution_status IN ('RESOLVED', 'UNRESOLVED', 'NON_MANUFACTURER', 'AMBIGUOUS')),
    FOREIGN KEY(part_id) REFERENCES parts_new(id),
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY(import_id) REFERENCES inventory_imports(id)
);

INSERT INTO inventory_new 
SELECT id, part_id, supplier_id, quantity_parsed, quantity_raw, date_code_raw, date_code_normalized, unit_cost_raw, currency, packaging, condition, moq, spq, availability_type, verification_status, is_active, import_id, source_updated_at, created_at, updated_at, NULL as manufacturer_raw, 'RESOLVED' as manufacturer_resolution_status FROM inventory;

-- Drop old tables (must drop inventory first due to FK, though deferred)
DROP TABLE inventory;
DROP TABLE parts;

-- Rename tables
ALTER TABLE parts_new RENAME TO parts;
ALTER TABLE inventory_new RENAME TO inventory;

-- Recreate parts indexes
CREATE UNIQUE INDEX idx_parts_resolved ON parts(manufacturer_id, mpn_search_normalized) WHERE manufacturer_id IS NOT NULL;
CREATE UNIQUE INDEX idx_parts_unresolved ON parts(mpn_search_normalized) WHERE manufacturer_id IS NULL;
CREATE INDEX idx_parts_search ON parts(mpn_search_normalized);

-- Recreate inventory indexes
CREATE INDEX idx_inventory_part ON inventory(part_id);
CREATE INDEX idx_inventory_supplier ON inventory(supplier_id);
CREATE INDEX idx_inventory_active ON inventory(is_active);
