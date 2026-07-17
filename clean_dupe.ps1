$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$badHtml = @"
            <span class="logo-micro-group">
              <span class="logo-m">M</span>
              <span class="logo-icro">ICRO</span>
              <span class="logo-mu">&#956;</span>
            </span>
          </span>
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        
        # Replace the literal bad HTML with nothing
        $content = $content.Replace($badHtml, "")
        
        [System.IO.File]::WriteAllText($path, $content)
        Write-Output "Cleaned up $file"
    }
}
