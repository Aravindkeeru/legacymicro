import re

with open('js/main.js', 'r', encoding='utf-8') as f:
    content = f.read()

old_block = re.search(r'// 10\. Sound Toggle Logic.*?(?=setupFormspree)', content, re.DOTALL).group(0)

new_block = '''// 10. Sound Toggle Logic
  // -----------------------------------------------
  const bgAudio = document.getElementById('bgAudio');
  const soundToggle = document.getElementById('soundToggle');
  
  if (bgAudio && soundToggle) {
    let fadeInterval = null;
    const fadeStep = 0.05;
    const fadeSpeed = 50; // 50ms * 20 steps = 1000ms = 1s fade
    const maxVolume = 1.0;

    const clearFade = () => { if (fadeInterval) clearInterval(fadeInterval); };

    soundToggle.addEventListener('click', () => {
      clearFade();
      
      if (bgAudio.paused) {
        bgAudio.volume = 0; // Start at 0 for fade in
        soundToggle.classList.add('playing');
        soundToggle.innerHTML = '<i data-lucide=\"loader\" style=\"animation: spin 1s linear infinite;\"></i>';
        if (typeof window.lucide !== 'undefined') window.lucide.createIcons();

        bgAudio.play().then(() => {
          soundToggle.innerHTML = '<i data-lucide=\"volume-2\"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          
          fadeInterval = setInterval(() => {
            if (bgAudio.volume < maxVolume) {
              bgAudio.volume = Math.min(maxVolume, bgAudio.volume + fadeStep);
            } else {
              clearFade();
            }
          }, fadeSpeed);
        }).catch(err => {
          console.error(\"Audio playback failed:\", err);
          soundToggle.classList.remove('playing');
          soundToggle.innerHTML = '<i data-lucide=\"volume-x\"></i>';
          if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
          
          if (typeof window.showToast === 'function') {
            window.showToast(\"Playback blocked or loading failed. Ensure volume is up.\");
          }
        });
      } else {
        // Start fading out
        soundToggle.classList.remove('playing');
        soundToggle.innerHTML = '<i data-lucide=\"volume-x\"></i>';
        if (typeof window.lucide !== 'undefined') window.lucide.createIcons();
        
        fadeInterval = setInterval(() => {
          if (bgAudio.volume > 0) {
            bgAudio.volume = Math.max(0, bgAudio.volume - fadeStep);
          } else {
            clearFade();
            bgAudio.pause();
          }
        }, fadeSpeed);
      }
    });
  }

  '''

content = content.replace(old_block, new_block)

with open('js/main.js', 'w', encoding='utf-8') as f:
    f.write(content)

print('Success')
