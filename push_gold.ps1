$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Animate LEGACY word to transition to a premium metallic gold color with a subtle glow after the slide-out transition completes"
git push
Write-Output "Committed and pushed successfully"
