$content = Get-Content index.html -Raw -Encoding UTF8

$newStatsBar = @"
  <!-- ========== Value Proposition Bar ========== -->
  <section class="section reveal">
    <div class="container">
      <div class="stats-bar" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 2rem; text-align: center; background: rgba(0,0,0,0.3); padding: 2.5rem 2rem; border-radius: var(--radius-lg); border: 1px solid rgba(255,255,255,0.05);">
        <div class="stat-item">
          <div style="font-size: 2.5rem; color: var(--accent); margin-bottom: 1rem; display: flex; justify-content: center;"><i data-lucide="globe" style="width: 36px; height: 36px;"></i></div>
          <div style="font-weight: 800; font-size: 1.2rem; color: var(--text-primary); letter-spacing: 0.5px;">Global Network</div>
          <div style="font-size: 0.9rem; color: var(--text-secondary); margin-top: 0.5rem;">Sourcing from USA, EU & APAC</div>
        </div>
        <div class="stat-item">
          <div style="font-size: 2.5rem; color: var(--accent); margin-bottom: 1rem; display: flex; justify-content: center;"><i data-lucide="zap" style="width: 36px; height: 36px;"></i></div>
          <div style="font-weight: 800; font-size: 1.2rem; color: var(--text-primary); letter-spacing: 0.5px;">&lt;24h Turnaround</div>
          <div style="font-size: 0.9rem; color: var(--text-secondary); margin-top: 0.5rem;">Rapid response on all RFQs</div>
        </div>
        <div class="stat-item">
          <div style="font-size: 2.5rem; color: var(--accent); margin-bottom: 1rem; display: flex; justify-content: center;"><i data-lucide="shield-check" style="width: 36px; height: 36px;"></i></div>
          <div style="font-weight: 800; font-size: 1.2rem; color: var(--text-primary); letter-spacing: 0.5px;">100% Genuine</div>
          <div style="font-size: 0.9rem; color: var(--text-secondary); margin-top: 0.5rem;">Zero counterfeit tolerance</div>
        </div>
        <div class="stat-item">
          <div style="font-size: 2.5rem; color: var(--accent); margin-bottom: 1rem; display: flex; justify-content: center;"><i data-lucide="award" style="width: 36px; height: 36px;"></i></div>
          <div style="font-weight: 800; font-size: 1.2rem; color: var(--text-primary); letter-spacing: 0.5px;">ISO 9001:2015</div>
          <div style="font-size: 0.9rem; color: var(--text-secondary); margin-top: 0.5rem;">Certified quality standards</div>
        </div>
      </div>
    </div>
  </section>
"@

$content = $content -replace '(?s)<!-- ========== Stats Bar ========== -->.*?</section>', $newStatsBar

Set-Content index.html $content -Encoding UTF8
