export async function onRequestPost(context) {
  try {
    const { request, env } = context;
    const body = await request.json();
    const query = body.query;

    if (!query) {
      return new Response(JSON.stringify({ error: "Missing search query" }), {
        status: 400,
        headers: { "Content-Type": "application/json" }
      });
    }

    const standardizedResults = [];
    const MARGIN = 1.30; // 30% Markup on all prices

    // Helper: Safely parse stock strings into numbers so we can filter out zeros
    function parseStock(stockStr) {
      if (stockStr === null || stockStr === undefined) return 0;
      const num = parseInt(String(stockStr).replace(/[^0-9]/g, ''), 10);
      return isNaN(num) ? 0 : num;
    }

    // =========================================================================
    // 1. FETCH FROM MOUSER
    // =========================================================================
    if (env.MOUSER_API_KEY) {
      try {
        const mouserUrl = `https://api.mouser.com/api/v1/search/partnumber?apiKey=${env.MOUSER_API_KEY}`;
        const mouserPayload = {
          SearchByPartRequest: {
            mouserPartNumber: query,
            partSearchOptions: "Starts With"
          }
        };

        const mouserResponse = await fetch(mouserUrl, {
          method: "POST",
          headers: { "Content-Type": "application/json", "Accept": "application/json" },
          body: JSON.stringify(mouserPayload)
        });

        if (mouserResponse.ok) {
          const mData = await mouserResponse.json();
          if (mData.SearchResults && mData.SearchResults.Parts) {
            mData.SearchResults.Parts.forEach(part => {
              const stockNum = parseStock(part.FactoryStock || part.Availability);
              
              // BUSINESS LOGIC: Only show if stock is strictly greater than 0
              if (stockNum > 0) {
                let displayPrice = "Call for Quote";
                if (part.PriceBreaks && part.PriceBreaks.length > 0) {
                  let rawPriceStr = part.PriceBreaks[0].Price;
                  let numericPrice = parseFloat(rawPriceStr.replace(/[^0-9.]/g, ''));
                  let currencySymbol = rawPriceStr.replace(/[0-9.,]/g, '').trim() || "$";
                  
                  if (!isNaN(numericPrice) && numericPrice > 0) {
                    displayPrice = currencySymbol + (numericPrice * MARGIN).toFixed(3);
                  }
                }

                standardizedResults.push({
                  source: "Global Partner Network",
                  mpn: part.ManufacturerPartNumber || "Unknown MPN",
                  manufacturer: part.Manufacturer || "Unknown",
                  stock: stockNum.toLocaleString(), // Add commas back (e.g. 1,000)
                  price: displayPrice
                });
              }
            });
          }
        }
      } catch (err) {
        console.error("Mouser Fetch Error:", err);
      }
    }

    // =========================================================================
    // 2. FETCH FROM NEXAR (OCTOPART) AGGREGATOR
    // =========================================================================
    if (env.NEXAR_CLIENT_ID && env.NEXAR_CLIENT_SECRET) {
      try {
        // Step A: Perform OAuth2 Handshake to get temporary token
        const tokenParams = new URLSearchParams({
          grant_type: "client_credentials",
          client_id: env.NEXAR_CLIENT_ID,
          client_secret: env.NEXAR_CLIENT_SECRET
        });
        
        const tokenRes = await fetch("https://identity.nexar.com/connect/token", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: tokenParams.toString()
        });

        if (tokenRes.ok) {
          const tokenData = await tokenRes.json();
          const nexarToken = tokenData.access_token;

          // Step B: Send GraphQL Query
          const gqlQuery = `
            query getParts($q: String!) {
              supSearchMpn(q: $q, limit: 10) {
                results {
                  part {
                    mpn
                    manufacturer { name }
                    sellers {
                      offers {
                        inventoryLevel
                        prices { price currency }
                      }
                    }
                  }
                }
              }
            }
          `;

          const nexarRes = await fetch("https://api.nexar.com/graphql", {
            method: "POST",
            headers: {
              "Authorization": `Bearer ${nexarToken}`,
              "Content-Type": "application/json"
            },
            body: JSON.stringify({ query: gqlQuery, variables: { q: query } })
          });

          if (nexarRes.ok) {
            const nData = await nexarRes.json();
            if (nData.data && nData.data.supSearchMpn && nData.data.supSearchMpn.results) {
              nData.data.supSearchMpn.results.forEach(res => {
                const part = res.part;
                if (part && part.sellers) {
                  part.sellers.forEach(seller => {
                    if (seller.offers) {
                      seller.offers.forEach(offer => {
                        const stockNum = parseStock(offer.inventoryLevel);
                        
                        // BUSINESS LOGIC: Only show if stock is strictly greater than 0
                        if (stockNum > 0) {
                          let displayPrice = "Call for Quote";
                          if (offer.prices && offer.prices.length > 0) {
                            const numPrice = offer.prices[0].price;
                            const sym = offer.prices[0].currency === "USD" ? "$" : offer.prices[0].currency;
                            displayPrice = sym + (numPrice * MARGIN).toFixed(3);
                          }

                          standardizedResults.push({
                            source: "Global Partner Network",
                            mpn: part.mpn || "Unknown MPN",
                            manufacturer: (part.manufacturer && part.manufacturer.name) ? part.manufacturer.name : "Unknown",
                            stock: stockNum.toLocaleString(),
                            price: displayPrice
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          }
        }
      } catch (err) {
        console.error("Nexar Fetch Error:", err);
      }
    }

    // =========================================================================
    // 3. RETURN MERGED RESULTS TO FRONTEND
    // =========================================================================
    return new Response(JSON.stringify({ results: standardizedResults }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
}
