$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -match "test|internal-calc") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Update Footer Manufacturers
    $content = $content -replace 'NXP', 'Xilinx'
    $content = $content -replace 'STMicroelectronics', 'Micron'
    
    # 2. Fix about.html scaling issue
    if ($file.Name -eq "about.html") {
        $content = $content -replace 'transform: scale\(1\.5\);?', ''
    }
    
    Set-Content $file.FullName $content -Encoding UTF8
}
