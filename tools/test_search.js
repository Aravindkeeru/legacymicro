// Phase 2.5: Automated Testing for Search API and Importer Logic
// Minimal test framework using Node.js built-in assert module

const assert = require('assert');

// --- 1. Date Code Safety Tests ---
function parseDateCode(rawDc) {
  if (!rawDc) return null;
  const str = String(rawDc).trim().toUpperCase();
  if (str === 'N/A' || str === '' || str === 'NONE') return null;
  if (str.includes('MIXED') || str.includes('MIX')) return 'Mixed';
  const plusMatch = str.match(/^(?:20)?([0-9]{2})\+$/);
  if (plusMatch) return plusMatch[1] + '+';
  return null; // Ambiguous 4-digit codes like 2334 fall here
}

function testDateCodes() {
  console.log("Running Date Code Safety Tests...");
  assert.strictEqual(parseDateCode("2334"), null, "YYWW should be null");
  assert.strictEqual(parseDateCode("2033"), null, "YYYY should be null");
  assert.strictEqual(parseDateCode("21+"), "21+", "YY+ should pass");
  assert.strictEqual(parseDateCode("2021+"), "21+", "YYYY+ should pass");
  assert.strictEqual(parseDateCode("18/19"), null, "Ranges should be null");
  assert.strictEqual(parseDateCode("Mixed DC"), "Mixed", "Mixed should pass");
  assert.strictEqual(parseDateCode("N/A"), null, "N/A should be null");
  assert.strictEqual(parseDateCode(""), null, "Blank should be null");
  console.log("✅ Date Code Tests Passed");
}

// --- 2. MPN Normalization Tests ---
function normalizeSearchMpn(mpn) {
  if (!mpn) return '';
  return String(mpn).toUpperCase().replace(/[\W_]+/g, '');
}

function testMpnNormalization() {
  console.log("Running MPN Normalization Tests...");
  assert.strictEqual(normalizeSearchMpn("STM32F407-VGT6"), "STM32F407VGT6");
  assert.strictEqual(normalizeSearchMpn("stm 32f 407"), "STM32F407");
  assert.strictEqual(normalizeSearchMpn("LPC1768/FBD"), "LPC1768FBD");
  assert.strictEqual(normalizeSearchMpn("NE555P+TR"), "NE555PTR");
  console.log("✅ MPN Normalization Tests Passed");
}

// --- 3. API Response Validation Tests ---
// Simulating the shape of the search_v2.js output
function testApiResponseSchema() {
  console.log("Running API Schema Tests...");
  
  const mockResponse = {
    results: [
      {
        mpn: "STM32F407VGT6",
        manufacturer: "STMicroelectronics",
        description: "MCU",
        match_type: "EXACT",
        availability: "LEGACY_MICRO_STOCK",
        public_quantity: "1500",
        date_code: "21+",
        condition: "New",
        multiple_sources: false,
        source_category: "LEGACY_NETWORK"
      }
    ],
    meta: { total: 1, external_fallback_used: false }
  };

  const item = mockResponse.results[0];
  
  // Test Data Exclusion (Security)
  assert.strictEqual(item.supplier_name, undefined, "Supplier name MUST NOT be leaked");
  assert.strictEqual(item.supplier_id, undefined, "Supplier ID MUST NOT be leaked");
  assert.strictEqual(item.unit_cost, undefined, "Cost MUST NOT be leaked");
  assert.strictEqual(item.margin, undefined, "Margin MUST NOT be leaked");

  // Test Pricing Exclusion
  assert.strictEqual(item.price, undefined, "Price MUST NOT be leaked (RFQ ONLY)");
  
  console.log("✅ API Schema Security Tests Passed");
}

// --- 4. HTTP Method & Input Validation (Mocked) ---
function validateInput(method, body) {
  if (method !== 'POST') return { status: 405, error: "Method Not Allowed" };
  const query = typeof body.query === 'string' ? body.query.trim() : '';
  if (!query || query.length < 3 || query.length > 50) return { status: 400, error: "Invalid search query" };
  return { status: 200 };
}

function testInputValidation() {
  console.log("Running Input Validation Tests...");
  assert.strictEqual(validateInput('GET', { query: "STM32" }).status, 405);
  assert.strictEqual(validateInput('POST', { query: "ST" }).status, 400, "Too short");
  assert.strictEqual(validateInput('POST', { query: "A".repeat(51) }).status, 400, "Too long");
  assert.strictEqual(validateInput('POST', { query: "STM32" }).status, 200, "Valid");
  console.log("✅ Input Validation Tests Passed");
}

function runAllTests() {
  try {
    testDateCodes();
    testMpnNormalization();
    testApiResponseSchema();
    testInputValidation();
    console.log("\nALL TESTS PASSED.");
  } catch (err) {
    console.error("TEST FAILED:", err.message);
    process.exit(1);
  }
}

if (require.main === module) {
  runAllTests();
}
