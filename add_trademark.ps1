$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$oldText = '<span class="logo-main-text">LEGACYMICRO</span>'
$newText = '<span class="logo-main-text">LEGACYMICRO<sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>'

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        $content = $content -replace [regex]::Escape($oldText), $newText
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Added registered trademark to $file"
    }
}
