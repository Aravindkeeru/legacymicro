$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Optimize PCB background animation: reduce opacity and thickness of traces so they perfectly complement the logo without distracting from the text legibility"
git push
Write-Output "Committed and pushed successfully"
