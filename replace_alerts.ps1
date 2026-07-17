$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Replace the alert with a toast function call
$oldLink = "href=`"javascript:alert('Our Market Insights blog is launching soon. Stay tuned for industry updates!');`""
$newLink = "href=`"javascript:void(0);`" onclick=`"showToast('Our Market Insights blog is launching soon. Stay tuned for industry updates!');`""

$content = $content -replace [regex]::Escape($oldLink), $newLink

[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Replaced alerts in index.html"
