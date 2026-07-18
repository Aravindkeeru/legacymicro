$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Architectural fix for responsive vias: remove fixed SVG vias and replace with absolute HTML vias locked to text percentages; add 4 total traces from IC chip"
git push
Write-Output "Committed and pushed successfully"
