$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Refine typography to a premium geometric sans-serif (Gilroy/Outfit/Montserrat); Apply ExtraBold Upright to LEGACY and ExtraBold Italic to MICRO while maintaining exact Y/M merge skew; Reduce kerning gap by 10% and increase MICRO width by 5% for perfect optical balance"
git push
Write-Output "Committed and pushed successfully"
