$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix ambient audio player setting initial volume to zero and never fading in; hardcode initial volume"
git push
Write-Output "Committed and pushed successfully"
