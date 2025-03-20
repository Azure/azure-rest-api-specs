function Get-NewTagSection($apiVersion, $resourceProvider, $apiVersionStatus, $specFiles) {

    $tagVersion = $apiVersion -match '(?<version>(\d{4}-\d{2}-\d{2}|\d+\.\d+)(-preview(\.\d+)?)?)'
    $tagVersion = $Matches['version']
    $baseDir = "$resourceProvider/$apiVersionStatus/$apiVersion"

    if ($apiVersionStatus -eq "preview") {
        $tagVersion = "preview-" + $tagVersion
    }

    $content = @"
### Tag: package-$tagVersion

These settings apply only when ``--tag=package-$tagVersion`` is specified on the command line.

```````yaml `$(tag) == 'package-$tagVersion'`
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

function Get-ReadmeWithLatestTag($readmeContent, $newApiVersion, $newApiVersionStatus ) {
    # Get the current tag date
    $currentTag = $readmeContent -match '(?m)^(tag:\s*)(package-)(.*)(?<apiVersion>(?<date>\d{4}-\d{2}(-\d{2})?)|(?<version>\d+\.\d+))'
    if ($currentTag = $Matches['date']) {
        $latestVersionDate = [datetime]($currentTag -replace '-preview', '')

        # Convert the new OpenAPI version to a date
        $newVersionDate = [datetime]($newApiVersion -replace '-preview', '')

        # Compare two dates
        if ($latestVersionDate -gt $newVersionDate) {
            Write-Warning "The new version is not newer than the current default version in the readme file."
        }
    } elseif ($currentTag = $Matches['version']) {
        $latestVersion = [version]($currentTag -replace '-preview', '')

        # Convert the new OpenAPI version to a date
        $newVersion = [Version]($newApiVersion -replace '-preview', '')

        # Compare two semvers
        if ($latestVersion -gt $newVersion) {
            Write-Warning "The new version is not newer than the current default version in the readme file."
        }
    }

    $tagVersion = $newApiVersion -match '(?<apiVersion>(?<date>\d{4}-\d{2}(-\d{2})?)|(?<version>\d+\.\d+)(-preview(\.\d+)?)?)'
    $tagVersion = $Matches['apiVersion']
    if ($newApiVersionStatus -eq "preview") {
        $tagVersion = "preview-" + $tagVersion
    }
    return $readmeContent -replace '(?m)^(tag:\s*)(package-.*)', "tag: package-$tagVersion"
}

function New-GitAddAndCommit {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)]
        [string]$directory,
        [Parameter(Mandatory = $true)]
        [string]$message
    )

    if ($PSCmdlet.ShouldProcess($directory, "Add and commit")) {
        git add $directory | Out-Null
        $message | git commit --file=-
    }
}
