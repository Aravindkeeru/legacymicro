$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Replace background image URLs for components
    $content = $content -replace "url\('comp_", "url('assets/comp_"
    $content = $content -replace 'url\("comp_', 'url("assets/comp_'
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Fixed image URLs in $($file.Name)"
}
