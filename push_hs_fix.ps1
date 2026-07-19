$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add internal-calc.html
git commit -m "Fix HS Code lookup logic: add prefix matching (8, 6, 4 digits) to support longer or international HS code variants like 10-digit codes"
git push
Write-Output "Committed and pushed successfully"
