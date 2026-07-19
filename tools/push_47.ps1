$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix trademark overlapping issue by adjusting margin and z-index; Cache bust v47"
git push
Write-Output "Committed and pushed successfully"
