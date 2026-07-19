$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "UI: Replace bright component images with cinematic dark themed assets to match website aesthetic, fix duplicates"
git push
Write-Output "Committed and pushed successfully"
