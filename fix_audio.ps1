$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 1. Add preload="auto" to index.html audio tag
$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)
$content = $content -replace '<audio id="bgAudio" loop>', '<audio id="bgAudio" loop preload="auto">'
[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Added preload=auto to index.html"

# 2. Add toast to main.js catch block
$mainFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\js\main.js"
$mainContent = [System.IO.File]::ReadAllText($mainFile, [System.Text.Encoding]::UTF8)
$oldCatch = @"
        }).catch(err => {
          console.error("Audio playback failed:", err);
        });
"@
$newCatch = @"
        }).catch(err => {
          console.error("Audio playback failed:", err);
          if (typeof window.showToast === 'function') {
            window.showToast("Playback blocked by device. Ensure volume is up and mute switch is off.");
          }
        });
"@
$mainContent = $mainContent.Replace($oldCatch, $newCatch)
[System.IO.File]::WriteAllText($mainFile, $mainContent, [System.Text.Encoding]::UTF8)
Write-Output "Updated main.js catch block"

# 3. Cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $c = $c -replace "\?v=\d+", "?v=22"
    [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
}
Write-Output "Busted cache to v=22"
