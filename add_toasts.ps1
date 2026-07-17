$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$cssFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"
$jsFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\js\main.js"

$toastCSS = @"

/* ========== Custom Toast Notifications ========== */
#toast-container {
  position: fixed;
  bottom: 24px;
  right: 24px;
  z-index: 9999;
  display: flex;
  flex-direction: column;
  gap: 12px;
  pointer-events: none;
}

.toast {
  background: var(--bg-card);
  color: var(--text-primary);
  padding: 16px 20px;
  border-radius: var(--radius-md);
  border: 1px solid var(--border);
  box-shadow: 0 10px 25px rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 0.95rem;
  font-weight: 500;
  transform: translateX(120%);
  opacity: 0;
  transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), opacity 0.4s ease;
  pointer-events: auto;
}

.toast.show {
  transform: translateX(0);
  opacity: 1;
}

.toast i {
  color: var(--accent);
}
"@

$toastJS = @"

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
  toast.innerHTML = `<i data-lucide="info"></i> <span>` + message + `</span>`;
  
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
"@

Add-Content -Path $cssFile -Value $toastCSS -Encoding UTF8
Add-Content -Path $jsFile -Value $toastJS -Encoding UTF8

Write-Output "Added Toast CSS and JS"
