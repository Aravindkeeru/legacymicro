$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Precisely shift the blue hybrid via to align perfectly above the letter R"
git push
Write-Output "Committed and pushed successfully"
