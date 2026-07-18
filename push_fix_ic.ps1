$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix IC chip connection to properly visibly emerge from the right edge of the IC chip image; perfectly isolate and remove only the animated flow-3 packet that was flashing over the E while leaving all core traces intact"
git push
Write-Output "Committed and pushed successfully"
