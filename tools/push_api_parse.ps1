$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add internal-calc.html
git commit -m "Enhance API parsing: update Mouser Fetch logic to extract explicit Tariffs if available, and expand category guessing to include DC-DC Converters"
git push
Write-Output "Committed and pushed successfully"
