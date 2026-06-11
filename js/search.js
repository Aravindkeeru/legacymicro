/* ==========================================================================
   Legacy Microtronix — Part Search Engine
   Funnel Mode: Directs all searches to Request Quote
   R&A Supply Solutions Pvt Ltd
   ========================================================================== */

(() => {
  'use strict';

  // ─── DOM Elements ─────────────────────────────────────────────────────────────
  const searchInput    = document.getElementById('searchInput');
  const searchBtn      = document.getElementById('searchBtn');
  const resultsDiv     = document.getElementById('searchResults');
  const emptyState     = document.getElementById('searchEmpty');
  const recentDiv      = document.getElementById('recentSearches');
  const recentTagsDiv  = document.getElementById('recentTags');
  const popularTags    = document.querySelectorAll('#popularTags .search-tag');

  // ─── Search History (localStorage) ────────────────────────────────────────────
  const HISTORY_KEY = 'lm_search_history';
  const MAX_HISTORY = 5;

  function getHistory() {
    try {
      return JSON.parse(localStorage.getItem(HISTORY_KEY)) || [];
    } catch {
      return [];
    }
  }

  function saveToHistory(query) {
    if (!query || !query.trim()) return;
    const q = query.trim().toUpperCase();
    let history = getHistory().filter(h => h !== q);
    history.unshift(q);
    if (history.length > MAX_HISTORY) history = history.slice(0, MAX_HISTORY);
    localStorage.setItem(HISTORY_KEY, JSON.stringify(history));
    renderRecentSearches();
  }

  function renderRecentSearches() {
    const history = getHistory();
    if (!history.length) {
      recentDiv.style.display = 'none';
      return;
    }
    recentDiv.style.display = 'block';
    recentTagsDiv.innerHTML = history.map(q =>
      `<button class="search-tag" data-query="${escapeHTML(q)}">${escapeHTML(q)}</button>`
    ).join('');

    // Attach click handlers
    recentTagsDiv.querySelectorAll('.search-tag').forEach(tag => {
      tag.addEventListener('click', () => {
        const query = tag.getAttribute('data-query');
        searchInput.value = query;
        executeSearch(query);
      });
    });
  }

  // ─── Utility Helpers ──────────────────────────────────────────────────────────
  function escapeHTML(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  function randomDelay() {
    // Simulated network delay: allow map animation to play (2000ms - 2500ms)
    return 2000 + Math.random() * 500;
  }

  // ─── Loading State ────────────────────────────────────────────────────────────
  function showLoading() {
    emptyState.style.display = 'none';
    resultsDiv.innerHTML = `
      <div class="search-map-container">
        <div class="map-wrapper">
          <svg class="map-svg" viewBox="0 0 1008 650" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill="currentColor" opacity="0.3" d="M141.4 141.8c-.8.8-1.5 2.1-1.5 3 0 1 .4 1.4 1.4 1.4.9 0 2.2-.6 3-1.4 1-1 1-2.2 0-3-.8-1-2.1-1-3 0zm4.5 4.5c-.8.8-1.5 2.1-1.5 3 0 1 .4 1.4 1.4 1.4.9 0 2.2-.6 3-1.4 1-1 1-2.2 0-3-.8-1-2.1-1-3 0zm4.5 4.5c-.8.8-1.5 2.1-1.5 3 0 1 .4 1.4 1.4 1.4.9 0 2.2-.6 3-1.4 1-1 1-2.2 0-3-.8-1-2.1-1-3 0z" />
            <path fill="currentColor" opacity="0.3" d="M220 180 c-10 -20 -30 -30 -50 -10 c-20 20 -10 50 10 60 c20 10 50 -20 40 -50 z" />
            <path fill="currentColor" opacity="0.3" d="M280 120 c-15 -10 -40 5 -30 30 c10 20 40 10 30 -30 z" />
            <path fill="currentColor" opacity="0.3" d="M350 250 c-20 -10 -50 10 -40 40 c10 20 50 0 40 -40 z" />
            <!-- North America -->
            <path fill="currentColor" d="M120 150 Q 150 100 250 100 T 350 150 T 300 250 T 200 300 T 100 250 Z" />
            <!-- South America -->
            <path fill="currentColor" d="M250 350 Q 300 350 350 450 T 300 550 T 250 450 Z" />
            <!-- Europe -->
            <path fill="currentColor" d="M450 150 Q 500 100 600 100 T 550 200 T 450 200 Z" />
            <!-- Africa -->
            <path fill="currentColor" d="M450 250 Q 550 200 600 300 T 550 450 T 450 400 Z" />
            <!-- Asia -->
            <path fill="currentColor" d="M600 100 Q 750 50 900 150 T 800 350 T 600 250 Z" />
            <!-- Australia -->
            <path fill="currentColor" d="M750 450 Q 800 400 900 450 T 850 550 T 750 500 Z" />
          </svg>
          <div class="map-node node-us"></div>
          <div class="map-node node-eu"></div>
          <div class="map-node node-in"></div>
          <div class="map-node node-cn"></div>
        </div>
        <div class="searching-text">
          <i data-lucide="radar"></i> Pinging global supplier network...
        </div>
      </div>
    `;
    lucide.createIcons();
  }

  // ─── Render Live API Results ────────────────────────────────────────────────────
  function renderLiveResults(query, results) {
    if (!results || results.length === 0) {
      // If API found nothing, fall back to the Manual RFQ Sourcing Card
      renderSourcingCard(query);
      return;
    }

    let rowsHtml = results.map(item => `
      <div class="result-details" style="padding: 10px 0; border-bottom: 1px solid var(--border-subtle);">
        <div class="result-detail-item">
          <div class="label">Part Number</div>
          <div class="value" style="color: var(--accent);">${escapeHTML(item.mpn)}</div>
          <div style="font-size: 0.75rem; color: var(--text-muted);">${escapeHTML(item.manufacturer)}</div>
        </div>
        <div class="result-detail-item">
          <div class="label">Stock</div>
          <div class="value">${escapeHTML(item.stock)}</div>
        </div>
        <div class="result-detail-item">
          <div class="label">Price</div>
          <div class="value">${escapeHTML(item.price)}</div>
        </div>
        <div class="result-detail-item" style="text-align: right;">
           <button class="btn btn-primary btn-sm" onclick="openQuoteModal('${escapeHTML(item.mpn)}')">
             Buy / RFQ
           </button>
        </div>
      </div>
    `).join('');

    resultsDiv.innerHTML = `
      <div class="result-card" style="animation: fadeInUp 0.4s ease forwards;">
        <div style="display:flex; justify-content:space-between; align-items:center; border-bottom: 1px solid var(--border); padding-bottom: 15px; margin-bottom: 15px;">
           <h3 style="margin:0;">Live Global Inventory</h3>
           <span class="status-badge status-available"><div class="status-dot"></div> Live Connection</span>
        </div>
        ${rowsHtml}
        <div style="text-align: center; margin-top: 20px;">
           <p style="font-size: 0.85rem; color: var(--text-secondary);">Don't see exactly what you need? Our team can source it from excess inventory.</p>
           <button class="btn btn-secondary btn-sm" style="margin-top: 10px;" onclick="openQuoteModal('${escapeHTML(query)}')">Request Manual Sourcing</button>
        </div>
      </div>
    `;
    emptyState.style.display = 'none';
  }

  // ─── Render Sourcing Funnel Results (Fallback) ────────────────────────────────
  function renderSourcingCard(query) {
    const q = escapeHTML(query);
    resultsDiv.innerHTML = `
      <div class="result-card" style="text-align:center; padding:var(--space-2xl); animation: fadeInUp 0.6s ease forwards;">
        <div style="display: inline-flex; justify-content: center; align-items: center; background: rgba(59, 130, 246, 0.1); width: 64px; height: 64px; border-radius: 50%; margin-bottom:var(--space-md);">
          <i data-lucide="globe" style="width: 32px; height: 32px; color: var(--accent-light);"></i>
        </div>
        <h3 style="margin-bottom:var(--space-sm);">Global Sourcing Initiated</h3>
        <p style="margin-bottom:var(--space-lg); max-width:500px; margin-left:auto; margin-right:auto; color: var(--text-secondary); line-height: 1.6;">
          We leverage our global network of verified suppliers to source <strong style="font-family:var(--font-mono); color:var(--text-primary);">${q}</strong> quickly. Request an instant quote, and our procurement team will get back to you with pricing and lead times within 24–48 hours.
        </p>
        <div class="result-actions" style="justify-content:center; gap: var(--space-md);">
          <button class="btn btn-primary" style="padding: 0.8rem 2rem; font-size: 1rem;" onclick="openQuoteModal('${q}')">
            <i data-lucide="file-text" style="width: 18px; height: 18px; margin-right: 8px;"></i> Request Official Quote
          </button>
        </div>
      </div>
    `;
    emptyState.style.display = 'none';
    if (window.lucide) window.lucide.createIcons();
  }

  // ─── Execute Search ───────────────────────────────────────────────────────────
  async function executeSearch(query) {
    const q = (query || '').trim();
    if (!q) return;

    searchInput.value = q;
    showLoading();
    saveToHistory(q);

    // Update URL without reload
    const url = new URL(window.location);
    url.searchParams.set('q', q);
    window.history.replaceState({}, '', url);

    scrollToResults();

    try {
      // Call our secure Cloudflare Backend Function
      const response = await fetch('/api/search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query: q })
      });

      if (!response.ok) {
        throw new Error('Backend API error or Key not configured');
      }

      const data = await response.json();
      
      // Artificial slight delay so the map animation looks cool
      setTimeout(() => {
        renderLiveResults(q, data.results);
      }, 1500);

    } catch (err) {
      console.warn("API Search Failed (Fallback to Manual Mode):", err);
      setTimeout(() => {
        renderSourcingCard(q); // Graceful fallback
      }, 1500);
    }
  }

  // ─── Clear Search ─────────────────────────────────────────────────────────────
  window.clearSearch = function() {
    searchInput.value = '';
    resultsDiv.innerHTML = '';
    emptyState.style.display = 'block';
    searchInput.focus();

    // Clean URL
    const url = new URL(window.location);
    url.searchParams.delete('q');
    window.history.replaceState({}, '', url);
  };

  // ─── Debounce ─────────────────────────────────────────────────────────────────
  let debounceTimer = null;

  function debounce(fn, delay = 300) {
    return (...args) => {
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(() => fn(...args), delay);
    };
  }

  // ─── Event Listeners ─────────────────────────────────────────────────────────

  // Search button click
  searchBtn.addEventListener('click', () => {
    executeSearch(searchInput.value);
    scrollToResults();
  });

  // Keyboard: Enter to search, Escape to clear
  searchInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      executeSearch(searchInput.value);
      searchInput.blur(); // Remove focus to prevent browser from snapping back up
      scrollToResults();
    }
    if (e.key === 'Escape') {
      e.preventDefault();
      window.clearSearch();
    }
  });

  // Live search with debounce (only trigger if input length >= 3)
  searchInput.addEventListener('input', debounce(() => {
    const q = searchInput.value.trim();
    if (q.length >= 3) {
      executeSearch(q);
    } else if (q.length === 0) {
      window.clearSearch();
    }
  }, 500)); // Increased debounce for funnel mode so it doesn't trigger wildly on every key

  function scrollToResults() {
    setTimeout(() => {
      const mapContainer = document.querySelector('.search-map-container') || document.querySelector('.search-results');
      if (mapContainer) {
        mapContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    }, 50);
  }

  // Popular search tags
  popularTags.forEach(tag => {
    tag.addEventListener('click', () => {
      const query = tag.getAttribute('data-query');
      searchInput.value = query;
      executeSearch(query);
      scrollToResults();
    });
  });

  // ─── URL Param Auto-search ────────────────────────────────────────────────────
  function checkURLParams() {
    const params = new URLSearchParams(window.location.search);
    const q = params.get('q');
    if (q && q.trim()) {
      searchInput.value = q.trim();
      executeSearch(q.trim());
      scrollToResults();
    }
  }

  // ─── Init ─────────────────────────────────────────────────────────────────────
  function init() {
    renderRecentSearches();
    checkURLParams();
    // Auto-focus search input (slight delay for page load animation)
    setTimeout(() => searchInput.focus(), 500);
  }

  // Run on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

})();
