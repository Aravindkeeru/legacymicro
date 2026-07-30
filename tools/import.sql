INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (1785393842515, 1, 'EMS Fabienne.xls', 10, 'IN_PROGRESS');
UPDATE inventory_imports SET rows_imported = 0, rows_rejected = 10, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = 1785393842515;
INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (1785393842516, 2, 'New XS_EU OEM_low prices.xlsx', 11, 'IN_PROGRESS');
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('TEXAS INSTRUMENTS');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'DS280MB810ZBLT', 'DS280MB810ZBLT', 'Low Power 28 Gbps 8 Ch Linear Repeater' FROM manufacturers WHERE canonical_name = 'TEXAS INSTRUMENTS';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 1594, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'DS280MB810ZBLT';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Broadcom');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'BCM53426A0KFSBG', 'BCM53426A0KFSBG', 'CI Ethernet Switch L2 24 ports 1GbE' FROM manufacturers WHERE canonical_name = 'Broadcom';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 922, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'BCM53426A0KFSBG';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('AMPHENOL');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'UE36-C16200-05B4A', 'UE36C1620005B4A', 'Cage QSFP-DD 1x1 2 rear pin HS' FROM manufacturers WHERE canonical_name = 'AMPHENOL';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 665, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'UE36-C16200-05B4A';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Skyworks');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'SI5347C-D-GM', 'SI5347CDGM', 'Quad DSPLL Any-Frequency/jitter Atten' FROM manufacturers WHERE canonical_name = 'Skyworks';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 320, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'SI5347C-D-GM';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('AD');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'LTM4700EY#PBF', 'LTM4700EYPBF', '4.5V To 16V DUAL 50A Step-Down DC/DC' FROM manufacturers WHERE canonical_name = 'AD';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 187, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'LTM4700EY#PBF';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('JUMPtec');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, '34011-0416-16-5', '340110416165', 'CPU, COMe-m4AL10 Intel E3940, Atom' FROM manufacturers WHERE canonical_name = 'JUMPtec';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 46, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = '34011-0416-16-5';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Broadcom');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'BCM88820CA1KFSBG', 'BCM88820CA1KFSBG', '4.8-Tb/s Jericho2c Integrated Packet' FROM manufacturers WHERE canonical_name = 'Broadcom';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 38, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'BCM88820CA1KFSBG';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('INTEL (Altera)');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, '5CGXFC7D6F27I7N', '5CGXFC7D6F27I7N', 'CI FPGA Cyclone V GX149500 Cells 28nm' FROM manufacturers WHERE canonical_name = 'INTEL (Altera)';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 37, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = '5CGXFC7D6F27I7N';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Microchip');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'PM6010B1-FEI', 'PM6010B1FEI', 'DIGI-G5 OTN Processors with encryption' FROM manufacturers WHERE canonical_name = 'Microchip';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 12, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'PM6010B1-FEI';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Microchip');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'PM6011B1-FEI', 'PM6011B1FEI', 'DIGI-G5 OTN Processo w/o encrypt BGA1932' FROM manufacturers WHERE canonical_name = 'Microchip';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = 'PM6011B1-FEI';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('INTEL (Altera)');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, '1SX165HN1F43E2VG', '1SX165HN1F43E2VG', 'U S MCT BGA-1760 Stratix10 FPGA 14nm' FROM manufacturers WHERE canonical_name = 'INTEL (Altera)';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 2, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842516
        FROM parts p WHERE p.mpn_original = '1SX165HN1F43E2VG';
UPDATE inventory_imports SET rows_imported = 11, rows_rejected = 0, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = 1785393842516;
INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (1785393842517, 3, 'RA Componenets latest.xlsx', 413, 'IN_PROGRESS');
UPDATE inventory_imports SET rows_imported = 0, rows_rejected = 413, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = 1785393842517;
INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (1785393842518, 4, 'STOCK_AGS200226.xlsx', 252, 'IN_PROGRESS');
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J332D693, J438B658', 'J332D693J438B658', 'Intel® Core™ i7-4600U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 8, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J332D693, J438B658';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V437B825', 'V437B825', 'Intel® Core™ i5-4310U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V437B825';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J431A567, J435A637', 'J431A567J435A637', 'Intel® Core™ i5-4210U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J431A567, J435A637';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J435436, J520B923,J522B645,J434C394,J435C436', 'J435436J520B923J522B645J434C394J435C436', 'Intel® Core™ i7-5600U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J435436, J520B923,J522B645,J434C394,J435C436';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V523A706', 'V523A706', 'Intel® Core™ i7-5500U Processor (4M Cache, up to 3.00 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V523A706';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V439C678, V527B872, V518B020, V601C400, V601B946, V602B075, V512D126, V547B739, V544B661, V524B817, V535B797, V634A699, V545B540, V518B295, V438C60', 'V439C678V527B872V518B020V601C400V601B946V602B075V512D126V547B739V544B661V524B817V535B797V634A699V545B540V518B295V438C60', 'Intel® Core™ i5-5300U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 42, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V439C678, V527B872, V518B020, V601C400, V601B946, V602B075, V512D126, V547B739, V544B661, V524B817, V535B797, V634A699, V545B540, V518B295, V438C60';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V451C939', 'V451C939', '"Intel® Core™ i3-5005U Processor 3M Cache, 2.00 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 15, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V451C939';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V538B822, V851B279, V746B325', 'V538B822V851B279V746B325', 'Intel® Core™ i3-6100U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V538B822, V851B279, V746B325';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J701D402', 'J701D402', 'Intel® Celeron® Processor 3855U' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J701D402';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J626C259', 'J626C259', 'Intel®Core™ i7-6500U Processor (4M' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J626C259';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V244I575', 'V244I575', 'Intel® Core™ i5-5300UProcessor (3MCache, up to2.90 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V244I575';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X934F481', 'X934F481', 'INTEL® 200 AND Z370 SERIES CHIPSET' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X934F481';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J622A979, J636B868,  J722C387', 'J622A979J636B868J722C387', 'Intel® Core™ i7-7500U Processor (4M Cache, up to 3.50 GHz )' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J622A979, J636B868,  J722C387';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V703C324', 'V703C324', 'INTEL® CORE™ I3-7100U PROCESSOR (3M CACHE, 2.40 GHZ)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V703C324';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J651B703,J727B775, J724B364, J640C078, J653B461, J727B263', 'J651B703J727B775J724B364J640C078J653B461J727B263', 'INTEL® CORE™ I3-7100U PROCESSOR (3M CACHE, 2.40 GHZ)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 8, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J651B703,J727B775, J724B364, J640C078, J653B461, J727B263';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J722C726', 'J722C726', '7th Generation Intel® Core™ i3 Processors  i3-7100U' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 10, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J722C726';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X110L500, X022F410, X128L320, X147L925', 'X110L500X022F410X128L320X147L925', 'INTEL®PENTIUM®PROCESSORG3240,3MACHE, 3.10GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 11, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X110L500, X022F410, X128L320, X147L925';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V703C089, V920C729, V920C631, V928C078', 'V703C089V920C729V920C631V928C078', 'Intel® Core™ i5-8350U Processor 6M Cache, up to 3.60 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 10, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V703C089, V920C729, V920C631, V928C078';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X147K694, X951H291, X147K487, X952G966', 'X147K694X951H291X147K487X952G966', 'Intel® Core™ i5-8350U Processor 6M Cache, up to 3.60 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 6, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X147K694, X951H291, X147K487, X952G966';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X022F338', 'X022F338', 'Intel® Core™ i5-8250U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X022F338';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X007D350', 'X007D350', 'INTEL®CORE™ I7-8550UPROCESSOR(8M CACHE, UPTO 4.00 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X007D350';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X928H497, X952G935', 'X928H497X952G935', 'INTEL®CORE™ I3-7020UPROCESSOR3M CACHE,2.30 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X928H497, X952G935';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V903C851', 'V903C851', 'INTEL®CORE™ I3-7020UPROCESSOR3M CACHE,2.30 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V903C851';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X905B067', 'X905B067', 'Intel® C246 Chipset' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X905B067';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V833C764, V911C375', 'V833C764V911C375', 'INTEL® CORE™ I5-8265U PROCESSOR 6M CACHE, UP TO 3.90 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V833C764, V911C375';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V043F820, V038F195', 'V043F820V038F195', 'Intel® Core™ i5-9300H Processor (8M Cache, up to 4.10 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V043F820, V038F195';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X030E622', 'X030E622', 'Intel® Core™ i5-8365UE Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X030E622';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J203H726, J040H575', 'J203H726J040H575', 'Intel® Core™ i3-1005G1 Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 7, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J203H726, J040H575';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V941D401', 'V941D401', 'Intel® Core™ i7-10810U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V941D401';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V120G970, V138J163', 'V120G970V138J163', 'Intel® Core™ i7-10750H Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 11, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V120G970, V138J163';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V127H185', 'V127H185', 'Intel® Core™ i7-10610U Processor (8M Cache, up to 4.90 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V127H185';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V410G874, V410G835, V349I536', 'V410G874V410G835V349I536', 'Intel® Core™ i5-1135G7 Processor (8M Cache, up to 4.20 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 11, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V410G874, V410G835, V349I536';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V115G591', 'V115G591', 'Intel® Core™ i7-11370H Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V115G591';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X203H538', 'X203H538', 'Intel® W580 Chipset' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X203H538';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J145G874, J146G414', 'J145G874J146G414', 'Intel® Core™ i9-11900H Processor (24M Cache, up to 4.80 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 6, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J145G874, J146G414';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X319M074', 'X319M074', 'Intel® Core™ i9-12950HX Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X319M074';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X312M395', 'X312M395', 'Intel® Core™ i7-13700HX Processo' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X312M395';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V802B085-2,  V802B085,', 'V802B0852V802B085', 'South Bridge Chip' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V802B085-2,  V802B085,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X916C822', 'X916C822', 'South Bridge Chip' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X916C822';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'L219H007-1, L218H018-2', 'L219H0071L218H0182', 'Intel® 82801JH I/O Controller' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'L219H007-1, L218H018-2';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V319B924', 'V319B924', 'Intel® Core™ i5-4288U Processor (3M Cache, up to 3.10 GHz) FC-BGA12F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V319B924';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V327C233, V331B744, V321C661, V437B697-2, V341B886', 'V327C233V331B744V321C661V437B6972V341B886', 'Intel® Core™ i7-4600U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 6, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V327C233, V331B744, V321C661, V437B697-2, V341B886';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V536C044, V435C60,', 'V536C044V435C60', 'Intel® Core™ i7-4510U Processor (4M Cache, up to 3.10 GHz) FC-BGA12F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V536C044, V435C60,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J422B152, J330D928, J425A995', 'J422B152J330D928J425A995', 'Intel® Core™ i7-4510U Processor (4M Cache, up to 3.10 GHz) FC-BGA12F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J422B152, J330D928, J425A995';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J424B607, J510A782, J438B794, J422B380, J441A996', 'J424B607J510A782J438B794J422B380J441A996', 'Intel® Core™ i5-4300U Processor (3M Cache, up to 2.90 GHz) FC-BGA12F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J424B607, J510A782, J438B794, J422B380, J441A996';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V435C081', 'V435C081', 'Intel® Core™ i5-4210U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V435C081';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V517C331, V549A945,  V517C331,  V516C458', 'V517C331V549A945V517C331V516C458', 'Intel® Core™ i3-4005U Processor
3M Cache, 1.70 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V517C331, V549A945,  V517C331,  V516C458';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J320A824,J320A824', 'J320A824J320A824', 'Intel® Core™ i3-4005U Processor
3M Cache, 1.70 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J320A824,J320A824';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V432C273', 'V432C273', 'Intel® Core™ M-5Y71 Processor (4M Cache, up to 2.90 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V432C273';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V542B572, V537B637, V512D726, V542B558, V544B286,  V536B735, V522A933, V520A814, V512D079, V517C092,  V547B954, V533B165', 'V542B572V537B637V512D726V542B558V544B286V536B735V522A933V520A814V512D079V517C092V547B954V533B165', 'Intel® Core™ i7-5600U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 12, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V542B572, V537B637, V512D726, V542B558, V544B286,  V536B735, V522A933, V520A814, V512D079, V517C092,  V547B954, V533B165';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J601B793', 'J601B793', 'Intel® Core™ i5-5300U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J601B793';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V614A847', 'V614A847', 'Intel® Core™ i5-5200U Processor (3M Cache, up to 2.70 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 8, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V614A847';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J433C544, J434C449', 'J433C544J434C449', 'Intel® Core™ i3-5010U Processor (3M Cache, 2.10 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J433C544, J434C449';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V544B450, V544B452, V544B479, V521C433,', 'V544B450V544B452V544B479V521C433', 'Intel® Core™ i3-5020U Processor (3M Cache, 2.20 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V544B450, V544B452, V544B479, V521C433,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J527B974, J527B853', 'J527B974J527B853', 'Intel® Core™ i3-5020U Processor (3M Cache, 2.20 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J527B974, J527B853';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J547C541', 'J547C541', 'Intel® Core™ m3-6Y30 Processor (4M Cache, up to 2.20 GHz) FC-BGA14C, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 13, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J547C541';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J732B970, J606B571-6, J732B970-7, J550B399-3, J551C657-2,  J529A891-2,', 'J732B970J606B5716J732B9707J550B3993J551C6572J529A8912', 'Intel® Pentium® Processor 4405U (2M Cache, 2.10 GHz) FC-BGA14C, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 24, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J732B970, J606B571-6, J732B970-7, J550B399-3, J551C657-2,  J529A891-2,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V535C089, V546C048,', 'V535C089V546C048', 'Intel® Pentium® Processor 4405U (2M Cache, 2.10 GHz) FC-BGA14C, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V535C089, V546C048,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J627C652', 'J627C652', 'Intel® Core™ i5-5300UProcessor (3MCache, up to2.90 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J627C652';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V616B849', 'V616B849', 'Intel® Core™ i7-6600U Processor 4M Cache, up to 3.40 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V616B849';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V512E087', 'V512E087', 'Intel® Xeon® Processor E3-1505M v5 (8M Cache, 2.80 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V512E087';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V537A106, V531A379, V624A918, V624A919, V652B000, V651A745, V651A753', 'V537A106V531A379V624A918V624A919V652B000V651A745V651A753', 'Intel® Core™ i7-6700HQ Processor (6M Cache, up to 3.50 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 7, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V537A106, V531A379, V624A918, V624A919, V652B000, V651A745, V651A753';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V719A843, V717B803, V715A572, V816B939, V730B283, V736B248, J643B006, V736A654, V610C139', 'V719A843V717B803V715A572V816B939V730B283V736B248J643B006V736A654V610C139', 'INTEL® CORE™ I3-6006U PROCESSOR (3M CACHE, 2.00 GHZ)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V719A843, V717B803, V715A572, V816B939, V730B283, V736B248, J643B006, V736A654, V610C139';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V639B437,', 'V639B437', 'Intel® Core™ i7-7500U Processor (4M Cache, up to 3.50 GHz )' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V639B437,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V639B336', 'V639B336', 'Intel® Core™ i7-7820HK Processor (8M Cache, up to 3.90 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V639B336';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X937J323', 'X937J323', '7th Generation Intel® Core™ i3 Processors  i3-7100U' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 6, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X937J323';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X931E609', 'X931E609', 'Intel® Celeron® Processor 3865U (2M Cache, 1.80 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X931E609';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V703C079', 'V703C079', 'INTEL®PENTIUM®PROCESSORG3240,3MACHE, 3.10GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 7, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V703C079';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X022F338, X022F680, X110L159', 'X022F338X022F680X110L159', 'Intel® Core™ i5-8250U Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X022F338, X022F680, X110L159';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V839C067', 'V839C067', 'INTEL®CORE™ I7-8550UPROCESSOR(8M CACHE, UPTO 4.00 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V839C067';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X940E050', 'X940E050', 'Intel® Pentium® Silver J5005 Processor (4M Cache, up to 2.80 GHz) FC-BGA15F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X940E050';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X103H581', 'X103H581', 'INTEL® CORE™ I3-8130U PROCESSOR 4M CACHE, UP TO 3.40 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X103H581';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V913B961, V005D931, V635B418, V629A968', 'V913B961V005D931V635B418V629A968', 'Intel® Core™ i7-8850H Processor 9M Cache, up to 4.30 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V913B961, V005D931, V635B418, V629A968';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X948E002', 'X948E002', 'MOBILE INTEL® HM370 CHIPSET' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X948E002';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J821E526, J848F498, J848F834,J907C629, J830E809, J848F498, J848F879,X016D619, X013E208', 'J821E526J848F498J848F834J907C629J830E809J848F498J848F879X016D619X013E208', 'Intel® Core™ i3-8145U Processor (4M Cache, up to 3.90 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J821E526, J848F498, J848F834,J907C629, J830E809, J848F498, J848F879,X016D619, X013E208';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V911C766', 'V911C766', 'INTEL CORE I7-8565U PROCESSOR (8M CACHE, UP TO 4.60 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V911C766';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J905E656', 'J905E656', 'INTEL CORE I7-8565U PROCESSOR (8M CACHE, UP TO 4.60 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J905E656';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V129I536, V941C854', 'V129I536V941C854', 'Intel® Core™ i7-9750H Processor (12M Cache, up to 4.50' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V129I536, V941C854';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X030E622', 'X030E622', 'Intel® Core™ i5-8365UE Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 2, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X030E622';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X107K651', 'X107K651', 'INTEL® CORE™ I7-8565U PROCESSOR 8M CACHE, UP TO 4.60 GHZ' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X107K651';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J048G155', 'J048G155', 'Intel® Core™ i7-1065G7 Processor 8M Cache, up to 3.90 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J048G155';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J203H726, J040H575', 'J203H726J040H575', 'Intel® Core™ i3-1005G1 Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 15, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J203H726, J040H575';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J106G070', 'J106G070', 'Intel® Core™ i5-1035G1 Processor (6M Cache, up to 3.60' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J106G070';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'J140G977', 'J140G977', 'Intel® Core™ i5-1035G1 Processor (6M Cache, up to 3.60 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'J140G977';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X202P544', 'X202P544', 'INTEL CORE I3-10110U PROCESSOR (4M CACHE, UP TO 4.10' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X202P544';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X227N295, X032C679', 'X227N295X032C679', 'Intel® Pentium® Gold 6405U Processor (2M Cache, 2.40 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 11, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X227N295, X032C679';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X121N641', 'X121N641', 'Intel® Core™ i7-10710U Processor (12M Cache, up to 4.70 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X121N641';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X121G40', 'X121G40', 'Intel® FH82Z490 Platform Controller Hub' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X121G40';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X111D288', 'X111D288', 'Intel® Core™ i7-10750H Processor' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X111D288';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V040F726', 'V040F726', 'Intel® Core™ i9-10980HK Processor (16M Cache, up to 5.30 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 5, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V040F726';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V202I133, V133I863, V201J401,', 'V202I133V133I863V201J401', 'Intel® Core™ i9-10885H Processor (16M Cache, up to 5.30 GHz) FC-BGA14F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 4, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V202I133, V133I863, V201J401,';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X218K075, X207H903', 'X218K075X207H903', 'Intel® Pentium® Silver N6000 Processor (4M Cache, up to 3.30 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 9, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X218K075, X207H903';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X122D566', 'X122D566', 'Intel® Celeron® Processor N4020 4M Cache, up to 2.80 GHz' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X122D566';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X203H538', 'X203H538', 'Intel® W580 Chipset' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X203H538';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V151I117', 'V151I117', 'Intel® Core™ i7-1195G7 Processor (12M Cache, up to 5.00 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V151I117';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V132I023', 'V132I023', 'Intel® Core™ i5-11500H Processor (12M Cache, up to 4.60 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V132I023';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'V112H035, V111G291', 'V112H035V111G291', 'Intel® Core™ i9-11900H Processor (24M Cache, up to 4.80 GHz)' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 3, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'V112H035, V111G291';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'X319K876', 'X319K876', 'Intel® Core™ i7-12850HX Processor (25M Cache, up to 4.80 GHz) FC-BGA16F, Tray' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 1, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'X319K876';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Intel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'L521F336', 'L521F336', 'Intel Core i9 processor 14900HX (36M Cache, up to 5.80 GHz) FC-BGA16F, Tray. Spec Code: SRMXF.' FROM manufacturers WHERE canonical_name = 'Intel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 4, 80, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842518
        FROM parts p WHERE p.mpn_original = 'L521F336';
UPDATE inventory_imports SET rows_imported = 99, rows_rejected = 153, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = 1785393842518;
INSERT INTO inventory_imports (id, supplier_id, filename, rows_total, status) VALUES (1785393842519, 5, 'XS_03.26.26.xlsx', 11, 'IN_PROGRESS');
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Silicon Lab');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'EFR32MG21A010F1024IM32-BR', 'EFR32MG21A010F1024IM32BR', NULL FROM manufacturers WHERE canonical_name = 'Silicon Lab';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 40217, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'EFR32MG21A010F1024IM32-BR';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Silicon Lab');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'BGM220SC22WGA2R', 'BGM220SC22WGA2R', NULL FROM manufacturers WHERE canonical_name = 'Silicon Lab';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 21898, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'BGM220SC22WGA2R';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Silicon Lab');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'WGM160P022KGN2', 'WGM160P022KGN2', NULL FROM manufacturers WHERE canonical_name = 'Silicon Lab';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 15375, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'WGM160P022KGN2';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Everlight');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, '19-213-Y2SC-9AS1T1B0E-5T-AM', '19213Y2SC9AS1T1B0E5TAM', NULL FROM manufacturers WHERE canonical_name = 'Everlight';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 42000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = '19-213-Y2SC-9AS1T1B0E-5T-AM';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Vishay');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'BZM55B6V8-TR', 'BZM55B6V8TR', NULL FROM manufacturers WHERE canonical_name = 'Vishay';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 100000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'BZM55B6V8-TR';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Onsemi');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'FQU2N60CTU', 'FQU2N60CTU', NULL FROM manufacturers WHERE canonical_name = 'Onsemi';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 100000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'FQU2N60CTU';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Maxim');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'TMC2300-LA-T', 'TMC2300LAT', NULL FROM manufacturers WHERE canonical_name = 'Maxim';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 5000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'TMC2300-LA-T';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Microchip');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'ATMEGA324PA-AU', 'ATMEGA324PAAU', NULL FROM manufacturers WHERE canonical_name = 'Microchip';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 20000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'ATMEGA324PA-AU';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Silicon Lab');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'SI7021-A20-GM1R', 'SI7021A20GM1R', NULL FROM manufacturers WHERE canonical_name = 'Silicon Lab';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 2523, '21+', 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'SI7021-A20-GM1R';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('TI');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'LMV321M7X/NOPB', 'LMV321M7XNOPB', NULL FROM manufacturers WHERE canonical_name = 'TI';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 120000, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'LMV321M7X/NOPB';
INSERT OR IGNORE INTO manufacturers (canonical_name) VALUES ('Atmel');
INSERT OR IGNORE INTO parts (manufacturer_id, mpn_original, mpn_search_normalized, description) 
        SELECT id, 'ATMEGA168PA-AUR', 'ATMEGA168PAAUR', NULL FROM manufacturers WHERE canonical_name = 'Atmel';
INSERT INTO inventory (part_id, supplier_id, quantity_parsed, date_code_normalized, availability_type, verification_status, import_id)
        SELECT p.id, 5, 14800, NULL, 'NETWORK_AVAILABLE', 'IMPORTED', 1785393842519
        FROM parts p WHERE p.mpn_original = 'ATMEGA168PA-AUR';
UPDATE inventory_imports SET rows_imported = 11, rows_rejected = 0, status = 'COMPLETED', import_completed_at = CURRENT_TIMESTAMP WHERE id = 1785393842519;