$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$newHtml = @"
          <span style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.2rem; display: flex; align-items: baseline;">
            <span class="logo-legacy-group">
              <span class="logo-legacy" style="color: #ffffff !important;">LEGAC</span>
              <span class="logo-y">Y</span>
            </span>
            <span class="logo-micro-group">
              <span class="logo-m">M</span>
              <span class="logo-icro">ICRO</span>
              <span class="logo-trusted">
                <span class="logo-tr">tr</span><span class="logo-mu">&#956;</span><span class="logo-sted">sted</span>
              </span>
            </span>
          </span>
"@

$newCss = @"
    .nav-logo { transition: transform 0.3s ease; }
    .logo-legacy-group {
      display: inline-flex;
      align-items: baseline;
      opacity: 0;
      animation: slideLegacyOut 1.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }
    .logo-legacy { 
      color: #ffffff !important; 
      transition: color 0.3s ease; 
    }
    .logo-y { 
      background: linear-gradient(to right, #ffffff 45%, var(--accent) 55%); 
      -webkit-background-clip: text; 
      -webkit-text-fill-color: transparent; 
      position: relative; 
      z-index: 2;
      transition: all 0.3s ease;
    }
    .logo-micro-group {
      display: inline-flex;
      align-items: baseline;
      animation: microFade 1s ease-out 0.5s forwards;
      opacity: 0;
      position: relative;
    }
    .logo-m {
      color: var(--accent);
      clip-path: polygon(30% 0, 100% 0, 100% 100%, 25% 100%);
      margin-left: -0.36em;
      position: relative;
      z-index: 1;
      transition: opacity 0.4s ease, transform 0.4s ease;
    }
    .logo-icro {
      color: var(--accent);
      margin-left: -0.05em;
      transition: opacity 0.4s ease, transform 0.4s ease;
    }
    .logo-trusted {
      position: absolute;
      left: -0.2em;
      top: 0;
      display: inline-flex;
      align-items: baseline;
      opacity: 0;
      transform: translateY(10px) scale(0.9);
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
      pointer-events: none;
      color: var(--accent);
      text-transform: lowercase;
      font-size: 1.05em;
    }
    .logo-mu {
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-weight: bold;
      font-size: 1.1em;
      margin: 0 0.02em;
    }
    .logo-tr, .logo-sted {
      color: var(--accent);
      letter-spacing: -0.5px;
    }
    .nav-logo:hover .logo-m,
    .nav-logo:hover .logo-icro {
      opacity: 0;
      transform: translateY(-5px);
    }
    .nav-logo:hover .logo-trusted {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
    .nav-logo:hover .logo-legacy { color: #ffffff !important; }
    .nav-logo:hover .logo-y { 
      background: linear-gradient(to right, #ffffff 50%, var(--accent) 50%) !important; 
      -webkit-background-clip: text !important; 
      -webkit-text-fill-color: transparent !important; 
    }
    @keyframes microFade {
      0% { opacity: 0; transform: translateX(-10px); }
      100% { opacity: 1; transform: translateX(0); }
    }
    @keyframes slideLegacyOut {
      0% { opacity: 0; transform: translateX(20px); clip-path: inset(0 100% 0 0); }
      100% { opacity: 1; transform: translateX(0); clip-path: inset(0 -20px 0 0); }
    }
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        
        # Replace HTML block in header and footer
        $htmlRegex = '(?s)<span style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.2rem; display: flex; align-items: baseline;">.*?</span>\s*</span>'
        $content = $content -replace $htmlRegex, $newHtml

        # Replace CSS
        $cssRegex = '(?s)\.nav-logo\s*\{.*?@keyframes slideLegacyOut\s*\{.*?\}[\s\}]*?(?=</style>)'
        $content = $content -replace $cssRegex, ($newCss + "`n    ")
        
        [System.IO.File]::WriteAllText($path, $content)
        Write-Output "Fixed trμsted in: $file"
    }
}
