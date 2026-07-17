$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$file = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$newLogos = @"
      <!-- Authentic Inline SVGs built to bypass hotlink protection -->
      <div class="manufacturer-logo">
        <svg width="120" height="30" viewBox="0 0 120 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="800" font-style="italic" font-size="20" letter-spacing="-0.5">Amphenol</text>
        </svg>
      </div>
      
      <div class="manufacturer-logo">
        <svg width="150" height="30" viewBox="0 0 150 30" fill="none">
          <text x="0" y="22" fill="#e73c3c" font-family="Arial, sans-serif" font-weight="900" font-size="18">TRACO</text>
          <text x="66" y="22" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="18">POWER</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="85" height="30" viewBox="0 0 85 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="22" letter-spacing="-1">KEMET</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="115" height="30" viewBox="0 0 115 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="900" font-size="18" letter-spacing="-1.5">MARVELL</text>
          <circle cx="85" cy="8" r="3.5" fill="#e73c3c" />
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="90" height="30" viewBox="0 0 90 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="800" font-size="22" letter-spacing="-1">Micron</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="95" height="30" viewBox="0 0 95 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="900" font-size="20" letter-spacing="-0.5">VISHAY</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="225" height="30" viewBox="0 0 225 30" fill="none">
          <rect x="0" y="3" width="22" height="22" fill="#cc0000" rx="2" />
          <text x="11" y="20" fill="white" font-family="'Times New Roman', serif" font-style="italic" font-size="18" font-weight="bold" text-anchor="middle">ti</text>
          <text x="28" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">TEXAS INSTRUMENTS</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="180" height="30" viewBox="0 0 180 30" fill="none">
          <polygon points="0,22 10,4 20,22" fill="#00a1e0" />
          <text x="26" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="16" letter-spacing="-0.5">ANALOG DEVICES</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="135" height="30" viewBox="0 0 135 30" fill="none">
          <text x="0" y="22" fill="#cc0000" font-family="Arial, sans-serif" font-weight="900" font-style="italic" font-size="22">M</text>
          <text x="22" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">MICROCHIP</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="165" height="30" viewBox="0 0 165 30" fill="none">
          <path d="M 0,26 L 8,4 L 32,4 L 24,26 Z" fill="#005599" />
          <text x="16" y="20" fill="white" font-family="Arial, sans-serif" font-weight="900" font-style="italic" font-size="16" text-anchor="middle">ST</text>
          <text x="38" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="700" font-size="15" letter-spacing="-0.5">life.augmented</text>
        </svg>
      </div>
      
      <!-- Duplicate for infinite scroll loop -->
      <div class="manufacturer-logo">
        <svg width="120" height="30" viewBox="0 0 120 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="800" font-style="italic" font-size="20" letter-spacing="-0.5">Amphenol</text>
        </svg>
      </div>
      
      <div class="manufacturer-logo">
        <svg width="150" height="30" viewBox="0 0 150 30" fill="none">
          <text x="0" y="22" fill="#e73c3c" font-family="Arial, sans-serif" font-weight="900" font-size="18">TRACO</text>
          <text x="66" y="22" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="18">POWER</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="85" height="30" viewBox="0 0 85 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="22" letter-spacing="-1">KEMET</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="115" height="30" viewBox="0 0 115 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="900" font-size="18" letter-spacing="-1.5">MARVELL</text>
          <circle cx="85" cy="8" r="3.5" fill="#e73c3c" />
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="90" height="30" viewBox="0 0 90 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="800" font-size="22" letter-spacing="-1">Micron</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="95" height="30" viewBox="0 0 95 30" fill="none">
          <text x="0" y="22" fill="currentColor" font-family="'Inter', sans-serif" font-weight="900" font-size="20" letter-spacing="-0.5">VISHAY</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="225" height="30" viewBox="0 0 225 30" fill="none">
          <rect x="0" y="3" width="22" height="22" fill="#cc0000" rx="2" />
          <text x="11" y="20" fill="white" font-family="'Times New Roman', serif" font-style="italic" font-size="18" font-weight="bold" text-anchor="middle">ti</text>
          <text x="28" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">TEXAS INSTRUMENTS</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="180" height="30" viewBox="0 0 180 30" fill="none">
          <polygon points="0,22 10,4 20,22" fill="#00a1e0" />
          <text x="26" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="900" font-size="16" letter-spacing="-0.5">ANALOG DEVICES</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="135" height="30" viewBox="0 0 135 30" fill="none">
          <text x="0" y="22" fill="#cc0000" font-family="Arial, sans-serif" font-weight="900" font-style="italic" font-size="22">M</text>
          <text x="22" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="800" font-size="16" letter-spacing="-0.5">MICROCHIP</text>
        </svg>
      </div>

      <div class="manufacturer-logo">
        <svg width="165" height="30" viewBox="0 0 165 30" fill="none">
          <path d="M 0,26 L 8,4 L 32,4 L 24,26 Z" fill="#005599" />
          <text x="16" y="20" fill="white" font-family="Arial, sans-serif" font-weight="900" font-style="italic" font-size="16" text-anchor="middle">ST</text>
          <text x="38" y="21" fill="currentColor" font-family="Arial, sans-serif" font-weight="700" font-size="15" letter-spacing="-0.5">life.augmented</text>
        </svg>
      </div>
"@

$cssAppend = @"
    /* Flawless Inline SVG CSS */
    .manufacturer-logo {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 40px;
    }
    .manufacturer-logo svg {
      color: rgba(255, 255, 255, 0.4);
      filter: grayscale(100%);
      transition: all 0.4s ease;
    }
    .manufacturer-logo:hover svg {
      color: rgba(255, 255, 255, 1);
      filter: grayscale(0%);
    }
"@

# Replace HTML (Removes old <img> tags, injects new <svg> tags)
$htmlRegex = '(?s)(<div class="manufacturer-track">).*?(</div>\s*</section>)'
$content = [regex]::Replace($content, $htmlRegex, "`$1`n$newLogos`n    `$2")

# Replace Old Filter CSS and Append New CSS
$cssRegex = '(?s)\/\* Official Manufacturer Logos CSS \*\/.+?(?=<\/style>)'
if ($content -match $cssRegex) {
    $content = [regex]::Replace($content, $cssRegex, $cssAppend + "`n    ")
} else {
    $content = [regex]::Replace($content, '(?s)(</style>)', "$cssAppend`n    `$1")
}

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Output "Applied flawless inline SVGs to ticker in index.html"
