$content = Get-Content index.html -Raw -Encoding UTF8

# 1 & 2 & 3. Fix head, description, keywords
$headFix = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Legacy Micro — Independent electronic component distributor. We specialize in sourcing hard-to-find, obsolete, and allocated semiconductors globally.">
  <meta name="keywords" content="electronic components, semiconductor distributor, hard-to-find parts, obsolete components, EOL parts, India distributor, Legacy Micro">
"@
$content = $content -replace '(?s)^\s*<meta name="description"[^>]+>\s*<meta name="keywords"[^>]+>', $headFix

# 4. JSON-LD Schema
$schema = @"
  <!-- JSON-LD Schema Markup -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@graph": [
      {
        "@type": "Organization",
        "@id": "https://legacy-micro.com/#organization",
        "name": "Legacy Micro",
        "url": "https://legacy-micro.com",
        "logo": "https://legacy-micro.com/assets/lm-logo.svg",
        "contactPoint": {
          "@type": "ContactPoint",
          "telephone": "+91-90000-00000",
          "contactType": "customer service",
          "areaServed": "IN",
          "availableLanguage": ["en"]
        }
      },
      {
        "@type": "LocalBusiness",
        "@id": "https://legacy-micro.com/#localbusiness",
        "name": "Legacy Micro",
        "image": "https://legacy-micro.com/assets/lm-logo.svg",
        "address": {
          "@type": "PostalAddress",
          "streetAddress": "Nehru Nagar",
          "addressLocality": "Guntur",
          "addressRegion": "Andhra Pradesh",
          "addressCountry": "IN"
        },
        "telephone": "+91-90000-00000"
      },
      {
        "@type": "WebSite",
        "@id": "https://legacy-micro.com/#website",
        "url": "https://legacy-micro.com/",
        "name": "Legacy Micro",
        "description": "Independent electronic component distributor specializing in hard-to-find and obsolete semiconductors.",
        "publisher": {
          "@id": "https://legacy-micro.com/#organization"
        },
        "potentialAction": {
          "@type": "SearchAction",
          "target": "https://legacy-micro.com/search.html?q={search_term_string}",
          "query-input": "required name=search_term_string"
        }
      }
    ]
  }
  </script>
</head>
"@
$content = $content -replace '</head>', $schema

# 5. Hero Copy
$content = $content -replace "India's Premier Component Sourcing", "Independent Electronic Component Distributor"
$content = $content -replace "(?s)Strategic procurement for the global electronics supply chain\. We specialize in sourcing hard-to-find,\s*obsolete, and allocated semiconductors with zero compromise on authenticity\.", "We keep production lines running. Can't find an obsolete IC? Facing allocation? Need an alternate part? Concerned about counterfeit risk? We specialize in sourcing hard-to-find and obsolete semiconductors globally."

# 6. Trust Signals and Ecosystem
$newTrustSection = @"
  <!-- ========== Trust Signals ========== -->
  <section class="section reveal" style="padding-top: 2rem; padding-bottom: 2rem; background: rgba(0, 240, 255, 0.02); border-bottom: 1px solid rgba(255,255,255,0.05); border-top: 1px solid rgba(255,255,255,0.05);">
    <div class="container">
      <div class="grid-3" style="gap: 1.5rem; text-align: center;">
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <i data-lucide="shield-check" style="color: var(--accent); width: 32px; height: 32px;"></i>
          <h4 style="margin: 0; font-size: 1.1rem;">Authentic Components</h4>
          <span style="color: var(--text-secondary); font-size: 0.9rem;">Zero Counterfeit Tolerance</span>
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <i data-lucide="globe" style="color: var(--accent); width: 32px; height: 32px;"></i>
          <h4 style="margin: 0; font-size: 1.1rem;">Global Supplier Network</h4>
          <span style="color: var(--text-secondary); font-size: 0.9rem;">Sourcing From 50+ Countries</span>
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <i data-lucide="zap" style="color: var(--accent); width: 32px; height: 32px;"></i>
          <h4 style="margin: 0; font-size: 1.1rem;">Fast RFQ Turnaround</h4>
          <span style="color: var(--text-secondary); font-size: 0.9rem;">Quotes Under 24 Hours</span>
        </div>
      </div>
    </div>
  </section>

  <!-- ========== Trusted Manufacturer Ecosystem ========== -->
  <section class="manufacturer-carousel">
    <div class="manufacturer-track">
      <!-- Authentic Logos using Clearbit API -->
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/ti.com" alt="Texas Instruments" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/analog.com" alt="Analog Devices" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/nxp.com" alt="NXP" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/st.com" alt="STMicroelectronics" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/infineon.com" alt="Infineon" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/microchip.com" alt="Microchip" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/murata.com" alt="Murata" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/vishay.com" alt="Vishay" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      
      <!-- Duplicate for infinite scroll loop -->
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/ti.com" alt="Texas Instruments" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/analog.com" alt="Analog Devices" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/nxp.com" alt="NXP" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/st.com" alt="STMicroelectronics" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/infineon.com" alt="Infineon" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/microchip.com" alt="Microchip" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/murata.com" alt="Murata" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/vishay.com" alt="Vishay" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
    </div>
  </section>
"@
$content = $content -replace '(?s)<!-- ========== Global Manufacturer Network ========== -->.*?</div>\s*</section>', $newTrustSection

# 7. Footer
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
$content = $content -replace '(?s)<div class="footer-grid">.*?</div>\s*</div>\s*</footer>', "$newFooter`n      </div>`n    </footer>"

# 8. FAB
$fabHtml = @"
  <!-- ========== Floating Sticky RFQ ========== -->
  <button class="btn btn-primary floating-rfq" onclick="openQuoteModal('')">
    <i data-lucide="file-text" style="width: 18px; height: 18px;"></i> Request Quote
  </button>
"@
$content = $content -replace '(?s)</body>', "$fabHtml`n</body>"

Set-Content index.html $content -Encoding UTF8
