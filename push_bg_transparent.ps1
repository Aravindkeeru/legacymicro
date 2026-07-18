$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "UI fix: remove solid black background from lower sections to allow the cinematic background video to show through seamlessly, eliminating harsh blocky cutoffs"
git push
Write-Output "Committed and pushed successfully"
