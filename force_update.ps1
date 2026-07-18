$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Fix copywriting in index.html by replacing specific target sentences precisely.
$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# 1. Hero Text
$content = $content -replace "Stop waiting 24\W+48 hours for part availability\.\s*Legacy Micro gives you instant access to global inventory \W+\s*search, quote, and source hard-to-find semiconductors in minutes, not days\.", "Strategic procurement for the global electronics supply chain. We specialize in sourcing hard-to-find, obsolete, and allocated semiconductors with zero compromise on authenticity."

# 2. Services Text
$content = $content -replace "<h3>Global Sourcing</h3>\s*<p>Source components from the USA, EU, Taiwan, and global markets. Our worldwide network of trusted suppliers ensures competitive pricing and reliable availability.</p>", "<h3>Tier-1 Global Sourcing</h3>`n          <p>Leverage our vetted international network to secure critical components at competitive market rates. We ensure unbroken supply continuity.</p>"

$content = $content -replace "<h3>Quality Assurance</h3>\s*<p>Rigorous inspection and anti-counterfeit verification for every component. Our multi-point quality checks guarantee authentic parts, every time.</p>", "<h3>Zero Counterfeit Tolerance</h3>`n          <p>Rigorous multi-point inspection and anti-counterfeit verification protocols. We guarantee 100% authentic, traceable components.</p>"

[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Fixed copy in index.html"

# Fix the broken logo-text-wrapper (delete it from all HTML files)
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $htmlContent = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # We want to remove the logo-text-wrapper entirely since we have the SVG.
    # The div starts with <div class="logo-text-wrapper" ...> and ends with </div> just before </a>
    # A regex to aggressively match and remove the logo-text-wrapper block.
    $pattern = '(?s)<div class="logo-text-wrapper"[^>]*>.*?</div>\s*</div>'
    $htmlContent = $htmlContent -replace $pattern, ''
    
    # There's another possible shape of it ending if I didn't match the inner divs correctly. 
    # Since it's right before </a>, let's just replace from <div class="logo-text-wrapper" up to </a> with </a>.
    $pattern2 = '(?s)<div class="logo-text-wrapper".*?</a>'
    $htmlContent = $htmlContent -replace $pattern2, "</a>"
    
    [System.IO.File]::WriteAllText($file.FullName, $htmlContent, [System.Text.Encoding]::UTF8)
    Write-Output "Removed broken typographic logo from $($file.Name)"
}

