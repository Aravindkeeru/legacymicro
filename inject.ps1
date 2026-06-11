$files = Get-ChildItem -Path "C:\Users\admin\.gemini\antigravity\scratch\racomlink\*.html"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Inject canvas after body
    if ($content -notmatch '<canvas id="circuit-bg"></canvas>') {
        $content = $content -replace '<body>', "<body>`r`n  <canvas id=`"circuit-bg`"></canvas>"
    }
    
    # Inject script before closing body
    if ($content -notmatch '<script src="js/circuit.js"></script>') {
        $content = $content -replace '</body>', "  <script src=`"js/circuit.js`"></script>`r`n</body>"
    }
    
    Set-Content -Path $file.FullName -Value $content
}
Write-Output "Injected into $($files.Count) files."
