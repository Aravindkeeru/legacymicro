export async function onRequest(context) {
  const { env } = context;

  if (!env.DB) {
    return new Response("Database not configured", { status: 500 });
  }

  try {
    // 1. Gather stats from the past 24 hours
    const searchStats = await env.DB.prepare(`
      SELECT 
        COUNT(*) as total_searches,
        COUNT(DISTINCT client_ip) as unique_searchers
      FROM search_logs 
      WHERE created_at >= datetime('now', '-1 day')
    `).first();

    const topSearches = await env.DB.prepare(`
      SELECT query_raw, COUNT(*) as count 
      FROM search_logs 
      WHERE created_at >= datetime('now', '-1 day')
      GROUP BY query_normalized
      ORDER BY count DESC 
      LIMIT 10
    `).all();

    const visitorStats = await env.DB.prepare(`
      SELECT 
        COUNT(*) as total_pageviews,
        COUNT(DISTINCT client_ip) as unique_visitors
      FROM visitor_logs 
      WHERE created_at >= datetime('now', '-1 day')
    `).first();

    const topPages = await env.DB.prepare(`
      SELECT path, COUNT(*) as views 
      FROM visitor_logs 
      WHERE created_at >= datetime('now', '-1 day')
      GROUP BY path
      ORDER BY views DESC 
      LIMIT 10
    `).all();

    // 2. Format the report
    let reportText = `Daily Analytics Report for legacy-micro.com\n`;
    reportText += `-------------------------------------------\n\n`;
    
    reportText += `VISITORS (Last 24 Hours):\n`;
    reportText += `- Unique Visitors: ${visitorStats.unique_visitors}\n`;
    reportText += `- Total Pageviews: ${visitorStats.total_pageviews}\n\n`;

    reportText += `TOP PAGES VISITED:\n`;
    topPages.results.forEach(p => {
      reportText += `- ${p.path} (${p.views} views)\n`;
    });

    reportText += `\nSEARCH QUERIES (Last 24 Hours):\n`;
    reportText += `- Unique Searchers: ${searchStats.unique_searchers}\n`;
    reportText += `- Total Searches: ${searchStats.total_searches}\n\n`;

    reportText += `TOP SEARCHED PART NUMBERS:\n`;
    if (topSearches.results.length === 0) {
      reportText += `- No searches in the last 24 hours.\n`;
    } else {
      topSearches.results.forEach(s => {
        reportText += `- "${s.query_raw}" (${s.count} times)\n`;
      });
    }

    // 3. Send via existing Formspree account
    // This will send an email to whatever email is configured for this Formspree form ID
    const formspreeResponse = await fetch("https://formspree.io/f/meeyadad", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        subject: "Legacy Micro - Daily Analytics Report",
        message: reportText,
        email: "analytics-bot@legacy-micro.com"
      })
    });

    if (!formspreeResponse.ok) {
      throw new Error(`Formspree rejected: ${formspreeResponse.statusText}`);
    }

    return new Response(JSON.stringify({ 
      success: true, 
      message: "Daily report generated and sent successfully." 
    }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
}
