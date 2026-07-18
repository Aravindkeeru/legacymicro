$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix ambient audio volume: increase hardcoded bgAudio.volume from 0.15 (15%) to 1.0 (100%) so that the background music is clearly audible when toggled on, especially on laptop speakers"
git push
Write-Output "Committed and pushed successfully"
