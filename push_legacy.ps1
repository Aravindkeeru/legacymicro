$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Content: Add legacy parts to Mega-Menu and Marquee, generate realistic IC assets"
git push
Write-Output "Committed and pushed successfully"
