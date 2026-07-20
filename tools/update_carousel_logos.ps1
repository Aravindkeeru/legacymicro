$content = Get-Content index.html -Raw -Encoding UTF8

$newCarousel = @"
  <!-- ========== Trusted Manufacturer Ecosystem ========== -->
  <section class="manufacturer-carousel">
    <div class="manufacturer-track">
      <!-- Typography Logos (Adblocker Safe) -->
      <div class="manufacturer-logo">TEXAS INSTRUMENTS</div>
      <div class="manufacturer-logo">ANALOG DEVICES</div>
      <div class="manufacturer-logo">XILINX</div>
      <div class="manufacturer-logo">MICRON</div>
      <div class="manufacturer-logo">INFINEON</div>
      <div class="manufacturer-logo">MICROCHIP</div>
      
      <!-- Duplicate for infinite scroll loop -->
      <div class="manufacturer-logo">TEXAS INSTRUMENTS</div>
      <div class="manufacturer-logo">ANALOG DEVICES</div>
      <div class="manufacturer-logo">XILINX</div>
      <div class="manufacturer-logo">MICRON</div>
      <div class="manufacturer-logo">INFINEON</div>
      <div class="manufacturer-logo">MICROCHIP</div>
    </div>
  </section>
"@

$content = $content -replace '(?s)<!-- ========== Trusted Manufacturer Ecosystem ========== -->.*?</section>', $newCarousel

Set-Content index.html $content -Encoding UTF8
