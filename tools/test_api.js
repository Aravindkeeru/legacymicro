const mpns = [
  '100-000000083', // AGS
  '9173B-01CS08LF', // EMS
  'CMD245C4', // RA
  'DS280MB810ZBLT', // NEW_XS
  'EFR32MG21A010F1024IM32-BR', // XS
  '193-00948-2203 REV L', // INDUS
  'VUM33-05N', // INDUS
  'DS32KHZN/WBGA+', // INDUS
  'STM8L152C8T6', // INDUS
  'ADR127BUJZ-REEL7', // INDUS
  'NON_EXISTENT_UNKNOWN_MPN_12345' // UNKNOWN
];

async function testAll() {
  for (const mpn of mpns) {
    const res = await fetch('https://legacymicro.pages.dev/api/search_v2', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ query: mpn })
    });
    const data = await res.json();
    console.log(`[TEST] ${mpn}`);
    console.log(`       Fallback Used: ${data.meta.external_fallback_used}`);
    if (data.results.length > 0) {
      console.log(`       First Result: Qty ${data.results[0].public_quantity}, Source: ${data.results[0].source_category}, Desc: ${data.results[0].description}`);
    } else {
      console.log(`       Results: 0`);
    }
  }
}

testAll();
