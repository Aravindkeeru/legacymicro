$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update audio fader: slow down fade-in duration to exactly 10 seconds for a more atmospheric entry, while keeping fade-out duration at 1 second for responsive pausing"
git push
Write-Output "Committed and pushed successfully"
