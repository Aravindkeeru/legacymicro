(function() {
  const searchInput = document.getElementById('searchInput');
  const searchBtn = document.getElementById('searchBtn');
  const resultsDiv = document.getElementById('searchResults');
  const emptyState = document.getElementById('searchEmpty');
  const popularTags = document.querySelectorAll('#popularTags .search-tag');

  // Escape HTML utility
  function escapeHTML(str) {
    return String(str).replace(/[&<>'"]/g, 
      tag => ({
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        "'": '&#39;',
        '"': '&quot;'
      }[tag])
    );
  }
  
  window.escapeAttr = function(str) {
    return String(str).replace(/"/g, '&quot;');
  };

  function showLoading() {
    if (resultsDiv) {
      resultsDiv.innerHTML = `
        <div class="loading-state" style="text-align:center; padding:var(--space-2xl);">
          <i data-lucide="loader-2" class="spin" style="width: 48px; height: 48px; color: var(--accent); opacity: 0.8;"></i>
          <p style="margin-top:var(--space-md); color: var(--text-secondary);">Querying global inventory...</p>
        </div>
      `;
      if (window.lucide) window.lucide.createIcons();
    }
    if (emptyState) emptyState.style.display = 'none';
  }

  function renderSourcingCard(query) {
    const q = escapeHTML(query);
    if (resultsDiv) {
      resultsDiv.innerHTML = `
      <div class="result-card card" style="text-align:center; padding:var(--space-2xl); animation: fadeInUp 0.6s ease forwards;">
        <div style="display: inline-flex; justify-content: center; align-items: center; background: rgba(59, 130, 246, 0.1); width: 64px; height: 64px; border-radius: 50%; margin-bottom:var(--space-md);">
          <i data-lucide="globe" style="width: 32px; height: 32px; color: var(--accent-light);"></i>
        </div>
        <h3 style="margin-bottom:var(--space-sm);">Part Not in Excess Stock</h3>
        <p style="margin-bottom:var(--space-lg); max-width:500px; margin-left:auto; margin-right:auto; color: var(--text-secondary); line-height: 1.6;">
          We leverage our global network of verified suppliers to source <strong style="font-family:var(--font-mono); color:white;">${q}</strong>. Request an instant quote, and our procurement team will get back to you with pricing and lead times within 24 hours.
        </p>
        <div class="result-actions" style="justify-content:center; gap: var(--space-md);">
          <button class="btn btn-primary" style="padding: 0.8rem 2rem; font-size: 1rem;" onclick="openQuoteModal('${escapeAttr(query)}')">
            <i data-lucide="file-text" style="width: 18px; height: 18px; margin-right: 8px;"></i> Request Official Quote
          </button>
        </div>
      </div>
      `;
    }
    if (emptyState) emptyState.style.display = 'none';
    if (window.lucide) window.lucide.createIcons();
  }

  function renderLocalResults(query, matches, isFallback = false) {
    const badgeText = isFallback ? 'EXTERNAL MARKET REFERENCE' : 'LEGACY NETWORK RESULT';
    let html = `<div class="search-results-meta">
      <h3 class="results-heading">Available Inventory</h3>
      <span class="results-badge">${badgeText}</span>
    </div>`;
    html += `<div class="search-results-list">`;
    
    matches.forEach(item => {
      const pn = escapeHTML(item.mpn || '');
      const mfg = escapeHTML(item.manufacturer || '');
      let desc = escapeHTML(item.description || '');
      if (desc.length > 120) desc = desc.substring(0, 117) + '...';
      const dc = escapeHTML(item.date_code || '');
      const qty = escapeHTML(item.public_quantity || '');
      const cond = escapeHTML(item.condition || '');
      const multipleSources = item.multiple_sources;

      let metricsHtml = '';
      if (qty) {
        metricsHtml += `<div class="src-metric"><span class="src-metric-label">QUANTITY</span><span class="src-metric-value">${qty}</span></div>`;
      }
      if (dc) {
        metricsHtml += `<div class="src-metric"><span class="src-metric-label">DATE CODE</span><span class="src-metric-value">${dc}</span></div>`;
      }
      if (cond) {
        metricsHtml += `<div class="src-metric"><span class="src-metric-label">CONDITION</span><span class="src-metric-value">${cond}</span></div>`;
      }

      html += `
        <div class="card src-card">
          <div class="src-header">
            <div class="src-title-group">
              <h4 class="src-mpn">${pn}</h4>
              ${mfg ? `<div class="src-mfg">${mfg}</div>` : ''}
            </div>
            <div class="src-status"><i data-lucide="check-circle" class="src-status-icon"></i> AVAILABLE</div>
          </div>
          
          ${desc ? `<div class="src-desc">${desc}</div>` : ''}
          
          ${metricsHtml ? `<div class="src-metrics">${metricsHtml}</div>` : ''}

          <div class="src-footer">
            <div class="src-multiple-sources">
              ${multipleSources ? 'Multiple sources available' : ''}
            </div>
            <button class="btn btn-primary src-quote-btn" onclick="openQuoteModal('${escapeAttr(pn)}', '${escapeAttr(mfg)}')">
              Request Quote
            </button>
          </div>
        </div>
      `;
    });
    
    html += `</div>`;
    
    if (resultsDiv) {
      resultsDiv.innerHTML = html;
    }
    if (emptyState) emptyState.style.display = 'none';
    if (window.lucide) window.lucide.createIcons();
  }

  async function executeSearch(query) {
    const q = (query || '').trim();
    if (!q) return;

    if (searchInput) searchInput.value = q;
    showLoading();

    try {
      const response = await fetch('/api/search_v2', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query: q })
      });
      
      if (!response.ok) {
        throw new Error('Search API returned ' + response.status);
      }
      
      const data = await response.json();
      
      if (data.results && data.results.length > 0) {
        const isFallback = data.meta && data.meta.external_fallback_used === true;
        renderLocalResults(q, data.results, isFallback);
      } else {
        renderSourcingCard(q);
      }
    } catch (e) {
      console.warn("Search fetch failed:", e);
      renderSourcingCard(q);
    }
  }

  window.clearSearch = function() {
    if (searchInput) searchInput.value = '';
    if (resultsDiv) resultsDiv.innerHTML = '';
    if (emptyState) emptyState.style.display = 'block';
    if (searchInput) searchInput.focus();
  };

  let debounceTimer = null;
  function debounce(fn, delay = 300) {
    return (...args) => {
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(() => fn(...args), delay);
    };
  }

  if (searchInput && searchBtn) {
    searchBtn.addEventListener('click', () => {
      executeSearch(searchInput.value);
    });

    searchInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        e.preventDefault();
        executeSearch(searchInput.value);
        searchInput.blur();
      }
      if (e.key === 'Escape') {
        e.preventDefault();
        window.clearSearch();
      }
    });

    searchInput.addEventListener('input', debounce(() => {
      const q = searchInput.value.trim();
      if (q.length >= 3) {
        executeSearch(q);
      } else if (q.length === 0) {
        window.clearSearch();
      }
    }, 400));
  }

  popularTags.forEach(tag => {
    tag.addEventListener('click', () => {
      const query = tag.getAttribute('data-query');
      executeSearch(query);
    });
  });
  
  // Hook up modified modal open function
  window.openQuoteModal = function(partNumber = '', mfg = '') {
    const modal = document.getElementById('quoteModal');
    const inputPart = document.getElementById('modalPart');
    const inputMessage = document.getElementById('modalMessage');
    
    if (modal) {
      modal.classList.add('active');
      // Ensure close button renders correctly in case it was missed
      if (window.lucide) window.lucide.createIcons();
    }
    
    if (inputPart) {
      inputPart.value = partNumber;
      // Also pre-fill manufacturer into message if known
      if (mfg && inputMessage) {
        if (!inputMessage.value.includes(mfg)) {
          inputMessage.value = `Manufacturer: ${mfg}\n` + inputMessage.value;
        }
      }
    }
  };

  window.closeQuoteModal = function() {
    const modal = document.getElementById('quoteModal');
    if (modal) modal.classList.remove('active');
  };

  // Close modal when clicking outside of it
  document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('quoteModal');
    if (modal) {
      modal.addEventListener('click', (e) => {
        if (e.target === modal) {
          window.closeQuoteModal();
        }
      });
    }
  });

  const urlParams = new URLSearchParams(window.location.search);
  const queryParam = urlParams.get('q');
  
  if (queryParam) {
    if (searchInput) searchInput.value = queryParam;
    executeSearch(queryParam);
  }

})();
