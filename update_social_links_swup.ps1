$socialFiles = Get-ChildItem -Path "c:\Users\chair\Downloads\portfolio26\courtney" -Filter *.html -Recurse
foreach ($file in $socialFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content

    # Add data-no-swup to social icons to prevent swup interception, ensuring they work as external links
    $content = $content -replace '(<a href="https?://.*?" target="_blank" class="social-icon")', '$1 data-no-swup'

    if ($content -ne $originalContent) {
        Write-Host "Updating $($file.Name)"
        Set-Content -Path $file.FullName -Value $content
    }
}
