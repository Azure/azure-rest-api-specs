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
$allChangedFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).Directory.FullName | ForEach-Object {[IO.Path]::GetRelativePath($($pwd.path), $_)}
$allChangedFiles = $allChangedFiles -replace '\\', '/'

if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $changedFiles = $allChangedFiles
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" --"
  $changedFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" --
  $changedFiles = $changedFiles -replace '\\', '/'

  Write-Host "changedFiles:"
  foreach ($changedFile in $changedFiles) {
    Write-Host "  $changedFile"
  }
  Write-Host

  $engFiles = $changedFiles | Where-Object {if ($_) { $_.StartsWith('eng') }}
  $repoRootFiles = $changedFiles | Where-Object {$_ -notmatch [Regex]::Escape([IO.Path]::DirectorySeparatorChar)}
  if ($engFiles -or $repoRootFiles) {
    $changedFiles = $allChangedFiles
  }
  else {
    $changedFiles = $changedFiles | Where-Object {if ($_) { $_.StartsWith('specification') }}
  }
}

$typespecFolders = @()
foreach ($file in $changedFiles) {
  if ($file -match 'specification\/[^\/]*\/') {
    $typespecFolder = (Get-ChildItem -path $matches[0] tspconfig.yaml -Recurse).Directory.FullName | ForEach-Object {if ($_) { [IO.Path]::GetRelativePath($($pwd.path), $_) }}
    $typespecFolders += $typespecFolder -replace '\\', '/'
  }
}
$typespecFolders = $typespecFolders | Select-Object -Unique

return $typespecFolders
