const fs = require('fs');
const path = require('path');

const dir = 'C:\\Users\\admin\\.gemini\\antigravity\\scratch\\racomlink';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

const logoReplacement = `<img src="assets/lm-logo.svg" alt="LM" style="height: 28px; width: auto; margin-right: 12px; border-radius: 4px;">`;

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');

  // Replace text logo with SVG image
  content = content.replace(/<span class="logo-icon">LM<\/span>/g, logoReplacement);

  // If index.html, remove the temp preview block
  if (file === 'index.html') {
    const startStr = '<!-- TEMP LOGO PREVIEW OVERLAY -->';
    const endStr = '  <canvas id="circuit-bg"></canvas>';
    const startIndex = content.indexOf(startStr);
    const endIndex = content.indexOf(endStr);
    
    if (startIndex !== -1 && endIndex !== -1) {
      content = content.substring(0, startIndex) + content.substring(endIndex);
    }
  }

  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`Updated ${file}`);
}
