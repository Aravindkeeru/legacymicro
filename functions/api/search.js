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

    // Security Check: Ensure API key is configured
    if (!env.MOUSER_API_KEY) {
      return new Response(JSON.stringify({ error: "Server Configuration Error: Mouser API Key not found" }), {
        status: 500,
        headers: { "Content-Type": "application/json" }
      });
    }

    // 1. Query Mouser API
    const mouserUrl = `https://api.mouser.com/api/v1/search/partnumber?apiKey=${env.MOUSER_API_KEY}`;
    const mouserPayload = {
      SearchByPartRequest: {
        mouserPartNumber: query,
        partSearchOptions: "Starts With"
      }
    };

    const mouserResponse = await fetch(mouserUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(mouserPayload)
    });

    if (!mouserResponse.ok) {
       return new Response(JSON.stringify({ error: "Upstream API Error" }), {
         status: mouserResponse.status,
         headers: { "Content-Type": "application/json" }
       });
    }

    const data = await mouserResponse.json();
    
    // 2. Format results into a standardized Hybrid JSON schema
    const standardizedResults = [];
    
    if (data.SearchResults && data.SearchResults.Parts) {
      data.SearchResults.Parts.forEach(part => {
        // Extract price, add 35% Margin for Resale
        let displayPrice = "Call for Quote";
        if (part.PriceBreaks && part.PriceBreaks.length > 0) {
          let rawPriceStr = part.PriceBreaks[0].Price;
          // Extract just the numbers (e.g., "$0.15" -> 0.15)
          let numericPrice = parseFloat(rawPriceStr.replace(/[^0-9.]/g, ''));
          // Extract the currency symbol (e.g., "$")
          let currencySymbol = rawPriceStr.replace(/[0-9.,]/g, '').trim() || "$";
          
          if (!isNaN(numericPrice) && numericPrice > 0) {
            let marginMarkup = 1.30; // 30% Margin
            let finalPrice = numericPrice * marginMarkup;
            displayPrice = currencySymbol + finalPrice.toFixed(3);
          } else {
            displayPrice = "Call for Quote";
          }
        }

        standardizedResults.push({
          source: "Global Partner Network", // Hiding 'Mouser' from the customer
          mpn: part.ManufacturerPartNumber || "Unknown MPN",
          manufacturer: part.Manufacturer || "Unknown",
          description: part.Description || "",
          stock: part.FactoryStock || part.Availability || "0",
          price: displayPrice,
          datasheet: part.DataSheetUrl || "#",
          lifecycle: part.LifecycleStatus || "Active",
          url: "#" // Don't link to Mouser, force them to request a quote
        });
      });
    }

    // 3. Return securely to frontend
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
