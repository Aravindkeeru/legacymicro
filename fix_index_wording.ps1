$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Safely replace the title
$content = $content -replace '<title>Legacy Micro — Source Any Electronic[\s\S]*?Instantly\.</title>', '<title>Legacy Micro - Source Any Electronic Component. Reliably.</title>'

# Safely replace the Hero H1
$content = $content -replace 'Source Any Electronic Component\.<br>\s*<span>Instantly\.</span>', "Source Any Electronic Component.<br>`n        <span>Reliably.</span>"

# Remove "Instant" from the badge
$content = $content -replace "India's First Instant Part Search", "India's Premier Component Sourcing"

[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Fixed index.html wording"
