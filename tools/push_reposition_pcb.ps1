$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Reposition PCB trace coordinates to avoid visual overlap with the logo text and subtitle; fixed the gold dot appearing between L&E and the blue line striking through 'Electronic components'"
git push
Write-Output "Committed and pushed successfully"
