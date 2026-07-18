$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$mainFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\js\main.js"
$content = [System.IO.File]::ReadAllText($mainFile, [System.Text.Encoding]::UTF8)

# Replace the entire sound toggle logic with a simpler, non-fading version
$pattern = '(?s)soundToggle\.addEventListener\(''click'', \(\) => \{.*?\n      \}\);'

$newLogic = @"
      soundToggle.addEventListener('click', () => {
        if (bgAudio.paused) {
          bgAudio.play().then(() => {
            soundToggle.classList.add('playing');
            soundToggle.innerHTML = '<i data-lucide="volume-2"></i>';
            if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          }).catch(err => {
            console.error("Audio playback failed:", err);
            if (typeof window.showToast === 'function') {
              window.showToast("Playback blocked by device. Ensure volume is up and mute switch is off.");
            }
          });
        } else {
          bgAudio.pause();
          soundToggle.classList.remove('playing');
          soundToggle.innerHTML = '<i data-lucide="volume-x"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
        }
      });
"@

$content = $content -replace $pattern, $newLogic

# Also disable the reveal animations on mobile in CSS to completely avoid iOS Safari intersection bugs
$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

if (-not ($cssContent -match 'reveal-mobile-fix')) {
$cssContent += @"

/* reveal-mobile-fix */
@media (max-width: 768px) {
  .reveal {
    opacity: 1 !important;
    transform: none !important;
    transition: none !important;
  }
}
"@
}

# Write files back
[System.IO.File]::WriteAllText($mainFile, $content, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Cache bust files
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $c = $c -replace "\?v=\d+", "?v=25"
    [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
}

Write-Output "Applied mobile logic fixes!"
