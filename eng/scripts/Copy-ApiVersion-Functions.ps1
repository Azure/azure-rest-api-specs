function Get-NewTagSection($apiVersion, $resourceProvider, $apiVersionStatus, $specFiles) {
    return @"
### Tag: package-$apiVersion

These settings apply only when ``--tag=package-$apiVersion`` is specified on the command line.

```````yaml `$(tag) == 'package-$apiVersion'
input-file:
$(
foreach ($specFile in $specFiles) {
    "  - $resourceProvider/$apiVersionStatus/$apiVersion/$specFile"
}
)
```````

"@
}

function Get-ReadmeWithNewTag($readmeContent, $tagContent) {
    return $readmeContent -replace '(?s)(### tag: package.*)', "$tagContent`n`$1"
}

function Get-ReadmeWithLatestTag($readmeContent, $newApiVersion ) {
    # Get the current tag date
    $currentTag = $readmeContent -match '(openapi-type:.*\n+tag:\s*)(?<version>package-.*)'
    $currentTag = $Matches['version']
    $latestVersionDate = if ($currentTag -match '(\d{4})-(\d{2})-?(\d{0,2}).*') { 
        if ($Matches[3] -eq '') { $Matches[3] = '01' }
        [datetime]::ParseExact($Matches[1] + '-' + $Matches[2] + '-' + $Matches[3], 'yyyy-MM-dd', $null) 
    } 
    else { 
        Write-Error "No date found in the readme tag: Tag $currentTag does not match the yyyy-MM-dd format"
        Exit 1
    }

    # Convert the new OpenAPI version to a date
    $newVersionDate = if ($newApiVersion -match '(\d{4})-(\d{2})-?(\d{0,2})') { 
        if ($Matches[3] -eq '') { $Matches[3] = '01' }
        [datetime]::ParseExact($Matches[1] + '-' + $Matches[2] + '-' + $Matches[3], 'yyyy-MM-dd', $null) 
    } 
    else { 
        Write-Error "No date found in the new version: Tag $newVersionDate does not match the yyyy-MM-dd format"
        Exit 1
    }

    # Compare two dates
    if ( $newVersionDate -gt $latestVersionDate) {    
        if ($readmeFile) {
            return $readmeContent -replace '(openapi-type:.*\n+tag:\s*)(package-.*)', "`$1package-$newApiVersion" 
        }
    }
    return ""
}

function New-GitAddAndCommit($directory, $message, $testMode = $false) {
    if ($testMode) {
        Write-Verbose "Test mode: git add $directory"
        Write-Verbose "Test mode: git commit -m $message"
    }
    else {
        git add $directory | Out-Null
        $message | git commit --file=-
    }
}
