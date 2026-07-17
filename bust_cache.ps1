$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Force cache bust on CSS and JS
    $content = $content -replace "style.css\?v=\d+", "style.css?v=20"
    $content = $content -replace "main.js\?v=\d+", "main.js?v=20"
    $content = $content -replace "bg_combined.js\?v=\d+", "bg_combined.js?v=20"
    
    # Fix the syntax error at the bottom of index.html
    if ($file.Name -eq 'index.html') {
        $content = $content -replace "\}\);\s*</script>", "} </script>"
    }
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Busted cache in $($file.Name)"
}
