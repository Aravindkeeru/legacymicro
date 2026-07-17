$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$file = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# 1. Fix the Header Gap
# Change margin-right on the LM icon from 12px to 8px
$content = $content -replace 'margin-right: 12px;', 'margin-right: 8px;'
# Change the massive 280px width to a tight 160px
$content = $content -replace 'width: 280px;', 'width: 160px;'

# 2. Fix the Texas Instruments Logo
# Replace the red square invention with just a sleek, bold text logo which is 100% accurate to their wordmark.
$oldTILogo = '(?s)<div class="manufacturer-logo">\s*<svg width="225" height="30" viewBox="0 0 225 30" fill="none">\s*<rect x="0" y="3" width="22" height="22" fill="#cc0000" rx="2" />\s*<text x="11" y="20" fill="white" font-family="''Times New Roman'', serif" font-style="italic" font-size="18" font-weight="bold" text-anchor="middle">ti</text>\s*<text x="28" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">TEXAS INSTRUMENTS</text>\s*</svg>\s*</div>'

$newTILogo = @"
      <div class="manufacturer-logo">
        <svg width="190" height="30" viewBox="0 0 190 30" fill="none">
          <text x="0" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">TEXAS INSTRUMENTS</text>
        </svg>
      </div>
"@

$content = [regex]::Replace($content, $oldTILogo, $newTILogo)

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Output "Fixed header gap and Texas Instruments logo in index.html"
