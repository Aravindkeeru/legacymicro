(function() {
  const searchInput = document.getElementById('searchInput');
  const searchBtn = document.getElementById('searchBtn');
  const resultsDiv = document.getElementById('searchResults');
  const emptyState = document.getElementById('searchEmpty');
  const popularTags = document.querySelectorAll('#popularTags .search-tag');

  // Configuration: List of Excel/CSV files to load
  const INVENTORY_FILES = [
    'EMS Fabienne.xls',
    'New XS_EU OEM_low prices.xlsx',
    'RA Componenets latest.xlsx',
    'STOCK_AGS200226.xlsx',
    'XS_03.26.26.xlsx'
  ];

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

  // Extract the latest Date Code (YY+) from a messy string
  function extractLatestDC(dcStr) {
    if (!dcStr) return '';
    const str = String(dcStr).trim();
    // Match 4-digit date codes between 1000 and 2999 (e.g. 1944, 2033, 2305)
    const regex = /\b(1[0-9]|2[0-9])([0-5][0-9])\b/g;
    let matches;
    let maxYear = -1;
    
    while ((matches = regex.exec(str)) !== null) {
      const yy = parseInt(matches[1], 10); // extracts the 19, 20, 23 part
      if (yy > maxYear) {
        maxYear = yy;
      }
    }
    
    if (maxYear !== -1) {
      return maxYear + '+';
    }
    
    // Fallback if no 4-digit date code found but string is short
    if (str.length < 15) return str;
    
    return 'Mixed';
  }

  // 1. Fetch and Parse Multiple Excel/CSV Files using SheetJS
  async function loadExcelInventory() {
    if (isInventoryLoaded) return;
    
    // Ensure SheetJS is loaded
    if (typeof XLSX === 'undefined') {
      console.warn("SheetJS not loaded, cannot parse Excel files.");
      return;
    }

    try {
      for (const fileName of INVENTORY_FILES) {
        try {
          const response = await fetch(fileName);
          if (!response.ok) {
            console.warn("Could not fetch " + fileName);
            continue;
          }
          
          const arrayBuffer = await response.arrayBuffer();
          const workbook = XLSX.read(arrayBuffer);
          const firstSheetName = workbook.SheetNames[0];
          const worksheet = workbook.Sheets[firstSheetName];
          const json = XLSX.utils.sheet_to_json(worksheet, { defval: "" });
          
          // Tag each item with its source file
          json.forEach(item => {
            item['SourceFile'] = fileName;
            inventoryData.push(item);
          });
          
        } catch (fileErr) {
          console.warn("Error parsing " + fileName, fileErr);
        }
      }
      isInventoryLoaded = true;
    } catch (e) {
      console.warn("Inventory Engine Warning:", e);
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

  function renderLocalResults(query, matches) {
    let html = `<h3 style="margin-bottom: var(--space-lg);">Available Inventory</h3>`;
    html += `<div style="display: flex; flex-direction: column; gap: var(--space-md);">`;
    
    matches.forEach(item => {
      const pn = escapeHTML(item['Part Number'] || item['PN'] || item['MPN'] || item['CF.CPU DC#'] || '');
      const mfg = escapeHTML(item['Manufacturer'] || item['Mfg'] || item['Brand'] || '');
      const desc = escapeHTML(item['Description'] || item['Desc'] || '');
      const rawDc = item['Date Code'] || item['D/C'] || item['DC'] || '';
      const dc = escapeHTML(extractLatestDC(rawDc));
      const qty = escapeHTML(item['Quantity'] || item['Qty'] || item['Stock On Hand'] || '');
      const cond = escapeHTML(item['Condition'] || item['Cond'] || '');
      const source = escapeHTML(item['SourceFile'] || 'Unknown Source');

      html += `
        <div class="card result-card" style="display: flex; flex-wrap: wrap; gap: var(--space-lg); align-items: center; padding: var(--space-xl); animation: fadeInUp 0.5s ease forwards; border-left: 4px solid var(--accent);">
          
          <div style="flex: 0 0 120px; text-align: center; background: rgba(255,255,255,0.03); padding: var(--space-md); border-radius: 8px; display: flex; justify-content: center; align-items: center;">
            <i data-lucide="cpu" style="width: 64px; height: 64px; color: var(--accent); opacity: 0.8;"></i>
          </div>

          <div style="flex: 1 1 300px;">
            <div style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 4px;">${mfg}</div>
            <h4 style="font-family: var(--font-mono); font-size: 1.5rem; margin: 0 0 var(--space-md) 0; color: white;">${pn}</h4>
            
            <div style="display: grid; grid-template-columns: 120px 1fr; gap: 8px; font-size: 0.9rem;">
              <div style="color: var(--text-secondary);">MFR #:</div>
              <div style="color: white; font-family: var(--font-mono);">${pn}</div>
              
              <div style="color: var(--text-secondary);">MFR:</div>
              <div style="color: white;">${mfg}</div>
              
              <div style="color: var(--text-secondary);">Description:</div>
              <div style="color: white;">${desc}</div>
              
              <div style="color: var(--text-secondary);">Date Code:</div>
              <div style="color: white;">${dc}</div>
            </div>
          </div>

          <div style="flex: 1 1 200px; padding-left: var(--space-md); border-left: 1px solid var(--border);">
            <div style="color: #4ade80; font-weight: bold; font-size: 1.25rem; margin-bottom: 8px;">
              <i data-lucide="check-circle" style="width: 18px; height: 18px; vertical-align: -2px;"></i> ${qty} In Stock
            </div>
            <div style="color: var(--text-secondary); font-size: 0.85rem; margin-bottom: var(--space-lg);">Available for immediate quote</div>
            <button class="btn btn-primary" style="width: 100%; font-weight: bold;" onclick="openQuoteModal('${escapeAttr(pn)}', '${escapeAttr(mfg)}')">
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

    // Ensure CSV is loaded
    await loadExcelInventory();

    setTimeout(() => {
      if (inventoryData.length > 0) {
        // Filter CSV
        const queryLower = q.toLowerCase();
        const matches = inventoryData.filter(item => {
          const pn = (item['Part Number'] || item['PN'] || item['MPN'] || item['CF.CPU DC#'] || item['Description'] || item['Desc'] || '').toLowerCase();
          const mfg = (item['Manufacturer'] || item['Mfg'] || item['Brand'] || '').toLowerCase();
          return pn.includes(queryLower) || mfg.includes(queryLower);
        });

        if (matches.length > 0) {
          renderLocalResults(q, matches);
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

  // Pre-load CSV in background on page init
  loadExcelInventory();

})();
