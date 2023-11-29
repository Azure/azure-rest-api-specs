function Test-SupportsDevOpsLogging() {
  return ($null -ne $env:SYSTEM_TEAMPROJECTID)
}

function LogInfo {
  Write-Host "$args"
}

function LogWarning {
  if (Test-SupportsDevOpsLogging) {
    Write-Host ("##vso[task.LogIssue type=warning;]$args" -replace "`n", "%0D%0A")
  }
  else {
    Write-Warning "$args"
  }
}

function LogErrorForFile($file, $errorString)
{
  if (Test-SupportsDevOpsLogging) {
    Write-Host ("##vso[task.logissue type=error;sourcepath=$file;linenumber=1;columnnumber=1;]$errorString" -replace "`n", "%0D%0A")
  }
  else {
    Write-Error "[Error in file $file]$errorString"
  }
}
function LogError {
  if (Test-SupportsDevOpsLogging) {
    Write-Host ("##vso[task.LogIssue type=error;]$args" -replace "`n", "%0D%0A")
  }
  else {
    Write-Error "$args"
  }
}

function LogDebug {
  if (Test-SupportsDevOpsLogging) {
    Write-Host "[debug]$args"
  }
  else {
    Write-Debug "$args"
  }
}

function LogGroupStart() {
  if (Test-SupportsDevOpsLogging) {
    Write-Host "##[group]$args"
  }
}

function LogGroupEnd() {
  if (Test-SupportsDevOpsLogging) {
    Write-Host "##[endgroup]"
  }
}

function LogJobFailure() {
  if (Test-SupportsDevOpsLogging) {
    Write-Host "##vso[task.complete result=Failed;]"
  }
}
