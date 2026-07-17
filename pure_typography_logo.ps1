$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$newHtml = @"
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; width: 280px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.25rem; position: relative; height: 1.2em; width: 100%;">
            
            <!-- Center initial mu -->
            <span class="logo-init-mu">&#956;</span>
            
            <!-- Primary typographic text -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span class="logo-main-text">LEGACYMICRO</span>
            </div>
            
            <!-- Hover Text -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: baseline; justify-content: center;">
              <span class="logo-tr">Tr</span><span class="logo-trusted-mu">&#956;</span><span class="logo-sted">sted</span>
            </div>

          </div>
          <span class="logo-subtitle" style="font-size: 0.38em; letter-spacing: 1.5px; color: #888; font-weight: 600; margin-top: 3px;">ELECTRONIC COMPONENTS</span>
        </div>
"@

$newCss = @"
    .nav-logo { transition: transform 0.3s ease; position: relative; }
    
    /* Initial mu fades out */
    .logo-init-mu {
      position: absolute;
      top: 0; left: 0; width: 100%; height: 100%;
      display: flex; align-items: center; justify-content: center;
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 2rem;
      pointer-events: none;
      animation: initialMuFade 0.8s cubic-bezier(0.25, 1, 0.5, 1) 0.5s forwards;
      z-index: 5;
    }
    @keyframes initialMuFade {
      0% { opacity: 0; transform: scale(0.5); }
      10% { opacity: 1; transform: scale(1.1); }
      30% { opacity: 1; transform: scale(1); }
      100% { opacity: 0; transform: scale(0.8); visibility: hidden; }
    }

    /* Primary wrappers */
    .logo-primary {
      transition: opacity 0.4s ease, transform 0.4s ease;
      z-index: 2;
    }
    .logo-hover {
      opacity: 0;
      transform: translateY(10px);
      transition: opacity 0.4s ease, transform 0.4s ease;
      z-index: 3;
      pointer-events: none;
    }

    /* Hover interactions on the wrapper, NOT !important */
    .nav-logo:hover .logo-primary {
      opacity: 0;
      transform: translateY(-10px) scale(0.95);
    }
    .nav-logo:hover .logo-hover {
      opacity: 1;
      transform: translateY(0);
    }

    /* Pure Typographic Logo Reveal */
    .logo-main-text {
      background: linear-gradient(to right, #ffffff 51%, var(--accent) 51%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      opacity: 0;
      clip-path: inset(0 50% 0 50%);
      animation: textWipeIn 1s cubic-bezier(0.16, 1, 0.3, 1) 1.0s forwards;
    }
    @keyframes textWipeIn {
      0% { opacity: 0; clip-path: inset(0 50% 0 50%); letter-spacing: -2px; transform: scale(0.95); }
      10% { opacity: 1; }
      100% { opacity: 1; clip-path: inset(0 0 0 0); letter-spacing: -0.5px; transform: scale(1); }
    }

    /* Trusted texts */
    .logo-tr, .logo-sted { color: #ffffff; }
    .logo-trusted-mu {
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 1.15em;
      margin: 0 0.05em;
    }

    /* Subtitle fade and slide */
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
      transform: translateX(12px);
      color: #aaa;
    }
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        # 1. Replace HTML wrapper block completely
        $htmlRegex = '(?s)<div class="logo-text-wrapper".*?ELECTRONIC COMPONENTS</span>\s*</div>'
        $content = $content -replace $htmlRegex, $newHtml

        # 2. Replace CSS completely
        $cssRegex = '(?s)\.nav-logo\s*\{.*?(?=</style>)'
        $content = $content -replace $cssRegex, ($newCss + "`n    ")
        
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Applied highly aesthetic typographic logo to: $file"
    }
}
