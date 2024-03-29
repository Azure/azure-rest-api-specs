function Get-NewTagSection($apiVersion, $resourceProvider, $apiVersionStatus, $specFiles, $resourceProviderInnerFolder = $null) {

    $tagVersion = $apiVersion -match '(?<date>\d{4}-\d{2})-\d{2}' 
    $tagVersion = $Matches['date']
    $baseDir = if ($resourceProviderInnerFolder) 
    { "$resourceProvider/$resourceProviderInnerFolder/$apiVersionStatus/$apiVersion" } 
    else { "$resourceProvider/$apiVersionStatus/$apiVersion" }
    
    $content = @"
### Tag: package-$(If($apiVersionStatus -eq "preview"){"preview-"})$tagVersion

These settings apply only when ``--tag=package-$(If($apiVersionStatus -eq "preview"){"preview-"})$tagVersion`` is specified on the command line.

```````yaml `$(tag) == 'package-$(If($apiVersionStatus -eq "preview"){"preview-"})$tagVersion'`
input-file:
"@

    foreach ($specFile in $specFiles) {
        $content += "`n  - $baseDir/$specFile"
    }

    $content += "`n" + '```' + "`n"
    return $content
}

function Get-ReadmeWithNewTag($readmeContent, $tagContent) {
    return $readmeContent -replace '(?s)(### tag: package.*)', "$tagContent`n`$1"
}

function Get-ReadmeWithLatestTag($readmeContent, $newApiVersion ) {
    # Get the current tag date
    $currentTag = $readmeContent -match '(openapi-type:.*\s+tag:\s*)(?<version>package-.*)'
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
        $tagVersion = $newApiVersion -match '(?<date>\d{4}-\d{2})-\d{2}(-(?<preview>preview))?'
        $tagVersion = $Matches['date']
        $isPreview = $Matches['preview']
        return $readmeContent -replace '(openapi-type:.*\s+tag:\s*)(package-.*)', "`$1package-$(if($isPreview -eq "preview"){"preview-"})$tagVersion" 
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
