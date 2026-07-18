$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Pull trademark closer to O and accelerate fade-in to 2.5s; Cache bust v48"
git push
Write-Output "Committed and pushed successfully"
