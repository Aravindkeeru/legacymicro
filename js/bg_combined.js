/**
 * Ultra-Clean Cinematic Background
 * No animations, allowing the raw video to take full focus.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    // Completely clear the canvas and do nothing else
    const ctx = canvas.getContext('2d');
    ctx.clearRect(0, 0, canvas.width, canvas.height);
});
