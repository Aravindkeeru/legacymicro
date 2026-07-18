$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Clean up all old animation blocks
$cssContent = $cssContent -replace '(?s)/\* Initial State \(Mu\) with Slide Transition \*/.*?(?=/\* Typographic innovation)', ''

$newAnimations = @"
/* Initial State (Mu) - Glowing Fade */
.logo-init-mu {
  color: var(--accent);
  font-family: 'Times New Roman', Times, serif;
  font-style: italic;
  font-size: 2rem;
  opacity: 1;
  text-shadow: 0 0 10px rgba(59, 130, 246, 0.8), 0 0 20px rgba(59, 130, 246, 0.4);
  animation: initialMuFade 1.2s cubic-bezier(0.25, 1, 0.5, 1) 0.5s forwards;
  z-index: 3;
  pointer-events: none;
}
@keyframes initialMuFade {
  0% { transform: scale(1); opacity: 1; }
  100% { transform: scale(1.5); opacity: 0; visibility: hidden; }
}

/* Wrapper handles aesthetic clip-path reveal and dramatic letter-spacing slide */
.logo-text-animator {
  display: inline-flex;
  align-items: center;
  position: relative;
  opacity: 0;
  clip-path: inset(0 50% 0 50%);
  -webkit-clip-path: inset(0 50% 0 50%);
  animation: textWipeIn 3.5s cubic-bezier(0.22, 1, 0.36, 1) 1.5s forwards;
}
@keyframes textWipeIn {
  0% { opacity: 0; clip-path: inset(0 50% 0 50%); -webkit-clip-path: inset(0 50% 0 50%); letter-spacing: -3px; transform: scale(0.98); }
  10% { opacity: 1; }
  100% { opacity: 1; clip-path: inset(0 -10px 0 -10px); -webkit-clip-path: inset(0 -10px 0 -10px); letter-spacing: -0.5px; transform: scale(1); }
}

"@

$cssContent = $cssContent -replace '/\* Typographic innovation', "$newAnimations/* Typographic innovation"

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files to cache bust
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=38"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied majestic transition timings"
