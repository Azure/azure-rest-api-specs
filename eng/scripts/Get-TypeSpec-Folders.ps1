[CmdletBinding()]
param (
  [Parameter(Position = 0, Mandatory = $true)]
  [string] $SpecsRepoRootDirectory,
  [Parameter(Position = 1, Mandatory = $false)]
  [string]$TargetBranch,
  [Parameter(Position = 2, Mandatory = $false)]
  [string]$SourceBranch
)

$tspFiles = @()
$allTspFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).FullName -replace "$($pwd.Path)/"
if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $tspFiles = $allTspFiles
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {`$_.StartsWith('specification')}"
  $diffFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" --
  $engFiles = $diffFiles | Where-Object {$_.StartsWith('eng')}
  $repoRootFiles = $diffFiles | Where-Object {$_ -notmatch '/'}
  if ($repoRootFiles) {
    $tspFiles = $allTspFiles
  }
  else {
    $tspFiles = $diffFiles | Where-Object {$_.StartsWith('specification')}
  }
}

$typespecFolders = @()
foreach ($file in $tspFiles) {
  $file -match 'specification\/[^\/]*\/' | out-null
  $typespecFolders += (Get-ChildItem -path $matches[0] tspconfig.yaml -Recurse).Directory.FullName -replace "$($pwd.Path)/"
}
$typespecFolders = $typespecFolders | Select-Object -Unique

return $typespecFolders
