$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Introduce audio fader: smoothly transition ambient music volume between 0 and 1.0 over 1 second when toggled, instead of instantly cutting in/out"
git push
Write-Output "Committed and pushed successfully"
