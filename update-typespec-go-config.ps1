#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Updates TypeSpec Go configuration in tspconfig.yaml files
    
.DESCRIPTION
    This script finds and updates the @azure-tools/typespec-go section in tspconfig.yaml files:
    1. Changes package-dir to emitter-output-dir with new value format
    2. Updates module config to replace {package-dir} with actual value
    3. Removes module-version config
    
.PARAMETER FilePath
    Path to the tspconfig.yaml file to update. If not specified, searches for files in current directory.
    
.PARAMETER Recurse
    Search recursively in subdirectories for tspconfig.yaml files
    
.EXAMPLE
    .\update-typespec-go-config.ps1 -FilePath ".\tspconfig.yaml"
    Updates a specific tspconfig.yaml file
    
.EXAMPLE
    .\update-typespec-go-config.ps1 -Recurse
    Searches and updates all tspconfig.yaml files in current directory and subdirectories
    
.EXAMPLE
    .\update-typespec-go-config.ps1
    Updates tspconfig.yaml files in current directory only
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$FilePath,
    
    [Parameter(Mandatory = $false)]
    [switch]$Recurse
)

function Update-TypeSpecGoConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ConfigFilePath
    )
    
    Write-Host "Processing file: $ConfigFilePath" -ForegroundColor Green
    
    # Read the file content
    $content = Get-Content -Path $ConfigFilePath -Raw
    
    # Check if the file contains @azure-tools/typespec-go section
    if ($content -notmatch '@azure-tools/typespec-go') {
        Write-Host "  No @azure-tools/typespec-go section found, skipping..." -ForegroundColor Yellow
        return $false
    }
    
    # Split content into lines for processing
    $lines = Get-Content -Path $ConfigFilePath
    $newLines = @()
    $inGoSection = $false
    $sectionIndent = ""
    $goSectionLines = @()
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        # Check if we're entering the typespec-go section
        if ($line -match '^\s*"@azure-tools/typespec-go":\s*$') {
            $inGoSection = $true
            $sectionIndent = $line.Length - $line.TrimStart().Length
            $newLines += $line
            $goSectionLines = @()
            Write-Host "  Found @azure-tools/typespec-go section" -ForegroundColor Cyan
            continue
        }
        
        # Check if we're leaving the current section (next section starts or indentation decreases)
        if ($inGoSection) {
            $currentIndent = $line.Length - $line.TrimStart().Length
            if (($line -match '^\s*"@.*":\s*$' -and $currentIndent -le $sectionIndent) -or 
                ($line -match '^\s*[a-zA-Z][^:]*:\s*$' -and $currentIndent -le $sectionIndent)) {
                # Process the collected Go section lines
                $processedLines = ConvertTo-GoSectionLines -Lines @($goSectionLines)
                $newLines += $processedLines
                $inGoSection = $false
                $newLines += $line
                continue
            }
        }
        
        # Process lines within the typespec-go section
        if ($inGoSection) {
            $goSectionLines += $line
        } else {
            # Keep lines outside the typespec-go section
            $newLines += $line
        }
    }
    
    # Handle case where Go section is at the end of file
    if ($inGoSection -and $goSectionLines.Count -gt 0) {
        $processedLines = ConvertTo-GoSectionLines -Lines @($goSectionLines)
        $newLines += $processedLines
    }
    
    # Write the updated content back to the file
    $newContent = $newLines -join "`n"
    if ($newContent -and -not $newContent.EndsWith("`n")) {
        $newContent += "`n"
    }
    Set-Content -Path $ConfigFilePath -Value $newContent -NoNewline
    
    Write-Host "  File updated successfully!" -ForegroundColor Green
    return $true
}

function ConvertTo-GoSectionLines {
    param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [string[]]$Lines = @()
    )
    
    if ($Lines.Count -eq 0) {
        return @()
    }
    
    # Filter out any empty string entries that PowerShell might pass
    $cleanLines = @($Lines | Where-Object { $_ -ne $null })
    
    if ($cleanLines.Count -eq 0) {
        return @()
    }
    
    $processedLines = @()
    $packageDirValue = ""
    $moduleValue = ""
    
    # First pass: extract package-dir and module values
    foreach ($line in $cleanLines) {
        if ($line -match '^\s*package-dir:\s*"?([^"]+)"?\s*$') {
            $packageDirValue = $matches[1]
            Write-Host "  Found package-dir: $packageDirValue" -ForegroundColor Cyan
        }
        if ($line -match '^\s*module:\s*"?([^"]+)"?\s*$') {
            $moduleValue = $matches[1]
            Write-Host "  Found module: $moduleValue" -ForegroundColor Cyan
        }
    }
    
    # Second pass: process and transform lines
    foreach ($line in $cleanLines) {
        # Skip empty lines and comments - keep them as is
        if ($line -match '^\s*$' -or $line -match '^\s*#') {
            $processedLines += $line
            continue
        }
        
        # Transform package-dir to emitter-output-dir
        if ($line -match '^\s*package-dir:\s*"?([^"]+)"?\s*$') {
            $indent = ($line -replace 'package-dir:.*$', '')
            $newLine = $indent + "emitter-output-dir: `"{output-dir}/{service-dir}/$packageDirValue`""
            $processedLines += $newLine
            Write-Host "  Changed package-dir to emitter-output-dir: {output-dir}/{service-dir}/$packageDirValue" -ForegroundColor Green
            continue
        }
        
        # Update module value
        if ($line -match '^\s*module:\s*"?([^"]+)"?\s*$') {
            if ($packageDirValue -and $moduleValue -match '\{package-dir\}') {
                $newModuleValue = $moduleValue -replace '\{package-dir\}', $packageDirValue
                $indent = ($line -replace 'module:.*$', '')
                $newLine = $indent + "module: `"$newModuleValue`""
                $processedLines += $newLine
                Write-Host "  Updated module to: $newModuleValue" -ForegroundColor Green
            } else {
                $processedLines += $line
            }
            continue
        }
        
        # Skip module-version line
        if ($line -match '^\s*module-version:') {
            Write-Host "  Removed module-version config" -ForegroundColor Green
            continue
        }
        
        # Keep all other lines in the section
        $processedLines += $line
    }
    
    return $processedLines
}

# Main execution
try {
    if ($FilePath) {
        # Process specific file
        if (-not (Test-Path $FilePath)) {
            Write-Error "File not found: $FilePath"
            exit 1
        }
        
        $updated = Update-TypeSpecGoConfig -ConfigFilePath $FilePath
        if ($updated) {
            Write-Host "`nSuccessfully updated: $FilePath" -ForegroundColor Green
        }
    } else {
        # Find tspconfig.yaml files
        $searchPath = if ($Recurse) { Get-ChildItem -Path "." -Name "tspconfig.yaml" -Recurse } else { Get-ChildItem -Path "." -Name "tspconfig.yaml" }
        
        if (-not $searchPath) {
            Write-Host "No tspconfig.yaml files found." -ForegroundColor Yellow
            exit 0
        }
        
        $updatedCount = 0
        foreach ($file in $searchPath) {
            $fullPath = Resolve-Path $file
            $updated = Update-TypeSpecGoConfig -ConfigFilePath $fullPath
            if ($updated) {
                $updatedCount++
            }
        }
        
        Write-Host "`nProcessing complete. Updated $updatedCount file(s)." -ForegroundColor Green
    }
} catch {
    Write-Error "An error occurred: $_"
    exit 1
}
