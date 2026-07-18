$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix glowing box artifact around LEGACY by removing text-shadow from the gold animation, which was getting clipped by overflow:hidden; Also change color to an even lighter warm white (#fef3c7)"
git push
Write-Output "Committed and pushed successfully"
