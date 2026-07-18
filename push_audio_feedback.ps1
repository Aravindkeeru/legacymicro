$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update sound toggle UI: instantly display a spinning loader icon on click to provide immediate visual feedback while the 8MB MP3 file buffers or if playback is delayed"
git push
Write-Output "Committed and pushed successfully"
