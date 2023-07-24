[CmdletBinding()]
param (
  [Parameter(Position = 0, Mandatory = $true)]
  [string] $SpecsRepoRootDirectory,
  [Parameter(Position = 1, Mandatory = $false)]
  [string]$TargetBranch,
  [Parameter(Position = 2, Mandatory = $false)]
  [string]$SourceBranch,
  [Parameter(Mandatory = $false)]
  [switch]$GitClean
)

$exitCode = 0

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" "$SpecsRepoRootDirectory" "$TargetBranch" "$SourceBranch"

Write-Host "typespecFolders:"
foreach ($typespecFolder in $typespecFolders) {
  Write-Host "  $typespecFolder"
}
Write-Host

if ($typespecFolders) {
  $typespecFolders = $typespecFolders.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)
  foreach ($typespecFolder in $typespecFolders) {
    npx --no tsv $typespecFolder 2>&1 | Write-Host
    if ($LASTEXITCODE) {
      $exitCode = 1
    }
    if ($GitClean) {
      Write-Host "git restore ."
      git restore .
      Write-Host "git clean -df"
      git clean -df
    }
  }
}

exit $exitCode
