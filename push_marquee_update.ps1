$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Update marquee component list and title: changed title to 'Frequently Sourced Components' and expanded marquee images from 8 to 17 unique components to showcase a wider variety of inventory"
git push
Write-Output "Committed and pushed successfully"
