import os

replacements = {
  "🔍": '<i data-lucide="search"></i>',
  "🌐": '<i data-lucide="globe"></i>',
  "🌍": '<i data-lucide="globe"></i>',
  "✅": '<i data-lucide="check-circle"></i>',
  "🏭": '<i data-lucide="factory"></i>',
  "🚗": '<i data-lucide="car"></i>',
  "📡": '<i data-lucide="radio"></i>',
  "✈️": '<i data-lucide="plane"></i>',
  "🏥": '<i data-lucide="activity"></i>',
  "🔌": '<i data-lucide="plug"></i>',
  "💻": '<i data-lucide="monitor"></i>',
  "⚡": '<i data-lucide="zap"></i>',
  "🛡️": '<i data-lucide="shield"></i>',
  "🔄": '<i data-lucide="refresh-cw"></i>',
  "💰": '<i data-lucide="dollar-sign"></i>',
  "🤝": '<i data-lucide="users"></i>',
  "📦": '<i data-lucide="package"></i>',
  "📋": '<i data-lucide="clipboard-list"></i>',
  "📧": '<i data-lucide="mail"></i>',
  "📞": '<i data-lucide="phone"></i>',
  "📍": '<i data-lucide="map-pin"></i>',
  "💡": '<i data-lucide="lightbulb"></i>',
  "🕐": '<i data-lucide="clock"></i>',
  "◆ ": ""
}

dir_path = r"C:\Users\admin\.gemini\antigravity\scratch\racomlink"
files = ["index.html", "about.html", "services.html", "contact.html", "search.html"]

for file in files:
    path = os.path.join(dir_path, file)
    if os.path.exists(path):
        with open(path, "r", encoding="utf-8") as f:
            content = f.read()
        
        for k, v in replacements.items():
            content = content.replace(k, v)
            
        if "lucide@latest" not in content:
            content = content.replace('<script src="js/main.js"></script>', '<script src="https://unpkg.com/lucide@latest"></script>\n  <script>lucide.createIcons();</script>\n  <script src="js/main.js"></script>')
            
        content = content.replace('class="text-gradient"', '')
        content = content.replace('<span class="pulse-dot"></span>', '')
        
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"Updated {file}")

search_js_path = os.path.join(dir_path, "js", "search.js")
if os.path.exists(search_js_path):
    with open(search_js_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    for k, v in replacements.items():
        content = content.replace(k, v)
        
    content = content.replace("emptyState.style.display = 'none';", "emptyState.style.display = 'none';\n    if (window.lucide) window.lucide.createIcons();")
    
    with open(search_js_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated search.js")
