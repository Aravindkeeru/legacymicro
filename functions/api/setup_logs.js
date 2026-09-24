export async function onRequest(context) {
  const { request, env } = context;

  // Only allow GET or POST
  if (request.method !== "GET" && request.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method Not Allowed" }), { status: 405 });
  }

  if (!env.DB) {
    return new Response(JSON.stringify({ error: "Database not configured" }), { status: 500 });
  }

  try {
    const searchLogsSql = `
      CREATE TABLE IF NOT EXISTS search_logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          query_raw TEXT NOT NULL,
          query_normalized TEXT NOT NULL,
          results_count INTEGER NOT NULL,
          client_ip TEXT,
          user_agent TEXT,
          created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    `;

    const visitorLogsSql = `
      CREATE TABLE IF NOT EXISTS visitor_logs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          path TEXT NOT NULL,
          referrer TEXT,
          client_ip TEXT,
          user_agent TEXT,
          created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    `;

    // Execute the table creation
    await env.DB.exec(searchLogsSql);
    await env.DB.exec(visitorLogsSql);

    return new Response(JSON.stringify({ 
      success: true, 
      message: "search_logs and visitor_logs tables created successfully." 
    }), {
      status: 200,
      headers: { "Content-Type": "application/json" }
    });

  } catch (error) {
    return new Response(JSON.stringify({ 
      error: "Internal Server Error", 
      details: error.message 
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
}
