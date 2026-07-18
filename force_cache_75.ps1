$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Enhance subtitle with a dynamic CSS text slider, slightly relax LEGACY letter spacing for legibility, and aggressively cache bust to v75 to ensure previous PCB SVG fixes propagate"
git push
Write-Output "Committed and pushed successfully"
