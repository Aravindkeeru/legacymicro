$fabHtml = @"

  <!-- ========== Floating Sticky RFQ ========== -->
  <button class="btn btn-primary floating-rfq" onclick="openQuoteModal('')">
    <i data-lucide="file-text" style="width: 18px; height: 18px;"></i> Request Quote
  </button>
"@

$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -match "test|internal-calc") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $content = $content -replace '(?s)</body>', "$fabHtml`n</body>"
    Set-Content $file.FullName $content -Encoding UTF8
}
