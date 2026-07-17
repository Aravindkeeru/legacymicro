$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        # FIX LOGO OVERLAP: Add !important to hover state so it overrides the animation
        $content = $content -replace "\.nav-logo:hover \.logo-legacy-micro \{`r?`n\s*opacity: 0;`r?`n\s*transform: translateY\(-10px\) scale\(0\.95\);`r?`n\s*\}", ".nav-logo:hover .logo-legacy-micro {`n      opacity: 0 !important;`n      transform: translateY(-10px) scale(0.95) !important;`n    }"
        
        # REPLACE R&A Supply Solutions
        # 1. Meta tags and titles
        $content = $content -replace "R&amp;A Supply Solutions Pvt Ltd", "Legacy Micro"
        $content = $content -replace "R&A Supply Solutions Pvt Ltd", "Legacy Micro"
        $content = $content -replace "R&amp;A Supply Solutions", "Legacy Micro"
        $content = $content -replace "R&A Supply Solutions", "Legacy Micro"

        # 2. Specific case in about.html: "R&A Supply Solutions Pvt Ltd, operating as <strong...Legacy Micro</strong>"
        # We'll just replace the whole sentence to be clean.
        $content = $content -replace "<p>Legacy Micro, operating as <strong style=`"color: var\(--text-primary\);`">Legacy Micro</strong>", "<p><strong style=`"color: var(--text-primary);`">Legacy Micro</strong>"
        
        # 3. Footer legal name which might have an invalid character () before Est. 2026
        # Let's use regex to replace `<p class="legal-name">...Est. 2026</p>` entirely
        $content = $content -replace '(?s)<p class="legal-name">.*?Est\. 2026</p>', '<p class="legal-name">Legacy Micro &bull; Est. 2026</p>'

        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Updated: $file"
    }
}
