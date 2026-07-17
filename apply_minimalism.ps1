$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 1. Update JS for Scroll Reveal
$jsFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\js\main.js"
$jsAdd = @"

// Ultra-premium Scroll Reveal Animations
document.addEventListener('DOMContentLoaded', () => {
  const revealElements = document.querySelectorAll('.reveal');
  
  const revealObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('active');
        // Optional: stop observing once revealed
        observer.unobserve(entry.target);
      }
    });
  }, {
    root: null,
    threshold: 0.15,
    rootMargin: "0px 0px -50px 0px"
  });

  revealElements.forEach(el => revealObserver.observe(el));
});
"@
Add-Content -Path $jsFile -Value $jsAdd -Encoding UTF8
Write-Output "Added IntersectionObserver to main.js"

# 2. Update CSS for Animations and Minimalism
$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$cssAdd = @"

/* ========== Premium Minimalism Overhaul ========== */

/* Reveal Animations */
.reveal {
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1);
}
.reveal.active {
  opacity: 1;
  transform: translateY(0);
}
.reveal-delay-1 { transition-delay: 100ms; }
.reveal-delay-2 { transition-delay: 200ms; }
.reveal-delay-3 { transition-delay: 300ms; }
.reveal-delay-4 { transition-delay: 400ms; }

/* Enhanced Typography & Negative Space */
body {
  line-height: 1.7;
  letter-spacing: -0.01em;
}

h1, h2, h3 {
  letter-spacing: -0.04em;
}

/* Subtle Glow on Interactive Elements */
.card {
  transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.4s ease, border-color 0.4s ease !important;
}
.card:hover {
  transform: translateY(-4px) scale(1.01) !important;
  border-color: var(--border-hover) !important;
  box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.5), 0 0 20px rgba(59, 130, 246, 0.05) !important;
}

.btn-primary {
  transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.3s ease, background 0.3s ease !important;
}
.btn-primary:hover {
  transform: translateY(-2px) !important;
  box-shadow: 0 0 20px rgba(59, 130, 246, 0.3), 0 4px 14px rgba(0, 0, 0, 0.25) !important;
  background: var(--accent-hover) !important;
}

/* Clean up borders globally */
.category-card {
  border: 1px solid var(--border-subtle);
}

/* Shimmer Effect on Hero Title */
.hero-title span {
  position: relative;
  display: inline-block;
  background: linear-gradient(90deg, #ffffff 0%, var(--accent) 50%, #ffffff 100%);
  background-size: 200% auto;
  color: transparent;
  -webkit-background-clip: text;
  background-clip: text;
  animation: shimmer 4s linear infinite;
}

@keyframes shimmer {
  to { background-position: 200% center; }
}
"@
Add-Content -Path $cssFile -Value $cssAdd -Encoding UTF8
Write-Output "Added minimalist animations to style.css"

