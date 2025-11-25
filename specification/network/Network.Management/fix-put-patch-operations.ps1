# Fix PUT and PATCH operations to use CloudError instead of ErrorResponse
$files = Get-ChildItem -Path . -Filter "*.tsp" -Recurse

$modifiedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    $modified = $false
    
    $lines = $content -split "`n"
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        # Match PUT/PATCH operation patterns
        if ($line -match '^\s+\w+\s+is\s+(ArmCustomPatchAsync|ArmCustomPatchSync)') {
            # Check if this line or next few lines have the closing >;
            $foundClosing = $false
            $closingLineIndex = -1
            
            # Look ahead up to 15 lines for closing >;
            for ($j = $i; $j -lt [Math]::Min($i + 15, $lines.Count); $j++) {
                if ($lines[$j] -match '>\s*;') {
                    $foundClosing = $true
                    $closingLineIndex = $j
                    break
                }
            }
            
            if ($foundClosing) {
                # Check if Error parameter already exists
                $hasError = $false
                for ($j = $i; $j -le $closingLineIndex; $j++) {
                    if ($lines[$j] -match 'Error\s*=\s*CloudError') {
                        $hasError = $true
                        break
                    }
                }
                
                if (-not $hasError) {
                    # Add Error = CloudError before >;
                    if ($closingLineIndex -eq $i) {
                        # Single line - add before >;
                        $lines[$i] = $lines[$i] -replace '>;', ', Error = CloudError>;'
                    } else {
                        # Multi-line - add on the line with >;
                        $lines[$closingLineIndex] = $lines[$closingLineIndex] -replace '(\s*)>;', '$1, Error = CloudError>;'
                    }
                    $modified = $true
                    $modifiedCount++
                }
            }
        }
    }
    
    if ($modified) {
        $newContent = $lines -join "`n"
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Modified: $($file.FullName)"
    }
}

Write-Host "`nTotal PUT/PATCH operations modified: $modifiedCount"
