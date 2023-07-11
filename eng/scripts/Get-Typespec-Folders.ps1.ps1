[CmdletBinding()]
param (
  [Parameter(Position = 0, Mandatory = $true)]
  [string] $SpecsRepoRootDirectory,
  [Parameter(Position = 1, Mandatory = $false)]
  [string]$TargetBranch,
  [Parameter(Position = 2, Mandatory = $false)]
  [string]$SourceBranch
)

Write-Host $TargetBranch
Write-Host $SourceBranch
$tspFiles = @()
if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $tspFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).FullName -replace "$($pwd.Path)/"
}
else {
  $tspFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff "$TargetBranch"..."$SourceBranch" -- --name-only | Where-Object {$_.StartsWith('specification')}
}

$typeSpecFolders = @()
foreach ($file in $tspFiles) {
  $file -match 'specification\/[^\/]*\/' | out-null
  $typeSpecFolders += $matches[0]
}
$typeSpecFolders = $typeSpecFolders | Select-Object -Unique

return $typeSpecFolders
