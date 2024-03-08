[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateScript({
            if (-not (Test-Path "$PSScriptRoot/../../specification/$_")) {
                throw "Service directory not found in the specification folder."
            }
            $true
        })]
    [ArgumentCompleter({
            Get-ChildItem "$PSScriptRoot/../../specification/" -Directory | Select-Object -ExpandProperty Name
        })]
    [string] $ServiceDirectory,

    [Parameter(Mandatory = $true)]
    [ValidateSet('data-plane', 'resource-manager')]
    [ArgumentCompleter({ 'data-plane', 'resource-manager' })]
    [string] $ServiceType,

    [Parameter(Mandatory = $true)]
    [ValidateScript({
            if (-not (Test-Path "$PSScriptRoot/../../specification/$ServiceDirectory/$ServiceType/$_")) {
                $validProviders = (Get-ChildItem "$PSScriptRoot/../../specification/$ServiceDirectory/$ServiceType/" -Directory).Name -join ', '
                throw "Service Provider not found. Valid options are: $validProviders"
            }
            $true
        })]
    [ArgumentCompleter({
            param($commandName,
                $parameterName,
                $wordToComplete,
                $commandAst,
                $fakeBoundParameters)
            Get-ChildItem "$PSScriptRoot/../../specification/$($fakeBoundParameters.ServiceDirectory)/$($fakeBoundParameters.ServiceType)/" -Directory | Select-Object -ExpandProperty Name
        })]
    [string] $Provider,

    [Parameter(Mandatory = $true)]
    [ArgumentCompleter({ "preview/", "stable/" })]
    [ValidateScript({ 
            function script:Get-Version([string] $version) {
                if ($version -match '^(?<status>stable|preview)/(?<version>(\d{4}-\d{2}-\d{2}|\d+\.\d+)(-preview(\.\d+)?)?)$') {
                    return $Matches['status'], $Matches['version']
                }
        
                throw 'Version must start with "stable/" or "preview/" and end with either a date-based version (recommended) like 2024-01-05 or a major.minor semver, followed by an optional "-preview" for previews APIs.'
            }
            Get-Version $_ })]
    [string] $NewVersion,
    
    [Parameter()]
    [ValidateScript({ Get-Version $_ })]
    [ArgumentCompleter({
            param($commandName,
                $parameterName,
                $wordToComplete,
                $commandAst,
                $fakeBoundParameters)
            [string[]] $stableVersions = Get-ChildItem "$PSScriptRoot/../../specification/$($fakeBoundParameters.ServiceDirectory)/$($fakeBoundParameters.ServiceType)/$($fakeBoundParameters.Provider)/stable/" -Directory | Select-Object -ExpandProperty Name |
            ForEach-Object { "stable/$_" }
            [string[]] $previewVersions = Get-ChildItem "$PSScriptRoot/../../specification/$($fakeBoundParameters.ServiceDirectory)/$($fakeBoundParameters.ServiceType)/$($fakeBoundParameters.Provider)/preview/" -Directory | Select-Object -ExpandProperty Name |
            ForEach-Object { "preview/$_" }
            return $stableVersions + $previewVersions
        })]
    # By Default, use the last preview version
    [string] $BaseVersion = (
        Get-ChildItem "$PSScriptRoot/../../specification/$ServiceDirectory/$ServiceType/$Provider/preview/" -Directory | Select-Object -ExpandProperty Name | Sort-Object -Descending | Select-Object -First 1 | ForEach-Object { "preview/$_" }
    )
)

$ErrorActionPreference = 'Stop'

$oldApiVersionStatus, $oldApiVersion = Get-Version $BaseVersion
$newApiVersionStatus, $newApiVersion = Get-Version $NewVersion

$repoDirectory = Resolve-Path "$PSScriptRoot/../.."
$readmeDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType" -Resolve
$oldDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$oldApiVersionStatus/$oldApiVersion" -Resolve
$newDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$newApiVersionStatus/$newApiVersion"

Write-Host "----------------------------------------" -ForegroundColor Green
Write-Host "Service Directory: $ServiceDirectory" -ForegroundColor Green
Write-Host "Service Type: $ServiceType" -ForegroundColor Green
Write-Host "Provider: $Provider" -ForegroundColor Green
Write-Host "Base Version: $BaseVersion" -ForegroundColor Green
Write-Host "New Version: $NewVersion" -ForegroundColor Green
Write-Host "----------------------------------------" -ForegroundColor Green

Write-Verbose "Copying $oldDirectory to $newDirectory"

# Copy the specs and create and initial commit to make it easier to diff changes to the previous version in a PR.
Copy-Item $oldDirectory $newDirectory -Recurse -Force

git add $newDirectory
@"
Copy files from $BaseVersion

Copied the files in a separate commit.
This allows reviewers to easily diff subsequent changes against the previous spec.
"@ | git commit --file=-

# Replace the $oldApiVersion with the $newApiVersion within all files in $newDirectory.
foreach ($file in Get-ChildItem $newDirectory -File -Recurse) {
    Write-Verbose "Replacing any API versions in $file"
    $content = $file | Get-Content -Raw
    $content -replace $oldApiVersion, $newApiVersion | Set-Content $file.FullName
}

# Commit just the version changes.
git add $newDirectory
@"
Update version to $NewVersion

Updated the API version from $BaseVersion to $NewVersion.
"@ | git commit --file=-

# Update readme file in the service type directory
$jsonFiles = Get-ChildItem $newDirectory -Filter '*.json' | Select-Object -ExpandProperty Name
$readmeFile = Get-ChildItem $readmeDirectory -Filter 'readme.md'

$readmeContentBlock = @"
### Tag: package-$newApiVersion

These settings apply only when ``--tag=package-$newApiVersion`` is specified on the command line.

```````yaml `$(tag) == 'package-$newApiVersion'
input-file:
$(
foreach ($jsonFile in $jsonFiles) {
  "  - $Provider/$newApiVersionStatus/$newApiVersion/$jsonFile"
}
)
```````

"@

if ($readmeFile) {
    $readmeContent = $readmeFile | Get-Content -Raw
    $readmeContent -replace '(?s)(### tag: package.*)', "$readmeContentBlock`n`$1" | Set-Content $readmeFile.FullName -NoNewline
}

# Update the tag to the latest preview or stable version in the readme file
$currentTag = $readmeContent -match '(openapi-type:.*\n+tag:\s*)(?<version>package-.*)'
$currentTag = $Matches['version']
$latestVersionDate = if ($currentTag -match '(\d{4})-(\d{2})-?(\d{0,2}).*') { 
    if ($Matches[3] -eq '') { $Matches[3] = '01' }
    [datetime]::ParseExact($Matches[1] + '-' + $Matches[2] + '-' + $Matches[3], 'yyyy-MM-dd', $null) 
} 
else { 
    Write-Warning "No date found in the readme tag"
    [datetime]::MinValue 
}

$newVersionDate = if ($newApiVersion -match '(\d{4})-(\d{2})-?(\d{0,2})') { 
    if ($Matches[3] -eq '') { $Matches[3] = '01' }
    [datetime]::ParseExact($Matches[1] + '-' + $Matches[2] + '-' + $Matches[3], 'yyyy-MM-dd', $null) 
} 
else { 
    Write-Warning "No date found in the new version"
    [datetime]::MinValue 
}

if ( $newVersionDate -gt $latestVersionDate) {    
    Write-Verbose "Updating the first tag in the first yaml code block in $readmeFile"
    if ($readmeFile) {
        $providerReadmeContent = $readmeFile | Get-Content -Raw
        $providerReadmeContent -replace '(openapi-type:.*\n+tag:\s*)(package-.*)', "`$1package-$newApiVersion" | Set-Content $readmeFile.FullName -NoNewline
    }
}
else {
    Write-Warning "The new version is not newer than the current version in the readme file. No changes were made."
}

git add $readmeDirectory
git commit -am"Added tag for $newApiVersion in readme file"