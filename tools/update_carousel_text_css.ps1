$css = Get-Content css\style.css -Raw -Encoding UTF8

$oldLogoCSS = @"
.manufacturer-logo img {
  filter: grayscale(100%) brightness(0.8);
  transition: filter 0.3s ease, transform 0.3s ease;
  transform: translateZ(0);
}

.manufacturer-logo img:hover {
  filter: grayscale(0%) brightness(1);
  transform: scale(1.05);
}
"@

$newLogoCSS = @"
.manufacturer-logo {
  flex-shrink: 0;
  font-family: var(--font-primary);
  font-size: 1.4rem;
  font-weight: 800;
  letter-spacing: 2px;
  color: rgba(255, 255, 255, 0.4);
  transition: color 0.3s ease, transform 0.3s ease, text-shadow 0.3s ease;
  transform: translateZ(0);
  cursor: default;
  padding: 0 1rem;
}

.manufacturer-logo:hover {
  color: rgba(255, 255, 255, 0.9);
  transform: scale(1.05);
  text-shadow: 0 0 15px rgba(255, 255, 255, 0.3);
}
"@

$css = $css -replace '(?s)\.manufacturer-logo img \{.*?\.manufacturer-logo img:hover \{.*?\}', $newLogoCSS

Set-Content css\style.css $css -Encoding UTF8
