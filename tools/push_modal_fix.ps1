$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
git add .
git commit -m "Fix UX: Add missing closeQuoteModal implementation, allow closing modal by clicking the backdrop overlay, and hardcode SVG close icon so it remains visible even if lucide script rendering is delayed or fails"
git push
Write-Output "Committed and pushed successfully"
