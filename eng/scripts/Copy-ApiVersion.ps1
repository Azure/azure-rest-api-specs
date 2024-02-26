[CmdletBinding()]
param (
    [Parameter(Mandatory)]
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

    [Parameter(Mandatory)]
    [ValidateSet('data-plane', 'resource-manager')]
    [ArgumentCompleter({ 'data-plane', 'resource-manager' })]
    [string] $ServiceType,

    [Parameter(Mandatory)]
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

    [Parameter(Mandatory)]
    [ArgumentCompleter({"preview/", "stable/"})]
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

Write-Host ''
Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' -ForegroundColor 'Yellow'
Write-Host '!!! IMPORTANT: Action Required !!!' -ForegroundColor 'Yellow'
Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' -ForegroundColor 'Yellow'
Write-Host ''
Write-Host "You must manually update the default version and copy $BaseVersion sections from any markdown files in $readmeDirectory."
Write-Host 'When complete, commit those changes as shown below, push to the upstream repo, and submit a pull request.'
Write-Host ''
Write-Host '    git commit -am"Updated readme files"'
Write-Host ''