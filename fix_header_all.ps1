$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        # Change margin-right on the LM icon from 12px to 8px
        $content = $content -replace 'margin-right: 12px;', 'margin-right: 8px;'
        # Change the massive 280px width to a tight 160px
        $content = $content -replace 'width: 280px;', 'width: 160px;'
        
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Fixed header gap in $file"
    }
}
