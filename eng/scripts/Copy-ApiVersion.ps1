[CmdletBinding(SupportsShouldProcess)]
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
        function script:Get-Version($version) {
            if ($version -match '^(?<status>stable|preview)/(?<version>(\d{4}-\d{2}(-\d{2})?|\d+\.\d+)(-preview(\.\d+)?)?)$') {
                return $Matches['status'], $Matches['version']
            }

            throw 'Version must start with "stable/" or "preview/" and end with either a date-based version (recommended) like 2024-01-05 or a major.minor semver, followed by an optional "-preview" for previews APIs.'
        }
        Get-Version $_
    })]
    [string] $NewVersion,
    
    [Parameter(Mandatory = $true)]
    [ValidateScript({ 
        if ($_ -match '^(?<status>stable|preview)/(?<version>(\d{4}-\d{2}(-\d{2})?|\d+\.\d+)(-preview(\.\d+)?)?)$') {
            return $Matches['status'], $Matches['version']
        }

        throw 'Version must start with "stable/" or "preview/" and end with either a date-based version (recommended) like 2024-01-05 or a major.minor semver, followed by an optional "-preview" for previews APIs.'
    })]
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
    [string] $BaseVersion
)

. "$PSScriptRoot/Copy-ApiVersion-Functions.ps1"

$oldApiVersionStatus, $oldApiVersion = Get-Version $BaseVersion
$newApiVersionStatus, $newApiVersion = Get-Version $NewVersion

$repoDirectory = Resolve-Path "$PSScriptRoot/../.."
$readmeDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType" -Resolve

$oldDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$oldApiVersionStatus/$oldApiVersion" -Resolve
$newDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$newApiVersionStatus/$newApiVersion"

Write-Host "----------------------------------------" 
Write-Host "Service Directory: $ServiceDirectory"
Write-Host "Service Type: $ServiceType"
Write-Host "Provider: $Provider"
Write-Host "Base Version: $BaseVersion"
Write-Host "New Version: $NewVersion"
Write-Host "----------------------------------------"

Write-Verbose "Copying $oldDirectory to $newDirectory"

# Copy the specs and create and initial commit to make it easier to diff changes to the previous version in a PR.
Copy-Item $oldDirectory $newDirectory -Recurse -Force

New-GitAddAndCommit $newDirectory @"
Copy files from $BaseVersion

Copied the files in a separate commit.
This allows reviewers to easily diff subsequent changes against the previous spec.
"@

# Replace the $oldApiVersion with the $newApiVersion within all files in $newDirectory.
foreach ($file in Get-ChildItem $newDirectory -File -Recurse) {
    Write-Verbose "Replacing any API versions in $file"
    $content = $file | Get-Content -Raw
    $content -replace $oldApiVersion, $newApiVersion | Set-Content $file.FullName -NoNewline
}

# Commit just the version changes.
New-GitAddAndCommit $newDirectory @"
Update version to $NewVersion

Updated the API version from $BaseVersion to $NewVersion.
"@

# Add new version tag in the readme file
$readmeFile = Get-ChildItem $readmeDirectory -Filter 'readme.md'
if ($readmeFile) {
    $jsonFiles = Get-ChildItem $newDirectory -Filter '*.json' | Select-Object -ExpandProperty Name
    $newReadmeTagBlock = Get-NewTagSection $newApiVersion $Provider $newApiVersionStatus $jsonFiles
    
    $readmeContent = $readmeFile | Get-Content -Raw
    $readmeContent = Get-ReadmeWithNewTag $readmeContent $newReadmeTagBlock
    $readmeContent | Set-Content $readmeFile.FullName -NoNewline
}
else {
    Write-Error "No readme file found in $readmeDirectory"
    Exit 1
}

# Update the latest version tag in the readme file
$val = Get-ReadmeWithLatestTag $readmeContent $newApiVersion $newApiVersionStatus
if ($val -ne "") {
    Write-Verbose "Updating the first tag in the first yaml code block in $readmeFile"
    $val | Set-Content $readmeFile.FullName -NoNewline
    Write-Information "Latest version tag in readme file updated."
}
else {
    Write-Warning "The new version is not newer than the current version in the readme file. No changes were made."
}

New-GitAddAndCommit $readmeDirectory @"
Added tag for $newApiVersion in readme file
"@
