$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Fix the malformed logo HTML. We will replace everything inside <a class="nav-logo"> ... </a>
    # with a clean SVG and the words LEGACY MICRO.
    $pattern = '(?s)<a href="index\.html" class="nav-logo"[^>]*>.*?</a>'
    
    $cleanLogo = @"
      <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none;">
        <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px;">
        <div style="display: flex; flex-direction: column; justify-content: center; align-items: flex-start; line-height: 1;">
          <span style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.25rem; color: var(--text-primary);">LEGACYMICRO</span>
          <span style="font-size: 0.45rem; letter-spacing: 1.5px; color: var(--text-secondary); font-weight: 600; margin-top: 4px;">ELECTRONIC COMPONENTS</span>
        </div>
      </a>
"@
    
    $content = $content -replace $pattern, $cleanLogo
    
    # Fix the syntax error at the bottom of index.html
    if ($file.Name -eq 'index.html') {
        $content = $content -replace '      } </script>', "      }`n    });`n  </script>"
    }
    
    # Cache bust
    $content = $content -replace "\?v=\d+", "?v=24"
    
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Fixed logo and syntax in $($file.Name)"
}
