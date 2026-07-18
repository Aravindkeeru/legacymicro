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

/* Wrapper handles aesthetic clip-path reveal and dramatic letter-spacing slide */
.logo-text-animator {
  display: inline-flex;
  align-items: center;
  position: relative;
  opacity: 0;
  clip-path: inset(0 50% 0 50%);
  -webkit-clip-path: inset(0 50% 0 50%);
  animation: textWipeIn 3.5s cubic-bezier(0.22, 1, 0.36, 1) 1.5s forwards;
}
@keyframes textWipeIn {
  0% { opacity: 0; clip-path: inset(0 50% 0 50%); -webkit-clip-path: inset(0 50% 0 50%); letter-spacing: -3px; transform: scale(0.98); }
  5% { opacity: 1; }
  100% { opacity: 1; clip-path: inset(0 -10px 0 -10px); -webkit-clip-path: inset(0 -10px 0 -10px); letter-spacing: -0.5px; transform: scale(1); }
}

/* Rock-solid iOS Safari fix: Dual layer text, NO background-clip */
.logo-layer-base {
  color: var(--text-primary);
  display: inline-flex;
  align-items: center;
  padding-right: 2px;
  padding-left: 2px;
  position: relative;
}
.logo-layer-accent {
  color: var(--accent);
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  display: inline-flex;
  align-items: center;
  padding-right: 2px;
  padding-left: 2px;
  /* Push clip-path to 55% to reduce blue proportion on the Y */
  clip-path: inset(0 0 0 54%);
  -webkit-clip-path: inset(0 0 0 54%);
  pointer-events: none;
}

/* Typographic innovation: Skewing MICRO to create a massive single slanting slash with Y */
.logo-micro {
  display: inline-block;
  transform: skewX(-14deg) translateZ(0);
  backface-visibility: hidden;
  margin-left: -0.22em; /* Heavily overlaps the skewed M leg perfectly into the Y arm */
  letter-spacing: inherit;
  transform-origin: bottom left;
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

# Update HTML files to cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=39"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied clean CSS and adjusted clip-path to 54%"
