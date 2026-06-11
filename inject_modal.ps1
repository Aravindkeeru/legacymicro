$modalHtml = @"
<!-- ========== Quote Modal ========== -->
<div id="quoteModal" class="modal-overlay">
  <div class="modal-content">
    <button class="modal-close" onclick="closeQuoteModal()" aria-label="Close modal">
      <i data-lucide="x"></i>
    </button>
    <h3 style="margin-bottom: 8px;">Request a Quote</h3>
    <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 24px;">Our team will get back to you within 24 hours.</p>
    
    <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
      <div class="form-row">
        <div class="form-group">
          <label for="modalEmail" class="form-label">Email Address *</label>
          <input type="email" id="modalEmail" name="email" class="form-input" required placeholder="john@company.com">
        </div>
        <div class="form-group">
          <label for="modalPhone" class="form-label">Phone Number</label>
          <input type="tel" id="modalPhone" name="phone" class="form-input" placeholder="+91-XXXXXXXXXX">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label for="modalPart" class="form-label">Part Number</label>
          <input type="text" id="modalPart" name="partNumber" class="form-input" style="font-family: var(--font-mono);" readonly>
        </div>
        <div class="form-group">
          <label for="modalQty" class="form-label">Quantity Required *</label>
          <input type="number" id="modalQty" name="quantity" class="form-input" required min="1" placeholder="e.g. 500">
        </div>
      </div>
      
      <div class="form-group">
        <label for="modalMessage" class="form-label">Additional Requirements</label>
        <textarea id="modalMessage" name="message" class="form-textarea" rows="3" placeholder="Target price, preferred brand, urgency..."></textarea>
      </div>
      
      <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 16px;">Submit Request</button>
    </form>
  </div>
</div>
"@

# Update index.html
$indexPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\index.html"
$indexContent = Get-Content $indexPath -Raw
if ($indexContent -notmatch 'id="quoteModal"') {
    $indexContent = $indexContent -replace '</body>', "$modalHtml`r`n</body>"
    # Replace anchor tags with buttons
    $indexContent = [regex]::Replace($indexContent, '<a href="contact\.html\?part=([^"]+)" class="btn btn-primary btn-sm">Request Quote</a>', '<button class="btn btn-primary btn-sm" onclick="openQuoteModal(''$1'')">Request Quote</button>')
    Set-Content -Path $indexPath -Value $indexContent
    Write-Output "Updated index.html"
}

# Update search.html
$searchPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\search.html"
$searchContent = Get-Content $searchPath -Raw
if ($searchContent -notmatch 'id="quoteModal"') {
    $searchContent = $searchContent -replace '</body>', "$modalHtml`r`n</body>"
    Set-Content -Path $searchPath -Value $searchContent
    Write-Output "Updated search.html"
}

# Update js/search.js
$searchJsPath = "C:\Users\admin\.gemini\antigravity\scratch\racomlink\js\search.js"
$searchJsContent = Get-Content $searchJsPath -Raw
$searchJsContent = [regex]::Replace($searchJsContent, '<a href="contact\.html\?part=\$\{encodeURIComponent\(part\.mpn\)\}" class="btn btn-primary btn-sm">Request Quote</a>', '<button class="btn btn-primary btn-sm" onclick="openQuoteModal(''\${part.mpn}'')">Request Quote</button>')
$searchJsContent = [regex]::Replace($searchJsContent, '<a href="contact\.html\?part=\$\{encodeURIComponent\(query\)\}" class="btn btn-primary">Submit Sourcing Inquiry</a>', '<button class="btn btn-primary" onclick="openQuoteModal(''\${query}'')">Submit Sourcing Inquiry</button>')
Set-Content -Path $searchJsPath -Value $searchJsContent
Write-Output "Updated search.js"

