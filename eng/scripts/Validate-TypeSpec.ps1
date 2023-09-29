[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false
)

$exitCode = 0

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" -CheckAll:$CheckAll

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
