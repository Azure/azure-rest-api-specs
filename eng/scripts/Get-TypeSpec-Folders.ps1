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
if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $changedFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).Directory.FullName | ForEach-Object {[IO.Path]::GetRelativePath($($pwd.path), $_)}
  $changedFiles = $changedFiles -replace '\\', '/'
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {`$_.StartsWith('specification')}"
  $changedFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {$_.StartsWith('specification')}
  $changedFiles = $changedFiles -replace '\\', '/'

  Write-Host "changedFiles:"
  foreach ($changedFile in $changedFiles) {
    Write-Host "  $changedFile"
  }
  Write-Host
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
