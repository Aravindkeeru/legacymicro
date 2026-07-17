$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Replace the root paths for comp_*.png
$content = $content -replace 'src="comp_', 'src="assets/comp_'

[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Updated image paths in index.html"
