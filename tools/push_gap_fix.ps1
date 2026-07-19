$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update logo-text-wrapper to shrink-wrap width, use padding to pull text tightly against IC chip, route high-speed traces via steep dog-legs to avoid collision, and increase LEGACY letter-spacing to match italic kerning of MICRO"
git push
Write-Output "Committed and pushed successfully"
