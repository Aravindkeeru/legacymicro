$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Completely remove all vias/dots to resolve distraction; finalize the 6-lane high-speed data bus from IC chip"
git push
Write-Output "Committed and pushed successfully"
