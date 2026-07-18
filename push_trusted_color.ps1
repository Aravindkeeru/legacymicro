$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update hover state animation: change 'Tr' and 'sted' to gold (#fef08a) to match the primary 'LEGACY' color and maintain consistent branding during flip animation"
git push
Write-Output "Committed and pushed successfully"
