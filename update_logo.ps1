$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$newHtml = @"
          <span style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.2rem; display: flex; align-items: baseline;">
            <span class="logo-legacy-group">
              <span class="logo-legacy">LEGAC</span>
              <span class="logo-y">Y</span>
            </span>
            <span class="logo-micro-group">
              <span class="logo-m">M</span>
              <span class="logo-icro">ICRO</span>
              <span class="logo-mu">μ</span>
            </span>
          </span>
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        
        # Replace footer logo block if it exists
        $footerRegex = '(?s)<span>LEGACY<span class="logo-text-accent">MICRO</span></span>'
        $content = $content -replace $footerRegex, $newHtml
        
        [System.IO.File]::WriteAllText($path, $content)
        Write-Output "Updated footer in: $file"
    }
}
