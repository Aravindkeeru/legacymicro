$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Remove font-style: italic and change to font-style: normal for MICRO
$patternMicro = '(?s)\.logo-micro-text \{.*?(?=transform:\s*scaleX\(1\.05\))'
$newMicro = @"
.logo-micro-text {
  color: var(--accent);
  display: inline-block;
  font-family: 'Gilroy', 'TT Norms Pro', 'Nexa', 'Mont', 'Outfit', 'Montserrat', sans-serif;
  font-weight: 800;
  font-style: normal; /* Removed native italic! Keep it upright to preserve identical geometric letterforms */
  /* Keep skew to maintain the exact 14deg Y/M merge, scaleX to increase width by 5% */
  "@
$cssContent = $cssContent -replace $patternMicro, $newMicro

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Now update cache bust in all HTML files
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=62"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Removed native italic from MICRO"
