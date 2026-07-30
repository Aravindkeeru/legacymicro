const https = require('https');

async function testSearch(query) {
  return new Promise((resolve) => {
    const data = JSON.stringify({ query });
    const req = https.request({
      hostname: 'phase2-staging.legacymicro.pages.dev',
      port: 443,
      path: '/api/search_v2',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': data.length
      }
    }, res => {
      let body = '';
      res.on('data', d => body += d);
      res.on('end', () => {
        console.log(`[${res.statusCode}] ${query} ->`, body);
        resolve();
      });
    });
    req.write(data);
    req.end();
  });
}

async function run() {
  await testSearch('INDUS-MPN-1');
  await testSearch('100-000000083'); // from AGS
}
run();
