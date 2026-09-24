export async function onRequest(context) {
  const { request, env } = context;
  
  if (request.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method Not Allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json", "Allow": "POST" }
    });
  }

  // Handle CORS preflight (if needed)
  const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type"
  };

  try {
    let body;
    try {
      body = await request.json();
    } catch (e) {
      return new Response(JSON.stringify({ error: "Bad Request" }), {
        status: 400,
        headers: { "Content-Type": "application/json", ...corsHeaders }
      });
    }

    if (!env.DB) {
      return new Response(JSON.stringify({ error: "Database not configured" }), {
        status: 500,
        headers: { "Content-Type": "application/json", ...corsHeaders }
      });
    }

    const path = typeof body.path === 'string' ? body.path.substring(0, 500) : '/';
    const referrer = typeof body.referrer === 'string' ? body.referrer.substring(0, 1000) : '';
    const clientIp = request.headers.get("CF-Connecting-IP") || "";
    const userAgent = request.headers.get("User-Agent") || "";

    // Asynchronously log the visitor
    context.waitUntil(
      env.DB.prepare("INSERT INTO visitor_logs (path, referrer, client_ip, user_agent) VALUES (?, ?, ?, ?)")
        .bind(path, referrer, clientIp, userAgent)
        .run().catch(e => console.error("Failed to log visitor:", e))
    );

    return new Response(JSON.stringify({ success: true }), {
      status: 200,
      headers: { "Content-Type": "application/json", ...corsHeaders }
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: "Internal Server Error" }), {
      status: 500,
      headers: { "Content-Type": "application/json", ...corsHeaders }
    });
  }
}
