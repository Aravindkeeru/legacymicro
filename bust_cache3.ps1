$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Aggressive cache bust
    $content = $content -replace "style.css\?v=\d+", "style.css?v=23"
    $content = $content -replace "main.js\?v=\d+", "main.js?v=23"
    $content = $content -replace "bg_combined.js\?v=\d+", "bg_combined.js?v=23"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Busted cache in $($file.Name)"
}
