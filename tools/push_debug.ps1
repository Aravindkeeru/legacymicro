$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add internal-calc.html
git commit -m "Enhance API parsing: add Manufacturer checks and debug output for unknown categories"
git push
Write-Output "Committed and pushed successfully"
