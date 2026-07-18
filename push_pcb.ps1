$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Add subtle animated PCB trace background to the navigation bar to enhance the semiconductor hardware aesthetic"
git push
Write-Output "Committed and pushed successfully"
