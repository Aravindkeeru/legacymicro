$files = Get-ChildItem -Path "C:\Users\admin\.gemini\antigravity\scratch\racomlink\*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Navbar Desktop Button
    $content = $content -replace '<a href="contact\.html" class="btn btn-primary btn-sm nav-cta desktop-only">Request Quote</a>', '<button class="btn btn-primary btn-sm nav-cta desktop-only" onclick="openQuoteModal('''')">Request Quote</button>'
    
    # Navbar Mobile Button
    $content = $content -replace '<a href="contact\.html" class="btn btn-primary mt-md">Request Quote</a>', '<button class="btn btn-primary mt-md" onclick="openQuoteModal('''')">Request Quote</button>'
    
    # CTA Submit Inquiry
    $content = $content -replace '<a href="contact\.html" class="btn btn-primary btn-lg">Submit Inquiry</a>', '<button class="btn btn-primary btn-lg" onclick="openQuoteModal('''')">Submit Inquiry</button>'

    Set-Content -Path $file.FullName -Value $content
}

Write-Output "Updated remaining anchor tags to modal buttons."
