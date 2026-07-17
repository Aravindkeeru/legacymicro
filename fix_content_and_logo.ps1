$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# 1. Move the CSS from index.html to style.css
$indexFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\index.html"
$styleFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\css\style.css"

$indexContent = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Use Regex to extract the <style> block
$pattern = '(?s)<style>(.*?)</style>'
$match = [regex]::Match($indexContent, $pattern)

if ($match.Success) {
    $cssContent = $match.Groups[1].Value
    # Append to style.css
    Add-Content -Path $styleFile -Value $cssContent -Encoding UTF8
    
    # Remove from index.html
    $indexContent = $indexContent -replace [regex]::Escape($match.Value), ''
    [System.IO.File]::WriteAllText($indexFile, $indexContent, [System.Text.Encoding]::UTF8)
    Write-Output "Moved inline CSS to style.css"
}

# 2. Fix the "Instantly" text in index.html Hero
$indexContent = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)
$indexContent = $indexContent -replace 'Source Any Electronic<br>Component\. Instantly\.', 'Source Any Electronic<br>Component. Reliably.'
$indexContent = $indexContent -replace 'Source Any Electronic\s*Component\.\s*Instantly\.', "Source Any Electronic\n        Component.\n        Reliably."
[System.IO.File]::WriteAllText($indexFile, $indexContent, [System.Text.Encoding]::UTF8)

# 3. Find and Replace "China" across all files
$files = Get-ChildItem "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro" -Filter *.html -Recurse
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($content -match "(?i)China") {
        # Replace occurrences of China (e.g., in supplier lists, global network text)
        $content = $content -replace '(?i)China,\s*', ''
        $content = $content -replace '(?i)China', 'Taiwan'
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Replaced China in $($file.Name)"
    }
}

# 4. Remove "Instant" from Search page title and headers
$searchFile = "C:\Users\aravi\.gemini\antigravity\scratch\legacymicro\search.html"
$searchContent = [System.IO.File]::ReadAllText($searchFile, [System.Text.Encoding]::UTF8)
$searchContent = $searchContent -replace 'Instant Part Availability', 'Part Availability Search'
$searchContent = $searchContent -replace 'Instant Part <span>Availability</span>', 'Part <span>Availability</span>'
$searchContent = $searchContent -replace 'Instant Component Availability', 'Component Availability'
[System.IO.File]::WriteAllText($searchFile, $searchContent, [System.Text.Encoding]::UTF8)
Write-Output "Updated search.html titles"

