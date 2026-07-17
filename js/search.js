(function() {
  const searchInput = document.getElementById('searchInput');
  const searchBtn = document.getElementById('searchBtn');
  const resultsDiv = document.getElementById('searchResults');
  const emptyState = document.getElementById('searchEmpty');
  const popularTags = document.querySelectorAll('#popularTags .search-tag');

  let inventoryData = [];
  let isInventoryLoaded = false;

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

  // 1. Fetch and Parse the CSV
  async function loadInventoryCSV() {
    if (isInventoryLoaded) return;
    try {
      const response = await fetch('inventory.csv');
      if (!response.ok) throw new Error('Could not fetch inventory.csv');
      
      const csvText = await response.text();
      const lines = csvText.split(/\r?\n/).filter(line => line.trim() !== '');
      
      if (lines.length > 1) {
        // Assume first line is header
        const headers = lines[0].split(',').map(h => h.trim());
        inventoryData = lines.slice(1).map(line => {
          const cols = line.split(',');
          let obj = {};
          headers.forEach((header, i) => {
            obj[header] = cols[i] ? cols[i].trim() : '';
          });
          return obj;
        });
        isInventoryLoaded = true;
      }
    } catch (e) {
      console.warn("CSV Engine Warning: No inventory.csv found, defaulting to Global Sourcing Fallback.", e);
    }
  }

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

  function renderCSVResults(query, matches) {
    let html = `<h3 style="margin-bottom: var(--space-lg);">Found ${matches.length} Excess Inventory Result${matches.length > 1 ? 's' : ''}</h3>`;
    html += `<div class="grid-2" style="gap: var(--space-md);">`;
    
    matches.forEach(item => {
      const pn = escapeHTML(item['Part Number'] || '');
      const mfg = escapeHTML(item['Manufacturer'] || '');
      const desc = escapeHTML(item['Description'] || '');
      const dc = escapeHTML(item['Date Code'] || '');
      const qty = escapeHTML(item['Quantity'] || '');
      const cond = escapeHTML(item['Condition'] || '');

      html += `
        <div class="card result-card" style="animation: fadeInUp 0.5s ease forwards; border-left: 4px solid var(--accent); padding: var(--space-lg);">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-md);">
            <div>
              <div style="color: var(--accent); font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px;">${mfg}</div>
              <h4 style="font-family: var(--font-mono); font-size: 1.25rem; margin: 0; color: white;">${pn}</h4>
            </div>
            <div class="hero-badge" style="margin: 0; background: rgba(34, 197, 94, 0.1); border-color: rgba(34, 197, 94, 0.3); color: #4ade80;">
              <i data-lucide="check-circle" style="width: 14px; height: 14px;"></i> In Stock
            </div>
          </div>
          
          <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: var(--space-md); border-bottom: 1px solid var(--border); padding-bottom: var(--space-md);">
            ${desc}
          </p>
          
          <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-sm); margin-bottom: var(--space-lg); font-size: 0.9rem;">
            <div><strong style="color: white;">D/C:</strong> <span style="color: var(--text-secondary);">${dc}</span></div>
            <div><strong style="color: white;">Qty:</strong> <span style="color: var(--text-secondary);">${qty}</span></div>
            <div style="grid-column: 1 / -1;"><strong style="color: white;">Condition:</strong> <span style="color: var(--text-secondary);">${cond}</span></div>
          </div>
          
          <button class="btn btn-primary" style="width: 100%;" onclick="openQuoteModal('${escapeAttr(pn)}', '${escapeAttr(mfg)}')">
            Request Price & Availability
          </button>
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

    // Ensure CSV is loaded
    await loadInventoryCSV();

    setTimeout(() => {
      if (inventoryData.length > 0) {
        // Filter CSV
        const queryLower = q.toLowerCase();
        const matches = inventoryData.filter(item => {
          const pn = (item['Part Number'] || '').toLowerCase();
          const mfg = (item['Manufacturer'] || '').toLowerCase();
          return pn.includes(queryLower) || mfg.includes(queryLower);
        });

        if (matches.length > 0) {
          renderCSVResults(q, matches);
        } else {
          renderSourcingCard(q);
        }
      } else {
        // No CSV found or empty, just show global sourcing fallback
        renderSourcingCard(q);
      }
    }, 600); // UI visual delay
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
    
    if (modal) modal.classList.add('active');
    
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

  // Pre-load CSV in background on page init
  loadInventoryCSV();

})();
