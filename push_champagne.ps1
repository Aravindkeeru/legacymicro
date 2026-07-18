$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Refine gold animation to use an ultra-pale premium champagne gold (#fde68a) for a lighter, more complementing glow"
git push
Write-Output "Committed and pushed successfully"
