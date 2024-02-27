[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string] $ServiceDirectory,

    [Parameter()]
    [ValidateSet('data-plane', 'resource-manager')]
    [string] $ServiceType = 'data-plane',

    [Parameter(Mandatory = $true)]
    [string] $Provider,

    [Parameter()]
    [ValidateScript({
        function script:Get-Version([string] $version) {
            if ($version -match '^(?<status>stable|preview)/(?<version>(\d{4}-\d{2}-\d{2}|\d+\.\d+)(-preview(\.\d+)?)?)$') {
                return $Matches['status'], $Matches['version']
            }
        
            throw 'Version must start with "stable/" or "preview/" and end with either a date-based version (recommended) like 2024-01-05 or a major.minor semver, followed by an optional "-preview" for previews APIs.'
        }
        # Throwing or returning truthy is sufficient.
        Get-Version $_
    })]
    [string] $FromVersion,

    [Parameter()]
    [ValidateScript({Get-Version $_})]
    [string] $ToVersion
)

$ErrorActionPreference = 'Stop'

$oldVersionStatus, $oldVersion = Get-Version $FromVersion
$newVersionStatus, $newVersion = Get-Version $ToVersion

$repoDirectory = Resolve-Path "$PSScriptRoot/../.."
$readmeDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType" -Resolve
$oldDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$oldVersionStatus/$oldVersion" -Resolve
$newDirectory = Join-Path $repoDirectory "specification/$ServiceDirectory/$ServiceType/$Provider/$newVersionStatus/$newVersion"

# Copy the specs and create and initial commit to make it easier to diff changes to the previous version in a PR.
Copy-Item $oldDirectory $newDirectory -Recurse -Force

git add $newDirectory
@"
Copy files from $FromVersion

Copied the files in a separate commit.
This allows reviewers to easily diff subsequent changes against the previous spec.
"@ | git commit --file=-

# Replace the $oldVersion with the $newVersion within all files in $newDirectory.
foreach ($file in Get-ChildItem $newDirectory -File -Recurse) {
    Write-Verbose "Replacing any API versions in $file"
    $content = $file | Get-Content -Raw
    $content -replace $oldVersion, $newVersion | Set-Content $file.FullName
}

# Commit just the version changes.
git add $newDirectory
@"
Update version to $ToVersion

Updated the API version from $FromVersion to $ToVersion.
"@ | git commit --file=-

Write-Host ''
Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' -ForegroundColor 'Yellow'
Write-Host '!!! IMPORTANT: Action Required !!!' -ForegroundColor 'Yellow'
Write-Host '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!' -ForegroundColor 'Yellow'
Write-Host ''
Write-Host "You must manually update the default version and copy $FromVersion sections from any markdown files in $readmeDirectory."
Write-Host 'When complete, commit those changes as shown below, push to the upstream repo, and submit a pull request.'
Write-Host ''
Write-Host '    git commit -am"Updated readme files"'
Write-Host ''