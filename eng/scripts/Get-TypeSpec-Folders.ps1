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
$osSlash = [IO.Path]::DirectorySeparatorChar
if ([string]::IsNullOrEmpty($TargetBranch) -or [string]::IsNullOrEmpty($SourceBranch)) {
  $tspFiles = (Get-ChildItem -path ./specification tspconfig.yaml -Recurse).FullName -replace [Regex]::Escape("$($pwd.Path)$osSlash")
}
else {
  Write-Host "git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {`$_.StartsWith('specification')}"
  $tspFiles = git -c core.quotepath=off -c i18n.logoutputencoding=utf-8 diff --name-only `"$TargetBranch...$SourceBranch`" -- | Where-Object {$_.StartsWith('specification')}
}

$typespecFolders = @()
foreach ($file in $tspFiles) {
  $file -match "specification\$osSlash[^\$osSlash]*\$osSlash" | out-null
  if ($matches) {
    $typespecFolders += (Get-ChildItem -path $matches[0] tspconfig.yaml -Recurse).Directory.FullName -replace "$($pwd.Path)$osSlash"
  }
}
$typespecFolders = $typespecFolders | Select-Object -Unique

return $typespecFolders
