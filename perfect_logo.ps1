$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Clean up ALL old logo CSS to prevent conflicts
$cssContent = $cssContent -replace '(?s)\.nav-logo \{ transition: transform 0\.3s ease; position: relative; \}.*?(?=/\* ----------)', ''
$cssContent = $cssContent -replace '(?s)/\* ---------- Typographic Logo Masterpiece ---------- \*/.*?(?=\z|\Z)', ''

$newCss = @"
/* ---------- Final Polished Logo Masterpiece ---------- */
.nav-logo { transition: transform 0.3s ease; position: relative; }

/* Primary State Container */
.logo-primary {
  transition: opacity 0.4s ease, transform 0.4s ease;
  z-index: 2;
}

/* Hover interactions */
.nav-logo:hover .logo-primary {
  opacity: 0 !important;
  transform: translateY(-10px) scale(0.95) !important;
}
.nav-logo:hover .logo-hover {
  opacity: 1 !important;
  transform: translateY(0) !important;
}
.nav-logo:hover .logo-subtitle {
  color: #aaa !important;
}

/* Initial State (Mu) with Slide Transition */
.logo-init-mu {
  color: var(--accent);
  font-family: 'Times New Roman', Times, serif;
  font-style: italic;
  font-size: 2rem;
  opacity: 1;
  animation: initialMuSlide 1s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;
  z-index: 3;
  pointer-events: none;
}
@keyframes initialMuSlide {
  0% { transform: translateX(0); opacity: 1; clip-path: inset(0 0 0 0); }
  100% { transform: translateX(-30px); opacity: 0; clip-path: inset(0 100% 0 0); visibility: hidden; }
}

/* Wrapper handles animation and clip-path */
.logo-text-animator {
  display: inline-flex;
  align-items: center;
  opacity: 0;
  clip-path: inset(0 50% 0 50%);
  animation: textWipeIn 1s cubic-bezier(0.16, 1, 0.3, 1) 1.2s forwards;
}
@keyframes textWipeIn {
  0% { opacity: 0; clip-path: inset(0 50% 0 50%); letter-spacing: -2px; transform: scale(0.95); }
  10% { opacity: 1; }
  100% { opacity: 1; clip-path: inset(0 0 0 0); letter-spacing: -0.5px; transform: scale(1); }
}

/* Inner text handles background gradient */
.logo-main-text {
  background: linear-gradient(to right, var(--text-primary) 50%, var(--accent) 50%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
  padding-right: 2px;
}

/* Subtitle */
.logo-subtitle {
  transition: color 0.4s ease;
  display: block;
  text-align: center;
  width: 100%;
}
"@

$cssContent += $newCss
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files with perfect flex-center alignment
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $perfectLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; overflow: hidden; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; overflow: hidden;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
            
            <!-- Primary State -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span class="logo-text-animator">
                <span class="logo-main-text">LEGACYMICRO<sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>
              </span>
            </div>
            
            <!-- Hover State (Trµsted) - Perfect Baseline Alignment -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; line-height: 1; margin: 0 1px; display: flex; align-items: baseline; transform: translateY(1px);">&#956;</span><span class="logo-sted" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">sted</span>
            </div>
            
            <!-- Initial State (µ) -->
            <div class="logo-init-mu" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span>&#956;</span>
            </div>
            
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.6px; color: var(--text-secondary); font-weight: 600; margin-top: 4px; text-align: center; width: 100%;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $perfectLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=30"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Perfected logo alignment and transitions"
