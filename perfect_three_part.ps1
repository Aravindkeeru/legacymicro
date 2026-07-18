$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Erase everything from the start of the logo master piece to the end of the file
$pattern = '(?s)/\* ---------- Final Polished Logo Masterpiece ---------- \*/.*$'
$cssContent = $cssContent -replace $pattern, ''

$cleanCss = @"
/* ---------- Final Polished Logo Masterpiece ---------- */
.nav-logo {
  transition: transform 0.3s ease;
  position: relative;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}

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

/* Initial State (Mu) - Glowing Fade */
.logo-init-mu {
  color: var(--accent);
  font-family: 'Times New Roman', Times, serif;
  font-style: italic;
  font-size: 2rem;
  opacity: 1;
  text-shadow: 0 0 10px rgba(59, 130, 246, 0.8), 0 0 20px rgba(59, 130, 246, 0.4);
  animation: initialMuFade 1.2s cubic-bezier(0.25, 1, 0.5, 1) 0.5s forwards;
  z-index: 3;
  pointer-events: none;
}
@keyframes initialMuFade {
  0% { transform: scale(1); opacity: 1; }
  100% { transform: scale(1.5); opacity: 0; visibility: hidden; }
}

/* Core Wrapper for 3-part animation */
.logo-core-wrapper {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

/* YM Center Fades In First */
.logo-ym {
  display: inline-flex;
  align-items: center;
  position: relative;
  z-index: 5;
  opacity: 0;
  animation: ymFadeIn 1s ease 1.5s forwards;
}
@keyframes ymFadeIn {
  0% { opacity: 0; transform: scale(0.95); }
  100% { opacity: 1; transform: scale(1); }
}

.logo-y {
  color: var(--text-primary);
}

.logo-m {
  color: var(--accent);
  display: inline-block;
  transform: skewX(-14deg) translateZ(0);
  backface-visibility: hidden;
  margin-left: -0.22em; /* Physically merges right arm of Y into skewed left leg of M */
  transform-origin: bottom left;
  position: relative;
  z-index: 6; /* M sits structurally on top of Y to form the junction */
}

/* LEGAC slides out to the left */
.logo-legac {
  color: var(--text-primary);
  display: inline-block;
  opacity: 0;
  transform: translateX(40px) translateZ(0);
  clip-path: inset(0 0 0 100%);
  -webkit-clip-path: inset(0 0 0 100%);
  animation: legacSlide 3s cubic-bezier(0.22, 1, 0.36, 1) 1.8s forwards;
}
@keyframes legacSlide {
  0% { opacity: 0; transform: translateX(40px) translateZ(0); clip-path: inset(0 0 0 100%); -webkit-clip-path: inset(0 0 0 100%); }
  5% { opacity: 1; }
  100% { opacity: 1; transform: translateX(0) translateZ(0); clip-path: inset(0 0 0 0); -webkit-clip-path: inset(0 0 0 0); }
}

/* ICRO slides out to the right */
.logo-icro {
  color: var(--accent);
  display: inline-block;
  opacity: 0;
  transform: translateX(-40px) translateZ(0);
  clip-path: inset(0 100% 0 0);
  -webkit-clip-path: inset(0 100% 0 0);
  animation: icroSlide 3s cubic-bezier(0.22, 1, 0.36, 1) 1.8s forwards;
}
@keyframes icroSlide {
  0% { opacity: 0; transform: translateX(-40px) translateZ(0); clip-path: inset(0 100% 0 0); -webkit-clip-path: inset(0 100% 0 0); }
  5% { opacity: 1; }
  100% { opacity: 1; transform: translateX(0) translateZ(0); clip-path: inset(0 0 0 0); -webkit-clip-path: inset(0 0 0 0); }
}

/* Glowing trademark */
.logo-reg {
  font-size: 0.35em;
  font-weight: 500;
  margin-left: 2px;
  color: #ef4444; /* High definition red */
  text-shadow: 0 0 6px rgba(239, 68, 68, 0.8), 0 0 12px rgba(239, 68, 68, 0.4);
  transform: translateY(-1em) translateZ(0);
  display: inline-block;
}

/* Subtitle */
.logo-subtitle {
  transition: color 0.4s ease;
  display: block;
  text-align: center;
  width: 100%;
}
"@

$cssContent += $cleanCss
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files with explicit 3-part layout
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $threePartLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; width: 230px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
            
            <!-- Primary State (3-part structure) -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span class="logo-core-wrapper">
                <span class="logo-legac">LEGAC</span>
                <span class="logo-ym">
                  <span class="logo-y">Y</span><!--
                  --><span class="logo-m">M</span>
                </span>
                <span class="logo-icro">ICRO</span>
              </span>
              <sup class="logo-reg">&reg;</sup>
            </div>
            
            <!-- Hover State (Trµsted) -->
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
    
    $content = $content -replace $logoPattern, $threePartLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=40"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied 3-part perfect sliding layout"
