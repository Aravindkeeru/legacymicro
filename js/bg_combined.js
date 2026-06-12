/**
 * Background Option D: The Ultimate High-Tech Aesthetic
 * Combines a subtle scrolling Cyberpunk Grid with floating Neural Constellation Nodes.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    
    // Grid variables
    let gridOffset = 0;
    const GRID_SPACING = 50;
    
    // Node variables
    let particles = [];
    const PARTICLE_COUNT = 60;
    const CONNECT_DISTANCE = 160;
    
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
        initParticles();
    }
    
    function initParticles() {
        particles = [];
        for (let i = 0; i < PARTICLE_COUNT; i++) {
            particles.push({
                x: Math.random() * width,
                y: Math.random() * height,
                vx: (Math.random() - 0.5) * 0.6,
                vy: (Math.random() - 0.5) * 0.6,
                radius: Math.random() * 1.5 + 1
            });
        }
    }
    
    window.addEventListener('resize', resize);
    
    function update() {
        // Update Grid
        gridOffset = (gridOffset + 0.3) % GRID_SPACING;
        
        // Update Nodes
        particles.forEach(p => {
            p.x += p.vx;
            p.y += p.vy;
            
            // Soft bounce off edges
            if (p.x < 0 || p.x > width) p.vx *= -1;
            if (p.y < 0 || p.y > height) p.vy *= -1;
        });
    }
    
    function draw() {
        // Clear previous frame
        ctx.clearRect(0, 0, width, height);
        
        // ==========================================
        // 1. Draw Subtle Scrolling Grid (Background Layer)
        // ==========================================
        ctx.strokeStyle = 'rgba(14, 165, 233, 0.06)'; // Extremely subtle Cyan
        ctx.lineWidth = 1;
        
        // Horizontal moving lines
        for (let y = gridOffset; y < height; y += GRID_SPACING) {
            ctx.beginPath();
            ctx.moveTo(0, y);
            ctx.lineTo(width, y);
            ctx.stroke();
        }
        
        // Vertical static lines
        for (let x = 0; x < width; x += GRID_SPACING) {
            ctx.beginPath();
            ctx.moveTo(x, 0);
            ctx.lineTo(x, height);
            ctx.stroke();
        }
        
        // Fade the edges of the grid into darkness using radial gradient
        const bgGradient = ctx.createRadialGradient(width/2, height/2, 0, width/2, height/2, Math.max(width, height) / 1.5);
        bgGradient.addColorStop(0, 'rgba(9, 9, 11, 0)');
        bgGradient.addColorStop(1, 'rgba(9, 9, 11, 1)');
        
        ctx.fillStyle = bgGradient;
        ctx.fillRect(0, 0, width, height);

        // ==========================================
        // 2. Draw Floating Nodes (Foreground Layer)
        // ==========================================
        ctx.lineWidth = 1;
        
        // Draw Laser Connections
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                let dx = particles[i].x - particles[j].x;
                let dy = particles[i].y - particles[j].y;
                let dist = Math.sqrt(dx * dx + dy * dy);
                
                if (dist < CONNECT_DISTANCE) {
                    let opacity = 1 - (dist / CONNECT_DISTANCE);
                    // Beautiful fade between brand blue and purple depending on distance
                    ctx.strokeStyle = `rgba(59, 130, 246, ${opacity * 0.4})`; 
                    ctx.beginPath();
                    ctx.moveTo(particles[i].x, particles[i].y);
                    ctx.lineTo(particles[j].x, particles[j].y);
                    ctx.stroke();
                }
            }
        }
        
        // Draw the Node Dots
        particles.forEach(p => {
            // Give nodes a soft glowing orb effect
            ctx.shadowBlur = 10;
            ctx.shadowColor = 'rgba(124, 58, 237, 0.8)';
            ctx.fillStyle = 'rgba(124, 58, 237, 0.9)'; // Purple dots
            
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            ctx.fill();
            
            // Reset shadow so it doesn't bleed into grid lines on next frame
            ctx.shadowBlur = 0;
        });
    }
    
    function animate() {
        update();
        draw();
        requestAnimationFrame(animate);
    }
    
    resize();
    animate();
});
