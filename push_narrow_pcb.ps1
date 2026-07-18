$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Restrict PCB trace animation width to only cover the area directly behind the LEGACY MICRO logo rather than spanning the entire navigation bar"
git push
Write-Output "Committed and pushed successfully"
