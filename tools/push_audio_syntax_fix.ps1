$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix critical JS syntax error on mobile: safely re-implement audio fade logic tracking currentVolume instead of browser volume to prevent iOS infinite loop without accidentally truncating trailing JS form handling and scroll animations"
git push
Write-Output "Committed and pushed successfully"
