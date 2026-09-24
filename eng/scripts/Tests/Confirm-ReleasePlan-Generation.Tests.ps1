# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.
# Offline tests for the release-plan generation gate and its pipeline ordering.

#Requires -Version 7.0
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }

BeforeAll {
    Set-StrictMode -Version 4
    $confirmationScript = Join-Path $PSScriptRoot '../Confirm-ReleasePlan-Generation.ps1'
    $templatePath = Join-Path $PSScriptRoot '../../pipelines/templates/stages/archetype-spec-gen-sdk.yml'
}

Describe 'Confirm-ReleasePlan-Generation command bridge' {
    BeforeAll {
        # A function, not an executable: every invocation explicitly supplies -AzsdkPath.
        function fakeazsdk {
            throw 'The offline azsdk function must be mocked.'
        }

        function Assert-AzsdkArguments {
            param([string[]] $ExpectedArguments)

            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            [string[]] $fakeAzsdkState.Arguments | Should -BeExactly $ExpectedArguments
        }

        $validationArguments = @(
            'spec-workflow', 'validate-sdk-run',
            '--workitem-id', '12345', '--pipeline-run', '67890',
            '--language', 'net', '--output', 'json'
        )
    }

    BeforeEach {
        $previousExitCode = Get-Variable LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue
        $hadExitCode = $null -ne $previousExitCode
        $savedExitCode = if ($hadExitCode) { $previousExitCode.Value } else { $null }
        # Functions do not set LASTEXITCODE automatically, unlike native commands.
        $global:LASTEXITCODE = 0
        # Explicit nulls isolate argument tests; omitted CLI fields are tested separately.
        # Share a reference object: script scope changes when the gate calls the Pester mock.
        $fakeAzsdkState = @{
            ExitCode = 0
            Arguments = @()
            Returned = $false
            Output = '{"status":"Success","response_error":null,"response_errors":null}'
        }
        $gateParameters = @{
            ReleasePlanWorkItemId = 12345
            BuildId = 67890
            SdkRepoName = 'azure-sdk-for-net'
            AzsdkPath = 'fakeazsdk'
        }

        Mock fakeazsdk {
            $fakeAzsdkState.Arguments = @($args)
            $global:LASTEXITCODE = $fakeAzsdkState.ExitCode
            $fakeAzsdkState.Returned = $true
            return $fakeAzsdkState.Output
        }
        Mock Write-Host {}
    }

    AfterEach {
        if ($hadExitCode) {
            $global:LASTEXITCODE = $savedExitCode
        } else {
            Remove-Variable LASTEXITCODE -Scope Global -ErrorAction SilentlyContinue
        }
    }

    It 'validates the work item and captured build using the <Language> repository mapping' -ForEach @(
        @{ Repository = 'azure-sdk-for-net'; Language = 'net' }
        @{ Repository = 'azure-sdk-for-js'; Language = 'js' }
        @{ Repository = 'azure-sdk-for-java'; Language = 'java' }
        @{ Repository = 'azure-sdk-for-python'; Language = 'python' }
        @{ Repository = 'azure-sdk-for-go'; Language = 'go' }
    ) {
        $gateParameters.SdkRepoName = $Repository

        & $confirmationScript @gateParameters

        Assert-AzsdkArguments @(
            'spec-workflow', 'validate-sdk-run',
            '--workitem-id', '12345', '--pipeline-run', '67890',
            '--language', $Language, '--output', 'json'
        )
    }

    It 'does not forward a PR URL or completion flags in validation mode' {
        $gateParameters.PullRequestUrl = 'https://github.com/Azure/azure-sdk-for-net/pull/123'

        & $confirmationScript @gateParameters

        Assert-AzsdkArguments $validationArguments
        $fakeAzsdkState.Arguments | Should -Not -Contain '--status'
        $fakeAzsdkState.Arguments | Should -Not -Contain '--sdk-pr'
    }

    It 'completes with <RequestedStatus> and preserves the PR URL as one argument' -ForEach @(
        @{ RequestedStatus = 'draft' }
        @{ RequestedStatus = 'ready for review' }
    ) {
        $gateParameters.SdkRepoName = 'azure-sdk-for-js'
        $gateParameters.Status = $RequestedStatus
        $gateParameters.PullRequestUrl = 'https://github.com/Azure/azure-sdk-for-js/pull/123'

        & $confirmationScript @gateParameters

        Assert-AzsdkArguments @(
            'spec-workflow', 'complete-sdk-run',
            '--workitem-id', '12345', '--pipeline-run', '67890',
            '--language', 'js', '--output', 'json',
            '--status', $RequestedStatus,
            '--sdk-pr', 'https://github.com/Azure/azure-sdk-for-js/pull/123'
        )
    }

    It 'reports <RequestedStatus> without passing an empty --sdk-pr argument' -ForEach @(
        @{ RequestedStatus = 'Failed to generate SDK.' }
        @{ RequestedStatus = 'No changes' }
    ) {
        $gateParameters.Status = $RequestedStatus
        $gateParameters.PullRequestUrl = ''

        & $confirmationScript @gateParameters

        Assert-AzsdkArguments @(
            'spec-workflow', 'complete-sdk-run',
            '--workitem-id', '12345', '--pipeline-run', '67890',
            '--language', 'net', '--output', 'json',
            '--status', $RequestedStatus
        )
        $fakeAzsdkState.Arguments | Should -Not -Contain '--sdk-pr'
    }

    It 'rejects <Case> BuildId before invoking the CLI' -ForEach @(
        @{ Case = 'zero'; InvalidBuildId = 0 }
        @{ Case = 'negative'; InvalidBuildId = -1 }
        @{ Case = 'nonnumeric'; InvalidBuildId = 'not-a-build-id' }
        @{ Case = 'out-of-range'; InvalidBuildId = [long]2147483648 }
    ) {
        $gateParameters.BuildId = $InvalidBuildId

        { & $confirmationScript @gateParameters } | Should -Throw

        Should -Invoke fakeazsdk -Times 0 -Exactly -Scope It
        Should -Invoke Write-Host -Times 0 -Exactly -Scope It
    }

    It 'uses the captured build ID, not caller SHA variables, in <Mode> mode' -ForEach @(
        @{ Mode = 'validation'; RequestedStatus = ''; Command = 'validate-sdk-run' }
        @{ Mode = 'completion'; RequestedStatus = 'No changes'; Command = 'complete-sdk-run' }
    ) {
        # Snapshot comparison belongs to the CLI. The bridge must not substitute caller SHAs.
        $capturedSha = 'a' * 40
        $callerSha = 'b' * 40
        $savedSourceVersion = [Environment]::GetEnvironmentVariable('BUILD_SOURCEVERSION')
        $savedSpecCommit = [Environment]::GetEnvironmentVariable('SPECREPOCOMMIT')
        try {
            [Environment]::SetEnvironmentVariable('BUILD_SOURCEVERSION', $callerSha)
            [Environment]::SetEnvironmentVariable('SPECREPOCOMMIT', $callerSha)
            $gateParameters.Status = $RequestedStatus
            $fakeAzsdkState.Output = @{
                status = 'Success'
                response_error = $null
                response_errors = $null
                details = @("Validated build 67890 snapshot at spec commit $capturedSha.")
            } | ConvertTo-Json

            & $confirmationScript @gateParameters

            $expectedArguments = @(
                'spec-workflow', $Command,
                '--workitem-id', '12345', '--pipeline-run', '67890',
                '--language', 'net', '--output', 'json'
            )
            if ($RequestedStatus) {
                $expectedArguments += @('--status', $RequestedStatus)
            }
            Assert-AzsdkArguments $expectedArguments
            $fakeAzsdkState.Arguments | Should -Not -Contain $callerSha
            $fakeAzsdkState.Arguments | Should -Not -Contain $capturedSha
        } finally {
            [Environment]::SetEnvironmentVariable('BUILD_SOURCEVERSION', $savedSourceVersion)
            [Environment]::SetEnvironmentVariable('SPECREPOCOMMIT', $savedSpecCommit)
        }
    }

    Context '<Mode> response handling' -ForEach @(
        @{ Mode = 'validation'; RequestedStatus = '' }
        @{ Mode = 'completion'; RequestedStatus = 'No changes' }
    ) {
        BeforeEach {
            $gateParameters.Status = $RequestedStatus
        }

        It 'accepts multiline success JSON and empty error collections' {
            $fakeAzsdkState.Output = @(
                '{'
                '  "status": "Success",'
                '  "response_error": "",'
                '  "response_errors": []'
                '}'
            )

            { & $confirmationScript @gateParameters } | Should -Not -Throw

            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            Should -Invoke Write-Host -Times 1 -Exactly -Scope It
        }

        It 'accepts CLI success JSON with omitted optional error fields' {
            # CommandResponse omits response_error and response_errors when they are null.
            $fakeAzsdkState.Output = '{"status":"Success","operation_status":"Succeeded","details":[]}'

            { & $confirmationScript @gateParameters } | Should -Not -Throw

            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            Should -Invoke Write-Host -Times 1 -Exactly -Scope It
        }

        It 'fails on native exit code <ExitCode> even when stdout reports success' -ForEach @(
            @{ ExitCode = 1 }
            @{ ExitCode = 42 }
        ) {
            $fakeAzsdkState.ExitCode = $ExitCode

            { & $confirmationScript @gateParameters } | Should -Throw '*SDK generation build 67890 no longer matches release plan 12345*'

            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            Should -Invoke Write-Host -Times 0 -Exactly -Scope It
        }

        It 'fails on <Case> JSON despite a zero exit code' -ForEach @(
            @{ Case = 'failed status'; Output = '{"status":"Failed","response_error":null,"response_errors":null}' }
            @{ Case = 'empty status'; Output = '{"status":"","response_error":null,"response_errors":null}' }
            @{ Case = 'a response error'; Output = '{"status":"Success","response_error":"Snapshot changed","response_errors":null}' }
            @{ Case = 'response errors'; Output = '{"status":"Success","response_error":null,"response_errors":["Snapshot changed","PR mismatch"]}' }
        ) {
            $fakeAzsdkState.Output = $Output

            { & $confirmationScript @gateParameters } | Should -Throw '*SDK generation validation did not succeed for build 67890*'

            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            Should -Invoke Write-Host -Times 0 -Exactly -Scope It
        }

        It 'fails closed on <Case> output' -ForEach @(
            @{ Case = 'malformed JSON'; Output = '{"status":"Success"'; ExpectedError = '*Conversion from JSON failed*' }
            @{ Case = 'non-JSON text'; Output = 'CLI did not return JSON'; ExpectedError = '*Conversion from JSON failed*' }
            @{ Case = 'empty'; Output = ''; ExpectedError = '*' }
        ) {
            $fakeAzsdkState.Output = $Output

            { & $confirmationScript @gateParameters } | Should -Throw $ExpectedError

            $fakeAzsdkState.Returned | Should -BeTrue
            Should -Invoke fakeazsdk -Times 1 -Exactly -Scope It
            Should -Invoke Write-Host -Times 0 -Exactly -Scope It
        }
    }
}

Describe 'Release-plan generation pipeline structure' {
    BeforeAll {
        $templateLines = @(Get-Content -LiteralPath $templatePath)
        $templateText = $templateLines -join "`n"

        # Inspect indentation-bounded steps without expanding or executing any pipeline YAML.
        function Get-GenerationStep {
            param([string] $Marker)

            $matchingLines = @(for ($i = 0; $i -lt $templateLines.Count; $i++) {
                if ($templateLines[$i].Contains($Marker)) { $i }
            })
            if ($matchingLines.Count -ne 1) {
                throw "Expected exactly one pipeline step containing '$Marker'; found $($matchingLines.Count)."
            }

            $start = $matchingLines[0]
            while ($start -ge 0 -and $templateLines[$start] -notmatch '^ *- (task|template|pwsh|script):') {
                $start--
            }
            if ($start -lt 0) { throw "No pipeline step starts before '$Marker'." }
            $indent = $templateLines[$start].Length - $templateLines[$start].TrimStart().Length
            $end = $start + 1
            while ($end -lt $templateLines.Count) {
                $line = $templateLines[$end]
                if ($line.Trim() -and -not $line.TrimStart().StartsWith('#') -and
                    ($line.Length - $line.TrimStart().Length) -le $indent) { break }
                $end++
            }
            $parentLine = ''
            for ($i = $start - 1; $i -ge 0; $i--) {
                $line = $templateLines[$i]
                if ($line.Trim() -and -not $line.TrimStart().StartsWith('#') -and
                    ($line.Length - $line.TrimStart().Length) -lt $indent) {
                    $parentLine = $line.Trim()
                    break
                }
            }
            return @{
                Index = $start
                Text = $templateLines[$start..($end - 1)] -join "`n"
                Parent = $parentLine
            }
        }

        $steps = @{
            Install = Get-GenerationStep 'template: /eng/common/pipelines/templates/steps/install-azsdk-cli.yml'
            Checkout = Get-GenerationStep 'template: /eng/common/pipelines/templates/steps/sparse-checkout.yml'
            Validate = Get-GenerationStep 'displayName: "Validate generation snapshot before publishing SDK changes"'
            Push = Get-GenerationStep 'template: /eng/common/pipelines/templates/steps/git-push-changes.yml'
            PullRequest = Get-GenerationStep 'displayName: Create pull request'
            NoChanges = Get-GenerationStep 'displayName: "Record unchanged SDK generation"'
            PullRequestUrl = Get-GenerationStep 'displayName: "Set pull request URL variable"'
            Failure = Get-GenerationStep 'displayName: "Set pull request generation failed status variable"'
            Complete = Get-GenerationStep 'displayName: Link current generation result to release plan'
            AutoRelease = Get-GenerationStep 'displayName: Add auto-release label'
        }
    }

    It 'installs azsdk for nonzero release-plan IDs as well as Rust generation' {
        $expectedCondition = 'and(succeeded(), or(contains(variables[''SdkRepoName''], ''rust''), ne(''${{ parameters.ReleasePlanWorkItemId }}'', ''0'')))'
        $steps.Install.Text | Should -Match ([regex]::Escape("Condition: $expectedCondition"))
        $steps.Install.Text | Should -Match ([regex]::Escape('SourceRootPath: $(SpecRepoDirectory)'))
        $steps.Install.Index | Should -BeLessThan $steps.Validate.Index
    }

    It 'pins the spec checkout to the captured build source version' {
        $templateText | Should -Match '(?m)^\s*- name: SpecRepoCommit\n\s+value: \$\(Build\.SourceVersion\)\s*$'
        $steps.Checkout.Text | Should -Match '(?m)Name: \$\(SpecRepoOwner\)/\$\(SpecRepoName\)\n\s+Commitish: \$\(SpecRepoCommit\)\n\s+WorkingDirectory: \$\(SpecRepoDirectory\)'
        $steps.Checkout.Index | Should -BeLessThan $steps.Install.Index
    }

    It 'guards <Step> on a nonzero release-plan ID' -ForEach @(
        @{ Step = 'Validate' }
        @{ Step = 'Complete' }
    ) {
        $steps[$Step].Parent | Should -BeExactly '- ${{ if ne(parameters.ReleasePlanWorkItemId, 0) }}:'
    }

    It 'runs <Step> from the pinned spec checkout using work-item and build IDs only' -ForEach @(
        @{ Step = 'Validate' }
        @{ Step = 'Complete' }
    ) {
        # Rollout requires a source/template commit containing this helper, not just a new CLI.
        $stepText = $steps[$Step].Text
        $stepText | Should -Match 'task: AzureCLI@2'
        $stepText | Should -Match 'scriptType: pscore'
        $stepText | Should -Match 'scriptLocation: scriptPath'
        $stepText | Should -Match ([regex]::Escape('scriptPath: $(SpecRepoDirectory)/eng/scripts/Confirm-ReleasePlan-Generation.ps1'))
        $stepText | Should -Match ([regex]::Escape('-ReleasePlanWorkItemId ${{ parameters.ReleasePlanWorkItemId }}'))
        $stepText | Should -Match ([regex]::Escape('-BuildId $(Build.BuildId)'))
        $stepText | Should -Match '-SdkRepoName "?\$\(SdkRepoName\)"?'
        $stepText | Should -Not -Match '(?i)-(SpecCommit(?:Sha)?|SpecRepoCommit|SourceVersion|SourceCommit|Commit(?:Sha)?)\b'
        $stepText | Should -Not -Match 'Build\.SourceVersion'
    }

    It 'validates before git push and PR creation without completion arguments' {
        $steps.Validate.Index | Should -BeLessThan $steps.Push.Index
        $steps.Validate.Index | Should -BeLessThan $steps.PullRequest.Index
        $steps.Validate.Text | Should -Not -Match '-(Status|PullRequestUrl)\b'
    }

    It 'does not downgrade <Step> failures with continueOnError' -ForEach @(
        @{ Step = 'Validate' }
        @{ Step = 'Complete' }
    ) {
        $steps[$Step].Text | Should -Not -Match '(?m)^\s*continueOnError:'
    }

    It 'records the PR URL and status before completing the captured build' {
        $steps.PullRequest.Index | Should -BeLessThan $steps.PullRequestUrl.Index
        $steps.PullRequestUrl.Index | Should -BeLessThan $steps.Complete.Index
        $steps.Complete.Text | Should -Match ([regex]::Escape('-PullRequestUrl "$(PullRequestUrl)"'))
        $steps.Complete.Text | Should -Match ([regex]::Escape('-Status "$(SdkPrStatus)"'))
    }

    It 'records no-change and failed outcomes before completion without requiring success' {
        $steps.NoChanges.Index | Should -BeLessThan $steps.Complete.Index
        $steps.NoChanges.Text | Should -Match ([regex]::Escape('variable=SdkPrStatus]No changes'))
        $steps.Failure.Index | Should -BeLessThan $steps.Complete.Index
        $steps.Failure.Text | Should -Match 'condition: failed\(\)'
        $steps.Failure.Text | Should -Match '\$prUrl = ""'
        $steps.Failure.Text | Should -Match 'Failed to generate SDK\.'
        $steps.Complete.Text | Should -Match ([regex]::Escape('condition: not(endsWith(variables[''SdkRepoName''], ''-pr''))'))
    }

    It 'completes successfully before an auto-release label can be applied' {
        $steps.Complete.Index | Should -BeLessThan $steps.AutoRelease.Index
        $steps.AutoRelease.Text | Should -Match 'condition: and\(succeeded\(\),'
        $steps.AutoRelease.Text | Should -Match ([regex]::Escape('-Labels "auto-release"'))
    }
}

Describe 'Generation gate PowerShell syntax' {
    It 'parses the production script with the real PowerShell parser' {
        $tokens = $null
        $parseErrors = $null
        $ast = [System.Management.Automation.Language.Parser]::ParseFile(
            $confirmationScript, [ref] $tokens, [ref] $parseErrors)

        $parseErrors | Should -BeNullOrEmpty
        $ast | Should -BeOfType ([System.Management.Automation.Language.ScriptBlockAst])
    }
}