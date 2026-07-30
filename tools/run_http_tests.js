const https = require('https');

const PORT = 8788;
const API_URL = `https://phase2-staging.legacymicro.pages.dev/api/search_v2`;

async function fetchSearch(query, method = 'POST', malformed = false) {
  return new Promise((resolve, reject) => {
    const req = https.request(API_URL, {
      method,
      headers: { 'Content-Type': 'application/json' }
    }, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          resolve({ status: res.statusCode, body: data ? JSON.parse(data) : null, raw: data });
        } catch(e) {
          resolve({ status: res.statusCode, body: null, raw: data });
        }
      });
    });

    req.on('error', reject);

    if (method === 'POST') {
      if (malformed) {
        req.write('{"query": "invalid JSON');
      } else if (query !== null) {
        req.write(JSON.stringify({ query }));
      }
    }
    req.end();
  });
}

async function runTests() {
  console.log("=== REAL HTTP TESTS ===");
  const testCases = [
    { name: "exact MPN", query: "DS280MB810ZBLT" },
    { name: "lowercase exact MPN", query: "ds280mb810zblt" },
    { name: "punctuation variation", query: "DS-280-MB810-ZBLT" },
    { name: "partial MPN", query: "DS280MB" },
    { name: "unknown MPN", query: "XXXXXYYYZZZ123" },
    { name: "empty query", query: "" },
    { name: "2-char query", query: "DS" },
    { name: "3-char query", query: "DS2" },
    { name: "51-char query", query: "A".repeat(51) },
  ];

  let dataLeakPass = true;

  for (const tc of testCases) {
    const res = await fetchSearch(tc.query);
    console.log(`[${res.status}] ${tc.name}: ${tc.query} -> Results: ${res.body?.results ? res.body.results.length : 0}`);
    
    // Data Leak Check
    const rawString = JSON.stringify(res.body || {});
    if (rawString.includes("supplier") || rawString.includes("cost") || rawString.includes("margin") || rawString.includes("trust_level")) {
      if (!rawString.includes("multiple_sources")) { // 'multiple_sources' is a safe field
        console.error(`  --> DATA LEAK DETECTED for ${tc.query}`);
        dataLeakPass = false;
      }
    }
  }

  // Malformed JSON
  const resMalformed = await fetchSearch(null, 'POST', true);
  console.log(`[${resMalformed.status}] malformed JSON -> ${resMalformed.raw.substring(0, 50)}`);

  // GET request
  const resGet = await fetchSearch(null, 'GET');
  console.log(`[${resGet.status}] GET request -> ${resGet.raw.substring(0, 50)}`);
  
  console.log("\n=== DATA LEAK TEST ===");
  console.log(`RESULT: ${dataLeakPass ? 'ACTUAL PASS' : 'ACTUAL FAIL'}`);
}

runTests().catch(console.error);
