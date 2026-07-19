$content = Get-Content js\main.js -Raw -Encoding UTF8

$parts = $content -split '// 10\. Sound Toggle Logic'
$prefix = $parts[0]

$suffix = $parts[1]
$suffixParts = $suffix -split '(?s)// 11\. Formspree Form Handling'
$afterToggle = "// 11. Formspree Form Handling" + $suffixParts[1]

$newToggleLogic = @"
// 10. Sound Toggle Logic
  // -----------------------------------------------
  const bgAudio = document.getElementById('bgAudio');
  const soundToggle = document.getElementById('soundToggle');
  
  if (bgAudio && soundToggle) {
    let fadeInterval = null;
    const fadeInStep = 0.005; // 1.0 / 0.005 = 200 steps. 200 * 50ms = 10000ms (10 seconds)
    const fadeOutStep = 0.05; // 1.0 / 0.05 = 20 steps. 20 * 50ms = 1000ms (1 second)
    const fadeSpeed = 50;
    const maxVolume = 1.0;
    
    // iOS Safari ignores assignments to HTMLMediaElement.volume and ALWAYS returns 1.0 when read.
    // If we use bgAudio.volume to track fade progress, the fade-out loop runs infinitely on iOS 
    // because it never reaches 0. We must track the current volume in our own variable.
    let currentVolume = maxVolume; 

    const clearFade = () => { if (fadeInterval) clearInterval(fadeInterval); };

    soundToggle.addEventListener('click', () => {
      clearFade();
      
      if (bgAudio.paused) {
        currentVolume = 0;
        bgAudio.volume = currentVolume; // Start at 0 for fade in
        soundToggle.classList.add('playing');
        soundToggle.innerHTML = '<i data-lucide="loader" style="animation: spin 1s linear infinite;"></i>';
        if (typeof window.lucide !== 'undefined') window.lucide.createIcons();

        bgAudio.play().then(() => {
          soundToggle.innerHTML = '<i data-lucide="volume-2"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          
          fadeInterval = setInterval(() => {
            if (currentVolume < maxVolume) {
              currentVolume = Math.min(maxVolume, currentVolume + fadeInStep);
              bgAudio.volume = currentVolume;
            } else {
              clearFade();
            }
          }, fadeSpeed);
        }).catch(err => {
          console.error("Audio playback failed:", err);
          soundToggle.classList.remove('playing');
          soundToggle.innerHTML = '<i data-lucide="volume-x"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          
          if (typeof window.showToast === 'function') {
            window.showToast("Playback blocked or loading failed. Ensure volume is up.");
          }
        });
      } else {
        // Start fading out
        soundToggle.classList.remove('playing');
        soundToggle.innerHTML = '<i data-lucide="volume-x"></i>';
        if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
        
        fadeInterval = setInterval(() => {
          if (currentVolume > 0) {
            currentVolume = Math.max(0, currentVolume - fadeOutStep);
            bgAudio.volume = currentVolume;
          } else {
            clearFade();
            bgAudio.pause();
          }
        }, fadeSpeed);
      }
    });
  }

  // -----------------------------------------------
  
"@

$finalContent = $prefix + $newToggleLogic + $afterToggle

Set-Content js\main.js $finalContent -Encoding UTF8
