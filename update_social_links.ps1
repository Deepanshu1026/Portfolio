$socialFiles = Get-ChildItem -Path "c:\Users\chair\Downloads\portfolio26\courtney" -Filter *.html -Recurse
foreach ($file in $socialFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content

    # Github
    $content = $content -replace '(<a href=")#(" target="_blank" class="social-icon">\s*<i class="fab fa-github"></i>)', '$1https://github.com/Deepanshu1026$2'
    
    # Linkedin
    $content = $content -replace '(<a href=")#(" target="_blank" class="social-icon">\s*<i class="fab fa-linkedin-in"></i>)', '$1https://www.linkedin.com/in/deepanshu-bisht-b3b733230/$2'
    
    # Twitter
    $content = $content -replace '(<a href=")#(" target="_blank" class="social-icon">\s*<i class="fab fa-twitter"></i>)', '$1https://x.com/deepanshu_84137$2'
    
    # Instagram
    $content = $content -replace '(<a href=")#(" target="_blank" class="social-icon">\s*<i class="fab fa-instagram"></i>)', '$1https://www.instagram.com/bisht_here20/$2'

    if ($content -ne $originalContent) {
        Write-Host "Updating $($file.Name)"
        Set-Content -Path $file.FullName -Value $content
    }
}
