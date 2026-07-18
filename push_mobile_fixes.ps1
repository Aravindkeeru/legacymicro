$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Optimize typography: decrease logo margin to 6px, add 0.5px letter-spacing to LEGACY; shift MICRO via rightward to perfectly align with R; boost ambient audio volume to 1.0 for mobile compatibility"
git push
Write-Output "Committed and pushed successfully"
