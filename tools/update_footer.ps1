$newFooter = @"
        <div class="footer-grid" style="grid-template-columns: 2fr 1fr 1fr 1fr 1fr; gap: 2rem;">
          <div class="footer-brand">
            <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap; margin-bottom: 1rem;">
              <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 12px; flex-shrink: 0;">
              <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; padding-left: 16px;">
                <div class="logo-top-line" style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
                  <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                    <span class="logo-core-wrapper">
                      <span class="logo-legacy-container">
                        <span class="logo-legacy" style="letter-spacing: 1px;">LEGACY</span>
                      </span>
                      <span class="logo-micro-container">
                        <span class="logo-mu-intro">&#956;</span>
                        <span class="logo-micro-text">MICRO</span>
                      </span>
                    </span>
                    <sup class="logo-reg">&reg;</sup>
                  </div>
                </div>
                <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.6px; color: var(--text-secondary); font-weight: 600; margin-top: 4px; text-align: center; width: 100%;">ELECTRONIC COMPONENTS</span>
              </div>
            </a>
            <p>Independent electronic component distributor. We keep production lines running globally.</p>
            <div style="margin-top: 1.5rem; color: var(--text-secondary); font-size: 0.9rem; line-height: 1.6;">
              <strong>Office:</strong> Nehru Nagar, Guntur, AP, India<br>
              <strong>Email:</strong> sales@legacy-micro.com<br>
              <strong>Phone:</strong> +91 90000 00000<br>
              <strong>GST:</strong> 37XXXXXXXXXX1ZV<br>
              <strong>IEC:</strong> XXXXXXXXXX
            </div>
            <div style="margin-top: 1rem;">
              <a href="#" style="color: var(--accent); text-decoration: none;"><i data-lucide="linkedin"></i> LinkedIn</a>
            </div>
            <p class="legal-name" style="margin-top: 2rem;">Legacy Micro &bull; Est. 2026</p>
          </div>
          <div>
            <h4>Manufacturers</h4>
            <div class="footer-links">
              <a href="manufacturers.html">All Manufacturers</a>
              <a href="mfr-texas-instruments.html">Texas Instruments</a>
              <a href="mfr-analog-devices.html">Analog Devices</a>
              <a href="mfr-infineon.html">Infineon</a>
              <a href="mfr-nxp.html">NXP</a>
              <a href="mfr-stmicroelectronics.html">STMicroelectronics</a>
              <a href="mfr-microchip.html">Microchip</a>
            </div>
          </div>
          <div>
            <h4>Industries</h4>
            <div class="footer-links">
              <a href="industries.html#industrial">Industrial</a>
              <a href="industries.html#automotive">Automotive</a>
              <a href="industries.html#medical">Medical</a>
              <a href="industries.html#telecom">Telecom</a>
              <a href="industries.html#aerospace">Aerospace</a>
              <a href="industries.html#energy">Energy</a>
            </div>
          </div>
          <div>
            <h4>Resources</h4>
            <div class="footer-links">
              <a href="#">Component Shortages</a>
              <a href="#">PCN Updates</a>
              <a href="#">EOL Notices</a>
              <a href="#">Manufacturer News</a>
              <a href="#">Counterfeit Awareness</a>
            </div>
          </div>
          <div>
            <h4>Company</h4>
            <div class="footer-links">
              <a href="about.html">About Us</a>
              <a href="quality.html">Quality Assurance</a>
              <a href="search.html">Part Search</a>
              <a href="contact.html">Contact</a>
              <a href="privacy.html">Privacy Policy</a>
              <a href="#">Terms of Sale</a>
            </div>
          </div>
        </div>
"@

$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -match "test|internal-calc") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $content = $content -replace '(?s)<div class="footer-grid">.*?</div>\s*</div>\s*</footer>', "$newFooter`n      </div>`n    </footer>"
    Set-Content $file.FullName $content -Encoding UTF8
}
