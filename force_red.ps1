$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Add !important to trademark colors
$pattern = 'color: #ef4444; /\* High definition red \*/'
$replacement = 'color: #ef4444 !important; /* High definition red */'
$cssContent = $cssContent -replace $pattern, $replacement

$pattern2 = 'text-shadow: 0 0 6px rgba\(239, 68, 68, 0\.8\), 0 0 12px rgba\(239, 68, 68, 0\.4\);'
$replacement2 = 'text-shadow: 0 0 6px rgba(239, 68, 68, 0.8), 0 0 12px rgba(239, 68, 68, 0.4) !important;'
$cssContent = $cssContent -replace $pattern2, $replacement2

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files to cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=43"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied important tags to trademark color"
