$dir = "C:\Users\admin\.gemini\antigravity\scratch\racomlink"
$files = @("index.html", "about.html", "services.html", "contact.html", "search.html")

$replacements = [ordered]@{
  "🔍" = '<i data-lucide="search"></i>'
  "🌐" = '<i data-lucide="globe"></i>'
  "🌍" = '<i data-lucide="globe"></i>'
  "✅" = '<i data-lucide="check-circle"></i>'
  "🏭" = '<i data-lucide="factory"></i>'
  "🚗" = '<i data-lucide="car"></i>'
  "📡" = '<i data-lucide="radio"></i>'
  "✈️" = '<i data-lucide="plane"></i>'
  "🏥" = '<i data-lucide="activity"></i>'
  "🔌" = '<i data-lucide="plug"></i>'
  "💻" = '<i data-lucide="monitor"></i>'
  "⚡" = '<i data-lucide="zap"></i>'
  "🛡️" = '<i data-lucide="shield"></i>'
  "🔄" = '<i data-lucide="refresh-cw"></i>'
  "💰" = '<i data-lucide="dollar-sign"></i>'
  "🤝" = '<i data-lucide="users"></i>'
  "📦" = '<i data-lucide="package"></i>'
  "📋" = '<i data-lucide="clipboard-list"></i>'
  "📧" = '<i data-lucide="mail"></i>'
  "📞" = '<i data-lucide="phone"></i>'
  "📍" = '<i data-lucide="map-pin"></i>'
  "💡" = '<i data-lucide="lightbulb"></i>'
  "🕐" = '<i data-lucide="clock"></i>'
  "◆ " = ""
}

foreach ($file in $files) {
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        foreach ($key in $replacements.Keys) {
            $content = $content.Replace($key, $replacements[$key])
        }
        
        if (-not $content.Contains("lucide@latest")) {
            $content = $content.Replace('<script src="js/main.js"></script>', "<script src=`"https://unpkg.com/lucide@latest`"></script>`n  <script>lucide.createIcons();</script>`n  <script src=`"js/main.js`"></script>")
        }
        
        $content = $content.Replace('class="text-gradient"', '')
        $content = $content.Replace('<span class="pulse-dot"></span>', '')
        
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $file"
    }
}

$searchJsPath = Join-Path $dir "js\search.js"
if (Test-Path $searchJsPath) {
    $content = [System.IO.File]::ReadAllText($searchJsPath, [System.Text.Encoding]::UTF8)
    foreach ($key in $replacements.Keys) {
        $content = $content.Replace($key, $replacements[$key])
    }
    
    $content = $content.Replace("emptyState.style.display = 'none';", "emptyState.style.display = 'none';`n    if (window.lucide) window.lucide.createIcons();")
    
    [System.IO.File]::WriteAllText($searchJsPath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated search.js"
}
