$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$newHtml = @"
        <div class="logo-text-wrapper" style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start; line-height: 1; position: relative;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.2rem; display: flex; align-items: center; position: relative; height: 1.2em; width: 100%;">
            <!-- Initial Greek U -->
            <span class="logo-init-mu">&#956;</span>
            
            <!-- Main Text -->
            <span class="logo-legacy-micro">
              <span class="logo-legacy">LEGACY</span><span class="logo-micro">MICRO</span>
            </span>
            
            <!-- Hover Text -->
            <span class="logo-trusted-state">
              <span class="logo-tr">Tr</span><span class="logo-trusted-mu">&#956;</span><span class="logo-sted">sted</span>
            </span>
          </div>
          <span class="logo-subtitle" style="font-size: 0.38em; letter-spacing: 1.5px; color: #888; font-weight: 600; margin-top: 3px;">ELECTRONIC COMPONENTS</span>
        </div>
"@

$newCss = @"
    .nav-logo { transition: transform 0.3s ease; position: relative; }
    .logo-init-mu {
      position: absolute;
      left: 35%; /* Center roughly over the logo area */
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 2rem;
      opacity: 1;
      animation: initialMuFade 2s cubic-bezier(0.25, 1, 0.5, 1) forwards;
      z-index: 3;
      pointer-events: none;
    }
    @keyframes initialMuFade {
      0% { transform: scale(0.5); opacity: 0; }
      20% { transform: scale(1.2); opacity: 1; }
      60% { transform: scale(1); opacity: 1; }
      100% { transform: scale(2.5); opacity: 0; visibility: hidden; }
    }
    .logo-legacy-micro {
      position: absolute;
      left: 0;
      display: flex;
      align-items: baseline;
      opacity: 0;
      transform: scale(0.8);
      animation: expandLegacyMicro 1.2s cubic-bezier(0.25, 1, 0.5, 1) 1.2s forwards;
      transition: opacity 0.4s ease, transform 0.4s ease;
    }
    .logo-legacy { color: #ffffff; }
    .logo-micro { color: var(--accent); }
    @keyframes expandLegacyMicro {
      0% { opacity: 0; transform: scale(0.9) translateY(10px); letter-spacing: -2px; }
      100% { opacity: 1; transform: scale(1) translateY(0); letter-spacing: -0.5px; }
    }
    .logo-trusted-state {
      position: absolute;
      left: 10px; /* Adjust to center visually */
      display: flex;
      align-items: baseline;
      opacity: 0;
      transform: translateY(10px);
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .logo-tr, .logo-sted { color: #ffffff; }
    .logo-trusted-mu {
      color: var(--accent);
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-size: 1.15em;
      margin: 0 0.05em;
    }
    .nav-logo:hover .logo-legacy-micro {
      opacity: 0;
      transform: translateY(-10px) scale(0.95);
    }
    .nav-logo:hover .logo-trusted-state {
      opacity: 1;
      transform: translateY(0);
    }
    .logo-subtitle {
      transition: transform 0.4s ease, color 0.4s ease;
    }
    .nav-logo:hover .logo-subtitle {
      transform: translateX(12px); /* Shift right slightly */
      color: #aaa !important;
    }
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        
        # Replace HTML
        $htmlRegex = '(?s)<div style="display: flex; flex-direction: column; justify-content: center; line-height: 1;">.*?ELECTRONIC COMPONENTS</span>\s*</div>'
        $content = $content -replace $htmlRegex, $newHtml

        # Replace CSS
        # Because we've completely changed the animation names, let's remove everything from .nav-logo { down to the last @keyframe block before </style>
        $cssRegex = '(?s)\.nav-logo\s*\{.*?@keyframes slideLegacyOut.*?\}\s*\}'
        $content = $content -replace $cssRegex, ($newCss + "`n")
        
        [System.IO.File]::WriteAllText($path, $content)
        Write-Output "Applied final animation to: $file"
    }
}
