$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix iOS Safari audio bug: stop relying on reading HTMLMediaElement.volume to track fade progress, as iOS ignores assignments and always returns 1.0, which caused an infinite fade-out loop preventing the audio from pausing"
git push
Write-Output "Committed and pushed successfully"
