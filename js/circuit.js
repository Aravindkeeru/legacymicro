/**
 * Legacy Microtronix - Next-Gen Aesthetic Background
 * Inspired by modern Silicon Valley tech sites (e.g. Wise, Stripe).
 * Renders a slow, subtle, professional ambient gradient mesh.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    
    // Gradient Orbs Configuration
    // Increased opacity and velocity so the effect is clearly visible and alive
    const orbs = [
        { color: 'rgba(59, 130, 246, 0.40)', x: 0, y: 0, vx: 0.8, vy: 0.5, radius: 0, baseRadius: 0.6 }, // Brand Blue
        { color: 'rgba(30, 64, 175, 0.35)', x: 0, y: 0, vx: -0.6, vy: 0.7, radius: 0, baseRadius: 0.5 }, // Deep Blue
        { color: 'rgba(124, 58, 237, 0.25)', x: 0, y: 0, vx: 0.5, vy: -0.6, radius: 0, baseRadius: 0.7 }, // Subtle Purple
        { color: 'rgba(14, 165, 233, 0.30)', x: 0, y: 0, vx: -0.7, vy: -0.4, radius: 0, baseRadius: 0.4 }  // Light Cyan
    ];
    
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
        
        // Initialize orb positions randomly within bounds on resize
        orbs.forEach(orb => {
            if (orb.radius === 0) {
                orb.x = Math.random() * width;
                orb.y = Math.random() * height;
            }
            orb.radius = Math.max(width, height) * orb.baseRadius;
        });
    }
    
    window.addEventListener('resize', resize);
    
    function update() {
        orbs.forEach(orb => {
            orb.x += orb.vx;
            orb.y += orb.vy;
            
            // Softly bounce off invisible boundaries slightly outside the screen
            const padding = orb.radius * 0.5;
            if (orb.x < -padding) orb.vx *= -1;
            if (orb.x > width + padding) orb.vx *= -1;
            if (orb.y < -padding) orb.vy *= -1;
            if (orb.y > height + padding) orb.vy *= -1;
        });
    }
    
    function draw() {
        // Clear canvas
        ctx.clearRect(0, 0, width, height);
        
        // Fill base dark background
        ctx.fillStyle = '#09090b';
        ctx.fillRect(0, 0, width, height);
        
        // We use global composite operation 'screen' or 'lighter' to blend the subtle colors
        ctx.globalCompositeOperation = 'screen';
        
        orbs.forEach(orb => {
            // Create a radial gradient for each orb to make it soft
            const gradient = ctx.createRadialGradient(
                orb.x, orb.y, 0,
                orb.x, orb.y, orb.radius
            );
            
            gradient.addColorStop(0, orb.color);
            gradient.addColorStop(1, 'rgba(0,0,0,0)'); // Fade to completely transparent
            
            ctx.fillStyle = gradient;
            ctx.beginPath();
            ctx.arc(orb.x, orb.y, orb.radius, 0, Math.PI * 2);
            ctx.fill();
        });
        
        // Reset composite operation
        ctx.globalCompositeOperation = 'source-over';
    }
    
    function animate() {
        update();
        draw();
        requestAnimationFrame(animate);
    }
    
    // Init
    resize();
    animate();
});
