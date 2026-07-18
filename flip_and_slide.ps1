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

/* Core Wrapper for 2-part animation */
.logo-core-wrapper {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

/* LEGACY expands and slides to the left */
.logo-legacy-container {
  display: inline-flex;
  max-width: 0;
  overflow: hidden;
  white-space: nowrap;
  justify-content: flex-end; /* Anchors the text to MICRO while expanding */
  animation: expandLegacy 3s cubic-bezier(0.22, 1, 0.36, 1) 1.5s forwards;
  position: relative;
  z-index: 5;
}
@keyframes expandLegacy {
  0% { max-width: 0; opacity: 0; }
  5% { opacity: 1; }
  100% { max-width: 150px; opacity: 1; } /* Large enough to fit LEGACY */
}

.logo-legacy {
  color: var(--text-primary);
  display: inline-block;
  padding-right: 0.1em; /* Slight padding to offset the M negative margin */
}

/* MICRO anchor container */
.logo-micro-container {
  display: inline-flex;
  position: relative;
  align-items: center;
  justify-content: center;
}

/* Glowing Mu Intro */
.logo-mu-intro {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: var(--accent);
  font-family: 'Times New Roman', Times, serif;
  font-style: italic;
  font-size: 2rem;
  text-shadow: 0 0 10px rgba(59, 130, 246, 0.8), 0 0 20px rgba(59, 130, 246, 0.4);
  animation: swapMu 0.8s cubic-bezier(0.22, 1, 0.36, 1) 0.8s forwards;
}
@keyframes swapMu {
  0% { opacity: 1; transform: translate(-50%, -50%) translateY(0); }
  100% { opacity: 0; transform: translate(-50%, -50%) translateY(-20px); visibility: hidden; }
}

/* The full word MICRO skewed */
.logo-micro-text {
  color: var(--accent);
  display: inline-block;
  transform: skewX(-14deg) translateZ(0);
  margin-left: -0.32em; /* Negative margin pulls M back over the Y when LEGACY appears */
  transform-origin: bottom left;
  backface-visibility: hidden;
  position: relative;
  z-index: 6; /* M sits structurally on top of Y to form the junction */
  opacity: 0;
  animation: swapMicro 0.8s cubic-bezier(0.22, 1, 0.36, 1) 0.8s forwards;
}
@keyframes swapMicro {
  0% { opacity: 0; transform: skewX(-14deg) translateY(20px); }
  100% { opacity: 1; transform: skewX(-14deg) translateY(0); }
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
  opacity: 0;
  animation: ymFadeIn 1s ease 1.5s forwards; /* Fades in with LEGACY */
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

# Update HTML files with explicit 2-part flip layout
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $twoPartLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; width: 230px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
            
            <!-- Primary State -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span class="logo-core-wrapper">
                
                <span class="logo-legacy-container">
                  <span class="logo-legacy">LEGACY</span>
                </span>
                
                <span class="logo-micro-container">
                  <span class="logo-mu-intro">&#956;</span>
                  <span class="logo-micro-text">MICRO</span>
                </span>

              </span>
              <sup class="logo-reg">&reg;</sup>
            </div>
            
            <!-- Hover State (Trµsted) -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; line-height: 1; margin: 0 1px; display: flex; align-items: baseline; transform: translateY(1px);">&#956;</span><span class="logo-sted" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">sted</span>
            </div>
            
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.6px; color: var(--text-secondary); font-weight: 600; margin-top: 4px; text-align: center; width: 100%;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $twoPartLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=41"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied 2-part flip and slide layout"
