$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -match "test|internal-calc") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Update GST, remove IEC, add ISO
    $content = $content -replace "<strong>GST:</strong> 37XXXXXXXXXX1ZV<br>\s*<strong>IEC:</strong> XXXXXXXXXX", "<strong>GST:</strong> 37AAPCR9059J1ZH<br>`n              <strong>ISO:</strong> 9001:2015 Certified"
    
    # 2. Remove LinkedIn
    $content = $content -replace '<div style="margin-top: 1rem;">\s*<a href="#" style="color: var\(--accent\); text-decoration: none;"><i data-lucide="linkedin"></i> LinkedIn</a>\s*</div>', ""

    Set-Content $file.FullName $content -Encoding UTF8
}
