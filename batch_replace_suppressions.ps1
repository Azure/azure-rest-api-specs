# PowerShell script to batch replace suppression justifications
$advisorPath = "d:\GitHub\mcgallan-azure-rest-api-specs\azure-rest-api-specs\specification\advisor\Advisor.Management"
$standardJustification = "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"

# Get all .tsp files in the Advisor.Management directory
$tspFiles = Get-ChildItem -Path $advisorPath -Filter "*.tsp" -Recurse

foreach ($file in $tspFiles) {
    Write-Host "Processing $($file.Name)..."
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content
    
    # Replace various non-standard justifications
    $replacements = @(
        @{Old = '"non-standard operations"'; New = "`"$standardJustification`""},
        @{Old = '"For backward compatibility"'; New = "`"$standardJustification`""},
        @{Old = '"Valid"'; New = "`"$standardJustification`""},
        @{Old = '"ARM"'; New = "`"$standardJustification`""},
        @{Old = '"template"'; New = "`"$standardJustification`""},
        @{Old = '""'; New = "`"$standardJustification`""}
    )
    
    foreach ($replacement in $replacements) {
        $content = $content -replace [regex]::Escape($replacement.Old), $replacement.New
    }
    
    # Handle suppressions without any justification (ending with just the rule name)
    # Pattern: #suppress "rule-name" at end of line -> #suppress "rule-name" "justification"
    $content = $content -replace '(#suppress\s+"[^"]+")(\s*$)', "`$1 `"$standardJustification`"`$2"
    
    # Write back if changes were made
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "  Updated $($file.Name)"
    } else {
        Write-Host "  No changes needed for $($file.Name)"
    }
}

Write-Host "Batch replacement completed."
