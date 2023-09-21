[CmdletBinding()]
param (
  [Parameter(Position = 0, Mandatory = $true)]
  [string] $SpecsRepoRootDirectory,
  [Parameter(Position = 1, Mandatory = $false)]
  [string]$TargetBranch,
  [Parameter(Position = 2, Mandatory = $false)]
  [string]$SourceBranch
)

$changedFiles = @()
$allChangedFiles = (Get-ChildItem -path ./specification tspconfig.* -Recurse).Directory.FullName | ForEach-Object {[IO.Path]::GetRelativePath($($pwd.path), $_)}
$allChangedFiles = $allChangedFiles -replace '\\', '/'

if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  if ($TargetBranch -or $SourceBranch) {
    throw "Please provide both target branch and source branch."
  }
  $changedFiles = $allChangedFiles
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" --"
  $changedFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" --
  $changedFiles = $changedFiles -replace '\\', '/' | Sort-Object

  Write-Host "changedFiles:"
  foreach ($changedFile in $changedFiles) {
    Write-Host "  $changedFile"
  }
  Write-Host

  $engFiles = $changedFiles | Where-Object {if ($_) { $_.StartsWith('eng') }}

  $rootFilesImpactingTypeSpec = @(
    ".gitattributes",
    ".prettierrc.json",
    "package-lock.json",
    "package.json",
    "tsconfig.json"
  )
  $repoRootFiles = $changedFiles | Where-Object {$_ -in $rootFilesImpactingTypeSpec}

  if (($Env:BUILD_REPOSITORY_NAME -eq 'azure/azure-rest-api-specs') -and ($engFiles -or $repoRootFiles)) {
    $changedFiles = $allChangedFiles
  }
  else {
    $changedFiles = $changedFiles | Where-Object {if ($_) { $_.StartsWith('specification') }}
  }
}

$typespecFolders = @()
$skippedTypespecFolders = @()
foreach ($file in $changedFiles) {
  if ($file -match 'specification\/[^\/]*\/') {
    if (Test-Path $matches[0]) {
      $typespecFolder = (Get-ChildItem -path $matches[0] tspconfig.* -Recurse).Directory.FullName | ForEach-Object {if ($_) { [IO.Path]::GetRelativePath($($pwd.path), $_) }}
      $typespecFolders += $typespecFolder -replace '\\', '/'
    } else {
      $skippedTypespecFolders += $matches[0]
    }
  }
}

foreach ($skippedTypespecFolder in $skippedTypespecFolders | Select-Object -Unique) {
  Write-Host "Cannot find directory $skippedTypespecFolder"
}

$typespecFolders = $typespecFolders | Select-Object -Unique | Sort-Object

return $typespecFolders
