const fs = require('fs');
const path = require('path');

const dir = 'C:\\Users\\aravi\\.gemini\\antigravity\\scratch\\legacymicro';
const files = ['index.html', 'about.html', 'services.html', 'contact.html', 'search.html', 'privacy.html'];

const newHtml = `
          <span style="font-weight: 800; letter-spacing: -0.5px; font-size: 1.2rem; display: flex; align-items: baseline;">
            <span class="logo-legacy-group">
              <span class="logo-legacy">LEGAC</span>
              <span class="logo-y">Y</span>
            </span>
            <span class="logo-micro-group">
              <span class="logo-m">M</span>
              <span class="logo-icro">ICRO</span>
              <span class="logo-mu">&mu;</span>
            </span>
          </span>
`;

for (const file of files) {
  const filePath = path.join(dir, file);
  let content = fs.readFileSync(filePath, 'utf8');

  // Fix the navigation logo
  // It starts with `<div style="display: flex; flex-direction: column; justify-content: center; line-height: 1;">`
  // and ends with `ELECTRONIC COMPONENTS</span>`
  
  const navRegex = /(<div style="display: flex; flex-direction: column; justify-content: center; line-height: 1;">)[\s\S]*?(<span style="font-size: 0.38em; letter-spacing: 1.5px; color: #888; font-weight: 600; margin-top: 3px;">ELECTRONIC COMPONENTS<\/span>)/g;
  
  content = content.replace(navRegex, `$1\n${newHtml}\n          $2`);

  // Fix the CSS to make the transition more visible and clean
  const cssRegex = /(?:\.nav-logo\s*\{)[\s\S]*?(?:@keyframes slideLegacyOut\s*\{[\s\S]*?\})/g;
  
  const newCss = `.nav-logo { transition: transform 0.3s ease; }
    .logo-legacy-group {
      display: inline-flex;
      align-items: baseline;
      opacity: 0;
      animation: slideLegacyOut 1.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }
    .logo-legacy { 
      color: #ffffff; 
      transition: color 0.3s ease; 
    }
    .logo-y { 
      background: linear-gradient(to right, #ffffff 45%, var(--accent) 55%); 
      -webkit-background-clip: text; 
      -webkit-text-fill-color: transparent; 
      position: relative; 
      z-index: 2;
      transition: all 0.3s ease;
    }
    .logo-micro-group {
      display: inline-flex;
      align-items: baseline;
      animation: microFade 1s ease-out 0.5s forwards;
      opacity: 0;
      position: relative;
    }
    .logo-m {
      color: var(--accent);
      /* Cut left part exactly to match Y slant */
      clip-path: polygon(30% 0, 100% 0, 100% 100%, 30% 100%);
      margin-left: -0.45em;
      position: relative;
      z-index: 1;
      transition: opacity 0.4s ease, transform 0.4s ease;
    }
    .logo-icro {
      color: var(--accent);
      margin-left: -0.05em;
      transition: opacity 0.4s ease, transform 0.4s ease;
    }
    .logo-mu {
      position: absolute;
      left: 0;
      color: var(--accent);
      opacity: 0;
      transform: translateY(10px) scale(0.8);
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
      pointer-events: none;
      font-family: 'Times New Roman', Times, serif;
      font-style: italic;
      font-weight: bold;
      font-size: 1.1em;
    }
    .nav-logo:hover .logo-m,
    .nav-logo:hover .logo-icro {
      opacity: 0;
      transform: translateY(-5px);
    }
    .nav-logo:hover .logo-mu {
      opacity: 1;
      transform: translateY(0) scale(1.1);
    }
    /* Legacy hovers */
    .nav-logo:hover .logo-legacy { color: #ffffff !important; }
    .nav-logo:hover .logo-y { 
      background: linear-gradient(to right, #ffffff 50%, var(--accent) 50%) !important; 
      -webkit-background-clip: text !important; 
      -webkit-text-fill-color: transparent !important; 
    }
    @keyframes microFade {
      0% { opacity: 0; transform: translateX(-10px); }
      100% { opacity: 1; transform: translateX(0); }
    }
    @keyframes slideLegacyOut {
      0% {
        opacity: 0;
        transform: translateX(20px);
        clip-path: inset(0 100% 0 0);
      }
      100% {
        opacity: 1;
        transform: translateX(0);
        clip-path: inset(0 -20px 0 0);
      }
    }`;
    
    // We replace only once per file since CSS is in the head
    content = content.replace(cssRegex, newCss);

  fs.writeFileSync(filePath, content, 'utf8');
  console.log(`Updated ${file}`);
}
