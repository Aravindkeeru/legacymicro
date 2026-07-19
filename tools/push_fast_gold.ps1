$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Speed up gold animation to 2.5s and use a lighter shade of premium gold (#fcd34d)"
git push
Write-Output "Committed and pushed successfully"
