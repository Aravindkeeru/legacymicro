const https = require('https');

async function fetchAPI(url, query) {
  return new Promise((resolve) => {
    const req = https.request(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' }
    }, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          resolve(JSON.parse(data).results?.length || 0);
        } catch(e) { resolve(0); }
      });
    });
    req.on('error', () => resolve(0));
    req.write(JSON.stringify({ query }));
    req.end();
  });
}

async function run() {
  const NEW_API = 'https://phase2-staging.legacymicro.pages.dev/api/search_v2';
  const OLD_API = 'https://legacy-micro.com/api/search'; // The actual old production URL

  // 20 Exact MPNs
  const exact = ["DS280MB810ZBLT", "BCM53426A0KFSBG", "UE36-C16200-05B4A", "SI5347C-D-GM", "LTM4700EY#PBF",
    "34011-0416-16-5", "BCM88820CA1KFSBG", "5CGXFC7D6F27I7N", "PM6010B1-FEI", "PM6011B1-FEI",
    "1SX165HN1F43E2VG", "J332D693", "J438B658", "V437B825", "J431A567",
    "J435A637", "J435436", "J520B923", "J522B645", "J434C394"];

  // 10 Variations
  const variations = ["ds280mb810zblt", "bcm53426A0kfsbg", "UE36 C16200 05B4A", "SI5347C-D-GM", "LTM4700EY-PBF",
    "34011-0416", "BCM88820CA1-KFSBG", "5cgxfc7d6f27i7n", "pm-6010-b1-fei", "PM 6011 B1 FEI"];

  // 10 Partial
  const partial = ["DS280MB", "BCM534", "UE36", "SI5347", "LTM47",
    "34011", "BCM888", "5CGXFC", "PM6010", "PM6011"];

  // 5 Garbage
  const garbage = ["XXXXXYY", "BLAHBLAH", "123490000", "UNKNOWN_PART", "NOPE_123"];

  async function testSet(label, queries) {
    let oldMatches = 0, newMatches = 0;
    for (const q of queries) {
      oldMatches += await fetchAPI(OLD_API, q);
      newMatches += await fetchAPI(NEW_API, q);
    }
    console.log(`${label}: OLD ${oldMatches} | NEW ${newMatches}`);
  }

  await testSet("20 Exact MPNs", exact);
  await testSet("10 Variations", variations);
  await testSet("10 Partial", partial);
  await testSet("5 Garbage", garbage);
}

run().catch(console.error);
