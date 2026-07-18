$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Remove the old SVG animation CSS block completely
$pattern = '(?s)/\* ---------- Logo Masterpiece Animations ---------- \*/.*?(?=\z|\Z)'
$cssContent = $cssContent -replace $pattern, ''

$newCss = @"
/* ---------- Typographic Logo Masterpiece ---------- */
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
  transform: translateX(12px) !important;
  color: #aaa !important;
}

/* Initial State (Mu) */
.logo-init-mu {
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

/* 
  CRITICAL iOS SAFARI FIX:
  iOS Safari completely breaks when clip-path, transform, and background-clip: text 
  are applied to the exact same element (renders as a solid box).
  The fix is to separate concerns: the wrapper handles animations, the inner span handles text gradient.
*/

/* Wrapper handles animation and clip-path */
.logo-text-animator {
  display: inline-flex;
  align-items: center;
  opacity: 0;
  clip-path: inset(0 50% 0 50%);
  animation: textWipeIn 1s cubic-bezier(0.16, 1, 0.3, 1) 1.0s forwards;
}
@keyframes textWipeIn {
  0% { opacity: 0; clip-path: inset(0 50% 0 50%); letter-spacing: -2px; transform: scale(0.95); }
  10% { opacity: 1; }
  100% { opacity: 1; clip-path: inset(0 0 0 0); letter-spacing: -0.5px; transform: scale(1); }
}

/* Inner text handles background gradient */
.logo-main-text {
  background: linear-gradient(to right, var(--text-primary) 51.5%, var(--accent) 51.5%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
  padding-right: 2px; /* Prevent italics or descenders from clipping */
}

/* Subtitle */
.logo-subtitle {
  transition: transform 0.4s ease, color 0.4s ease;
}
"@

$cssContent += $newCss
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
Write-Output "Added Typographic CSS"

# Update HTML files
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $typoLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; overflow: hidden; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: flex-start; line-height: 1; width: 170px; overflow: hidden;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%;">
            
            <!-- Primary State (Pure Typographic Gradient Reveal) -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: flex-start;">
              <span class="logo-text-animator">
                <span class="logo-main-text">LEGACYMICRO<sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>
              </span>
            </div>
            
            <!-- Hover State (Trµsted) -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: baseline; justify-content: flex-start; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr" style="color: var(--text-primary);">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; margin: 0 1px;">&#956;</span><span class="logo-sted" style="color: var(--text-primary);">sted</span>
            </div>
            
            <!-- Initial State (µ) -->
            <div class="logo-init-mu" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: flex-start;">
              <span style="margin-left: 55px;">&#956;</span>
            </div>
            
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.5px; color: var(--text-secondary); font-weight: 600; margin-top: 4px;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $typoLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=29"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Restored typographic logo in $($file.Name)"
}
