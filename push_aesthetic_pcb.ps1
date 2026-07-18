$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Upgrade PCB background animation to a highly aesthetic, premium design featuring complex parallel data buses, hardware vias, dual-color traces (Gold/Blue), and continuous flowing data packet animations"
git push
Write-Output "Committed and pushed successfully"
