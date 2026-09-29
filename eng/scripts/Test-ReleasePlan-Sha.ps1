# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

<#
.SYNOPSIS
Checks a queued source SHA against the actual agent checkout without generating or publishing SDKs.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version 4
$ErrorActionPreference = 'Stop'

if ($env:BUILD_DEFINITIONNAME -ne 'TEST - release-plan SHA handoff 16848') {
    throw 'This probe may run only in its dedicated checkout-only test pipeline.'
}
$expectedSha = $env:BUILD_SOURCEVERSION
if ($expectedSha -notmatch '^[0-9a-fA-F]{40}$') {
    throw 'Build.SourceVersion must be a full commit SHA.'
}
$actualSha = git -C $env:BUILD_SOURCESDIRECTORY rev-parse HEAD
if ($LASTEXITCODE -ne 0 -or $actualSha.Trim() -ine $expectedSha) {
    throw "Checked-out HEAD does not match queued SourceVersion $expectedSha."
}
if ([string]::IsNullOrWhiteSpace($env:SHA_TEST_API_VERSION)) {
    throw 'The API version was not forwarded to the test pipeline.'
}
if ($env:SHA_TEST_SDK_RELEASE_TYPE -notin @('beta', 'stable')) {
    throw 'The SDK release type was not forwarded to the test pipeline.'
}

# This is the existing SDK pipeline classification predicate, evaluated without PR or label writes.
$wouldOpenAsDraft = $env:BUILD_SOURCEBRANCH -ne 'refs/heads/main' -or
    -not $env:SHA_TEST_TRIGGER_SOURCE.EndsWith('-release', [StringComparison]::Ordinal)
$evidence = [ordered]@{
    testOnly = $true
    probeRevision = 'snapshot-b'
    buildId = $env:BUILD_BUILDID
    definitionId = $env:SYSTEM_DEFINITIONID
    sourceBranch = $env:BUILD_SOURCEBRANCH
    sourceVersion = $expectedSha
    checkedOutHead = $actualSha.Trim()
    configPath = $env:SHA_TEST_CONFIG_PATH
    apiVersion = $env:SHA_TEST_API_VERSION
    sdkReleaseType = $env:SHA_TEST_SDK_RELEASE_TYPE
    releasePlanWorkItemId = $env:SHA_TEST_PLAN_ID
    createPullRequestInput = $env:SHA_TEST_CREATE_PR_INPUT
    wouldOpenAsDraft = $wouldOpenAsDraft
    sdkGenerationExecuted = $false
    publishingExecuted = $false
    notificationExecuted = $false
}
$artifactPath = Join-Path $env:BUILD_ARTIFACTSTAGINGDIRECTORY 'sha-handoff.json'
New-Item -ItemType Directory -Force -Path $env:BUILD_ARTIFACTSTAGINGDIRECTORY | Out-Null
$evidence | ConvertTo-Json | Set-Content -LiteralPath $artifactPath -Encoding utf8
Write-Output ($evidence | ConvertTo-Json -Compress)
Write-Output 'Verified: queued SourceVersion equals the actual Git checkout; no SDK/PR/release/email actions ran.'
