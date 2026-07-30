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
CREATE INDEX idx_parts_mpn_norm ON parts(mpn_search_normalized);

CREATE TABLE inventory (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    part_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    quantity_raw TEXT,
    quantity_parsed INTEGER,
    date_code_raw TEXT,
    date_code_normalized TEXT,
    condition TEXT,
    unit_cost REAL,
    currency TEXT DEFAULT 'USD',
    lead_time TEXT,
    availability_type TEXT NOT NULL,
    source_updated_at DATETIME,
    import_id INTEGER,
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(part_id) REFERENCES parts(id),
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE inventory_imports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    filename TEXT NOT NULL,
    file_hash TEXT,
    rows_total INTEGER DEFAULT 0,
    rows_imported INTEGER DEFAULT 0,
    rows_rejected INTEGER DEFAULT 0,
    import_started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    import_completed_at DATETIME,
    status TEXT NOT NULL,
    error_summary TEXT,
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE supplier_field_mappings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    source_column TEXT NOT NULL,
    target_field TEXT NOT NULL,
    transform_type TEXT,
    is_required BOOLEAN DEFAULT 0,
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id)
);

-- Insert seed data for the 5 suppliers
INSERT INTO suppliers (id, internal_code, internal_name, trust_level) VALUES
(1, 'EMS', 'EMS Fabienne', 2),
(2, 'NEW_XS', 'New XS EU OEM', 2),
(3, 'RA', 'RA Components', 2),
(4, 'AGS', 'STOCK AGS', 2),
(5, 'XS', 'XS 03.26', 2);
