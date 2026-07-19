$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Compress Y-coordinates of high-speed bus to keep traces well inside viewBox borders; shift traces left to start immediately after IC chip; reduce padding-left to bring text closer to IC chip"
git push
Write-Output "Committed and pushed successfully"
