# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

[CmdletBinding()]
param([string]$PipelineText)

BeforeAll {
    Set-StrictMode -Version 4
    $ErrorActionPreference = 'Stop'
    if (-not $PipelineText) {
        $PipelineText = Get-Content (Join-Path $PSScriptRoot '../../pipelines/release-plan.yml') -Raw
    }
    $match = [regex]::Match($PipelineText, '(?ms)^              inlineScript: \|\r?\n(?<script>.*?)(?=^          - )')
    if (-not $match.Success) { throw 'Release-plan pipeline script not found.' }
    $pipelineScript = [regex]::Replace($match.Groups['script'].Value, '(?m)^                ', '')

    function pnpm {
        param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Arguments)
        throw 'The test must mock pnpm; no release-plan automation may run.'
    }

    function Invoke-TestPipelineStep {
        param(
            [string]$CommitSha = ('b' * 40),
            [string]$SourceBranch = 'refs/heads/main',
            [int]$PrNumber = 0,
            [int]$ReleasePlanId = 0
        )
        $script = $pipelineScript.Replace('${{ parameters.PrNumber }}', "$PrNumber").
            Replace('${{ parameters.ReleasePlanId }}', "$ReleasePlanId").
            Replace('${{ parameters[''Test-release-Plan''] }}', 'true').
            Replace('$(Build.SourceVersion)', $CommitSha).
            Replace('$(Build.SourceBranch)', $SourceBranch).
            Replace('$(Build.Repository.Name)', 'Azure/azure-rest-api-specs').
            Replace('$(Build.SourcesDirectory)', 'test-checkout').
            Replace('$(Build.ArtifactStagingDirectory)', 'test-artifacts')
        return & ([scriptblock]::Create($script))
    }
}

Describe 'Release-plan pipeline source SHA' {
    BeforeEach {
        Mock pnpm { return $Arguments }
        Mock git { throw 'Pipeline must not derive its SHA from local Git.' }
    }

    AfterEach {
        Should -Invoke git -Times 0 -Exactly
    }

    It 'uses the triggering main SHA with PR number <PrNumber>' -ForEach @(
        @{ PrNumber = 0 },
        @{ PrNumber = 123 }
    ) {
        $arguments = @(Invoke-TestPipelineStep -PrNumber $PrNumber)
        $arguments[0..1] | Should -Be @('exec', 'create-release-plan')
        $arguments[$arguments.IndexOf('--commit-sha') + 1] | Should -Be ('b' * 40)
        if ($PrNumber) {
            $arguments[$arguments.IndexOf('--pr-number') + 1] | Should -Be "$PrNumber"
        } else {
            $arguments | Should -Not -Contain '--pr-number'
        }
        Should -Invoke pnpm -Times 1 -Exactly
    }

    It 'rejects an absent or invalid triggering SHA: <CommitSha>' -ForEach @(
        @{ CommitSha = '' },
        @{ CommitSha = 'HEAD' },
        @{ CommitSha = 'abc123' },
        @{ CommitSha = ('z' * 40) }
    ) {
        { Invoke-TestPipelineStep -CommitSha $CommitSha } | Should -Throw '*Build.SourceVersion*'
        Should -Invoke pnpm -Times 0 -Exactly
    }

    It 'rejects a non-main source branch: <SourceBranch>' -ForEach @(
        @{ SourceBranch = 'refs/heads/feature' },
        @{ SourceBranch = 'refs/pull/123/merge' }
    ) {
        { Invoke-TestPipelineStep -SourceBranch $SourceBranch } | Should -Throw '*main branch*'
        Should -Invoke pnpm -Times 0 -Exactly
    }

    It 'keeps ID-only retrieval independent of the checkout SHA' {
        $arguments = @(Invoke-TestPipelineStep -ReleasePlanId 9001 -CommitSha '' -SourceBranch 'refs/heads/feature')
        $arguments[$arguments.IndexOf('--release-plan-id') + 1] | Should -Be '9001'
        $arguments | Should -Not -Contain '--commit-sha'
        Should -Invoke pnpm -Times 1 -Exactly
    }
}

Describe 'Checkout-only SHA probe' {
    BeforeAll {
        $probePath = Join-Path $PSScriptRoot '../Test-ReleasePlan-Sha.ps1'
    }

    BeforeEach {
        $probeEnvironment = @{
            BUILD_DEFINITIONNAME = 'TEST - release-plan SHA handoff 16848'
            BUILD_SOURCEVERSION = ('b' * 40)
            BUILD_SOURCEBRANCH = 'refs/pull/46689/head'
            BUILD_SOURCESDIRECTORY = $TestDrive
            BUILD_ARTIFACTSTAGINGDIRECTORY = (Join-Path $TestDrive 'evidence')
            BUILD_BUILDID = '123'
            SYSTEM_DEFINITIONID = '8413'
            SHA_TEST_CONFIG_PATH = 'specification/contoso/tspconfig.yaml'
            SHA_TEST_API_VERSION = '2024-01-01'
            SHA_TEST_SDK_RELEASE_TYPE = 'beta'
            SHA_TEST_PLAN_ID = '9001'
            SHA_TEST_TRIGGER_SOURCE = 'sdk-release'
            SHA_TEST_CREATE_PR_INPUT = 'true'
        }
        $originalEnvironment = @{}
        foreach ($name in $probeEnvironment.Keys) {
            $originalEnvironment[$name] = [Environment]::GetEnvironmentVariable($name)
            [Environment]::SetEnvironmentVariable($name, $probeEnvironment[$name])
        }
        Mock git { $global:LASTEXITCODE = 0; return ('b' * 40) }
    }

    AfterEach {
        foreach ($name in $originalEnvironment.Keys) {
            [Environment]::SetEnvironmentVariable($name, $originalEnvironment[$name])
        }
    }

    It 'records the actual SHA and classifies <SourceBranch> without generation' -ForEach @(
        @{ SourceBranch = 'refs/pull/46689/head'; Draft = $true },
        @{ SourceBranch = 'refs/heads/main'; Draft = $false }
    ) {
        $env:BUILD_SOURCEBRANCH = $SourceBranch
        & $probePath
        $evidence = Get-Content (Join-Path $env:BUILD_ARTIFACTSTAGINGDIRECTORY 'sha-handoff.json') -Raw | ConvertFrom-Json
        $evidence.checkedOutHead | Should -Be $env:BUILD_SOURCEVERSION
        $evidence.wouldOpenAsDraft | Should -Be $Draft
        $evidence.sdkGenerationExecuted | Should -BeFalse
        $evidence.publishingExecuted | Should -BeFalse
        $evidence.notificationExecuted | Should -BeFalse
    }

    It 'rejects a different checkout instead of reporting success' {
        Mock git { $global:LASTEXITCODE = 0; return ('a' * 40) }
        { & $probePath } | Should -Throw '*does not match*'
    }

    It 'rejects an unrelated pipeline before inspecting the checkout' {
        $env:BUILD_DEFINITIONNAME = 'SDK Generation - Java'
        { & $probePath } | Should -Throw '*dedicated checkout-only test pipeline*'
        Should -Invoke git -Times 0 -Exactly
    }
}
