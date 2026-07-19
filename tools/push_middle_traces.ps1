$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Reposition traces to align directly with IC pins (Y=34-64), creating a beautiful 6-lane data bus; add 2 straight traces routed directly through the middle (behind text) to balance visual density"
git push
Write-Output "Committed and pushed successfully"
