$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Enhance UX: Upgrade Mega-Menu aesthetics (glassmorphism) and fix Request Quote modal bindings"
git push
Write-Output "Committed and pushed successfully"
