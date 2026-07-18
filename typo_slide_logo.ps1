$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Remove the old textWipeIn CSS completely
$cssContent = $cssContent -replace '(?s)/\* Wrapper handles animation and clip-path \*/.*?(?=/\* Subtitle \*/)', ''

$newCss = @"
/* Center YM typographic fade in */
.logo-ym-center {
  position: relative;
  z-index: 2;
  opacity: 0;
  transform: scale(0.8);
  animation: fadeYMIn 0.8s cubic-bezier(0.25, 1, 0.5, 1) 0.8s forwards;
  display: flex;
}
@keyframes fadeYMIn {
  0% { opacity: 0; transform: scale(0.8); }
  100% { opacity: 1; transform: scale(1); }
}

/* LEGAC slides out to the left */
.logo-legac {
  position: relative;
  z-index: 1;
  color: var(--text-primary);
  opacity: 0;
  transform: translateX(45px);
  animation: slideLegac 1s cubic-bezier(0.16, 1, 0.3, 1) 1.0s forwards;
}
@keyframes slideLegac {
  0% { opacity: 0; transform: translateX(45px); clip-path: inset(0 0 0 100%); }
  10% { opacity: 1; }
  100% { opacity: 1; transform: translateX(0); clip-path: inset(0 0 0 0); }
}

/* ICRO slides out to the right */
.logo-icro {
  position: relative;
  z-index: 1;
  color: var(--accent);
  opacity: 0;
  transform: translateX(-45px);
  animation: slideIcro 1s cubic-bezier(0.16, 1, 0.3, 1) 1.0s forwards;
}
@keyframes slideIcro {
  0% { opacity: 0; transform: translateX(-45px); clip-path: inset(0 100% 0 0); }
  10% { opacity: 1; }
  100% { opacity: 1; transform: translateX(0); clip-path: inset(0 0 0 0); }
}
"@

$cssContent += $newCss
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files with new typographic sliding structure
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $typographicSliderLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; min-width: 190px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
            
            <!-- Primary State (Typographic YM Center + Sliding Ends) -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
               <span class="logo-legac">LEGAC</span>
               <span class="logo-ym-center">
                 <span style="color: var(--text-primary);">Y</span><span style="color: var(--accent);">M</span>
               </span>
               <span class="logo-icro">ICRO<sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>
            </div>
            
            <!-- Hover State (Trµsted) - Perfect Baseline Alignment -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; line-height: 1; margin: 0 1px; display: flex; align-items: baseline; transform: translateY(1px);">&#956;</span><span class="logo-sted" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">sted</span>
            </div>
            
            <!-- Initial State (µ) -->
            <div class="logo-init-mu" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span>&#956;</span>
            </div>
            
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.6px; color: var(--text-secondary); font-weight: 600; margin-top: 4px; text-align: center; width: 100%;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $typographicSliderLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=31"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Applied purely typographic sliding logo"
