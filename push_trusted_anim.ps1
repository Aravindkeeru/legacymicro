$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Animate 'Trusted' hover state: transition from white to the exact champagne gold (#fef3c7) used by 'LEGACY' with a 0.2s delay for a seamless fade-in effect"
git push
Write-Output "Committed and pushed successfully"
