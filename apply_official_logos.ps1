$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$file = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

$newLogos = @"
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Amphenol_logo.svg" alt="Amphenol"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3d/TRACO_Electronic_AG_Logo.svg" alt="TRACO POWER"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/63/Kemet_Corporation_logo.svg" alt="KEMET"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3f/Marvell_Technology_Group_logo.svg" alt="MARVELL"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/60/Micron_Technology_logo.svg" alt="Micron"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/1/1d/Vishay_Intertechnology_logo.svg" alt="VISHAY"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/2/23/Texas_Instruments_logo.svg" alt="TEXAS INSTRUMENTS"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/7/7b/Analog_Devices_Logo.svg" alt="ANALOG DEVICES"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/6b/Microchip_Technology_logo.svg" alt="MICROCHIP"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/e/ea/STMicroelectronics_logo.svg" alt="STMicroelectronics"></div>
      
      <!-- Duplicate for infinite scroll loop -->
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Amphenol_logo.svg" alt="Amphenol"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3d/TRACO_Electronic_AG_Logo.svg" alt="TRACO POWER"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/63/Kemet_Corporation_logo.svg" alt="KEMET"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3f/Marvell_Technology_Group_logo.svg" alt="MARVELL"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/60/Micron_Technology_logo.svg" alt="Micron"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/1/1d/Vishay_Intertechnology_logo.svg" alt="VISHAY"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/2/23/Texas_Instruments_logo.svg" alt="TEXAS INSTRUMENTS"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/7/7b/Analog_Devices_Logo.svg" alt="ANALOG DEVICES"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/6/6b/Microchip_Technology_logo.svg" alt="MICROCHIP"></div>
      <div class="manufacturer-logo"><img src="https://upload.wikimedia.org/wikipedia/commons/e/ea/STMicroelectronics_logo.svg" alt="STMicroelectronics"></div>
"@

$cssAppend = @"
    /* Official Manufacturer Logos CSS */
    .manufacturer-logo {
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 0 40px;
    }
    .manufacturer-logo img {
      height: 32px;
      width: auto;
      object-fit: contain;
      filter: grayscale(100%) brightness(0) invert(1) opacity(0.5);
      transition: all 0.4s ease;
    }
    .manufacturer-logo:hover img {
      filter: grayscale(0%) brightness(100%) invert(0) opacity(1);
    }
"@

# Replace HTML
$htmlRegex = '(?s)(<div class="manufacturer-track">).*?(</div>\s*</section>)'
$content = [regex]::Replace($content, $htmlRegex, "`$1`n$newLogos`n    `$2")

# Append CSS before </style>
$cssRegex = '(?s)(</style>)'
$content = [regex]::Replace($content, $cssRegex, "$cssAppend`n    `$1")

[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
Write-Output "Applied official SVG logos to ticker in index.html"
