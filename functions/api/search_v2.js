// Phase 2: PRIVATE V2 INVENTORY BACKEND API
// DO NOT REPLACE production search.js with this yet.
// This is for internal testing of the D1 database.

export async function onRequestPost(context) {
  try {
    const { request, env } = context;
    const body = await request.json();
    const query = typeof body.query === 'string' ? body.query.trim() : '';

    if (!query || query.length < 3 || query.length > 50) {
      return new Response(JSON.stringify({ 
        error: "Invalid search query", 
        results: [], 
        meta: { total: 0 } 
      }), {
        status: 400,
        headers: { "Content-Type": "application/json" }
      });
    }

    const queryNorm = query.toUpperCase().replace(/[\W_]+/g, '');
    const standardizedResults = [];
    let externalFallbackUsed = false;

    // 1. QUERY LOCAL INVENTORY (Cloudflare D1)
    if (!env.DB) {
      return new Response(JSON.stringify({ error: "env.DB is undefined", envKeys: Object.keys(env) }), { status: 500 });
    }
    if (env.DB) {
      try {
        // Find best representative inventory record per part
        // Prioritize LEGACY_MICRO_STOCK (trust), then NETWORK_AVAILABLE
        // Group by mpn_search_normalized to deduplicate identical parts from multiple suppliers
        const sql = `
          SELECT 
            p.mpn_original,
            m.canonical_name as manufacturer,
            p.description,
            i.quantity_parsed,
            i.date_code_normalized,
            i.condition,
            i.availability_type,
            COUNT(i.id) OVER(PARTITION BY p.mpn_search_normalized) as source_count
          FROM parts p
          JOIN manufacturers m ON p.manufacturer_id = m.id
          JOIN inventory i ON i.part_id = p.id
          JOIN suppliers s ON i.supplier_id = s.id
          WHERE p.mpn_search_normalized LIKE ?
          AND i.is_active = 1
          ORDER BY 
            -- 6. MPN match confidence (Overall search relevance)
            CASE WHEN p.mpn_search_normalized = ? THEN 1 ELSE 2 END,
            -- 1. Inventory ownership / availability category
            CASE i.availability_type 
              WHEN 'LEGACY_MICRO_STOCK' THEN 1 
              WHEN 'NETWORK_AVAILABLE' THEN 2 
              ELSE 3 
            END,
            -- 2. Supplier active status
            CASE WHEN s.is_active = 1 THEN 1 ELSE 2 END,
            -- 3. Verification status
            CASE i.verification_status
              WHEN 'VERIFIED' THEN 1
              WHEN 'IMPORTED' THEN 2
              WHEN 'UNVERIFIED' THEN 3
              WHEN 'STALE' THEN 4
              ELSE 5
            END,
            -- 4. Supplier trust level (Higher is better, assuming 1=high or maybe 100=high? Let's sort DESC if higher is better)
            s.trust_level DESC,
            -- 5. Freshness
            COALESCE(i.source_updated_at, i.imported_at) DESC,
            -- 7. Usable quantity
            i.quantity_parsed DESC
        `;
        
        const { results } = await env.DB.prepare(sql)
          .bind(`%${queryNorm}%`, queryNorm)
          .all();

        // Manual deduplication in JS to pick the best row per MPN (since GROUP BY breaks ORDER BY priorities in simple SQLite queries)
        const seenMpn = new Set();
        
        results.forEach(row => {
          if (!seenMpn.has(row.mpn_original)) {
            seenMpn.add(row.mpn_original);
            standardizedResults.push({
              mpn: row.mpn_original,
              manufacturer: row.manufacturer,
              description: row.description,
              match_type: row.mpn_original.toUpperCase().replace(/[\W_]+/g, '') === queryNorm ? 'EXACT' : 'PARTIAL',
              availability: row.availability_type,
              public_quantity: row.quantity_parsed ? row.quantity_parsed.toLocaleString() : 'Call',
              date_code: row.date_code_normalized || 'Mixed',
              condition: row.condition || 'New',
              multiple_sources: row.source_count > 1,
              source_category: 'LEGACY_NETWORK'
            });
          }
        });
      } catch (dbErr) {
        console.error("D1 Query Error:", dbErr);
        // Fallthrough to external APIs if local fails
      }
    }

    // 2. EXTERNAL FALLBACK (Mouser / Nexar)
    // Only fire if we have zero local results or want enrichment
    if (standardizedResults.length === 0) {
      externalFallbackUsed = true;
      
      // Mouser Fetch with Timeout
      if (env.MOUSER_API_KEY) {
        try {
          const controller = new AbortController();
          const timeoutId = setTimeout(() => controller.abort(), 3500); // 3.5s strict timeout
          
          const mouserRes = await fetch(`https://api.mouser.com/api/v2/search/partnumber?apiKey=${env.MOUSER_API_KEY}`, {
            method: "POST",
            headers: { "Content-Type": "application/json", "Accept": "application/json" },
            body: JSON.stringify({ SearchByPartRequest: { mouserPartNumber: query, partSearchOptions: "Exact" } }),
            signal: controller.signal
          });
          clearTimeout(timeoutId);

          if (mouserRes.ok) {
            const mData = await mouserRes.json();
            if (mData.SearchResults && mData.SearchResults.Parts) {
              mData.SearchResults.Parts.forEach(part => {
                let stock = parseInt(part.AvailabilityInStock) || 0;
                if (stock > 0) {
                  standardizedResults.push({
                    mpn: part.ManufacturerPartNumber,
                    manufacturer: part.Manufacturer,
                    description: part.Description,
                    match_type: 'EXACT',
                    availability: 'EXTERNAL_MARKET_REFERENCE',
                    public_quantity: stock.toLocaleString(),
                    date_code: 'Mixed',
                    condition: 'New',
                    multiple_sources: false,
                    source_category: 'EXTERNAL_MARKET'
                  });
                }
              });
            }
          }
        } catch (mErr) {
          console.error("Mouser timeout/error:", mErr);
        }
      }
      
      // Nexar integration would go here with KV token caching
      // ...
    }

    return new Response(JSON.stringify({ 
      results: standardizedResults, 
      meta: { 
        total: standardizedResults.length,
        external_fallback_used: externalFallbackUsed
      } 
    }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });

  } catch (error) {
    return new Response(JSON.stringify({ 
      error: "Internal Server Error", // Do not expose stack traces
      results: [],
      meta: { total: 0 }
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
}
