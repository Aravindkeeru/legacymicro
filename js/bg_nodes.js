/**
 * Alternative Background A: High-Tech Node Constellation
 * Draws floating tech nodes that connect with laser lines when close to each other.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    let particles = [];
    
    // Configuration
    const PARTICLE_COUNT = 80;
    const CONNECT_DISTANCE = 150;
    
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
                vx: (Math.random() - 0.5) * 0.8,
                vy: (Math.random() - 0.5) * 0.8,
                radius: Math.random() * 2 + 1
            });
        }
    }
    
    window.addEventListener('resize', resize);
    
    function update() {
        particles.forEach(p => {
            p.x += p.vx;
            p.y += p.vy;
            
            // Bounce off edges
            if (p.x < 0 || p.x > width) p.vx *= -1;
            if (p.y < 0 || p.y > height) p.vy *= -1;
        });
    }
    
    function draw() {
        ctx.fillStyle = '#09090b';
        ctx.fillRect(0, 0, width, height);
        
        ctx.lineWidth = 1;
        
        // Draw connections
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                let dx = particles[i].x - particles[j].x;
                let dy = particles[i].y - particles[j].y;
                let dist = Math.sqrt(dx * dx + dy * dy);
                
                if (dist < CONNECT_DISTANCE) {
                    let opacity = 1 - (dist / CONNECT_DISTANCE);
                    ctx.strokeStyle = `rgba(59, 130, 246, ${opacity * 0.5})`; // Brand Blue
                    ctx.beginPath();
                    ctx.moveTo(particles[i].x, particles[i].y);
                    ctx.lineTo(particles[j].x, particles[j].y);
                    ctx.stroke();
                }
            }
        }
        
        // Draw nodes
        particles.forEach(p => {
            ctx.fillStyle = 'rgba(124, 58, 237, 0.8)'; // Purple dots
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
            ctx.fill();
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
