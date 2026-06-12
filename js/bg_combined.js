/**
 * Cinematic Floating Dust Background
 * Renders slow, out-of-focus dust particles to compliment a realistic background video.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    let particles = [];
    const particleCount = 150; // Amount of dust particles
    
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
    }
    
    window.addEventListener('resize', resize);
    resize();
    
    class DustParticle {
        constructor() {
            this.reset();
            // Start particles at random heights initially
            this.y = Math.random() * height;
        }
        
        reset() {
            this.x = Math.random() * width;
            this.y = height + Math.random() * 100; // Start slightly below screen
            this.size = Math.random() * 3 + 0.5; // Size between 0.5 and 3.5
            
            // Speed: Very slow drift upwards
            this.speedY = -(Math.random() * 0.3 + 0.1);
            this.speedX = (Math.random() - 0.5) * 0.2;
            
            // Opacity: Varying levels of subtlety
            this.baseOpacity = Math.random() * 0.4 + 0.1; 
            this.pulseSpeed = Math.random() * 0.02 + 0.005;
            this.pulseTime = Math.random() * Math.PI * 2;
        }
        
        update() {
            this.x += this.speedX;
            this.y += this.speedY;
            
            // Gentle swaying motion
            this.x += Math.sin(this.pulseTime) * 0.2;
            
            // Pulse opacity slightly
            this.pulseTime += this.pulseSpeed;
            this.currentOpacity = this.baseOpacity + Math.sin(this.pulseTime) * 0.1;
            if (this.currentOpacity < 0) this.currentOpacity = 0;
            
            // Reset if it floats off the top
            if (this.y < -10) {
                this.reset();
            }
        }
        
        draw() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(255, 255, 255, ${this.currentOpacity})`;
            ctx.fill();
            
            // Add a slight "glow" effect for larger particles to simulate bokeh
            if (this.size > 2) {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.size * 2, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(255, 255, 255, ${this.currentOpacity * 0.2})`;
                ctx.fill();
            }
        }
    }
    
    function init() {
        particles = [];
        for (let i = 0; i < particleCount; i++) {
            particles.push(new DustParticle());
        }
    }
    
    function draw() {
        // Clear previous frame (keeping it completely transparent to show video underneath)
        ctx.clearRect(0, 0, width, height);
        
        particles.forEach(p => {
            p.update();
            p.draw();
        });
        
        requestAnimationFrame(draw);
    }
    
    init();
    draw();
});
