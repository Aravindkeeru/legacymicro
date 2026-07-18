$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Erase the old animation timings
$pattern = '(?s)/\* Glowing Mu Intro \*/.*?(?=/\* Subtitle \*/)'
$cssContent = $cssContent -replace $pattern, ''

$newTimings = @"
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
  /* Effortless, slightly slower fade out */
  animation: swapMu 1.2s cubic-bezier(0.22, 1, 0.36, 1) 1s forwards;
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
  margin-left: -0.32em;
  transform-origin: bottom left;
  backface-visibility: hidden;
  position: relative;
  z-index: 6;
  opacity: 0;
  /* Effortless, slightly slower flip in */
  animation: swapMicro 1.2s cubic-bezier(0.22, 1, 0.36, 1) 1s forwards;
}
@keyframes swapMicro {
  0% { opacity: 0; transform: skewX(-14deg) translateY(20px); }
  100% { opacity: 1; transform: skewX(-14deg) translateY(0); }
}

/* LEGACY expands and slides to the left */
.logo-legacy-container {
  display: inline-flex;
  max-width: 0;
  overflow: hidden;
  white-space: nowrap;
  justify-content: flex-end;
  /* Very slow, dramatic, noticeable slide out after MICRO settles */
  animation: expandLegacy 4.5s cubic-bezier(0.16, 1, 0.3, 1) 1.8s forwards;
  position: relative;
  z-index: 5;
}
@keyframes expandLegacy {
  0% { max-width: 0; opacity: 0; }
  2% { opacity: 1; }
  100% { max-width: 150px; opacity: 1; }
}

.logo-legacy {
  color: var(--text-primary);
  display: inline-block;
  padding-right: 0.1em;
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
  /* Fades in ONLY after LEGACY is completely fully visible (1.8s + 4.5s = 6.3s) */
  animation: regFadeIn 2s ease 6.0s forwards; 
}
@keyframes regFadeIn {
  0% { opacity: 0; transform: translateY(-1em) translateZ(0) scale(0.8); }
  100% { opacity: 1; transform: translateY(-1em) translateZ(0) scale(1); }
}

"@

$cssContent = $cssContent -replace '/\* Subtitle \*/', "$newTimings/* Subtitle */"

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files to cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=42"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied slow effortless timings and trademark delay"
