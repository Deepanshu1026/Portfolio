$socialFiles = Get-ChildItem -Path "c:\Users\chair\Downloads\portfolio26\courtney" -Filter *.html -Recurse
foreach ($file in $socialFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content

    # Regex to match the LinkedIn link that might be split across lines
    # It looks for the href, then any whitespace/attributes, then the class="social-icon", ensuring it doesn't already have data-no-swup
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, 
        '(<a href="https://www\.linkedin\.com/in/deepanshu-bisht-b3b733230/"[^>]*?)(class="social-icon")(?!.*data-no-swup)', 
        '$1$2 data-no-swup', 
        [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($content -ne $originalContent) {
        Write-Host "Updating LinkedIn in $($file.Name)"
        Set-Content -Path $file.FullName -Value $content
    }
}
