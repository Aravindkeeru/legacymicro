$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$files = @('index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html')

$oldBrand = @"
          <p>India's smartest independent distributor for semiconductors, hard-to-find &amp; obsolete electronic components.</p>
          <p class="legal-name">Legacy Micro &bull; Est. 2026</p>
"@

$newBrand = @"
          <p>India's smartest independent distributor for semiconductors, hard-to-find &amp; obsolete electronic components.</p>
          <div style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 12px; line-height: 1.8;">
            <div><i data-lucide="shield-check" style="width: 14px; height: 14px; display: inline-block; vertical-align: middle; margin-right: 4px; color: var(--accent);"></i> <strong>ISO 9001:2015 Certified</strong></div>
            <div><i data-lucide="award" style="width: 14px; height: 14px; display: inline-block; vertical-align: middle; margin-right: 4px; color: var(--accent);"></i> <strong>MSME Registered</strong></div>
            <div><i data-lucide="file-text" style="width: 14px; height: 14px; display: inline-block; vertical-align: middle; margin-right: 4px; color: var(--accent);"></i> GSTIN: 37AAPCR9059J1ZH</div>
          </div>
"@

$oldContact = @"
          <div class="footer-links">
            <a href="mailto:info@legacy-micro.com">info@legacy-micro.com</a>
            <a href="tel:+919063977251">+91 90639 77251</a>
            <span>Nehru Nagar, Guntur</span>
            <span>Andhra Pradesh, India</span>
          </div>
"@

$newContact = @"
          <div class="footer-links" style="font-size: 0.9rem;">
            <a href="mailto:info@legacy-micro.com">info@legacy-micro.com</a>
            <a href="tel:+919063977251">+91 90639 77251</a>
            <span style="margin-top: 12px; color: white;"><strong>Registered Office:</strong></span>
            <span>8-3-7, Buchaiah thota road</span>
            <span>Nehru Nagar, Guntur 522002</span>
            <span>Andhra Pradesh, India</span>
          </div>
"@

foreach ($file in $files) {
    $path = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        $content = $content.Replace($oldBrand, $newBrand)
        $content = $content.Replace($oldContact, $newContact)
        
        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Updated footer info in $file"
    }
}
