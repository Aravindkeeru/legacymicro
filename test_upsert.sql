INSERT INTO suppliers (id, internal_code, internal_name, trust_level) VALUES
(1, 'EMS', 'EMS Fabienne', 10)
ON CONFLICT(id) DO UPDATE SET 
    internal_code=excluded.internal_code,
    internal_name=excluded.internal_name,
    trust_level=excluded.trust_level;
