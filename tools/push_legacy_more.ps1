$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Content: Add Motorola, Dallas, Bosch, AKM, Leach, and EPROM parts with generated images"
git push
Write-Output "Committed and pushed successfully"
