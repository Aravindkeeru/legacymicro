$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Add glowing text-shadow to mu
$muTarget = "    opacity: 1;`n    animation: initialMuSlide 1s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;"
$muReplace = "    opacity: 1;`n    text-shadow: 0 0 10px rgba(59, 130, 246, 0.8), 0 0 20px rgba(59, 130, 246, 0.4);`n    animation: initialMuSlide 1s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;"
$cssContent = $cssContent.Replace($muTarget, $muReplace)

# Slow down the dramatic text Wipe from 1s to 2s
$wipeTarget = "animation: textWipeIn 1s cubic-bezier(0.16, 1, 0.3, 1) 1.2s forwards;"
$wipeReplace = "animation: textWipeIn 2.2s cubic-bezier(0.16, 1, 0.3, 1) 1.2s forwards;"
$cssContent = $cssContent.Replace($wipeTarget, $wipeReplace)

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update cache buster
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $content = $content -replace "\?v=32", "?v=33"
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied glowing mu and slowed down slide animation"
