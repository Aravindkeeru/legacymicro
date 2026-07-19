$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Enhance UX: Add Mega-Menu for 'Products' with categorized product listings for easier navigation, similar to industechno.in layout"
git push
Write-Output "Committed and pushed successfully"
