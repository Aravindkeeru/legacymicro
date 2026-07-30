import { onRequestPost as __api_search_js_onRequestPost } from "C:\\Users\\aravi\\.gemini\\antigravity\\scratch\\legacymicro\\functions\\api\\search.js"
import { onRequest as __api_search_v2_js_onRequest } from "C:\\Users\\aravi\\.gemini\\antigravity\\scratch\\legacymicro\\functions\\api\\search_v2.js"

export const routes = [
    {
      routePath: "/api/search",
      mountPath: "/api",
      method: "POST",
      middlewares: [],
      modules: [__api_search_js_onRequestPost],
    },
  {
      routePath: "/api/search_v2",
      mountPath: "/api",
      method: "",
      middlewares: [],
      modules: [__api_search_v2_js_onRequest],
    },
  ]