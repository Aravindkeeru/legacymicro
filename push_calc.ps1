$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update ambient volume, insights content, and add internal HS/Freight Calculator"
git push
Write-Output "Committed and pushed successfully"
