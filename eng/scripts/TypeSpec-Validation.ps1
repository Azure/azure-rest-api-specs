[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false,
  [switch]$DryRun = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$TargetCommitish = "HEAD",
  [int]$FolderCount = 0
)

. $PSScriptRoot/Logging-Functions.ps1
. $PSScriptRoot/Suppressions-Functions.ps1

function ValidateService($service, $typeSpecFolders) {

}

$typespecFolders, $checkedAll = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" `
  -BaseCommitish:$BaseCommitish `
  -TargetCommitish:$TargetCommitish `
  -CheckAll:$CheckAll

if ($FolderCount) { 
  $typespecFolders = $typespecFolders[0..($FolderCount - 1)]
}

# Group typespec folders by "service" (the first folder in the path)
# Example: 'specification/ai/DocumentIntelligence' -> 'ai'

$serviceFolders = $typespecFolders | Group-Object -Property { Split-Path $_ -Parent }

$typespecFoldersWithFailures = @()
if ($typespecFolders) {
  # TODO: Does this do anything? 
  # $typespecFolders = $typespecFolders.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)

  $serviceFolders | ForEach-Object -Parallel {
    $service = $_.Name
    $typespecFolders = $_.Group

    $result = @{
      Service = $service;
      Suppressed = @();
      Logs = @{};
      Errors = @{};
    }
  
    foreach ($typespecFolder in $typespecFolders) {
      # LogGroupStart "Validating $typespecFolder"
  
      if ($checkedAll) {
        $suppression = Get-Suppression "TypeSpecValidationAll" $typespecFolder
        if ($suppression) {
          $reason = $suppression["reason"] ?? "<no reason specified>"
          $result["Suppressed"] += "Suppressed: $typespecFolder $reason"
          continue
        }
      }
  
      $result.Logs[$typespecFolder] = @("npm exec --no -- tsv $typespecFolder")
  
      if ($DryRun) {
        continue
      }
  
      $result.Logs[$typespecFolder] += npm exec --no -- tsv $typespecFolder 2>&1
      if ($LASTEXITCODE) {
        $errorString = "TypeSpec Validation failed for project $typespecFolder run the following command locally to validate."
        $errorString += "`n > npm ci"
        $errorString += "`n > npx tsv $typespecFolder"
        $errorString += "`nFor more detailed docs see https://aka.ms/azsdk/specs/typespec-validation"
  
        $result.Errors[$typespecFolder] = $errorString
      }
  
      if ($GitClean) {
        # TODO: Ensure this is proper and correct. Can something in service A
        # affect files in Service B? Can they impact files in the root? Worth 
        # examining.
        git restore $typespecFolder | Out-Null
        git clean -df $typespecFolder | Out-Null
      }
    }
  
    # Return results
    return $result
  } | ForEach-Object { 
    # TODO: MORE LOGGING
    LogGroupStart "Validation for $($_.Service)"
    if ($_.Suppressed.Count) { 
      Write-Host "Suppressed: "
      foreach ($item in $_.Suppressed) {
        Write-Host " > $item"
      }
    }
    foreach ($item in $_.Logs.GetEnumerator()) {
      LogGroupStart $item.Key
      $item.Value | Write-Host
    }
    if($_.Errors.Count) { 
      LogError "Errors:"
      foreach ($item in $_.Errors.GetEnumerator()) {
        $typespecFoldersWithFailures += $item.Key
        $item.Value | Write-Host
      }
    }

    LogGroupEnd
  }
} else {
  if ($CheckAll) {
    LogError "TypeSpec Validation - All did not validate any specs"
    LogJobFailure
    exit 1
  }
}

if ($typespecFoldersWithFailures.Count -gt 0) {
  LogInfo "TypeSpec Validation failed for some folder to fix run and address any errors:"
  LogInfo " > npm ci"
  foreach ($typespecFolderWithFailure in $typespecFoldersWithFailures) {
    LogInfo " > npx tsv $typespecFolderWithFailure"
  }
  LogInfo "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation"
  LogJobFailure
  exit 1
}

exit 0
