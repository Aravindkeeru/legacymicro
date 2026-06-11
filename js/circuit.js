/**
 * PCB Circuit Background Animation
 * Draws realistic circuit board traces (zig-zags, 45-degree angles, variable thickness)
 * with glowing "electrons" traveling along them.
 */
document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('circuit-bg');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    let width, height;
    
    // Configuration
    const config = {
        gridSize: 30, // Base grid for snapping points
        traceCount: 35, // Number of distinct circuit traces
        traceColors: ['rgba(255, 255, 255, 0.04)', 'rgba(59, 130, 246, 0.05)', 'rgba(255, 255, 255, 0.02)'],
        electronColor: '#3b82f6',
        electronGlow: 10,
        baseSpeed: 1,
        scrollSpeedMultiplier: 8
    };
    
    // State
    let traces = [];
    let electrons = [];
    let scrollVelocity = 0;
    let lastScrollY = window.scrollY;
    
    // Resize handler
    function resize() {
        width = window.innerWidth;
        height = window.innerHeight;
        canvas.width = width;
        canvas.height = height;
        initTraces();
    }
    
    window.addEventListener('resize', resize);
    
    // Track scrolling for speed boost
    window.addEventListener('scroll', () => {
        const currentScrollY = window.scrollY;
        const delta = Math.abs(currentScrollY - lastScrollY);
        scrollVelocity = Math.min(delta * 0.15, 6);
        lastScrollY = currentScrollY;
    });
    
    // Decay scroll velocity
    setInterval(() => {
        scrollVelocity = Math.max(0, scrollVelocity - 0.25);
    }, 50);
    
    // Generate PCB traces
    function initTraces() {
        traces = [];
        electrons = [];
        
        const cols = Math.floor(width / config.gridSize);
        const rows = Math.floor(height / config.gridSize);
        
        for (let i = 0; i < config.traceCount; i++) {
            // Random start point snapped to grid
            let startCol = Math.floor(Math.random() * cols);
            let startRow = Math.floor(Math.random() * rows);
            
            let points = [{ x: startCol * config.gridSize, y: startRow * config.gridSize }];
            let segments = Math.floor(Math.random() * 5) + 3; // 3 to 7 segments
            
            let currentX = points[0].x;
            let currentY = points[0].y;
            let currentDir = Math.floor(Math.random() * 8); // 8 directions (including 45 deg)
            
            for (let s = 0; s < segments; s++) {
                // Determine segment length
                let length = (Math.floor(Math.random() * 4) + 2) * config.gridSize;
                
                // Directions: 0=E, 1=SE, 2=S, 3=SW, 4=W, 5=NW, 6=N, 7=NE
                let dx = 0, dy = 0;
                
                if (currentDir === 0) dx = length;
                else if (currentDir === 1) { dx = length; dy = length; }
                else if (currentDir === 2) dy = length;
                else if (currentDir === 3) { dx = -length; dy = length; }
                else if (currentDir === 4) dx = -length;
                else if (currentDir === 5) { dx = -length; dy = -length; }
                else if (currentDir === 6) dy = -length;
                else if (currentDir === 7) { dx = length; dy = -length; }
                
                currentX += dx;
                currentY += dy;
                points.push({ x: currentX, y: currentY });
                
                // Change direction by 45 or 90 degrees
                let turn = Math.random() < 0.5 ? 1 : 2; // 45 or 90 deg turn
                if (Math.random() < 0.5) turn = -turn;
                currentDir = (currentDir + turn + 8) % 8;
            }
            
            // Define trace properties
            let thickness = Math.random() < 0.7 ? 1 : (Math.random() < 0.8 ? 2 : 4);
            let color = config.traceColors[Math.floor(Math.random() * config.traceColors.length)];
            let hasViaStart = Math.random() < 0.5;
            let hasViaEnd = Math.random() < 0.8;
            
            traces.push({
                points,
                thickness,
                color,
                hasViaStart,
                hasViaEnd,
                totalLength: calculateTraceLength(points)
            });
            
            // Add 1 or 2 electrons to this trace
            let numElectrons = Math.random() < 0.3 ? 2 : 1;
            for(let e=0; e<numElectrons; e++) {
                electrons.push({
                    traceIndex: i,
                    progress: Math.random() * 100, // % along the trace
                    speed: (Math.random() * 0.4 + 0.2) * (Math.random() < 0.5 ? 1 : -1), // Random speed & direction
                    size: thickness === 4 ? 3 : 2
                });
            }
        }
    }
    
    function calculateTraceLength(points) {
        let length = 0;
        for (let i = 0; i < points.length - 1; i++) {
            let dx = points[i+1].x - points[i].x;
            let dy = points[i+1].y - points[i].y;
            length += Math.sqrt(dx*dx + dy*dy);
        }
        return length;
    }
    
    function getPointOnTrace(points, progressPercent) {
        if (points.length === 0) return { x: 0, y: 0 };
        if (points.length === 1) return points[0];
        
        let totalLength = calculateTraceLength(points);
        let targetLength = totalLength * (Math.max(0, Math.min(100, progressPercent)) / 100);
        
        let currentLength = 0;
        for (let i = 0; i < points.length - 1; i++) {
            let dx = points[i+1].x - points[i].x;
            let dy = points[i+1].y - points[i].y;
            let segLength = Math.sqrt(dx*dx + dy*dy);
            
            if (currentLength + segLength >= targetLength) {
                // The point is on this segment
                let remaining = targetLength - currentLength;
                let ratio = remaining / segLength;
                return {
                    x: points[i].x + dx * ratio,
                    y: points[i].y + dy * ratio
                };
            }
            currentLength += segLength;
        }
        return points[points.length - 1];
    }
    
    function update() {
        const speedBoost = 1 + scrollVelocity;
        
        for (let e of electrons) {
            e.progress += e.speed * speedBoost;
            
            // Bounce at ends
            if (e.progress >= 100) {
                e.progress = 100;
                e.speed *= -1;
            } else if (e.progress <= 0) {
                e.progress = 0;
                e.speed *= -1;
            }
        }
    }
    
    function draw() {
        ctx.clearRect(0, 0, width, height);
        
        // Draw PCB Traces
        ctx.lineCap = 'round';
        ctx.lineJoin = 'round';
        
        for (let trace of traces) {
            ctx.beginPath();
            ctx.strokeStyle = trace.color;
            ctx.lineWidth = trace.thickness;
            
            // Trace lines
            ctx.moveTo(trace.points[0].x, trace.points[0].y);
            for (let i = 1; i < trace.points.length; i++) {
                ctx.lineTo(trace.points[i].x, trace.points[i].y);
            }
            ctx.stroke();
            
            // Draw Vias (solder pads)
            ctx.fillStyle = trace.color;
            if (trace.hasViaStart) {
                ctx.beginPath();
                ctx.arc(trace.points[0].x, trace.points[0].y, trace.thickness + 2, 0, Math.PI * 2);
                ctx.fill();
                // Inner hole
                ctx.fillStyle = '#09090b';
                ctx.beginPath();
                ctx.arc(trace.points[0].x, trace.points[0].y, trace.thickness, 0, Math.PI * 2);
                ctx.fill();
            }
            if (trace.hasViaEnd) {
                ctx.fillStyle = trace.color;
                let lastPoint = trace.points[trace.points.length - 1];
                ctx.beginPath();
                ctx.arc(lastPoint.x, lastPoint.y, trace.thickness + 2, 0, Math.PI * 2);
                ctx.fill();
                // Inner hole
                ctx.fillStyle = '#09090b';
                ctx.beginPath();
                ctx.arc(lastPoint.x, lastPoint.y, trace.thickness, 0, Math.PI * 2);
                ctx.fill();
            }
        }
        
        // Draw Electrons
        ctx.fillStyle = config.electronColor;
        ctx.shadowBlur = config.electronGlow;
        ctx.shadowColor = config.electronColor;
        
        for (let e of electrons) {
            let trace = traces[e.traceIndex];
            let pos = getPointOnTrace(trace.points, e.progress);
            
            ctx.beginPath();
            ctx.arc(pos.x, pos.y, e.size, 0, Math.PI * 2);
            ctx.fill();
        }
        
        // Reset shadow
        ctx.shadowBlur = 0;
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
