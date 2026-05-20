<#
.SYNOPSIS
    Runs the ARM API Reviewer evaluation suite end-to-end.

.DESCRIPTION
    Single script to clone/update the evaluate (vally) framework, build it,
    run the full ARM API Reviewer eval suite, and report results.

    Prerequisites:
      - Node.js >= 20 and npm (https://nodejs.org/)
      - Git
      - VS Code with GitHub Copilot active (the executor uses Copilot agent sessions)

    The script will:
      1. Clone microsoft/evaluate (or pull latest if already cloned)
      2. Install dependencies and build
      3. Run the eval suite
      4. Print a pass/fail summary and open the results

.PARAMETER Suite
    Which suite to run. Default: "all" (28 stimuli across 11 eval files).
    Pass a specific eval file name (without path) to run one category, e.g. "eval-operations".

.PARAMETER Model
    Override the agent model. Default: use the model declared in each eval YAML.
    Example: "claude-sonnet-4.6" for faster iteration.

.PARAMETER JudgeModel
    Override the LLM judge model. Default: use the judge_model from eval YAML.

.PARAMETER Workers
    Number of concurrent stimulus sessions. Default: 1 (sequential -- most reliable).
    Increase to 3-5 if you have no other Copilot sessions open.

.PARAMETER Timeout
    Per-stimulus timeout in milliseconds. Default: 600000 (10 minutes).

.PARAMETER EvaluateRepo
    Path where microsoft/evaluate should be cloned. Default: sibling to azure-rest-api-specs.

.PARAMETER SkipBuild
    Skip the npm install + build step (use if evaluate is already built).

.PARAMETER ShowOutput
    Show full agent output during execution (passes --verbose to vally).

.EXAMPLE
    # Run everything with defaults (safest)
    .\run-evals.ps1

.EXAMPLE
    # Fast iteration: sonnet model, 3 workers
    .\run-evals.ps1 -Model "claude-sonnet-4.6" -Workers 3

.EXAMPLE
    # Run just the operations tests
    .\run-evals.ps1 -Suite "eval-operations"

.EXAMPLE
    # Skip rebuild if you already ran once
    .\run-evals.ps1 -SkipBuild

.EXAMPLE
    # Point to an existing evaluate clone
    .\run-evals.ps1 -EvaluateRepo "C:\repos\evaluate"
#>

[CmdletBinding()]
param(
    [string]$Suite = "all",
    [string]$Model = "",
    [string]$JudgeModel = "",
    [int]$Workers = 1,
    [int]$Timeout = 600000,
    [string]$EvaluateRepo = "",
    [switch]$SkipBuild,
    [switch]$ShowOutput
)

Set-StrictMode -Version Latest
# NOTE: We use "Continue" (not "Stop") because git, npm, and node all write
# progress/warnings to stderr. With "Stop", PowerShell treats any stderr
# output as a terminating error -- even "npm warn" or "Cloning into...".
$ErrorActionPreference = "Continue"

# Ensure console can handle UTF-8 output from vally (which may emit emoji)
$prevOutputEncoding = [Console]::OutputEncoding
$prevConsoleEncoding = $OutputEncoding
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}
$OutputEncoding = [System.Text.Encoding]::UTF8

# ---- Resolve paths -----------------------------------------------------------

$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) { $ScriptDir = (Get-Location).Path }

# The eval project root (where .vally.yaml lives)
$EvalRoot = $ScriptDir

# Default: clone evaluate as a sibling to the azure-rest-api-specs repo
if (-not $EvaluateRepo) {
    # Find the git root of azure-rest-api-specs
    try {
        Push-Location $EvalRoot
        $SpecsRepo = (git rev-parse --show-toplevel 2>&1).ToString().Replace('/', [IO.Path]::DirectorySeparatorChar)
        Pop-Location
    } catch {
        Pop-Location
        $SpecsRepo = (Resolve-Path (Join-Path $EvalRoot "..\..\..\..\..")).Path
    }
    $EvaluateRepo = Join-Path (Split-Path $SpecsRepo -Parent) "evaluate"
}

$VallyCli = Join-Path $EvaluateRepo "packages\cli\dist\index.js"
$ResultsDir = Join-Path $EvalRoot "results"

# ---- Preflight checks --------------------------------------------------------

Write-Host ""
Write-Host "+--------------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "|         ARM API Reviewer -- Evaluation Suite Runner          |" -ForegroundColor Cyan
Write-Host "+--------------------------------------------------------------+" -ForegroundColor Cyan
Write-Host ""

# Check Node.js
try {
    $nodeVersion = (node --version 2>&1).ToString().TrimStart('v')
    $nodeMajor = [int]($nodeVersion.Split('.')[0])
    if ($nodeMajor -lt 20) {
        throw "Node.js >= 20 required (found v$nodeVersion). Install from https://nodejs.org/"
    }
    Write-Host "  [OK] Node.js v$nodeVersion" -ForegroundColor Green
} catch {
    throw "Node.js not found. Install from https://nodejs.org/"
}

# Check npm
try {
    $npmVersion = (npm --version 2>&1).ToString()
    Write-Host "  [OK] npm v$npmVersion" -ForegroundColor Green
} catch {
    throw "npm not found. Install Node.js from https://nodejs.org/"
}

# Check git
try {
    $null = git --version 2>&1
    Write-Host "  [OK] git available" -ForegroundColor Green
} catch {
    throw "git not found. Install from https://git-scm.com/"
}

# Check .vally.yaml exists
if (-not (Test-Path (Join-Path $EvalRoot ".vally.yaml"))) {
    throw "Cannot find .vally.yaml in $EvalRoot -- script must live in the eval project root."
}
Write-Host "  [OK] Eval project: $EvalRoot" -ForegroundColor Green
Write-Host ""

# ---- Step 1: Clone or update evaluate ----------------------------------------

Write-Host "---- Step 1: evaluate framework --------------------------------" -ForegroundColor Yellow

if (Test-Path (Join-Path $EvaluateRepo ".git")) {
    Write-Host "  evaluate repo found at $EvaluateRepo"
    if (-not $SkipBuild) {
        Write-Host "  Pulling latest..."
        Push-Location $EvaluateRepo
        $pullOutput = git pull --ff-only 2>&1
        $pullOutput | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "  git pull failed (you may be on a branch or have local changes). Continuing with existing checkout."
        }
        Pop-Location
    }
} else {
    Write-Host "  Cloning microsoft/evaluate to $EvaluateRepo ..."
    $cloneOutput = git clone https://github.com/microsoft/evaluate.git $EvaluateRepo 2>&1
    $cloneOutput | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to clone microsoft/evaluate. Check your network and GitHub access."
    }
}

# ---- Step 2: Install & build ------------------------------------------------

Write-Host ""
Write-Host "---- Step 2: Install & build -----------------------------------" -ForegroundColor Yellow

if ($SkipBuild -and (Test-Path $VallyCli)) {
    Write-Host "  Skipping build (-SkipBuild flag and CLI already exists)" -ForegroundColor DarkGray
} else {
    if ($SkipBuild) {
        Write-Warning "  -SkipBuild set but CLI not found at $VallyCli -- building anyway."
    }
    Push-Location $EvaluateRepo
    Write-Host "  Running npm install..."
    $npmOut = npm install 2>&1
    $npmOut | Select-Object -Last 5 | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    if ($LASTEXITCODE -ne 0) { Pop-Location; throw "npm install failed." }

    Write-Host "  Running npm run build..."
    $npmOut = npm run build 2>&1
    $npmOut | Select-Object -Last 5 | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    if ($LASTEXITCODE -ne 0) { Pop-Location; throw "npm run build failed." }
    Pop-Location

    if (-not (Test-Path $VallyCli)) {
        throw "Build succeeded but CLI not found at $VallyCli -- check evaluate repo structure."
    }
    Write-Host "  [OK] vally CLI built" -ForegroundColor Green
}

# ---- Step 3: Run the eval suite ----------------------------------------------

Write-Host ""
Write-Host "---- Step 3: Running eval suite --------------------------------" -ForegroundColor Yellow

# Build the command
$timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH-mm-ss-fffZ")
$outputDir = Join-Path $ResultsDir $timestamp

$cmd = @("node", $VallyCli, "eval")

# Suite or single eval file
if ($Suite -eq "all") {
    $cmd += @("--suite", "all")
} elseif ($Suite -like "eval-*") {
    $evalFile = Join-Path $EvalRoot "evaluate\$Suite.yaml"
    if (-not (Test-Path $evalFile)) {
        throw "Eval file not found: $evalFile"
    }
    $cmd += @("-e", $evalFile)
} else {
    # Try as a suite name
    $cmd += @("--suite", $Suite)
}

$cmd += @("--output-dir", $outputDir)
$cmd += @("--workers", $Workers.ToString())
$cmd += @("--timeout", $Timeout.ToString())
$cmd += @("--junit")

if ($Model) { $cmd += @("--model", $Model) }
if ($JudgeModel) { $cmd += @("--judge-model", $JudgeModel) }
if ($ShowOutput) { $cmd += @("--verbose") }

$cmdDisplay = ($cmd | ForEach-Object { if ($_ -match '\s') { "`"$_`"" } else { $_ } }) -join " "

Write-Host ""
Write-Host "  Command:" -ForegroundColor DarkGray
Write-Host "    $cmdDisplay" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Output: $outputDir" -ForegroundColor DarkGray
Write-Host ""

if ($Workers -gt 1) {
    Write-Host "  WARNING: Running with $Workers workers. Close all Copilot chat" -ForegroundColor DarkYellow
    Write-Host "  sessions in VS Code to avoid session contention timeouts." -ForegroundColor DarkYellow
    Write-Host ""
}

Write-Host "  Starting... (this takes several minutes)" -ForegroundColor Cyan
Write-Host ""

# Run from the eval root so .vally.yaml is discovered
Push-Location $EvalRoot
$evalStart = Get-Date

# Execute -- stream output live, filtering noise from node/npm stderr
& $cmd[0] $cmd[1..($cmd.Count - 1)] 2>&1 | ForEach-Object {
    $line = $_.ToString()
    # Suppress Node.js experimental warnings and trace-warnings hints
    if ($line -match 'ExperimentalWarning|--trace-warnings') { return }
    if ($line -match 'PASS|passed') {
        Write-Host "  $line" -ForegroundColor Green
    } elseif ($line -match 'FAIL|failed') {
        Write-Host "  $line" -ForegroundColor Red
    } elseif ($line -match 'WARN') {
        Write-Host "  $line" -ForegroundColor Yellow
    } else {
        Write-Host "  $line"
    }
}
$evalExitCode = $LASTEXITCODE
$evalDuration = (Get-Date) - $evalStart
Pop-Location

# ---- Step 4: Report results -------------------------------------------------

Write-Host ""
Write-Host "---- Step 4: Results -------------------------------------------" -ForegroundColor Yellow
Write-Host ""

$resultsFile = Join-Path $outputDir "eval-results.md"
$jsonlFile = Join-Path $outputDir "results.jsonl"
$junitFile = Join-Path $outputDir "eval-results.junit.xml"

# Vally may create a nested timestamp subfolder inside --output-dir.
# If we don't find results at the top level, search one level down.
if (-not (Test-Path $jsonlFile)) {
    $nested = Get-ChildItem -Path $outputDir -Filter "results.jsonl" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($nested) {
        $actualDir = $nested.DirectoryName
        $resultsFile = Join-Path $actualDir "eval-results.md"
        $jsonlFile = $nested.FullName
        $junitFile = Join-Path $actualDir "eval-results.junit.xml"
    }
}

if (Test-Path $jsonlFile) {
    # Parse results.jsonl for summary.
    # The JSONL may contain different record types (trajectory records + summary).
    # Filter to trajectory records only (those that have a "status" field).
    $allRecords = @(Get-Content $jsonlFile | ForEach-Object { $_ | ConvertFrom-Json })
    $results = @($allRecords | Where-Object { $null -ne $_.PSObject.Properties['status'] })
    $totalStimuli = $results.Count
    $passed = @($results | Where-Object {
        $null -ne $_.PSObject.Properties['gradeResult'] -and
        $null -ne $_.gradeResult -and
        $_.gradeResult.passed -eq $true
    }).Count
    $failed = $totalStimuli - $passed

    # Compute pass rate
    if ($totalStimuli -gt 0) {
        $passRate = [math]::Round(($passed / $totalStimuli) * 100, 1)
    } else {
        $passRate = 0
    }

    Write-Host "  +----------------------------------------------+" -ForegroundColor Cyan
    Write-Host "  |            EVALUATION SUMMARY                |" -ForegroundColor Cyan
    Write-Host "  +----------------------------------------------+" -ForegroundColor Cyan
    Write-Host ("  |  Total stimuli:  {0,-28}|" -f $totalStimuli) -ForegroundColor Cyan
    if ($failed -eq 0) {
        Write-Host ("  |  Passed:         {0,-28}|" -f "[PASS] $passed") -ForegroundColor Green
    } else {
        Write-Host ("  |  Passed:         {0,-28}|" -f "$passed") -ForegroundColor Cyan
    }
    if ($failed -gt 0) {
        Write-Host ("  |  Failed:         {0,-28}|" -f "[FAIL] $failed") -ForegroundColor Red
    } else {
        Write-Host ("  |  Failed:         {0,-28}|" -f "0") -ForegroundColor Cyan
    }
    Write-Host ("  |  Pass rate:      {0,-28}|" -f "$passRate%") -ForegroundColor $(if ($passRate -ge 90) { "Green" } elseif ($passRate -ge 70) { "Yellow" } else { "Red" })
    Write-Host ("  |  Duration:       {0,-28}|" -f "$([math]::Round($evalDuration.TotalMinutes, 1)) min") -ForegroundColor Cyan
    Write-Host "  +----------------------------------------------+" -ForegroundColor Cyan
    Write-Host ""

    # Show failed stimuli details
    if ($failed -gt 0) {
        Write-Host "  Failed stimuli:" -ForegroundColor Red
        $results | Where-Object {
            -not ($null -ne $_.PSObject.Properties['gradeResult'] -and
                  $null -ne $_.gradeResult -and
                  $_.gradeResult.passed -eq $true)
        } | ForEach-Object {
            $name = if ($null -ne $_.PSObject.Properties['stimulusName']) { $_.stimulusName } elseif ($null -ne $_.PSObject.Properties['stimulus']) { $_.stimulus.name } else { "(unknown)" }
            $evidence = if ($null -ne $_.PSObject.Properties['gradeResult'] -and $null -ne $_.gradeResult) { $_.gradeResult.evidence } elseif ($null -ne $_.PSObject.Properties['error']) { $_.error } else { "No result (timeout or error)" }
            Write-Host "    [FAIL] $name" -ForegroundColor Red
            Write-Host "           $evidence" -ForegroundColor DarkGray
        }
        Write-Host ""
    }

    # Show per-suite breakdown
    Write-Host "  Per-suite breakdown:" -ForegroundColor DarkGray
    $namedResults = @($results | Where-Object { $null -ne $_.PSObject.Properties['stimulus'] })
    if ($namedResults.Count -gt 0) {
        $namedResults | Group-Object { $_.stimulus.name -replace '-[^-]+$', '' } | Sort-Object Name | ForEach-Object {
            $suiteName = $_.Name
            $suiteTotal = $_.Count
            $suitePassed = @($_.Group | Where-Object {
                $null -ne $_.PSObject.Properties['gradeResult'] -and
                $null -ne $_.gradeResult -and
                $_.gradeResult.passed -eq $true
            }).Count
            $icon = if ($suitePassed -eq $suiteTotal) { "PASS" } else { "FAIL" }
            Write-Host "    [$icon] $suiteName : $suitePassed/$suiteTotal" -ForegroundColor $(if ($suitePassed -eq $suiteTotal) { "Green" } else { "Yellow" })
        }
    }
    Write-Host ""
} else {
    Write-Host "  [WARNING] No results.jsonl found -- eval may have crashed." -ForegroundColor Red
    Write-Host "            Check output above for errors." -ForegroundColor Red
    Write-Host ""
}

# Show output file locations
Write-Host "  Output files:" -ForegroundColor DarkGray
if (Test-Path $resultsFile)  { Write-Host "    $resultsFile" -ForegroundColor DarkGray }
if (Test-Path $jsonlFile)    { Write-Host "    $jsonlFile" -ForegroundColor DarkGray }
if (Test-Path $junitFile)    { Write-Host "    $junitFile" -ForegroundColor DarkGray }
Write-Host ""

# Restore original encoding
try { [Console]::OutputEncoding = $prevOutputEncoding } catch {}
$OutputEncoding = $prevConsoleEncoding

# Exit with the eval's exit code so CI can gate on it
if ($evalExitCode -ne 0) {
    Write-Host "  Eval exited with code $evalExitCode" -ForegroundColor Red
}

exit $evalExitCode
