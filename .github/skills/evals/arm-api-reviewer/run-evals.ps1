<#
.SYNOPSIS
    Runs the ARM API Reviewer evaluation suite end-to-end.

.DESCRIPTION
    Single script to clone/update the vally framework, build it,
    run the full ARM API Reviewer eval suite, and report results.

    Prerequisites:
      - Node.js >= 20 and npm (https://nodejs.org/)
      - Git
      - VS Code with GitHub Copilot active (the executor uses Copilot agent sessions)

    The script will:
      1. Clone microsoft/vally (or pull latest if already cloned)
      2. Install dependencies and build
      3. Run the eval suite
      4. Print a pass/fail summary and open the results

.PARAMETER Suite
    Which suite to run. Default: "all" (the full configured eval suite).
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

.PARAMETER VallyRepo
    Path where microsoft/vally should be cloned. Default: sibling to azure-rest-api-specs.

.PARAMETER SkipBuild
    Skip the npm install + build step (use if vally is already built).

.PARAMETER ShowOutput
    Show full agent output during execution (passes --verbose to the vally CLI).

.PARAMETER Repeat
    Number of times to run the full eval suite back-to-back. Default: 1.
    Each run gets its own timestamped results folder so nothing is overwritten.
    Useful for verifying stability of the suite and detecting flaky stimuli.

.PARAMETER DelayBetweenRunsSeconds
    Cooldown in seconds between consecutive runs when -Repeat > 1. Default: 15.
    Gives Copilot agent sessions, network rate-limiters, and judge-model
    contexts time to settle so each run starts from a clean baseline.
    Set to 0 to run back-to-back with no wait. Bump to 60+ if you see
    rate-limit errors across runs.

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
    # Point to an existing vally clone
    .\run-evals.ps1 -VallyRepo "C:\repos\vally"

.EXAMPLE
    # Run the full suite 3 times with a 60-second cooldown between runs
    .\run-evals.ps1 -Repeat 3

.EXAMPLE
    # Three back-to-back runs with no cooldown
    .\run-evals.ps1 -Repeat 3 -DelayBetweenRunsSeconds 0
#>

[CmdletBinding()]
param(
    [string]$Suite = "all",
    [string]$Model = "",
    [string]$JudgeModel = "",
    [int]$Workers = 1,
    [int]$Timeout = 600000,
    [string]$VallyRepo = "",
    [switch]$SkipBuild,
    [switch]$ShowOutput,
    [ValidateRange(1, 100)]
    [int]$Repeat = 1,
    [ValidateRange(0, 3600)]
    [int]$DelayBetweenRunsSeconds = 15
)

Set-StrictMode -Version Latest
# NOTE: We use "Continue" (not "Stop") because git, npm, and node all write
# progress/warnings to stderr. With "Stop", PowerShell treats any stderr
# output as a terminating error -- even "npm warn" or "Cloning into...".
$ErrorActionPreference = "Continue"

# Ensure console can handle UTF-8 output from the vally CLI (which may emit emoji)
$prevOutputEncoding = [Console]::OutputEncoding
$prevConsoleEncoding = $OutputEncoding
try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}
$OutputEncoding = [System.Text.Encoding]::UTF8

# ---- Resolve paths -----------------------------------------------------------

$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) { $ScriptDir = (Get-Location).Path }

# The eval project root (where the vally CLI's project config lives -- the
# file is named .vally.yaml because that is the filename the vally CLI
# looks for; do not rename it).
$EvalRoot = $ScriptDir

# Default: clone vally as a sibling to the azure-rest-api-specs repo
if (-not $VallyRepo) {
    # Find the git root of azure-rest-api-specs
    try {
        Push-Location $EvalRoot
        $SpecsRepo = (git rev-parse --show-toplevel 2>&1).ToString().Replace('/', [IO.Path]::DirectorySeparatorChar)
        Pop-Location
    } catch {
        Pop-Location
        $SpecsRepo = (Resolve-Path (Join-Path $EvalRoot "..\..\..\..\..")).Path
    }
    $VallyRepo = Join-Path (Split-Path $SpecsRepo -Parent) "vally"
}

$VallyCli = Join-Path $VallyRepo "packages\cli\dist\index.js"
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

# Check the vally-CLI project config file exists (named .vally.yaml as
# required by the vally CLI -- do not rename).
if (-not (Test-Path (Join-Path $EvalRoot ".vally.yaml"))) {
    throw "Cannot find .vally.yaml (the vally-CLI project config) in $EvalRoot -- script must live in the eval project root."
}
Write-Host "  [OK] Eval project: $EvalRoot" -ForegroundColor Green
Write-Host ""

# ---- Step 1: Clone or update vally ------------------------------------------

Write-Host "---- Step 1: vally framework -----------------------------------" -ForegroundColor Yellow

if (Test-Path (Join-Path $VallyRepo ".git")) {
    Write-Host "  vally repo found at $VallyRepo"
    if (-not $SkipBuild) {
        Write-Host "  Pulling latest..."
        Push-Location $VallyRepo
        $pullOutput = git pull --ff-only 2>&1
        $pullOutput | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "  git pull failed (you may be on a branch or have local changes). Continuing with existing checkout."
        }
        Pop-Location
    }
} else {
    Write-Host "  Cloning microsoft/vally to $VallyRepo ..."
    $cloneOutput = git clone https://github.com/microsoft/vally.git $VallyRepo 2>&1
    $cloneOutput | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to clone microsoft/vally. Check your network and GitHub access."
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
    Push-Location $VallyRepo
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
        throw "Build succeeded but CLI not found at $VallyCli -- check vally repo structure."
    }
    Write-Host "  [OK] vally CLI built" -ForegroundColor Green
}

# ---- Step 3: Run the eval suite (looped) ------------------------------------

Write-Host ""
Write-Host "---- Step 3: Running eval suite --------------------------------" -ForegroundColor Yellow
if ($Repeat -gt 1) {
    Write-Host "  Running the full suite $Repeat times for stability verification" -ForegroundColor Yellow
    if ($DelayBetweenRunsSeconds -gt 0) {
        Write-Host "  Cooldown between runs: $DelayBetweenRunsSeconds seconds" -ForegroundColor Yellow
    } else {
        Write-Host "  Cooldown between runs: disabled" -ForegroundColor Yellow
    }
}

$runSummaries = @()
$overallExitCode = 0

for ($runIndex = 1; $runIndex -le $Repeat; $runIndex++) {

    if ($Repeat -gt 1) {
        Write-Host ""
        Write-Host "================================================================" -ForegroundColor Magenta
        Write-Host ("                       RUN {0} of {1}" -f $runIndex, $Repeat) -ForegroundColor Magenta
        Write-Host "================================================================" -ForegroundColor Magenta
    }

    # Reset per-run state so each iteration starts from a clean baseline.
    # ($LASTEXITCODE persists across PowerShell commands; null it to avoid
    # carrying a stale value from the previous run into our exit-code logic.)
    $global:LASTEXITCODE = 0
    $evalExitCode  = 0
    $totalStimuli  = 0
    $passed        = 0
    $failed        = 0
    $passRate      = 0
    $results       = @()

    # Build the command (fresh per run -- each gets its own output dir).
    $timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH-mm-ss-fffZ")
    $outputDir = Join-Path $ResultsDir $timestamp

    $cmd = @("node", $VallyCli, "eval")

    # Suite or single eval file
    if ($Suite -eq "all") {
        $cmd += @("--suite", "all")
    } elseif ($Suite -like "eval-*") {
        $evalFile = Join-Path $EvalRoot "vally\$Suite.yaml"
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
    $cmd += @("--timeout", "$($Timeout)ms")
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

    # Run from the eval root so the vally CLI's project config (.vally.yaml) is discovered
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

    # ---- Step 4: Report results (per run) -----------------------------------

    Write-Host ""
    if ($Repeat -gt 1) {
        Write-Host ("---- Step 4: Results (run {0} of {1}) -------------------------" -f $runIndex, $Repeat) -ForegroundColor Yellow
    } else {
        Write-Host "---- Step 4: Results -------------------------------------------" -ForegroundColor Yellow
    }
    Write-Host ""

    $resultsFile = Join-Path $outputDir "eval-results.md"
    $jsonlFile = Join-Path $outputDir "results.jsonl"
    $junitFile = Join-Path $outputDir "eval-results.junit.xml"

    # The vally CLI may create a nested timestamp subfolder inside --output-dir.
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
                # Stimulus name lives at trajectory.stimulus.name OR gradeResult.stimulusName.
                # Earlier versions of this script looked at $_.stimulusName and $_.stimulus.name
                # at the top of the record; the JSONL schema actually nests them, so
                # both lookups silently returned "(unknown)". Fixed paths:
                $name = '(unknown)'
                if ($null -ne $_.PSObject.Properties['gradeResult'] -and $null -ne $_.gradeResult -and $null -ne $_.gradeResult.PSObject.Properties['stimulusName']) {
                    $name = $_.gradeResult.stimulusName
                } elseif ($null -ne $_.PSObject.Properties['trajectory'] -and $null -ne $_.trajectory.stimulus -and $null -ne $_.trajectory.stimulus.name) {
                    $name = $_.trajectory.stimulus.name
                }
                $evidence = if ($null -ne $_.PSObject.Properties['gradeResult'] -and $null -ne $_.gradeResult) { $_.gradeResult.evidence } elseif ($null -ne $_.PSObject.Properties['error']) { $_.error } else { "No result (timeout or error)" }
                # List the per-grader names that failed (not just the aggregate evidence).
                $failedGraders = @()
                if ($null -ne $_.PSObject.Properties['gradeResult'] -and $null -ne $_.gradeResult -and $null -ne $_.gradeResult.PSObject.Properties['details']) {
                    $failedGraders = @($_.gradeResult.details | Where-Object { $_.passed -eq $false } | ForEach-Object { $_.name })
                }
                Write-Host "    [FAIL] $name" -ForegroundColor Red
                Write-Host "           $evidence" -ForegroundColor DarkGray
                if ($failedGraders.Count -gt 0) {
                    Write-Host ("           Failed graders: {0}" -f ($failedGraders -join ', ')) -ForegroundColor DarkGray
                }
            }
            Write-Host ""
        }

        # Show per-suite breakdown
        Write-Host "  Per-suite breakdown:" -ForegroundColor DarkGray
        $namedResults = @($results | Where-Object {
            $null -ne $_.PSObject.Properties['trajectory'] -and
            $null -ne $_.trajectory.stimulus -and
            $null -ne $_.trajectory.stimulus.name
        })
        if ($namedResults.Count -gt 0) {
            $namedResults | Group-Object { $_.trajectory.stimulus.name -replace '-[^-]+$', '' } | Sort-Object Name | ForEach-Object {
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

    # Capture this run's summary for the aggregate report.
    $runSummaries += [PSCustomObject]@{
        Run         = $runIndex
        Total       = $totalStimuli
        Passed      = $passed
        Failed      = $failed
        PassRate    = $passRate
        DurationMin = [math]::Round($evalDuration.TotalMinutes, 1)
        ExitCode    = $evalExitCode
        OutputDir   = $outputDir
        JsonlFile   = $jsonlFile
    }

    # Surface the worst exit code so CI can gate on it.
    if ($evalExitCode -ne 0 -and $overallExitCode -eq 0) {
        $overallExitCode = $evalExitCode
    }

    # Cooldown between runs (skip after the final run). Gives Copilot agent
    # sessions, network rate-limiters, and judge-model contexts time to settle
    # so each iteration starts from a clean baseline.
    if ($runIndex -lt $Repeat -and $DelayBetweenRunsSeconds -gt 0) {
        Write-Host ""
        Write-Host ("  Cooling down for {0} seconds before run {1}..." -f $DelayBetweenRunsSeconds, ($runIndex + 1)) -ForegroundColor DarkCyan
        Start-Sleep -Seconds $DelayBetweenRunsSeconds
    }
}

# ---- Aggregate summary (only when -Repeat > 1) ------------------------------

if ($Repeat -gt 1) {
    Write-Host ""
    Write-Host "+--------------------------------------------------------------+" -ForegroundColor Magenta
    Write-Host ("|             AGGREGATE SUMMARY ({0} runs){1}|" -f $Repeat, (' ' * (32 - "$Repeat runs".Length))) -ForegroundColor Magenta
    Write-Host "+--------------------------------------------------------------+" -ForegroundColor Magenta
    Write-Host ""

    $runSummaries |
        Select-Object Run, Total, Passed, Failed, @{Name='PassRate%'; Expression={$_.PassRate}}, DurationMin, ExitCode |
        Format-Table -AutoSize | Out-String | Write-Host

    $aggTotal  = ($runSummaries | Measure-Object -Property Total  -Sum).Sum
    $aggPassed = ($runSummaries | Measure-Object -Property Passed -Sum).Sum
    $aggFailed = ($runSummaries | Measure-Object -Property Failed -Sum).Sum
    if ($aggTotal -gt 0) {
        $aggPassRate = [math]::Round(($aggPassed / $aggTotal) * 100, 1)
    } else {
        $aggPassRate = 0
    }
    $aggDuration = [math]::Round((($runSummaries | Measure-Object -Property DurationMin -Sum).Sum), 1)

    $aggColor = if ($aggFailed -eq 0) { "Green" } elseif ($aggPassRate -ge 70) { "Yellow" } else { "Red" }
    Write-Host ("  Aggregate: {0}/{1} passed ({2}%) across {3} runs in {4} min total" -f $aggPassed, $aggTotal, $aggPassRate, $Repeat, $aggDuration) -ForegroundColor $aggColor

    # Per-stimulus stability: how many runs each stimulus passed.
    # Flaky stimuli (passed sometimes, failed other times) are the main
    # reason to use -Repeat, so we surface them explicitly.
    $allStimulusResults = @()
    foreach ($s in $runSummaries) {
        if (-not (Test-Path $s.JsonlFile)) { continue }
        Get-Content $s.JsonlFile | ForEach-Object {
            $rec = $_ | ConvertFrom-Json
            # Stimulus name lives at trajectory.stimulus.name (not top-level
            # $rec.stimulus.name) and gradeResult.stimulusName -- the older
            # field paths were silently wrong and dropped every record.
            $stimName = $null
            if ($null -ne $rec.PSObject.Properties['trajectory'] -and $null -ne $rec.trajectory.stimulus -and $null -ne $rec.trajectory.stimulus.name) {
                $stimName = $rec.trajectory.stimulus.name
            } elseif ($null -ne $rec.PSObject.Properties['gradeResult'] -and $null -ne $rec.gradeResult.stimulusName) {
                $stimName = $rec.gradeResult.stimulusName
            }
            if ($null -ne $rec.PSObject.Properties['status'] -and $null -ne $stimName) {
                $stimulusPassed = ($null -ne $rec.PSObject.Properties['gradeResult'] -and
                                   $null -ne $rec.gradeResult -and
                                   $rec.gradeResult.passed -eq $true)
                $allStimulusResults += [PSCustomObject]@{
                    Run      = $s.Run
                    Stimulus = $stimName
                    Passed   = $stimulusPassed
                }
            }
        }
    }

    if ($allStimulusResults.Count -gt 0) {
        Write-Host ""
        Write-Host "  Per-stimulus stability (passes / runs):" -ForegroundColor DarkGray
        $allStimulusResults | Group-Object Stimulus | Sort-Object Name | ForEach-Object {
            $name      = $_.Name
            $passCount = @($_.Group | Where-Object { $_.Passed }).Count
            $runCount  = $_.Group.Count
            if ($passCount -eq $runCount) {
                $marker = "[OK]   "; $color = "Green"
            } elseif ($passCount -eq 0) {
                $marker = "[FAIL] "; $color = "Red"
            } else {
                $marker = "[FLAKY]"; $color = "Yellow"
            }
            Write-Host ("    {0} {1} : {2}/{3}" -f $marker, $name, $passCount, $runCount) -ForegroundColor $color
        }
        Write-Host ""
    }
}

# Restore original encoding
try { [Console]::OutputEncoding = $prevOutputEncoding } catch {}
$OutputEncoding = $prevConsoleEncoding

# Exit with the worst exit code from all runs so CI can gate on it
if ($overallExitCode -ne 0) {
    Write-Host "  Eval suite exited with non-zero code: $overallExitCode" -ForegroundColor Red
}

exit $overallExitCode
