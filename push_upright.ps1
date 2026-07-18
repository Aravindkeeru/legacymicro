$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Remove native italic from MICRO; Use pure geometric upright font with skewX to preserve identical stroke weight and letterform geometry"
git push
Write-Output "Committed and pushed successfully"
