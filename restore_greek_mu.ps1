$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 1. Revert the mobile reveal fix in style.css to bring back transitions on mobile
$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Remove the reveal-mobile-fix block
$pattern = '(?s)/\* reveal-mobile-fix \*/.*?@media \(max-width: 768px\) \{.*?\.reveal \{.*?\}'
$cssContent = $cssContent -replace $pattern, ''

# Also remove the closing brace that was left behind
$cssContent = $cssContent -replace '\}\s*\Z', ''

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
Write-Output "Restored mobile transitions"

# 2. Restore Greek mu logo in HTML files
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $greekLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; overflow: hidden; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: flex-start; line-height: 1; width: 140px; overflow: hidden;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; color: var(--text-primary);">
            <!-- Primary typographic text -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: flex-start; transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-main-text">LEGACYMICRO<sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>
            </div>
            
            <!-- Hover Text -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: baseline; justify-content: flex-start; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr">In </span><span class="logo-trusted-mu" style="color: #f59e0b; font-size: 1.2em; margin: 0 4px;">&#956;</span><span class="logo-sted"> we trust</span>
            </div>
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.5px; color: var(--text-secondary); font-weight: 600; margin-top: 4px;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $greekLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=26"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Restored Greek mu logo in $($file.Name)"
}

# 3. Add the CSS for the logo hover effect to style.css
$hoverCss = @"

/* Logo Hover Effect */
.nav-logo:hover .logo-primary {
  opacity: 0 !important;
  transform: translateY(-10px) !important;
}
.nav-logo:hover .logo-hover {
  opacity: 1 !important;
  transform: translateY(0) !important;
}
"@
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)
if (-not ($cssContent -match 'Logo Hover Effect')) {
    $cssContent += $hoverCss
    [System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
}

Write-Output "Added logo hover CSS"
