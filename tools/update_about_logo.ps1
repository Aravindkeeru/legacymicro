$content = Get-Content about.html -Raw -Encoding UTF8

$aboutLogoTransition = @"
          <div style="text-align: center; padding: 2rem; position: relative; overflow: hidden; min-height: 250px; display: flex; flex-direction: column; align-items: center; justify-content: center; background: rgba(0,0,0,0.2); border-radius: var(--radius-lg); border: 1px solid rgba(255,255,255,0.05);">
            <!-- Premium Animated PCB Background (Aesthetic & Complimenting) -->
            <svg class="nav-pcb-bg" viewBox="0 0 360 100" preserveAspectRatio="xMidYMid slice" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 1; opacity: 0.7;">
                <!-- Background structure bus lines -->
                <g class="pcb-base">
                    <!-- Shifted down to safely clear the subtitle (Y=80) -->
                    <path d="M 0 88 L 120 88 L 135 73 L 260 73 L 275 88 L 360 88" />
                    <path d="M 0 93 L 115 93 L 135 78 L 255 78 L 270 93 L 360 93" />
                    <path d="M 0 98 L 110 98 L 135 83 L 250 83 L 265 98 L 360 98" />
                </g>
                <!-- Input Bus (Feeds into IC chip from the left) -->
                <path class="trace-line trace-gold draw-in" style="animation-delay: 0.1s" d="M -20 30 L 20 30 L 30 40 L 50 40" />
                <path class="data-packet packet-gold flow-1" style="animation-delay: 0.1s" d="M -20 30 L 20 30 L 30 40 L 50 40" />
                
                <path class="trace-line trace-blue draw-in" style="animation-delay: 0.3s" d="M -20 60 L 20 60 L 30 50 L 50 50" />
                <path class="data-packet packet-blue flow-2" style="animation-delay: 0.3s" d="M -20 60 L 20 60 L 30 50 L 50 50" />
      
                <!-- High-Speed Output Bus (6 lanes splitting from IC pins, including middle routes) -->
                <!-- Top Bus (2 Lanes) -->
                <path class="trace-line trace-gold draw-in" style="animation-delay: 0.2s" d="M 45 34 L 56 34 L 56 15 L 59 12 L 350 12" />
                <path class="data-packet packet-gold flow-1" style="animation-delay: 0.2s" d="M 45 34 L 56 34 L 56 15 L 59 12 L 350 12" />
                
                <path class="trace-line trace-blue draw-in" style="animation-delay: 0.4s" d="M 45 40 L 53 40 L 53 20 L 56 17 L 350 17" />
                <path class="data-packet packet-blue flow-2" style="animation-delay: 0.4s" d="M 45 40 L 53 40 L 53 20 L 56 17 L 350 17" />
                
                <!-- Middle Bus (2 Lanes straight through behind text) -->
                <path class="trace-line trace-gold draw-in" style="animation-delay: 0.6s" d="M 45 46 L 350 46" />
                <path class="data-packet packet-gold flow-1" style="animation-delay: 1.6s" d="M 45 46 L 350 46" />
      
                <path class="trace-line trace-blue draw-in" style="animation-delay: 1.3s" d="M 45 52 L 350 52" />
                <path class="data-packet packet-blue flow-2" style="animation-delay: 1.3s" d="M 45 52 L 350 52" />
                
                <!-- Bottom Bus (2 Lanes) -->
                <path class="trace-line trace-gold draw-in" style="animation-delay: 0.5s" d="M 45 58 L 53 58 L 53 75 L 56 78 L 350 78" />
                <path class="data-packet packet-gold flow-1" style="animation-delay: 0.5s" d="M 45 58 L 53 58 L 53 75 L 56 78 L 350 78" />
                
                <path class="trace-line trace-blue draw-in" style="animation-delay: 0.7s" d="M 45 64 L 56 64 L 56 80 L 59 83 L 350 83" />
                <path class="data-packet packet-blue flow-2" style="animation-delay: 1.7s" d="M 45 64 L 56 64 L 56 80 L 59 83 L 350 83" />
            </svg>
            
            <a href="index.html" class="nav-logo" style="display: flex; align-items: center; text-decoration: none; white-space: nowrap; position: relative; z-index: 10; transform: scale(1.5);">
              <img src="assets/lm-logo.svg" alt="Legacy Micro Logo" style="height: 38px; width: auto; margin-right: 6px; flex-shrink: 0;">
              <div class="logo-text-wrapper" style="position: relative; display: flex; flex-direction: column; justify-content: center; align-items: center; line-height: 1; padding-left: 16px;">
                <div class="logo-top-line" style="font-weight: 800; letter-spacing: 0.5px; font-size: 1.15rem; position: relative; height: 1.2em; width: 100%; display: flex; justify-content: center; align-items: center;">
                  
                  <!-- Primary State -->
                  <div class="logo-primary" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                    <span class="logo-core-wrapper">
                      
                      <span class="logo-legacy-container">
                        <span class="logo-legacy" style="letter-spacing: 1px;">LEGACY</span>
                      </span>
                      
                      <span class="logo-micro-container">
                        <span class="logo-mu-intro">&#956;</span>
                        <span class="logo-micro-text">MICRO</span>
                      </span>
      
                    </span>
                    <sup class="logo-reg">&reg;</sup>
                  </div>
                  
                  <!-- Hover State (Trµsted) -->
                  <div class="logo-hover" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; opacity: 0; transform: translateY(10px); transition: opacity 0.3s ease, transform 0.3s ease;">
                    <span class="logo-tr" style="color: var(--text-primary); letter-spacing: 1px; line-height: 1; display: flex; align-items: baseline;">Tr</span><span class="logo-trusted-mu" style="color: var(--accent); font-family: 'Times New Roman', Times, serif; font-size: 1.1em; line-height: 1; margin: 0 1px; display: flex; align-items: baseline; transform: translateY(1px);">&#956;</span><span class="logo-sted" style="color: var(--text-primary); line-height: 1; display: flex; align-items: baseline;">sted</span>
                  </div>
                  
                </div>
                <span class="logo-subtitle" style="font-size: 0.4rem; letter-spacing: 1.6px; color: var(--text-secondary); font-weight: 600; margin-top: 4px; text-align: center; width: 100%; position: relative; height: 1em; display: flex; justify-content: center; align-items: center; overflow: hidden;">
                  <span class="flip-words">
                    <span class="flip-word">ELECTRONIC COMPONENTS</span>
                    <span class="flip-word">ACTIVE COMPONENTS</span>
                    <span class="flip-word">PASSIVE COMPONENTS</span>
                    <span class="flip-word">OBSOLETE &amp; EOL</span>
                  </span>
                </span>
              </div>
            </a>
          </div>
"@

$content = $content -replace '(?s)<div style="text-align: center; padding: 2rem;">.*?</div>\s*</div>\s*</div>\s*</div>\s*</section>', "$aboutLogoTransition`n        </div>`n      </div>`n    </div>`n  </section>"

Set-Content about.html $content -Encoding UTF8
