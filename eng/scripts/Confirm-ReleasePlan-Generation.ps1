# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [ValidateRange(1, [int]::MaxValue)]
  [int] $ReleasePlanWorkItemId,
  [Parameter(Mandatory = $true)]
  [ValidateRange(1, [int]::MaxValue)]
  [int] $BuildId,
  [Parameter(Mandatory = $true)]
  [ValidateSet('azure-sdk-for-net', 'azure-sdk-for-java', 'azure-sdk-for-js', 'azure-sdk-for-python', 'azure-sdk-for-go')]
  [string] $SdkRepoName,
  [string] $PullRequestUrl = '',
  [string] $Status = '',
  [string] $AzsdkPath = $env:AZSDK
)

Set-StrictMode -Version 4
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($AzsdkPath)) {
  $AzsdkPath = 'azsdk'
}
$command = if ($Status) { 'complete-sdk-run' } else { 'validate-sdk-run' }
$cliArgs = @(
  'spec-workflow', $command,
  '--workitem-id', $ReleasePlanWorkItemId,
  '--pipeline-run', $BuildId,
  '--language', $SdkRepoName.Replace('azure-sdk-for-', ''),
  '--output', 'json'
)
if ($Status) {
  $cliArgs += @('--status', $Status)
  if ($PullRequestUrl) {
    $cliArgs += @('--sdk-pr', $PullRequestUrl)
  }
}

$raw = & $AzsdkPath @cliArgs
if ($LASTEXITCODE -ne 0) {
  throw "SDK generation build $BuildId no longer matches release plan $ReleasePlanWorkItemId, or its result could not be saved. $($raw -join [Environment]::NewLine)"
}
$response = ($raw -join [Environment]::NewLine) | ConvertFrom-Json -AsHashtable
if ($response['status'] -ne 'Success' -or $response['response_error'] -or $response['response_errors']) {
  throw "SDK generation validation did not succeed for build $BuildId. $($raw -join [Environment]::NewLine)"
}
Write-Host ($raw -join [Environment]::NewLine)
