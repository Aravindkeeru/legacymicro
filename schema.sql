-- Phase 2 Database Schema for Cloudflare D1

DROP TABLE IF EXISTS inventory_imports;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS manufacturer_aliases;
DROP TABLE IF EXISTS manufacturers;
DROP TABLE IF EXISTS supplier_field_mappings;
DROP TABLE IF EXISTS suppliers;

CREATE TABLE manufacturers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    canonical_name TEXT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE manufacturer_aliases (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id INTEGER NOT NULL,
    alias TEXT NOT NULL,
    alias_normalized TEXT NOT NULL UNIQUE,
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(id)
);

CREATE TABLE suppliers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    internal_code TEXT NOT NULL UNIQUE,
    internal_name TEXT NOT NULL,
    trust_level INTEGER DEFAULT 1,
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO suppliers (id, internal_code, internal_name, trust_level) VALUES
(1, 'EMS', 'EMS Fabienne', 10),
(2, 'NEW_XS', 'New XS', 8),
(3, 'RA', 'RA Components', 9),
(4, 'AGS', 'AGS Stock', 9),
(5, 'XS', 'XS Regular', 7),
(6, 'INDUS', 'Indus Source', 8)
ON CONFLICT(id) DO UPDATE SET 
    internal_code=excluded.internal_code,
    internal_name=excluded.internal_name,
    trust_level=excluded.trust_level;

CREATE TABLE parts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manufacturer_id INTEGER NOT NULL,
    mpn_original TEXT NOT NULL,
    mpn_canonical TEXT,
    mpn_search_normalized TEXT NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(id)
);
CREATE UNIQUE INDEX idx_parts_manufacturer_mpn ON parts(manufacturer_id, mpn_search_normalized);
CREATE INDEX idx_parts_search ON parts(mpn_search_normalized);

CREATE TABLE inventory_imports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    filename TEXT NOT NULL,
    import_started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    import_completed_at DATETIME,
    rows_total INTEGER DEFAULT 0,
    rows_imported INTEGER DEFAULT 0,
    rows_rejected INTEGER DEFAULT 0,
    status TEXT DEFAULT 'ANALYZING', -- ANALYZING, VALIDATED, STAGED, ACTIVE, FAILED, SUPERSEDED
    superseded_by_id INTEGER,
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE inventory (
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
    is_active BOOLEAN DEFAULT 0, -- Active snapshot model
    import_id INTEGER,
    source_updated_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(part_id) REFERENCES parts(id),
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY(import_id) REFERENCES inventory_imports(id)
);
CREATE INDEX idx_inventory_part ON inventory(part_id);
CREATE INDEX idx_inventory_supplier ON inventory(supplier_id);
CREATE INDEX idx_inventory_active ON inventory(is_active);

CREATE TABLE supplier_field_mappings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    feed_code TEXT NOT NULL,
    field_internal TEXT NOT NULL,
    field_source TEXT NOT NULL,
    is_required BOOLEAN DEFAULT 0,
    transform_logic TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id),
    UNIQUE(supplier_id, feed_code, field_internal)
);
