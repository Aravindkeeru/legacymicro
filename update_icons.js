const fs = require('fs');
const path = require('path');

const replacements = {
  '🔍': '<i data-lucide="search"></i>',
  '🌐': '<i data-lucide="globe"></i>',
  '🌍': '<i data-lucide="globe"></i>',
  '✅': '<i data-lucide="check-circle"></i>',
  '🏭': '<i data-lucide="factory"></i>',
  '🚗': '<i data-lucide="car"></i>',
  '📡': '<i data-lucide="radio"></i>',
  '✈️': '<i data-lucide="plane"></i>',
  '🏥': '<i data-lucide="activity"></i>',
  '🔌': '<i data-lucide="plug"></i>',
  '💻': '<i data-lucide="monitor"></i>',
  '⚡': '<i data-lucide="zap"></i>',
  '🛡️': '<i data-lucide="shield"></i>',
  '🔄': '<i data-lucide="refresh-cw"></i>',
  '💰': '<i data-lucide="dollar-sign"></i>',
  '🤝': '<i data-lucide="users"></i>',
  '📦': '<i data-lucide="package"></i>',
  '📋': '<i data-lucide="clipboard-list"></i>',
  '📧': '<i data-lucide="mail"></i>',
  '📞': '<i data-lucide="phone"></i>',
  '📍': '<i data-lucide="map-pin"></i>',
  '💡': '<i data-lucide="lightbulb"></i>',
  '🕐': '<i data-lucide="clock"></i>',
  '◆ ': ''
};

const dir = 'C:\\Users\\admin\\.gemini\\antigravity\\scratch\\racomlink';

['index.html', 'about.html', 'services.html', 'contact.html', 'search.html'].forEach(file => {
  const filePath = path.join(dir, file);
  if (fs.existsSync(filePath)) {
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Replace emojis
    for (const [emoji, replacement] of Object.entries(replacements)) {
      content = content.split(emoji).join(replacement);
    }
    
    // Add lucide script before <script src="js/main.js">
    if (!content.includes('lucide@latest')) {
      content = content.replace('<script src="js/main.js"></script>', '<script src="https://unpkg.com/lucide@latest"></script>\n  <script>lucide.createIcons();</script>\n  <script src="js/main.js"></script>');
    }
    
    // Remove text-gradient and pulse-dot
    content = content.replace(/class="text-gradient"/g, '');
    content = content.replace(/<span class="pulse-dot"><\/span>/g, '');
    
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${file}`);
  }
});

// Update search.js to include lucide.createIcons() and remove emojis
const searchJsPath = path.join(dir, 'js', 'search.js');
if (fs.existsSync(searchJsPath)) {
  let searchJs = fs.readFileSync(searchJsPath, 'utf8');
  for (const [emoji, replacement] of Object.entries(replacements)) {
    searchJs = searchJs.split(emoji).join(replacement);
  }
  
  // insert lucide.createIcons(); after rendering results and empty states
  searchJs = searchJs.replace(/emptyState\.style\.display = 'none';/g, "emptyState.style.display = 'none';\n    if (window.lucide) window.lucide.createIcons();");
  
  fs.writeFileSync(searchJsPath, searchJs, 'utf8');
  console.log(`Updated search.js`);
}
