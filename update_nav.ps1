$source = "index.html"
$files = Get-ChildItem -Filter *.html

$content = Get-Content $source -Raw
# Regex to extract nav
if ($content -match '(?ms)(<div class="mil-navigation">\s*<nav id="swupMenu".*?<\/nav>\s*<\/div>)') {
    $template = $matches[1]
    # Clean active
    $cleanTemplate = $template -replace ' mil-active', ''
} else {
    Write-Host "Nav not found in index.html"
    exit
}

foreach ($file in $files) {
    if ($file.Name -eq "index.html") { continue }
    
    $fileContent = Get-Content $file.FullName -Raw
    
    # Custom active logic
    $currentNav = $cleanTemplate
    if ($file.Name -match "^home|^index") {
        $currentNav = $currentNav -replace '(?ms)(<li class="mil-has-children)(">(\s*)<a href="index.html">Home</a>)', '$1 mil-active$2'
    } elseif ($file.Name -match "^project|^portfolio") {
        $currentNav = $currentNav -replace '(?ms)(<li class="mil-has-children)(">(\s*)<a href="project-1.html">Projects</a>)', '$1 mil-active$2'
    } elseif ($file.Name -match "^blog|^publication") {
        $currentNav = $currentNav -replace '(?ms)(<li class="mil-has-children)(">(\s*)<a href="blog-1.html">Blog</a>)', '$1 mil-active$2'
    } elseif ($file.Name -eq "contact.html") {
        $currentNav = $currentNav -replace '(?ms)(<li>)(\s*<a href="contact.html">Contact</a>)', '<li class="mil-active">$2'
    }
    
    # Replace
    $pattern = '(?ms)(<div class="mil-navigation">\s*<nav id="swupMenu".*?<\/nav>\s*<\/div>)'
    
    # Check if pattern matches first
    if ($fileContent -match $pattern) {
        $newContent = [regex]::Replace($fileContent, $pattern, $currentNav)
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Updated $($file.Name)"
    } else {
        Write-Host "Skipped $($file.Name) (Nav not found)"
    }
}
