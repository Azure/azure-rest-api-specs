<#
.SYNOPSIS
    Compatibility shim. Runs the ARM API Reviewer eval suite via the shared runner.

.DESCRIPTION
    The runner was hoisted to `.github/skills/evals/run-evals.ps1` when the
    data-plane suite was added, so both suites share one implementation instead
    of maintaining two ~600-line copies. This shim keeps the documented
    `arm-api-reviewer/run-evals.ps1` entry point working and forwards every
    parameter unchanged.

    Prefer calling the shared runner directly:
      ..\run-evals.ps1 -SuiteDir arm-api-reviewer

.EXAMPLE
    .\run-evals.ps1

.EXAMPLE
    .\run-evals.ps1 -Suite "eval-true-negatives" -Repeat 3
#>

[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Forwarded
)

$shared = Join-Path (Split-Path $PSScriptRoot -Parent) "run-evals.ps1"

if (-not (Test-Path $shared)) {
    throw "Shared eval runner not found at $shared"
}

& $shared -SuiteDir "arm-api-reviewer" @Forwarded
exit $LASTEXITCODE
