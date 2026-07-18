$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Restore original trace shape, entirely remove the moving dot from the trace passing behind E, and construct a new trace originating from the LM IC chip routing under the text"
git push
Write-Output "Committed and pushed successfully"
