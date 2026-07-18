$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Precisely adjust the start of the gold trace so the traveling animation dot doesn't cross behind the E; explicitly code the golden circle with blue dot above A; explicitly mirror it as a blue circle with golden inside above R, without changing the underlying track shapes"
git push
Write-Output "Committed and pushed successfully"
