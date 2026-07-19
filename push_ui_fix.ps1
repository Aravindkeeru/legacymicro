$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add internal-calc.html
git commit -m "Fix UI rendering bug in Calculator: resolved JavaScript syntax error caused by escaped backticks in the row template literal"
git push
Write-Output "Committed and pushed successfully"
