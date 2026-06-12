/**
 * Alternative Background B: Cyberpunk Moving Grid
 * Draws a futuristic perspective grid that scrolls forward.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    let offset = 0;
    
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
    }
    
    window.addEventListener('resize', resize);
    
    function draw() {
        ctx.fillStyle = '#09090b';
        ctx.fillRect(0, 0, width, height);
        
        ctx.strokeStyle = 'rgba(14, 165, 233, 0.15)'; // Cyan lines
        ctx.lineWidth = 1;
        
        const spacing = 40;
        offset = (offset + 0.5) % spacing;
        
        // Draw horizontal lines (moving)
        for (let y = offset; y < height; y += spacing) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(width, y);
            ctx.stroke();
        }
        
        // Draw vertical lines (static)
        for (let x = 0; x < width; x += spacing) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, height);
            ctx.stroke();
        }
        
        // Add a slight radial gradient overlay to fade edges
        const gradient = ctx.createRadialGradient(width/2, height/2, 0, width/2, height/2, width/1.5);
        gradient.addColorStop(0, 'rgba(9, 9, 11, 0)');
        gradient.addColorStop(1, 'rgba(9, 9, 11, 1)');
        
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, width, height);
    }
    
    function animate() {
        draw();
        requestAnimationFrame(animate);
    }
    
    resize();
    animate();
});
