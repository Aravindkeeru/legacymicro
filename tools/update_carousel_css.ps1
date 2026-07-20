$css = Get-Content css\style.css -Raw -Encoding UTF8

if ($css -notmatch "manufacturer-carousel") {
    $css += @"

/* ========== Manufacturer Carousel ========== */
.manufacturer-carousel {
  width: 100%;
  overflow: hidden;
  padding: 1.5rem 0;
  background: rgba(0, 0, 0, 0.2);
  border-top: 1px solid rgba(255,255,255,0.05);
  border-bottom: 1px solid rgba(255,255,255,0.05);
  position: relative;
  white-space: nowrap;
}

.manufacturer-carousel::before,
.manufacturer-carousel::after {
  content: '';
  position: absolute;
  top: 0;
  width: 100px;
  height: 100%;
  z-index: 2;
  pointer-events: none;
}
.manufacturer-carousel::before {
  left: 0;
  background: linear-gradient(to right, var(--bg-primary), transparent);
}
.manufacturer-carousel::after {
  right: 0;
  background: linear-gradient(to left, var(--bg-primary), transparent);
}

.manufacturer-track {
  display: inline-flex;
  gap: 3rem;
  align-items: center;
  animation: scroll-manufacturers 25s linear infinite;
}

.manufacturer-track:hover {
  animation-play-state: paused;
}

.manufacturer-logo {
  flex-shrink: 0;
}

.manufacturer-logo img {
  filter: grayscale(100%) brightness(0.8);
  transition: filter 0.3s ease, transform 0.3s ease;
  transform: translateZ(0);
}

.manufacturer-logo img:hover {
  filter: grayscale(0%) brightness(1);
  transform: scale(1.05);
}

@keyframes scroll-manufacturers {
  0% { transform: translateX(0); }
  100% { transform: translateX(calc(-50% - 1.5rem)); } /* -50% because we duplicated the items */
}
"@
    Set-Content css\style.css $css -Encoding UTF8
}
