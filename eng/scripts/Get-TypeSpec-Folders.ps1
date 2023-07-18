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
$sanitizedPwd = $($pwd.path) -replace '\\', '/'
if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $tspFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).FullName -replace '\\', '/' | ForEach-Object {[IO.Path]::GetRelativePath($sanitizedPwd, $_)}
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {`$_.StartsWith('specification')}"
  $tspFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {$_.StartsWith('specification')}
}
$tspFile -replace '\\', '/'

$typespecFolders = @()
foreach ($file in $tspFiles) {
  if ($file -match 'specification\/[^\/]*\/') {
    $typespecFolders += (Get-ChildItem -path $matches[0] tspconfig.yaml -Recurse).Directory.FullName -replace '\\', '/' | ForEach-Object {[IO.Path]::GetRelativePath($sanitizedPwd, $_)}
  }
}
$typespecFolders = $typespecFolders | Select-Object -Unique

return $typespecFolders
