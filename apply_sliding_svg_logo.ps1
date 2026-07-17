$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$newHtml = @"
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; width: 280px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.25rem; display: flex; align-items: center; justify-content: center; position: relative; height: 1.2em; width: 100%;">
            <!-- Initial Greek U -->
            <span class="logo-init-mu">&#956;</span>
            
            <!-- YM Custom SVG Merge -->
            <svg class="logo-ym-svg" viewBox="0 0 53 24" preserveAspectRatio="xMidYMid meet" style="height: 0.9em; width: auto; margin-top: 1px;">
              <!-- White Y left arm -->
              <path d="M 0 0 L 8 0 L 23 24 L 15 24 Z" fill="#ffffff" />
              <!-- Blue shared arm (Y right + M left) -->
              <path d="M 30 0 L 38 0 L 23 24 L 15 24 Z" fill="var(--accent)" />
              <!-- Blue M middle arm -->
              <path d="M 30 0 L 38 0 L 53 24 L 45 24 Z" fill="var(--accent)" />
              <!-- Blue M right stem -->
              <path d="M 45 0 L 53 0 L 53 24 L 45 24 Z" fill="var(--accent)" />
            </svg>
            
            <!-- Text sliding left -->
            <span class="logo-legac">LEGAC</span>
            
            <!-- Text sliding right -->
            <span class="logo-icro">ICRO</span>
            
            <!-- Hover Text -->
            <span class="logo-trusted-state">
              <span class="logo-tr">Tr</span><span class="logo-trusted-mu">&#956;</span><span class="logo-sted">sted</span>
            </span>
          </div>
          <span class="logo-subtitle" style="font-size: 0.38em; letter-spacing: 1.5px; color: #888; font-weight: 600; margin-top: 3px;">ELECTRONIC COMPONENTS</span>
        </div>
"@

$newCss = @"
    .nav-logo { transition: transform 0.3s ease; position: relative; display: flex; align-items: center; }
    
    .logo-init-mu {
      position: absolute;
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 2rem;
      opacity: 1;
      transform: scale(0.9);
      animation: initialMuFade 0.8s cubic-bezier(0.25, 1, 0.5, 1) 0.5s forwards;
      z-index: 5;
      pointer-events: none;
    }
    @keyframes initialMuFade {
      0% { opacity: 0; transform: scale(0.5); }
      10% { opacity: 1; transform: scale(1.1); }
      30% { opacity: 1; transform: scale(1); }
      100% { opacity: 0; transform: scale(0.8); visibility: hidden; }
    }

    .logo-ym-svg {
      position: absolute;
      opacity: 0;
      transform: scale(0.8);
      animation: fadeYMIn 0.8s cubic-bezier(0.25, 1, 0.5, 1) 1.0s forwards;
      z-index: 4;
      transition: opacity 0.3s ease, transform 0.3s ease;
    }
    @keyframes fadeYMIn {
      0% { opacity: 0; transform: scale(0.8); }
      100% { opacity: 1; transform: scale(1); }
    }

    .logo-legac {
      position: absolute;
      right: 50%;
      margin-right: 12px;
      color: #ffffff;
      opacity: 0;
      clip-path: inset(0 0 0 100%);
      animation: slideLegac 1.2s cubic-bezier(0.16, 1, 0.3, 1) 1.2s forwards;
      transition: opacity 0.3s ease, transform 0.3s ease;
    }
    @keyframes slideLegac {
      0% { opacity: 0; transform: translateX(20px); clip-path: inset(0 0 0 100%); }
      100% { opacity: 1; transform: translateX(0); clip-path: inset(0 0 0 0); }
    }

    .logo-icro {
      position: absolute;
      left: 50%;
      margin-left: 12px;
      color: var(--accent);
      opacity: 0;
      clip-path: inset(0 100% 0 0);
      animation: slideIcro 1.2s cubic-bezier(0.16, 1, 0.3, 1) 1.2s forwards;
      transition: opacity 0.3s ease, transform 0.3s ease;
    }
    @keyframes slideIcro {
      0% { opacity: 0; transform: translateX(-20px); clip-path: inset(0 100% 0 0); }
      100% { opacity: 1; transform: translateX(0); clip-path: inset(0 0 0 0); }
    }

    .logo-trusted-state {
      position: absolute;
      display: flex;
      align-items: baseline;
      opacity: 0;
      transform: translateY(10px);
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
      z-index: 10;
    }
    .logo-tr, .logo-sted { color: #ffffff; }
    .logo-trusted-mu {
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 1.15em;
      margin: 0 0.05em;
    }

    .nav-logo:hover .logo-legac,
    .nav-logo:hover .logo-icro,
    .nav-logo:hover .logo-ym-svg {
      opacity: 0 !important;
      transform: translateY(-10px) scale(0.95) !important;
    }
    
    .nav-logo:hover .logo-trusted-state {
      opacity: 1;
      transform: translateY(0);
    }

    .logo-subtitle {
      opacity: 0;
      transform: translateY(5px);
      animation: fadeSubtitle 1s cubic-bezier(0.16, 1, 0.3, 1) 1.8s forwards;
      transition: transform 0.4s ease, color 0.4s ease;
    }
    @keyframes fadeSubtitle {
      100% { opacity: 1; transform: translateY(0); }
    }
    .nav-logo:hover .logo-subtitle {
      transform: translateX(12px) !important;
      color: #aaa !important;
    }
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        # Replace HTML
        $htmlRegex = '(?s)<div class="logo-text-wrapper".*?ELECTRONIC COMPONENTS</span>\s*</div>'
        $content = $content -replace $htmlRegex, $newHtml

        # Replace CSS
        $cssRegex = '(?s)\.nav-logo\s*\{.*?@keyframes fadeSubtitle.*?\}\s*\}'
        $content = $content -replace $cssRegex, ($newCss + "`n")
        
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Applied perfect SVG merge & sliding animation to: $file"
    }
}
