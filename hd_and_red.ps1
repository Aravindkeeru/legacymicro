$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Add antialiasing to the main logo class
$logoTarget = ".nav-logo { transition: transform 0.3s ease; position: relative; }"
$logoReplace = ".nav-logo { transition: transform 0.3s ease; position: relative; -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale; text-rendering: optimizeLegibility; }"
$cssContent = $cssContent.Replace($logoTarget, $logoReplace)

# Add hardware acceleration to logo-micro for high definition rendering of the skew
$microTarget = "transform: skewX(-14deg);"
$microReplace = "transform: skewX(-14deg) translateZ(0);`n  backface-visibility: hidden;"
$cssContent = $cssContent.Replace($microTarget, $microReplace)

# Change trademark to red and add hardware acceleration
$regTarget = @"
.logo-reg {
  font-size: 0.35em;
  font-weight: 500;
  margin-left: 2px;
  color: var(--accent);
  text-shadow: 0 0 6px rgba(59, 130, 246, 0.8), 0 0 12px rgba(59, 130, 246, 0.4);
  transform: translateY(-1em);
  display: inline-block;
}
"@
$regReplace = @"
.logo-reg {
  font-size: 0.35em;
  font-weight: 500;
  margin-left: 2px;
  color: #ef4444;
  text-shadow: 0 0 6px rgba(239, 68, 68, 0.8), 0 0 12px rgba(239, 68, 68, 0.4);
  transform: translateY(-1em) translateZ(0);
  display: inline-block;
}
"@
$cssContent = $cssContent -replace '(?s)\.logo-reg \{.*?display: inline-block;`r?`n\}', $regReplace

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files to cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=37"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied high-definition text rendering and red trademark"
