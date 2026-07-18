$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# 1. Update font-family for .logo-legacy
$patternLegacy = '(?s)\.logo-legacy \{\s*color:\s*var\(--text-primary\);\s*display:\s*inline-block;\s*padding-right:\s*0\.1em;\s*\}'
$newLegacy = @"
.logo-legacy {
  color: var(--text-primary);
  display: inline-block;
  padding-right: 0.1em;
  font-family: 'Gilroy', 'TT Norms Pro', 'Nexa', 'Mont', 'Outfit', 'Montserrat', sans-serif;
  font-weight: 800;
  font-style: normal;
  letter-spacing: -1px; /* Tighter geometric tracking */
}
"@
$cssContent = $cssContent -replace $patternLegacy, $newLegacy

# 2. Update font-family, width, and gap for .logo-micro-text
$patternMicro = '(?s)\.logo-micro-text \{\s*color:\s*var\(--accent\);\s*display:\s*inline-block;\s*transform:\s*skewX\(-14deg\)\s*translateZ\(0\);\s*margin-left:\s*-0\.32em;\s*letter-spacing:\s*0\.5px;.*?(?=opacity:\s*0;)'
$newMicro = @"
.logo-micro-text {
  color: var(--accent);
  display: inline-block;
  font-family: 'Gilroy', 'TT Norms Pro', 'Nexa', 'Mont', 'Outfit', 'Montserrat', sans-serif;
  font-weight: 800;
  font-style: italic;
  /* Keep skew to maintain the exact 14deg Y/M merge, scaleX to increase width by 5% */
  transform: scaleX(1.05) skewX(-14deg) translateZ(0); 
  /* Reduce gap by 10% (from -0.32em to -0.35em) */
  margin-left: -0.35em;
  letter-spacing: 0.5px;
  transform-origin: bottom left;
  backface-visibility: hidden;
  position: relative;
  z-index: 6;
"@
$cssContent = $cssContent -replace $patternMicro, $newMicro

# Also inject google fonts at the top of CSS
$cssContent = $cssContent -replace "@import url\('https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;450;500;600;700;800&family=JetBrains\+Mono:wght@400;500&display=swap'\);", "@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;450;500;600;700;800&family=JetBrains+Mono:wght@400;500&family=Outfit:wght@800&family=Montserrat:ital,wght@0,800;1,800&display=swap');"

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Now update all HTML files to inject the google font
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $content = $content -replace "family=Inter:wght@300;400;450;500;600;700;800&amp;family=JetBrains\+Mono:wght@400;500&amp;display=swap", "family=Inter:wght@300;400;450;500;600;700;800&amp;family=JetBrains+Mono:wght@400;500&amp;family=Outfit:wght@800&amp;family=Montserrat:ital,wght@0,800;1,800&amp;display=swap"
    $content = $content -replace "family=Inter:wght@300;400;450;500;600;700;800&family=JetBrains\+Mono:wght@400;500&display=swap", "family=Inter:wght@300;400;450;500;600;700;800&family=JetBrains+Mono:wght@400;500&family=Outfit:wght@800&family=Montserrat:ital,wght@0,800;1,800&display=swap"
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=61"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied premium geometric font update"
