$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix CSS caching issue: update CSS cache buster to v=98 across all HTML files to ensure Mega-Menu styles load properly"
git push
Write-Output "Committed and pushed successfully"
