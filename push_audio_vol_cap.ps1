$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update max volume limit: cap ambient audio at 80% to ensure it remains a background track and doesn't overwhelm the user's primary audio on loud devices"
git push
Write-Output "Committed and pushed successfully"
