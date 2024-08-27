[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$TargetCommitish = "HEAD"
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$checkAllPath = ((Get-ChildItem "specification" -Directory).Name -replace '^', 'specification/') -replace '$', '/'

if ($CheckAll) {
  $changedFiles = $checkAllPath
}
else {
  $changedFiles = @(Get-ChangedFiles -baseCommitish $BaseCommitish -targetCommitish $TargetCommitish -diffFilter "")
  $coreChangedFiles = Get-ChangedCoreFiles $changedFiles

  if ($coreChangedFiles) {
    Write-Verbose "Found changes to core eng or root files so checking all specs."
    $changedFiles = $checkAllPath
  }
  else {
    $changedFiles = Get-ChangedFilesUnderSpecification $changedFiles
  }
}

$typespecFolders = @()
$skippedTypespecFolders = @()
foreach ($file in $changedFiles) {
  if ($file -match 'specification(\/[^\/]+\/)+') {
    $path = "$repoPath/$($matches[0])"
    if (Test-Path $path) {
      Write-Verbose "Checking for tspconfig files under $path"
      $typespecFolder = Get-ChildItem -path $path tspconfig.* -Recurse
      if ($typespecFolder) {
        $typespecFolders += $typespecFolder.Directory.FullName
      }
    } else {
      $skippedTypespecFolders += $path
    } 
  }
}
foreach ($skippedTypespecFolder in $skippedTypespecFolders | Select-Object -Unique) {
  Write-Host "Cannot find directory $skippedTypespecFolder"
}

$typespecFolders = $typespecFolders | ForEach-Object { [IO.Path]::GetRelativePath($repoPath, $_) -replace '\\', '/' } | Sort-Object -Unique

return $typespecFolders
