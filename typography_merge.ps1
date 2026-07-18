$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Add CSS for the merged YM typography and glowing trademark
$newCss = @"
/* Typographic innovation: Merging Y and M physically */
.logo-merge {
  margin-left: -0.11em; /* Tightly overlaps M into Y's right arm */
  letter-spacing: inherit;
}

/* Glowing trademark */
.logo-reg {
  font-size: 0.35em;
  font-weight: 500;
  margin-left: 2px;
  color: var(--accent);
  text-shadow: 0 0 6px rgba(59, 130, 246, 0.8), 0 0 12px rgba(59, 130, 246, 0.4);
  transform: translateY(-1em);
  display: inline-block;
}

.logo-layer-base {
  color: var(--text-primary);
  display: inline-flex;
  align-items: center;
  padding-right: 2px;
  padding-left: 2px;
  position: relative;
}
"@

# Replace old base layer CSS to match inline-flex
$cssContent = $cssContent -replace '(?s)\.logo-layer-base \{.*?(?=\.logo-layer-accent)', $newCss
[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)

# Update HTML files for single trademark and logo-merge
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $updatedLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; width: 230px;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
            
            <!-- Primary State -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
              <span class="logo-text-animator">
                <span style="position: relative; display: inline-flex;">
                  <span class="logo-layer-base">LEGACY<span class="logo-merge">MICRO</span></span>
                  <span class="logo-layer-accent">LEGACY<span class="logo-merge">MICRO</span></span>
                </span>
                <sup class="logo-reg">&reg;</sup>
              </span>
            </div>
            
            <!-- Hover State (Trµsted) -->
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
    
    $content = $content -replace $logoPattern, $updatedLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=35"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Output "Fixed trademark and innovated YM typography merge"
