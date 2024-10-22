[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false,
  [switch]$DryRun = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$TargetCommitish = "HEAD",
  [int]$FolderCount = 0,
  [int] $Parallelism = $env:TSV_PARALLELISM
)

. $PSScriptRoot/Logging-Functions.ps1
. $PSScriptRoot/Suppressions-Functions.ps1

if (!$Parallelism) { 
  $Parallelism = 1
}

$typespecFolders, $checkedAll = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" `
  -BaseCommitish:$BaseCommitish `
  -TargetCommitish:$TargetCommitish `
  -CheckAll:$CheckAll

# Use -FolderCount to do performance testing on Typespec-Validation.ps1 with 
# -CheckAll set to $true. This constrains the typeSpec folders to the first N 
# folders. 
if ($FolderCount) { 
  $typespecFolders = $typespecFolders[0..($FolderCount - 1)]
}

$typespecFoldersWithFailures = @()
if ($typespecFolders) {
  # Group typespec folders by "service" (the first folder in the path). This
  # parallel validation at the level of the service.
  # Example: 'specification/ai/DocumentIntelligence' -> 'specification/ai'.
  $serviceFolders = $typespecFolders | Group-Object -Property { 
    # "specification\ai\DocumentIntelligence" -> @("specification", "ai", "DocumentIntelligence")
    $splitPath = $_ -replace '\\', '/' -split '/'

    # @("specification", "ai", "DocumentIntelligence") -> "specification/ai"
    return $splitPath[0..1] -join '/'
  }
  
  Write-Host "Starting per-service parallel validation with parallelism: $Parallelism"

  $serviceFolders `
  | ForEach-Object -ThrottleLimit $Parallelism -Parallel {
    $service = $_.Name
    $typespecFolders = $_.Group

    $result = @{
      Service = $service;
      Suppressed = @();
      Logs = @{};
      Errors = @{};
    }
  
    foreach ($typespecFolder in $typespecFolders) {  
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
        # Clean at the level of the service because it's possible for items in 
        # the service folder to change files at the level of the service folder.
        git restore $service | Out-Null
        git clean -df $service | Out-Null
      }
    }
  
    # Return results
    return $result

  } | ForEach-Object {
    # Handle outputs (single-threaded)
    Write-Host "Validation for Service: $($_.Service):"
    if ($_.Suppressed.Count) { 
      Write-Host "Suppressions in $($_.Service): "
      foreach ($item in $_.Suppressed) {
        Write-Host " > $item"
      }
    }

    foreach ($item in $_.Logs.GetEnumerator()) {
      LogGroupStart "Validation for $($item.Key)"
      $item.Value | Write-Host
      LogGroupEnd
    }

    if($_.Errors.Count) {
      Write-Host "Errors in $($_.Service):"
      foreach ($item in $_.Errors.GetEnumerator()) {
        $typespecFoldersWithFailures += $item.Key
        LogError $item.Value
      }
    }
  }
} else {
  if ($CheckAll) {
    LogError "TypeSpec Validation - All did not validate any specs"
    LogJobFailure
    exit 1
  }
}

if ($typespecFoldersWithFailures.Count -gt 0) {
  LogInfo "TypeSpec Validation failed for some folders. To fix run and address any errors:"
  LogInfo " > npm ci"
  foreach ($typespecFolderWithFailure in $typespecFoldersWithFailures) {
    LogInfo " > npx tsv $typespecFolderWithFailure"
  }
  LogInfo "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation"
  LogJobFailure
  exit 1
}

exit 0
