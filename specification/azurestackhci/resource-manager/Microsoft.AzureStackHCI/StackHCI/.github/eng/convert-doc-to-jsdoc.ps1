<#
.SYNOPSIS
Converts @doc("...") decorators to /** ... */ JSDoc comments in TypeSpec files.

.DESCRIPTION
This script processes .tsp files and converts @doc("text") decorators to 
/** text */ style comments, which is the preferred documentation style.

Handles:
- Model-level @doc decorators
- Property-level @doc decorators  
- Union member @doc decorators
- Interface method @doc decorators

.PARAMETER Path
Path to the .tsp file or directory to process.

.PARAMETER DryRun
If specified, shows what changes would be made without actually modifying files.

.EXAMPLE
.\convert-doc-to-jsdoc.ps1 -Path "models.tsp"

.EXAMPLE
.\convert-doc-to-jsdoc.ps1 -Path "." -DryRun
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Path,
    
    [switch]$DryRun
)

function Convert-DocToJsDoc {
    param(
        [string]$FilePath
    )
    
    $lines = Get-Content -Path $FilePath
    $newLines = @()
    $changes = 0
    $i = 0
    
    while ($i -lt $lines.Count) {
        $line = $lines[$i]
        $trimmedLine = $line.Trim()
        
        # Check if line starts with @doc("...")
        if ($trimmedLine -match '^@doc\("([^"]+)"\)$') {
            $docText = $Matches[1]
            $indent = $line -replace '^(\s*).*', '$1'
            
            # Replace with JSDoc comment
            $newLines += "$indent/**"
            $newLines += "$indent * $docText"
            $newLines += "$indent */"
            $changes++
        }
        # Check for inline @doc on property lines: @doc("text")\n  propertyName: type
        elseif ($trimmedLine -match '^@doc\("([^"]+)"\)') {
            # This handles cases where @doc is on same line with other content
            # For now, just convert to JSDoc style
            $docText = $Matches[1]
            $indent = $line -replace '^(\s*).*', '$1'
            $restOfLine = $trimmedLine -replace '@doc\("[^"]+"\)\s*', ''
            
            if ($restOfLine) {
                # There's content after @doc, keep it on separate line
                $newLines += "$indent/**"
                $newLines += "$indent * $docText"
                $newLines += "$indent */"
                $newLines += "$indent$restOfLine"
            } else {
                $newLines += "$indent/**"
                $newLines += "$indent * $docText"
                $newLines += "$indent */"
            }
            $changes++
        }
        else {
            $newLines += $line
        }
        
        $i++
    }
    
    if ($changes -gt 0) {
        if ($DryRun) {
            Write-Host "Would modify: $FilePath ($changes @doc -> /** */ conversions)"
        } else {
            $newLines | Set-Content -Path $FilePath
            Write-Host "Modified: $FilePath ($changes @doc -> /** */ conversions)"
        }
        return $changes
    } else {
        Write-Host "No @doc found: $FilePath"
        return 0
    }
}

$totalChanges = 0

# Process files
if (Test-Path $Path -PathType Container) {
    Get-ChildItem -Path $Path -Filter "*.tsp" | ForEach-Object {
        $totalChanges += Convert-DocToJsDoc -FilePath $_.FullName
    }
} elseif (Test-Path $Path -PathType Leaf) {
    $totalChanges = Convert-DocToJsDoc -FilePath $Path
} else {
    Write-Error "Path not found: $Path"
    exit 1
}

Write-Host "`nTotal changes: $totalChanges"
if ($DryRun) {
    Write-Host "This was a dry run. No files were modified."
}
