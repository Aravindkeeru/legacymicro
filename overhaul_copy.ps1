$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# 1. Update Hero Copy
$oldHero = @"
        Stop waiting 24–48 hours for part availability. Legacy Micro gives you instant access to global inventory — 
        search, quote, and source hard-to-find semiconductors in minutes, not days.
"@
$newHero = @"
        Strategic procurement for the global electronics supply chain. We specialize in sourcing hard-to-find, obsolete, and allocated semiconductors with zero compromise on authenticity.
"@
$content = $content.Replace($oldHero, $newHero)

# 2. Update Global Sourcing Service
$oldService1 = @"
          <h3>Global Sourcing</h3>
          <p>Source components from the USA, EU, Taiwan, and global markets. Our worldwide network of trusted suppliers ensures competitive pricing and reliable availability.</p>
"@
$newService1 = @"
          <h3>Tier-1 Global Sourcing</h3>
          <p>Leverage our vetted international network to secure critical components at competitive market rates. We ensure unbroken supply continuity.</p>
"@
$content = $content.Replace($oldService1, $newService1)

# 3. Update Quality Assurance Service
$oldService2 = @"
          <h3>Quality Assurance</h3>
          <p>Rigorous inspection and anti-counterfeit verification for every component. Our multi-point quality checks guarantee authentic parts, every time.</p>
"@
$newService2 = @"
          <h3>Zero Counterfeit Tolerance</h3>
          <p>Rigorous multi-point inspection and anti-counterfeit verification protocols. We guarantee 100% authentic, traceable components.</p>
"@
$content = $content.Replace($oldService2, $newService2)

# 4. Update "Simple Process" text
$oldProcess = @"
        <p>Three simple steps to get the components you need — fast, reliable, and quality-assured.</p>
"@
$newProcess = @"
        <p>Streamlined procurement designed for high-volume EMS and defense contractors.</p>
"@
$content = $content.Replace($oldProcess, $newProcess)

# 5. Update Call to Action
$oldCTA = @"
        <p>Our sourcing specialists can locate virtually any electronic component — including obsolete, end-of-life, and hard-to-find parts. Tell us what you need.</p>
"@
$newCTA = @"
        <p>Submit your BOM or target part numbers. Our procurement specialists will deploy our global network to secure your supply chain immediately.</p>
"@
$content = $content.Replace($oldCTA, $newCTA)

[System.IO.File]::WriteAllText($indexFile, $content, [System.Text.Encoding]::UTF8)
Write-Output "Overhauled copywriting in index.html"
