$cssPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\css\style.css"
$indexPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\index.html"

$newCss = @"

/* ---------- Manufacturer Logo Carousel ---------- */
.manufacturer-carousel {
  width: 100%;
  overflow: hidden;
  background: var(--bg-tertiary);
  padding: var(--space-xl) 0;
  border-bottom: 1px solid var(--border);
  position: relative;
  display: flex;
}

.manufacturer-carousel::before,
.manufacturer-carousel::after {
  content: "";
  position: absolute;
  top: 0;
  bottom: 0;
  width: 100px;
  z-index: 2;
  pointer-events: none;
}

.manufacturer-carousel::before {
  left: 0;
  background: linear-gradient(to right, var(--bg-tertiary), transparent);
}

.manufacturer-carousel::after {
  right: 0;
  background: linear-gradient(to left, var(--bg-tertiary), transparent);
}

.manufacturer-track {
  display: flex;
  gap: var(--space-4xl);
  padding-left: var(--space-4xl);
  animation: manufacturer-scroll 30s linear infinite;
  align-items: center;
}

@keyframes manufacturer-scroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.manufacturer-logo {
  font-family: var(--font-sans);
  font-weight: 800;
  font-size: 1.5rem;
  color: var(--text-muted);
  letter-spacing: -0.5px;
  white-space: nowrap;
  opacity: 0.6;
  transition: opacity 0.3s var(--ease), color 0.3s var(--ease);
}

.manufacturer-logo:hover {
  opacity: 1;
  color: var(--text-primary);
}

/* ---------- Our Approach Section ---------- */
.approach-section {
  padding: var(--space-4xl) 0;
  background: var(--bg-primary);
}

.approach-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--space-lg);
  margin-top: var(--space-2xl);
}

@media (min-width: 768px) {
  .approach-grid { grid-template-columns: repeat(3, 1fr); }
}

.approach-card {
  padding: var(--space-2xl);
  background: var(--bg-secondary);
  border: 1px solid var(--border);
  border-radius: var(--radius-xl);
  position: relative;
  overflow: hidden;
  transition: transform 0.4s var(--ease), border-color 0.4s var(--ease);
}

.approach-card::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 4px;
  background: var(--accent);
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.4s var(--ease);
}

.approach-card:hover {
  transform: translateY(-5px);
  border-color: var(--border-hover);
}

.approach-card:hover::before {
  transform: scaleX(1);
}

.approach-number {
  position: absolute;
  top: var(--space-xl);
  right: var(--space-xl);
  font-size: 4rem;
  font-weight: 800;
  color: rgba(255, 255, 255, 0.03);
  line-height: 1;
}

.approach-icon {
  font-size: 2.5rem;
  margin-bottom: var(--space-md);
  color: var(--accent);
}

.approach-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: var(--space-sm);
}

/* ---------- Product Categories ---------- */
.categories-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--space-lg);
  margin-top: var(--space-2xl);
}

@media (min-width: 768px) {
  .categories-grid { grid-template-columns: repeat(3, 1fr); }
}

.category-card {
  height: 350px;
  border-radius: var(--radius-xl);
  overflow: hidden;
  position: relative;
  border: 1px solid var(--border);
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: var(--space-xl);
  text-decoration: none;
}

.category-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0.4;
  transition: opacity 0.5s var(--ease), transform 0.5s var(--ease);
  z-index: 0;
}

.category-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to top, rgba(9, 9, 11, 0.95) 0%, rgba(9, 9, 11, 0.4) 60%, rgba(9, 9, 11, 0.1) 100%);
  z-index: 1;
}

.category-card:hover .category-bg {
  opacity: 0.6;
  transform: scale(1.05);
}

.category-content {
  position: relative;
  z-index: 2;
}

.category-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: var(--space-sm);
}

.category-list {
  list-style: none;
  padding: 0;
  margin: 0;
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.category-list li {
  margin-bottom: 4px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.category-list li::before {
  content: "→";
  color: var(--accent);
}
"@

Add-Content -Path $cssPath -Value $newCss

$htmlContent = Get-Content $indexPath -Raw

$carouselHtml = @"
  <!-- ========== Global Manufacturer Network ========== -->
  <section class="manufacturer-carousel">
    <div class="manufacturer-track">
      <div class="manufacturer-logo">TEXAS INSTRUMENTS</div>
      <div class="manufacturer-logo" style="font-style: italic;">ANALOG DEVICES</div>
      <div class="manufacturer-logo" style="font-weight: 900; letter-spacing: 1px;">MICROCHIP</div>
      <div class="manufacturer-logo" style="font-family: monospace; font-size: 1.8rem;">NXP</div>
      <div class="manufacturer-logo">STMicroelectronics</div>
      <div class="manufacturer-logo" style="font-weight: 600;">Infineon</div>
      <div class="manufacturer-logo" style="letter-spacing: 2px;">XILINX</div>
      <div class="manufacturer-logo">Amphenol</div>
      <div class="manufacturer-logo">Littelfuse</div>
      <!-- Duplicate for infinite scroll -->
      <div class="manufacturer-logo">TEXAS INSTRUMENTS</div>
      <div class="manufacturer-logo" style="font-style: italic;">ANALOG DEVICES</div>
      <div class="manufacturer-logo" style="font-weight: 900; letter-spacing: 1px;">MICROCHIP</div>
      <div class="manufacturer-logo" style="font-family: monospace; font-size: 1.8rem;">NXP</div>
      <div class="manufacturer-logo">STMicroelectronics</div>
      <div class="manufacturer-logo" style="font-weight: 600;">Infineon</div>
      <div class="manufacturer-logo" style="letter-spacing: 2px;">XILINX</div>
      <div class="manufacturer-logo">Amphenol</div>
      <div class="manufacturer-logo">Littelfuse</div>
    </div>
  </section>
"@

$categoriesHtml = @"
  <!-- ========== Product Categories ========== -->
  <section class="section reveal" style="padding-bottom: 0;">
    <div class="container">
      <div class="section-header">
        <span class="section-label">Electronic Components</span>
        <h2>Quality Components. Endless Possibilities.</h2>
        <p>From semiconductors to connectors and beyond, we supply a wide range of electronic components to power innovation and drive performance.</p>
      </div>
      <div class="categories-grid">
        <div class="category-card">
          <div class="category-bg" style="background-image: url('assets/comp_atmega.png');"></div>
          <div class="category-overlay"></div>
          <div class="category-content">
            <h3 class="category-title">Semiconductors & ICs</h3>
            <ul class="category-list">
              <li>Microcontrollers (MCU)</li>
              <li>Memory ICs</li>
              <li>Power Management ICs</li>
              <li>RF & Wireless ICs</li>
            </ul>
          </div>
        </div>
        <div class="category-card">
          <div class="category-bg" style="background-image: url('assets/comp_amphenol.png');"></div>
          <div class="category-overlay"></div>
          <div class="category-content">
            <h3 class="category-title">Interconnects</h3>
            <ul class="category-list">
              <li>Board to Board Connectors</li>
              <li>Power Connectors</li>
              <li>RF Connectors</li>
              <li>MIL-SPEC Connectors</li>
            </ul>
          </div>
        </div>
        <div class="category-card">
          <div class="category-bg" style="background-image: url('assets/comp_kemet.png');"></div>
          <div class="category-overlay"></div>
          <div class="category-content">
            <h3 class="category-title">Passives & Protection</h3>
            <ul class="category-list">
              <li>Capacitors (Tantalum, MLCC)</li>
              <li>Fuses & TVS Diodes</li>
              <li>Surge Protection Devices</li>
              <li>Resistors & Inductors</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </section>
"@

$approachHtml = @"
  <!-- ========== Our Approach ========== -->
  <section class="approach-section reveal">
    <div class="container">
      <div class="section-header text-center" style="max-width: 800px; margin: 0 auto;">
        <span class="section-label">What Drives Us</span>
        <h2>Our Strategic Approach</h2>
        <p>At Legacy Microtronix, we follow a structured approach built on reliability, accountability, and scalable growth to deliver long-term value for our partners.</p>
      </div>
      <div class="approach-grid">
        <div class="approach-card">
          <div class="approach-number">01</div>
          <div class="approach-icon"><i data-lucide="shield-check"></i></div>
          <h3 class="approach-title">Supply Continuity</h3>
          <p class="text-secondary">Ensuring uninterrupted supply flow to keep your production moving. Every sourcing decision is guided by delivery commitment.</p>
        </div>
        <div class="approach-card">
          <div class="approach-number">02</div>
          <div class="approach-icon"><i data-lucide="search-check"></i></div>
          <h3 class="approach-title">Quality Verification</h3>
          <p class="text-secondary">Rigorous checks and authenticity assurance you can depend on. We maintain transparent communication and traceability standards.</p>
        </div>
        <div class="approach-card">
          <div class="approach-number">03</div>
          <div class="approach-icon"><i data-lucide="line-chart"></i></div>
          <h3 class="approach-title">Risk Mitigation</h3>
          <p class="text-secondary">Proactive planning to minimize disruptions and delays. Strategic stocking programs that reduce risk and uncertainty.</p>
        </div>
      </div>
    </div>
  </section>
"@

# Inject Carousel right after Hero section
if ($htmlContent -notmatch 'class="manufacturer-carousel"') {
    $htmlContent = $htmlContent -replace '<!-- ========== Trust Signals ========== -->', "$carouselHtml`r`n  <!-- ========== Trust Signals ========== -->"
}

# Inject Categories right before Featured Inventory
if ($htmlContent -notmatch 'class="categories-grid"') {
    $htmlContent = $htmlContent -replace '<!-- ========== Featured Inventory Component ========== -->', "$categoriesHtml`r`n  <!-- ========== Featured Inventory Component ========== -->"
}

# Inject Approach right after Trust Signals
if ($htmlContent -notmatch 'class="approach-section"') {
    $htmlContent = $htmlContent -replace '<!-- ========== Search Component ========== -->', "$approachHtml`r`n  <!-- ========== Search Component ========== -->"
}

Set-Content -Path $indexPath -Value $htmlContent
Write-Output "Vollersasea cues injected successfully."
