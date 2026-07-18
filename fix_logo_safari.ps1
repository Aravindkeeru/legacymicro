$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 1. Update the HTML
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $logoPattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $cleanLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; overflow: hidden; white-space: nowrap;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
        <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: flex-start; line-height: 1; width: 150px; overflow: hidden;">
          <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; color: var(--text-primary);">
            
            <!-- Primary typographic text -->
            <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: flex-start; transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-main-text"><span style="color: var(--text-primary);">LEGACY</span><span style="color: var(--accent);">MICRO</span><sup style="font-size: 0.4em; font-weight: 500; margin-left: 2px;">&reg;</sup></span>
            </div>
            
            <!-- Hover Text (Trµsted) -->
            <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: baseline; justify-content: flex-start; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
              <span class="logo-tr">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; margin: 0 1px;">&#956;</span><span class="logo-sted">sted</span>
            </div>
          </div>
          <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.5px; color: var(--text-secondary); font-weight: 600; margin-top: 4px;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $logoPattern, $cleanLogo
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=27"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Fixed logo in $($file.Name)"
}

# 2. Fix the CSS to remove buggy iOS WebKit background clip
$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssContent = [System.IO.File]::ReadAllText($cssFile, [System.Text.Encoding]::UTF8)

# Strip out the problematic .logo-main-text CSS
$pattern = '(?s)\.logo-main-text \{.*?\}'
$cssContent = $cssContent -replace $pattern, ''

[System.IO.File]::WriteAllText($cssFile, $cssContent, [System.Text.Encoding]::UTF8)
Write-Output "Fixed iOS CSS bug"
