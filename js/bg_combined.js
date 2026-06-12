/**
 * Optical Inspection Scanner Background
 * Renders a slow-moving, high-tech laser scanline to compliment industrial PCB video backgrounds.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    
    // Scanner variables
    let scanY = 0;
    const scanSpeed = 1.5; // Pixels per frame
    
    // Crosshairs
    const crosshairs = [];
    
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
    }
    
    window.addEventListener('resize', resize);
    resize();
    
    function draw() {
        // Clear previous frame
        ctx.clearRect(0, 0, width, height);
        
        // 1. Draw the Scanning Laser Line
        scanY += scanSpeed;
        if (scanY > height + 100) {
            scanY = -50; // Reset above screen
            
            // Randomize crosshairs occasionally
            crosshairs.length = 0;
            for(let i=0; i<3; i++) {
                crosshairs.push({
                    x: Math.random() * width,
                    y: Math.random() * height,
                    size: Math.random() * 20 + 10,
                    opacity: Math.random() * 0.5 + 0.1
                });
            }
        }
        
        // The core bright line
        ctx.beginPath();
        ctx.moveTo(0, scanY);
        ctx.lineTo(width, scanY);
        ctx.strokeStyle = 'rgba(59, 130, 246, 0.8)'; // Brand Blue
        ctx.lineWidth = 2;
        ctx.shadowBlur = 15;
        ctx.shadowColor = 'rgba(59, 130, 246, 1)';
        ctx.stroke();
        
        // The soft glowing trail behind the line
        const trailGradient = ctx.createLinearGradient(0, scanY - 40, 0, scanY);
        trailGradient.addColorStop(0, 'rgba(59, 130, 246, 0)');
        trailGradient.addColorStop(1, 'rgba(59, 130, 246, 0.15)');
        
        ctx.fillStyle = trailGradient;
        ctx.fillRect(0, scanY - 40, width, 40);
        
        // Turn off shadow for standard drawing
        ctx.shadowBlur = 0;
        
        // 2. Draw subtle targeting crosshairs
        crosshairs.forEach(c => {
            ctx.beginPath();
            ctx.strokeStyle = `rgba(59, 130, 246, ${c.opacity})`;
            ctx.lineWidth = 1;
            
            // Horizontal line
            ctx.moveTo(c.x - c.size, c.y);
            ctx.lineTo(c.x + c.size, c.y);
            // Vertical line
            ctx.moveTo(c.x, c.y - c.size);
            ctx.lineTo(c.x, c.y + c.size);
            
            // Corner ticks
            const t = c.size / 2;
            ctx.strokeRect(c.x - t, c.y - t, t*2, t*2);
            
            ctx.stroke();
        });
        
        requestAnimationFrame(draw);
    }
    
    draw();
});
