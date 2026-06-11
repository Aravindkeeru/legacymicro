$indexPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\index.html"
$content = Get-Content $indexPath -Raw

$trustHtml = @"
  <!-- ========== Trust Signals ========== -->
  <section class="trust-section reveal">
    <div class="container">
      <div class="section-header">
        <h2>Trusted by India's Manufacturers</h2>
        <p>We hold ourselves to the same standards as the world's best component brokers — with a focus on Indian business needs.</p>
      </div>
      <div class="trust-grid">
        <div class="trust-badge">
          <div class="trust-badge-icon">🏛️</div>
          <div class="trust-badge-title">GST Registered</div>
          <div class="trust-badge-note">Valid B2B invoices</div>
        </div>
        <div class="trust-badge">
          <div class="trust-badge-icon">📋</div>
          <div class="trust-badge-title">IEC Registered</div>
          <div class="trust-badge-note">Licensed importer</div>
        </div>
        <div class="trust-badge">
          <div class="trust-badge-icon">💰</div>
          <div class="trust-badge-title">INR Invoicing</div>
          <div class="trust-badge-note">No forex complications</div>
        </div>
        <div class="trust-badge">
          <div class="trust-badge-icon">🔒</div>
          <div class="trust-badge-title">Anti-Counterfeit</div>
          <div class="trust-badge-note">Full inspection process</div>
        </div>
        <div class="trust-badge">
          <div class="trust-badge-icon">📦</div>
          <div class="trust-badge-title">ERAI Membership</div>
          <div class="trust-badge-note">In progress</div>
        </div>
        <div class="trust-badge">
          <div class="trust-badge-icon">✅</div>
          <div class="trust-badge-title">ISO 9001</div>
          <div class="trust-badge-note">Certification planned</div>
        </div>
      </div>
    </div>
  </section>
"@

$capabilitiesHtml = @"
  <!-- ========== Core Capabilities ========== -->
  <section class="section reveal">
    <div class="container">
      <div class="section-header">
        <span class="section-label">Our Strengths</span>
        <h2>Strategic Sourcing Capabilities</h2>
        <p>Whether it's a short supply crisis, an EOL disaster, or a bulk order opportunity — we have the network to solve it.</p>
      </div>
      <div class="capabilities-grid">
        <div class="capability-card">
          <div class="capability-icon">⚡</div>
          <h3 class="capability-title">Spot Market Sourcing</h3>
          <p class="text-secondary">When authorized stock is depleted or lead times stretch to 52 weeks, we tap the spot market. We verify every source and provide full traceability.</p>
        </div>
        <div class="capability-card">
          <div class="capability-icon">🏭</div>
          <h3 class="capability-title">Obsolete & EOL Components</h3>
          <p class="text-secondary">Long after a part goes end-of-life, we maintain relationships with excess inventory holders globally. No component is too old.</p>
        </div>
        <div class="capability-card">
          <div class="capability-icon">🇨🇳</div>
          <h3 class="capability-title">China Direct Sourcing</h3>
          <p class="text-secondary">Shenzhen relationships mean 40–60% savings on high-volume orders vs. Western distribution — with full authenticity verification.</p>
        </div>
        <div class="capability-card">
          <div class="capability-icon">📦</div>
          <h3 class="capability-title">Excess Inventory Buying</h3>
          <p class="text-secondary">Companies with excess or obsolete inventory can sell to us. We pay fair market value, fast turnaround, and handle all logistics.</p>
        </div>
      </div>
    </div>
  </section>
"@

$marqueeHtml = @"
  <!-- ========== Infinite Component Marquee ========== -->
  <section class="section reveal" style="padding-bottom: 0;">
    <div class="container" style="margin-bottom: var(--space-xl);">
      <h2 style="text-align: center;">Frequent Selling & Legacy Inventory</h2>
    </div>
    <div class="marquee-container">
      <div class="marquee-track">
        <!-- Item 1 -->
        <div class="marquee-item">
          <img src="assets/comp_opa2134.png" alt="OPA2134">
          <div class="marquee-overlay">
            <div class="marquee-mpn">OPA2134PA</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('OPA2134PA')">Request Quote</button>
          </div>
        </div>
        <!-- Item 2 -->
        <div class="marquee-item">
          <img src="assets/comp_atmega.png" alt="ATMEGA328P">
          <div class="marquee-overlay">
            <div class="marquee-mpn">ATMEGA328P-PU</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('ATMEGA328P-PU')">Request Quote</button>
          </div>
        </div>
        <!-- Item 3 -->
        <div class="marquee-item">
          <img src="assets/comp_ad9361.png" alt="AD9361">
          <div class="marquee-overlay">
            <div class="marquee-mpn">AD9361BBCZ</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('AD9361BBCZ')">Request Quote</button>
          </div>
        </div>
        <!-- Item 4 -->
        <div class="marquee-item">
          <img src="assets/comp_nxp.png" alt="LPC1768">
          <div class="marquee-overlay">
            <div class="marquee-mpn">LPC1768FBD100</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('LPC1768FBD100')">Request Quote</button>
          </div>
        </div>
        <!-- Item 5 -->
        <div class="marquee-item">
          <img src="assets/comp_igbt.png" alt="IGBT">
          <div class="marquee-overlay">
            <div class="marquee-mpn">FF150R12RT4</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('FF150R12RT4')">Request Quote</button>
          </div>
        </div>
        <!-- Item 6 -->
        <div class="marquee-item">
          <img src="assets/comp_kemet.png" alt="Tantalum">
          <div class="marquee-overlay">
            <div class="marquee-mpn">T491A105K035AT</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('T491A105K035AT')">Request Quote</button>
          </div>
        </div>
        <!-- Item 7 -->
        <div class="marquee-item">
          <img src="assets/comp_amphenol.png" alt="MS3106A">
          <div class="marquee-overlay">
            <div class="marquee-mpn">MS3106A-18-1S</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('MS3106A-18-1S')">Request Quote</button>
          </div>
        </div>
        <!-- Item 8 -->
        <div class="marquee-item">
          <img src="assets/comp_dsub.png" alt="DB9">
          <div class="marquee-overlay">
            <div class="marquee-mpn">DB9-FEMALE</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('DB9-FEMALE')">Request Quote</button>
          </div>
        </div>
        <!-- Duplicate set for infinite loop seamlessly -->
        <div class="marquee-item">
          <img src="assets/comp_opa2134.png" alt="OPA2134">
          <div class="marquee-overlay">
            <div class="marquee-mpn">OPA2134PA</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('OPA2134PA')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_atmega.png" alt="ATMEGA328P">
          <div class="marquee-overlay">
            <div class="marquee-mpn">ATMEGA328P-PU</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('ATMEGA328P-PU')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_ad9361.png" alt="AD9361">
          <div class="marquee-overlay">
            <div class="marquee-mpn">AD9361BBCZ</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('AD9361BBCZ')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_nxp.png" alt="LPC1768">
          <div class="marquee-overlay">
            <div class="marquee-mpn">LPC1768FBD100</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('LPC1768FBD100')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_igbt.png" alt="IGBT">
          <div class="marquee-overlay">
            <div class="marquee-mpn">FF150R12RT4</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('FF150R12RT4')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_kemet.png" alt="Tantalum">
          <div class="marquee-overlay">
            <div class="marquee-mpn">T491A105K035AT</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('T491A105K035AT')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_amphenol.png" alt="MS3106A">
          <div class="marquee-overlay">
            <div class="marquee-mpn">MS3106A-18-1S</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('MS3106A-18-1S')">Request Quote</button>
          </div>
        </div>
        <div class="marquee-item">
          <img src="assets/comp_dsub.png" alt="DB9">
          <div class="marquee-overlay">
            <div class="marquee-mpn">DB9-FEMALE</div>
            <button class="btn btn-primary btn-sm" onclick="openQuoteModal('DB9-FEMALE')">Request Quote</button>
          </div>
        </div>
      </div>
    </div>
  </section>
"@

$newsHtml = @"
  <!-- ========== Semiconductor Insights & News ========== -->
  <section class="section reveal">
    <div class="container">
      <div class="section-header">
        <span class="section-label">Market Intelligence</span>
        <h2>Semiconductor Insights</h2>
        <p>Stay updated on Indian market trends, global lead times, and allocation strategies.</p>
      </div>
      <div class="news-grid">
        <!-- Article 1 -->
        <article class="news-card">
          <div class="news-image" style="background: url('assets/comp_fpga.png') center/cover;"></div>
          <div class="news-content">
            <div class="news-meta">
              <span>Market Trends</span>
              <span>June 2026</span>
            </div>
            <h3 class="news-title">Navigating EOL Sourcing in the Indian Defense Sector</h3>
            <p class="news-excerpt">As legacy defense programs are extended, the demand for obsolete MIL-SPEC components is surging. Here's how to secure authentic stock.</p>
            <a href="#" class="news-link">Read Full Article <i data-lucide="arrow-right" style="width: 14px;"></i></a>
          </div>
        </article>
        <!-- Article 2 -->
        <article class="news-card">
          <div class="news-image" style="background: url('assets/comp_stm32.png') center/cover;"></div>
          <div class="news-content">
            <div class="news-meta">
              <span>Supply Chain</span>
              <span>May 2026</span>
            </div>
            <h3 class="news-title">2026 Semiconductor Outlook: MCU Lead Times Stabilize</h3>
            <p class="news-excerpt">While general purpose MCUs are seeing normalized lead times, specialized automotive and industrial chips remain tightly allocated.</p>
            <a href="#" class="news-link">Read Full Article <i data-lucide="arrow-right" style="width: 14px;"></i></a>
          </div>
        </article>
        <!-- Article 3 -->
        <article class="news-card">
          <div class="news-image" style="background: url('assets/comp_igbt.png') center/cover;"></div>
          <div class="news-content">
            <div class="news-meta">
              <span>Strategic Sourcing</span>
              <span>April 2026</span>
            </div>
            <h3 class="news-title">Why Indian EMS Providers are Shifting to Independent Distributors</h3>
            <p class="news-excerpt">With franchised distributors enforcing strict non-cancellable terms, independent brokers offer the flexibility modern EMS requires.</p>
            <a href="#" class="news-link">Read Full Article <i data-lucide="arrow-right" style="width: 14px;"></i></a>
          </div>
        </article>
      </div>
    </div>
  </section>
"@

if ($content -notmatch 'class="trust-section"') {
    $content = $content -replace '<!-- ========== Search Component ========== -->', "$trustHtml`r`n  <!-- ========== Search Component ========== -->"
}

if ($content -notmatch 'class="capabilities-grid"') {
    $content = $content -replace '<!-- ========== CTA Section ========== -->', "$capabilitiesHtml`r`n  <!-- ========== CTA Section ========== -->"
}

if ($content -notmatch 'class="marquee-container"') {
    $content = $content -replace '<!-- ========== CTA Section ========== -->', "$marqueeHtml`r`n  <!-- ========== CTA Section ========== -->"
}

if ($content -notmatch 'class="news-grid"') {
    $content = $content -replace '<!-- ========== CTA Section ========== -->', "$newsHtml`r`n  <!-- ========== CTA Section ========== -->"
}

Set-Content -Path $indexPath -Value $content
Write-Output "Injected new sections into index.html"

# Fix Audio in index.html to local file (empty audio for now)
# Create a silent 1-second mp3 data URI to prevent errors if they don't have one, or just tell them to put one in assets
$content = $content -replace 'src="https://assets.mixkit.co/music/download/mixkit-deep-ambient-116.mp3"', 'src="assets/bg-music.mp3"'
Set-Content -Path $indexPath -Value $content

