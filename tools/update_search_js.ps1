$jsPath = "js\search.js"
$content = Get-Content $jsPath -Raw -Encoding UTF8

# 1. Add INVENTORY_FILES config
$content = $content -replace "let inventoryData = \[\];", @"
  // Configuration: List of Excel/CSV files to load
  const INVENTORY_FILES = [
    'inventory_usa.xlsx',
    'inventory_europe.xlsx'
  ];

  let inventoryData = [];
"@

# 2. Replace loadInventoryCSV with loadExcelInventory
$newLoadFunc = @"
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
            console.warn(`Could not fetch ` + fileName);
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
          console.warn(`Error parsing ` + fileName, fileErr);
        }
      }
      isInventoryLoaded = true;
    } catch (e) {
      console.warn("Inventory Engine Warning:", e);
    }
  }
"@

$content = $content -replace "(?s)// 1\. Fetch and Parse the CSV.*?\} catch \(e\) \{.*?\}\n  \}", $newLoadFunc

# 3. Rename renderCSVResults and add Source badge
$newRender = @"
  function renderLocalResults(query, matches) {
    let html = `<h3 style="margin-bottom: var(--space-lg);">Found ` + matches.length + ` Excess Inventory Result` + (matches.length > 1 ? 's' : '') + `</h3>`;
    html += `<div class="grid-2" style="gap: var(--space-md);">`;
    
    matches.forEach(item => {
      const pn = escapeHTML(item['Part Number'] || item['PN'] || '');
      const mfg = escapeHTML(item['Manufacturer'] || item['Mfg'] || '');
      const desc = escapeHTML(item['Description'] || item['Desc'] || '');
      const dc = escapeHTML(item['Date Code'] || item['D/C'] || '');
      const qty = escapeHTML(item['Quantity'] || item['Qty'] || '');
      const cond = escapeHTML(item['Condition'] || '');
      const source = escapeHTML(item['SourceFile'] || 'Unknown Source');

      html += `
        <div class="card result-card" style="animation: fadeInUp 0.5s ease forwards; border-left: 4px solid var(--accent); padding: var(--space-lg);">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-md);">
            <div>
              <div style="color: var(--accent); font-weight: 700; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px;">` + mfg + `</div>
              <h4 style="font-family: var(--font-mono); font-size: 1.25rem; margin: 0; color: white;">` + pn + `</h4>
              <div style="font-size: 0.75rem; color: var(--text-secondary); margin-top: 4px;"><i data-lucide="file-spreadsheet" style="width: 12px; height: 12px; vertical-align: -2px;"></i> Source: ` + source + `</div>
            </div>
            <div class="hero-badge" style="margin: 0; background: rgba(34, 197, 94, 0.1); border-color: rgba(34, 197, 94, 0.3); color: #4ade80;">
              <i data-lucide="check-circle" style="width: 14px; height: 14px;"></i> In Stock
            </div>
          </div>
          
          <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: var(--space-md); border-bottom: 1px solid var(--border); padding-bottom: var(--space-md);">
            ` + desc + `
          </p>
          
          <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-sm); margin-bottom: var(--space-lg); font-size: 0.9rem;">
            <div><strong style="color: white;">D/C:</strong> <span style="color: var(--text-secondary);">` + dc + `</span></div>
            <div><strong style="color: white;">Qty:</strong> <span style="color: var(--text-secondary);">` + qty + `</span></div>
            <div style="grid-column: 1 / -1;"><strong style="color: white;">Condition:</strong> <span style="color: var(--text-secondary);">` + cond + `</span></div>
          </div>
          
          <button class="btn btn-primary" style="width: 100%;" onclick="openQuoteModal('` + escapeAttr(pn) + `', '` + escapeAttr(mfg) + `')">
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
"@
$content = $content -replace "(?s)  function renderCSVResults\(query, matches\) \{.*?\n  \}", $newRender

# 4. Update References
$content = $content -replace "loadInventoryCSV", "loadExcelInventory"
$content = $content -replace "renderCSVResults", "renderLocalResults"
$content = $content -replace "item\['Part Number'\]", "(item['Part Number'] || item['PN'])"
$content = $content -replace "item\['Manufacturer'\]", "(item['Manufacturer'] || item['Mfg'])"

Set-Content $jsPath $content -Encoding UTF8
