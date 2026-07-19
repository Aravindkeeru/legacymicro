$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Remove offending data-packet crossing behind G; multiply IC chip traces for a dramatic aesthetic effect; perfectly shift R via rightward"
git push
Write-Output "Committed and pushed successfully"
