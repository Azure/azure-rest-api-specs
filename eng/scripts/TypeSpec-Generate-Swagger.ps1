[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$TargetCommitish = "HEAD"
)

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" -BaseCommitish:$BaseCommitish -TargetCommitish:$TargetCommitish -CheckAll:$CheckAll
if ($typespecFolders) {
    $typespecFolders = $typespecFolders.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)
    foreach ($typespecFolder in $typespecFolders) {
        Push-Location $typespecFolder
        npx tsp compile .
        Pop-Location
    }
  } else {
    if ($CheckAll) {
      LogError "TypeSpec Generate Swagger - All did not generate any swaggers"
      LogJobFailure
      exit 1
    }
  }