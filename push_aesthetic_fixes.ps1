$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Refine aesthetic PCB traces: remove distracting dot behind the E, and mirror the aesthetic gold via above A by adding a corresponding blue via directly above the R in MICRO"
git push
Write-Output "Committed and pushed successfully"
