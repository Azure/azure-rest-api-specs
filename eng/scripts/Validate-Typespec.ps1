[CmdletBinding()]
param (
  [Parameter(Position = 0, Mandatory = $true)]
  [string] $SpecsRepoRootDirectory,
  [Parameter(Position = 1, Mandatory = $false)]
  [string]$TargetBranch,
  [Parameter(Position = 2, Mandatory = $false)]
  [string]$SourceBranch
)

$typespecFolders = @()

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" "$SpecsRepoRootDirectory" "$TargetBranch" "$SourceBranch"

$exitCode = 0
foreach ($typespecFolder in $typespecFolders) {
  npx --no tsv $typespecFolder 2>&1 | Write-Host
  if ($LASTEXITCODE) {
    $exitCode = 1
  }
  git restore .
  git clean -df
}

exit $exitCode
