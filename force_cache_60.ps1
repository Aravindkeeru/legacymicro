$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust to force the browser to forget the chip version
    $content = $content -replace "\?v=\d+", "?v=60"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Cache busted to v60"

git add .
git commit -m "Cache bust v60 to forcefully clear the gimmicky chip version from user browser cache"
git push
Write-Output "Committed and pushed successfully"
