$socialFiles = Get-ChildItem -Path "c:\Users\chair\Downloads\portfolio26\courtney" -Filter *.html -Recurse

# Define the search string exactly as it appears in the files (including indentation)
$searchString = '<a href="https://www.linkedin.com/in/deepanshu-bisht-b3b733230/" target="_blank"
                            class="social-icon">'

# Define the replacement string
$replaceString = '<a href="https://www.linkedin.com/in/deepanshu-bisht-b3b733230/" target="_blank"
                            class="social-icon" data-no-swup>'

foreach ($file in $socialFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    
    if ($content.Contains($searchString)) {
        Write-Host "Fixing LinkedIn in $($file.Name)"
        $content = $content.Replace($searchString, $replaceString)
        Set-Content -Path $file.FullName -Value $content
    }
}
