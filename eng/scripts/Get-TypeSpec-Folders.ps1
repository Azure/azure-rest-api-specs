[CmdletBinding()]
param (
  [switch]$IgnoreCoreFiles = $false,
  [switch]$CheckAll = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$HeadCommitish = "HEAD",
  [string]$RepoPath = "$PSScriptRoot/../.."
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1

$repoPath = (Resolve-Path $RepoPath).Path

$checkedAll = $false

if ($CheckAll) {
  $typespecFolders = Get-ChildItem -Path "$repoPath/specification" tspconfig.* -Recurse |
    ForEach-Object { [IO.Path]::GetRelativePath($repoPath, $_.Directory.FullName) -replace '\\', '/' } |
    Sort-Object -Unique
  $checkedAll = $true
}
else {
  $changedFiles = @(Get-ChangedFiles -baseCommitish $BaseCommitish -headCommitish $HeadCommitish -diffFilter "")
  $coreChangedFiles = Get-ChangedCoreFiles $changedFiles

  if ($coreChangedFiles -and !$IgnoreCoreFiles) {
    Write-Verbose "Found changes to core eng or root files so checking all specs."
    $searchPaths = @("specification/")
    $checkedAll = $true
  }
  else {
    $changedFiles = Get-ChangedFilesUnderSpecification $changedFiles
    $searchPaths = @(
      $changedFiles | ForEach-Object {
        if ($_ -match 'specification(\/[^\/]+\/)+') {
          $matches[0]
        }
      }
    ) | Sort-Object -Unique
  }

  $typespecFolders = @(
    foreach ($revision in @($BaseCommitish, $HeadCommitish)) {
      if ($searchPaths.Count -eq 0) {
        continue
      }

      $revisionFiles = & git -C $repoPath -c core.quotepath=off ls-tree -r --name-only $revision -- @searchPaths
      if ($LASTEXITCODE -ne 0) {
        throw "Failed to list TypeSpec projects in revision '$revision'."
      }

      $revisionFiles | Where-Object { $_ -match '(^|/)tspconfig\.[^/]+$' } |
        ForEach-Object { $_ -replace '/tspconfig\.[^/]+$', '' }
    }
  ) | Sort-Object -Unique
}

return @($typespecFolders, $checkedAll)
