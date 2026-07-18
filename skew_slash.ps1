$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Replace the old logo-merge with the new logo-micro skew approach
$cssContent = $cssContent -replace '(?s)\.logo-merge \{.*?\}', @"
/* Typographic innovation: Skewing MICRO to create a massive single slanting slash with Y */
.logo-micro {
  display: inline-block;
  transform: skewX(-14deg);
  margin-left: -0.22em; /* Heavily overlaps the skewed M leg perfectly into the Y arm */
  letter-spacing: inherit;
  transform-origin: bottom left;
}
"@

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files to use logo-micro instead of logo-merge
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $content = $content -replace '<span class="logo-merge">MICRO</span>', '<span class="logo-micro">MICRO</span>'
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=36"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied dynamic skewed M to create single massive slash"
