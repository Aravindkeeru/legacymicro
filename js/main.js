/* ==========================================================================
   Legacy Microtronix — Main JavaScript
   R&A Supply Solutions Pvt Ltd
   Clean ES6+ · No dependencies
   ========================================================================== */

(() => {
  'use strict';

  // ───────────────────────────────────────────────
  // DOM References
  // ───────────────────────────────────────────────
  const navbar    = document.getElementById('navbar');
  const navToggle = document.getElementById('navToggle');
  const mobileMenu = document.getElementById('mobileMenu');

  // ───────────────────────────────────────────────
  // 1. Scroll-Based Navigation
  // ───────────────────────────────────────────────
  const SCROLL_THRESHOLD = 50;
  let lastScrollY = 0;
  let ticking = false;

  const onScroll = () => {
    lastScrollY = window.scrollY;
    if (!ticking) {
      window.requestAnimationFrame(() => {
        if (navbar) {
          navbar.classList.toggle('scrolled', lastScrollY > SCROLL_THRESHOLD);
        }
        ticking = false;
      });
      ticking = true;
    }
  };

  window.addEventListener('scroll', onScroll, { passive: true });
  // Set initial state on load
  onScroll();

  // ───────────────────────────────────────────────
  // 2. Mobile Menu Toggle
  // ───────────────────────────────────────────────
  if (navToggle && mobileMenu) {
    navToggle.addEventListener('click', () => {
      navToggle.classList.toggle('active');
      mobileMenu.classList.toggle('active');
      // Prevent body scroll when menu is open
      document.body.style.overflow = mobileMenu.classList.contains('active') ? 'hidden' : '';
    });

    // Close menu when a link is clicked
    mobileMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        navToggle.classList.remove('active');
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
      });
    });

    // Close menu on Escape key
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && mobileMenu.classList.contains('active')) {
        navToggle.classList.remove('active');
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
      }
    });
  }

  // ───────────────────────────────────────────────
  // 3. Scroll Reveal (IntersectionObserver)
  // ───────────────────────────────────────────────
  const revealElements = document.querySelectorAll('.reveal');

  if (revealElements.length > 0 && 'IntersectionObserver' in window) {
    const revealObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            revealObserver.unobserve(entry.target); // Animate only once
          }
        });
      },
      {
        threshold: 0.1,
        rootMargin: '0px 0px -40px 0px'
      }
    );

    revealElements.forEach(el => revealObserver.observe(el));
  } else {
    // Fallback: show everything if no IntersectionObserver
    revealElements.forEach(el => el.classList.add('visible'));
  }

  // ───────────────────────────────────────────────
  // 4. Animated Counters
  // ───────────────────────────────────────────────
  const statNumbers = document.querySelectorAll('.stat-number');

  /**
   * Animate a number from 0 to its target value.
   * Handles suffixes like +, %, <, h and the "K" abbreviation.
   */
  const animateCounter = (el) => {
    // Determine target value
    const dataTarget = el.getAttribute('data-target');
    const rawText = el.textContent.trim();

    // Extract numeric portion and identify prefix/suffix
    let prefix = '';
    let suffix = '';
    let targetValue = 0;
    let useK = false;

    if (dataTarget) {
      targetValue = parseInt(dataTarget, 10);
    }

    // Parse display format from the original text
    if (rawText.startsWith('<')) {
      prefix = '<';
    }

    if (rawText.includes('K')) {
      useK = true;
      suffix = 'K';
    }
    if (rawText.includes('+')) {
      suffix += '+';
    }
    if (rawText.includes('%')) {
      suffix += '%';
    }
    if (rawText.includes('h') && !rawText.includes('K')) {
      suffix += 'h';
    }

    // If no data-target, try to extract number from text
    if (!dataTarget) {
      const numMatch = rawText.match(/[\d.]+/);
      if (numMatch) {
        targetValue = parseInt(numMatch[0], 10);
      }
    }

    // Display value (for "10K+" we animate 0→10, then display "10K+")
    const displayTarget = useK ? Math.round(targetValue / 1000) : targetValue;

    const duration = 2000; // 2 seconds
    const startTime = performance.now();

    const easeOutQuart = (t) => 1 - Math.pow(1 - t, 4);

    const step = (currentTime) => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / duration, 1);
      const easedProgress = easeOutQuart(progress);
      const currentValue = Math.round(easedProgress * displayTarget);

      // Build the display string with styled accent spans
      let display = prefix + currentValue + suffix;

      // Rebuild with accent styling
      let html = '';
      if (prefix) {
        html += `<span class="accent">${prefix}</span>`;
      }
      html += currentValue;
      if (suffix) {
        html += `<span class="accent">${suffix.replace(/[K]/g, '')}</span>`;
        if (useK) {
          html = '';
          if (prefix) html += `<span class="accent">${prefix}</span>`;
          html += currentValue + 'K';
          const remainingSuffix = suffix.replace('K', '');
          if (remainingSuffix) {
            html += `<span class="accent">${remainingSuffix}</span>`;
          }
        }
      }

      el.innerHTML = html;

      if (progress < 1) {
        requestAnimationFrame(step);
      }
    };

    requestAnimationFrame(step);
  };

  if (statNumbers.length > 0 && 'IntersectionObserver' in window) {
    const counterObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            animateCounter(entry.target);
            counterObserver.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.5 }
    );

    statNumbers.forEach(el => counterObserver.observe(el));
  }

  // ───────────────────────────────────────────────
  // 5. Smooth Scroll for Anchor Links
  // ───────────────────────────────────────────────
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', (e) => {
      const targetId = anchor.getAttribute('href');
      if (targetId === '#' || targetId === '') return;

      const targetElement = document.querySelector(targetId);
      if (targetElement) {
        e.preventDefault();
        const navHeight = navbar ? navbar.offsetHeight : 72;
        const targetPosition = targetElement.getBoundingClientRect().top + window.scrollY - navHeight;

        window.scrollTo({
          top: targetPosition,
          behavior: 'smooth'
        });

        // Close mobile menu if open
        if (mobileMenu && mobileMenu.classList.contains('active')) {
          navToggle.classList.remove('active');
          mobileMenu.classList.remove('active');
          document.body.style.overflow = '';
        }
      }
    });
  });

  // ───────────────────────────────────────────────
  // 6. Homepage Search Form Redirect
  // ───────────────────────────────────────────────
  const heroSearchForm = document.getElementById('heroSearchForm');

  if (heroSearchForm) {
    heroSearchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const input = heroSearchForm.querySelector('.search-input');
      const query = input ? input.value.trim() : '';

      if (query) {
        window.location.href = `search.html?q=${encodeURIComponent(query)}`;
      } else {
        // Focus the input if empty
        if (input) {
          input.focus();
          // Brief visual feedback
          const wrapper = heroSearchForm.querySelector('.search-wrapper');
          if (wrapper) {
            wrapper.style.borderColor = 'var(--danger)';
            wrapper.style.boxShadow = '0 0 0 3px rgba(239, 68, 68, 0.3)';
            setTimeout(() => {
              wrapper.style.borderColor = '';
              wrapper.style.boxShadow = '';
            }, 1500);
          }
        }
      }
    });

    // Also handle clicking the search hints
    heroSearchForm.closest('.hero-content')?.querySelectorAll('.search-hint kbd').forEach(kbd => {
      kbd.style.cursor = 'pointer';
      kbd.addEventListener('click', () => {
        const input = heroSearchForm.querySelector('.search-input');
        if (input) {
          input.value = kbd.textContent;
          input.focus();
        }
      });
    });
  }

  // ───────────────────────────────────────────────
  // 7. Active Nav Link Detection
  // ───────────────────────────────────────────────
  const setActiveNavLink = () => {
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop() || 'index.html';

    // Update desktop nav links
    const navLinks = document.querySelectorAll('.nav-links a');
    navLinks.forEach(link => {
      const linkPage = link.getAttribute('href');
      link.classList.remove('active');

      if (linkPage === currentPage) {
        link.classList.add('active');
      }
      // Handle root URL mapping to index.html
      if ((currentPage === '' || currentPage === '/') && linkPage === 'index.html') {
        link.classList.add('active');
      }
    });

    // Update mobile menu links
    const mobileLinks = document.querySelectorAll('.mobile-menu a:not(.btn)');
    mobileLinks.forEach(link => {
      const linkPage = link.getAttribute('href');
      link.classList.remove('active');

      if (linkPage === currentPage) {
        link.classList.add('active');
      }
      if ((currentPage === '' || currentPage === '/') && linkPage === 'index.html') {
        link.classList.add('active');
      }
    });
  };

  setActiveNavLink();

  // ───────────────────────────────────────────────
  // 8. Keyboard Accessibility Enhancements
  // ───────────────────────────────────────────────
  // Allow Enter/Space on interactive non-button elements
  document.querySelectorAll('.industry-badge, .card').forEach(el => {
    if (!el.getAttribute('tabindex')) {
      el.setAttribute('tabindex', '0');
    }
  });

  // ───────────────────────────────────────────────
  // 9. Prefers Reduced Motion
  // ───────────────────────────────────────────────
  const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');

  if (prefersReducedMotion.matches) {
    // Instantly reveal all elements without animation
    document.querySelectorAll('.reveal').forEach(el => {
      el.style.transition = 'none';
      el.classList.add('visible');
    });
  }

  // ───────────────────────────────────────────────
  // 10. Sound Toggle Logic
  // ───────────────────────────────────────────────
  const bgAudio = document.getElementById('bgAudio');
  const soundToggle = document.getElementById('soundToggle');
  
  if (bgAudio && soundToggle) {
    // Start at 0 volume for fade-in
    bgAudio.volume = 0;
    const targetVolume = 0.15; // Very subtle 15% max volume
    let fadeInterval;
    
          soundToggle.addEventListener('click', () => {
        if (bgAudio.paused) {
          bgAudio.play().then(() => {
            soundToggle.classList.add('playing');
            soundToggle.innerHTML = '<i data-lucide="volume-2"></i>';
            if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          }).catch(err => {
            console.error("Audio playback failed:", err);
            if (typeof window.showToast === 'function') {
              window.showToast("Playback blocked by device. Ensure volume is up and mute switch is off.");
            }
          });
        } else {
          bgAudio.pause();
          soundToggle.classList.remove('playing');
          soundToggle.innerHTML = '<i data-lucide="volume-x"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
        }
      });
    }
  };

  setupFormspree('quoteForm', 'quoteFormStatus');
  setupFormspree('contactForm', 'contactFormStatus');

})();

// Custom Toast Notification System
window.showToast = function(message) {
  let container = document.getElementById('toast-container');
  if (!container) {
    container = document.createElement('div');
    container.id = 'toast-container';
    document.body.appendChild(container);
  }

  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.innerHTML = '<i data-lucide="info"></i> <span>' + message + '</span>';
  
  container.appendChild(toast);
  if (window.lucide) window.lucide.createIcons();

  // Trigger animation
  requestAnimationFrame(() => {
    toast.classList.add('show');
  });

  // Remove after 4 seconds
  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 400); // Wait for transition
  }, 4000);
};

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
