$content = Get-Content index.html -Raw -Encoding UTF8

# Update Trust Signals
$content = $content -replace 'Authentic Components', 'Genuine Parts.'
$content = $content -replace 'Zero Counterfeit Tolerance', 'Verified Sources.'

# Update Manufacturer Ecosystem
$newCarousel = @"
  <!-- ========== Trusted Manufacturer Ecosystem ========== -->
  <section class="manufacturer-carousel">
    <div class="manufacturer-track">
      <!-- Authentic Logos using Clearbit API -->
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/ti.com" alt="Texas Instruments" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/analog.com" alt="Analog Devices" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/xilinx.com" alt="Xilinx" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/micron.com" alt="Micron" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/infineon.com" alt="Infineon" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/microchip.com" alt="Microchip" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      
      <!-- Duplicate for infinite scroll loop -->
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/ti.com" alt="Texas Instruments" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/analog.com" alt="Analog Devices" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/xilinx.com" alt="Xilinx" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/micron.com" alt="Micron" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/infineon.com" alt="Infineon" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
      <div class="manufacturer-logo"><img src="https://logo.clearbit.com/microchip.com" alt="Microchip" style="height: 40px; max-width: 150px; object-fit: contain; background: white; border-radius: 4px; padding: 4px;"></div>
    </div>
  </section>
"@
$content = $content -replace '(?s)<!-- ========== Trusted Manufacturer Ecosystem ========== -->.*?</section>', $newCarousel

Set-Content index.html $content -Encoding UTF8
