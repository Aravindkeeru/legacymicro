const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: "new" });
  const page = await browser.newPage();
  
  try {
    console.log("Navigating to https://www.legacy-micro.com");
    await page.goto('https://www.legacy-micro.com');
    
    console.log("Typing 'CMD245C4' in homepage search box");
    await page.type('#searchInput', 'CMD245C4');
    await page.click('#searchBtn');
    
    console.log("Waiting for navigation to search.html");
    await page.waitForNavigation();
    
    console.log("Waiting for results");
    await page.waitForSelector('.result-card');
    
    const html = await page.content();
    if (html.includes('CMD245C4') && html.includes('78 In Stock')) {
      console.log("Search successful! Results rendered.");
    } else {
      console.log("Search failed to render expected results.");
      console.log(html.substring(0, 500));
    }
  } catch (e) {
    console.error("Test failed:", e);
  } finally {
    await browser.close();
  }
})();
