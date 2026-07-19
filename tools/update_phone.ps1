$htmlFiles = Get-ChildItem -Filter *.html

foreach ($file in $htmlFiles) {
    if ($file.Name -match "test|internal-calc") { continue }
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace in Footer
    $content = $content -replace '\+91 90000 00000', '+91 90639 77251'
    
    # Replace in Schema
    $content = $content -replace '\+91-90000-00000', '+91-90639-77251'
    
    Set-Content $file.FullName $content -Encoding UTF8
}
