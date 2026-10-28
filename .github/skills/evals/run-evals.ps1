<#
.SYNOPSIS
    Runs an API Reviewer evaluation suite end-to-end.

.DESCRIPTION
    Single script to clone/update the vally framework, build it,
    run an eval suite, and report results.

    This script is shared by every eval suite under `.github/skills/evals/`.
    Select the suite with -SuiteDir. It was hoisted out of
    `arm-api-reviewer/` when the data-plane suite was added, rather than
    copied: a ~600-line duplicate would drift, and this repo already has
    documented evidence of duplicated review content drifting (see
    `references/reviewer-posted-parity.md`).

    Prerequisites:
      - Node.js >= 20 and npm (https://nodejs.org/)
      - Git
      - An authenticated GitHub Copilot CLI on PATH. The default `copilot-sdk`
        executor spawns it directly -- this runs headless and does NOT require
        VS Code. (Concurrent VS Code Copilot sessions can still contend for
        capacity, which is why -Workers defaults to 1.)
      - Access to github.com/microsoft/vally, which is a private repository.

    The script will:
      1. Clone microsoft/vally (or pull latest if already cloned)
      2. Install dependencies and build
      3. Run the eval suite
      4. Print a pass/fail summary and open the results

.PARAMETER SuiteDir
    Which eval suite to run -- a directory name under `.github/skills/evals/`,
    or an absolute path to an eval project root (the directory containing
    `.vally.yaml`). Default: "arm-api-reviewer".
    Example: "data-plane-api-reviewer".

.PARAMETER Suite
    Which eval file(s) within the suite to run. Default: "all" (the full
    configured eval suite). Pass a specific eval file name (without path) to
    run one category, e.g. "eval-operations".

.PARAMETER Model
    Override the agent model. Default: use the model declared in each eval YAML.
    Example: "claude-sonnet-4.6" for faster iteration.

    NOTE for the data-plane suite: the model in the eval YAML is intentionally
    kept equal to `engine.model` in
    `.github/workflows/data-plane-api-review.md`. Overriding it here produces a
    number that does not transfer to production and must not be compared with
    the production regression baseline.

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
    # Run the ARM suite with defaults (safest)
    .\run-evals.ps1

.EXAMPLE
    # Run the data-plane suite
    .\run-evals.ps1 -SuiteDir "data-plane-api-reviewer"

.EXAMPLE
    # The data-plane true-negative regression suite (`runs: 3` is configured)
    .\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "true-negatives"

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
    [string]$SuiteDir = "arm-api-reviewer",
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

# ---- Helpers ------------------------------------------------------------------

<#
.SYNOPSIS
    Counts findings the agent emitted on true-negative stimuli.

.DESCRIPTION
    A true-negative stimulus is one where the correct output is silence, so any
    finding is a false positive. Stimuli are identified as true negatives by a
    `tn-` name prefix (the convention used by the data-plane suite) or by living
    in an eval file whose name contains "true-negative".

    Findings are counted from the report's own finding syntax, defined in
    `references/data-plane-report-format.md`:

        ### 🔴 Blocking            <- severity section heading
        **[DP-VIS-02] Title** ...  <- one finding

    The counter walks the report in order: a severity heading sets the current
    severity, and each subsequent bracketed finding is charged to it. That is
    deliberately NOT the same as counting glyphs. An earlier version counted
    severity glyphs at line start, which counts *sections* -- five blocking
    false positives under one `### 🔴 Blocking` heading scored as 1. Harmless
    for the blocking regression metric, which only asks whether the count is zero, but a large
    undercount for the non-blocking trend, which is the whole point of
    tracking it.

    The finding pattern is family-agnostic on purpose. The agent really does
    raise `**[SEC-SECRET-DETECT] ...**` and other non-`DP-` IDs, and a counter
    keyed to the `DP-XXX-NN` shape under-reports the false-positive rate. See
    "Rule-ID vocabulary" in the report-format reference for the nine families.

    Severity policy:
      Blocking     -- FAILS THE REGRESSION RUN.
      Non-blocking -- TRACKED. Warning and suggestion findings on a
                      true negative are counted and trended, because that is
                      what quietly gets a review bot muted, but they do not
                      fail the run. Four true-negative rubrics deliberately
                      tolerate suggestion-severity output; this counts that
                      output without contradicting them.
      Suggestion   -- FAILS THE REGRESSION RUN when over budget. At most
                      $SuggestionBudget (default 2) per true-negative TRIAL.
                      Suggestions were previously free: TN graders are narrow by
                      design, so a report could satisfy every one of them while
                      burying the author in defensible 💡 findings. Padding is
                      exactly that pile, so a metric pricing suggestions at zero
                      cannot measure it. Banning them outright would contradict
                      the rubrics that permit asking, at 💡, whether a value set
                      is protocol-fixed -- hence a budget. Suggestions also roll
                      into NonBlocking so that metric stays comparable with
                      every previous run.

    Retracted findings are NOT counted. The reviewer has emitted a finding and
    then withdrawn it in the same report ("_(Retracted -- contact info, not a
    secret.)_", or a blocking heading followed by "No Blocking findings"). That
    is a format violation, not a wrong assertion: the report's own conclusion is
    correct, so charging it to the false-positive metric would overstate the
    noise a reader actually experiences. A grader fails it on format grounds
    instead -- the same tracked-vs-gated split used for malformed Questions.

    A retraction on the SAME LINE as a finding retracts that finding; one on its
    own line retracts the finding above it. Conflating the two silently
    un-counts an innocent neighboring finding and understates the metric.

    Returns a PSCustomObject with StimulusCount, Blocking, NonBlocking,
    Suggestion, SuggestionBudget, PerStimulusSuggestions, OverBudget, and
    Observed. `Observed` is $true when the agent spoke this report format's
    vocabulary at least once.

    Observed alone does not validate the counts. The real check is
    reconciliation against Get-TrueNegativeGraderFailures: if the graders
    failed trials while this function counted nothing, the two are measuring
    different things and the zeros here are blind, not clean. That is not
    hypothetical -- the first real run of the data-plane suite produced a
    genuine invented finding and 12 failed trials while this function
    reported 0 blocking / 0 non-blocking, because the report format lived only
    in the agent file, which the eval harness never loads.
#>
function Get-TrueNegativeFindingCounts {
    param(
        [string]$JsonlPath,
        # At most this many Suggestion-severity findings per true-negative
        # TRIAL. Suggestions were previously free: TN graders are narrow, so a
        # pile of individually-defensible 💡 findings scored as a pass. Padding
        # is exactly that pile, so a metric that prices it at zero cannot measure
        # it. Banning suggestions outright is also wrong -- the rubrics
        # explicitly permit asking, at 💡, whether a value set is protocol-fixed
        # -- so this is a budget rather than a ban.
        [int]$SuggestionBudget = 2
    )

    $blocking = 0
    $nonBlocking = 0
    $suggestion = 0
    $unsectioned = 0
    $stimulusCount = 0
    $glyphSeen = $false
    # stimulus name -> highest count seen in any one trial of it.
    $perStimulusSuggestions = @{}
    $perStimulusUnsectioned = @{}

    # A finding: bold-bracketed rule ID. Tolerates a bullet or a numbered list
    # marker before it, because a numbered findings list is a presentation
    # choice that costs a reader nothing. The BRACKET is not negotiable: the
    # considered-rules table writes plain bold IDs without brackets, so the
    # bracket is the only thing separating a raised finding from a declined one.
    $findingPattern = '^\s*(?:[-*+]\s*|\d+[.)]\s*)?\*\*\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\]'

    if (-not (Test-Path $JsonlPath)) {
        return [PSCustomObject]@{
            StimulusCount          = 0
            Blocking               = 0
            NonBlocking            = 0
            Suggestion             = 0
            Unsectioned            = 0
            SuggestionBudget       = $SuggestionBudget
            PerStimulusSuggestions = @{}
            PerStimulusUnsectioned = @{}
            OverBudget             = @()
            Observed               = $false
        }
    }

    foreach ($line in (Get-Content $JsonlPath)) {
        if (-not $line.Trim()) { continue }

        try { $rec = $line | ConvertFrom-Json } catch { continue }
        if ($null -eq $rec.PSObject.Properties['status']) { continue }

        $stimName = $null
        if ($null -ne $rec.PSObject.Properties['trajectory'] -and $null -ne $rec.trajectory.stimulus -and $null -ne $rec.trajectory.stimulus.name) {
            $stimName = $rec.trajectory.stimulus.name
        } elseif ($null -ne $rec.PSObject.Properties['gradeResult'] -and $null -ne $rec.gradeResult -and $null -ne $rec.gradeResult.stimulusName) {
            $stimName = $rec.gradeResult.stimulusName
        }
        if (-not $stimName) { continue }

        $isTrueNegative = $stimName -like 'tn-*'
        if (-not $isTrueNegative -and $null -ne $rec.PSObject.Properties['trajectory'] -and $null -ne $rec.trajectory.PSObject.Properties['evalFile']) {
            $isTrueNegative = "$($rec.trajectory.evalFile)" -match 'true-negative'
        }
        if (-not $isTrueNegative) { continue }

        $stimulusCount++

        # Read the agent's output field rather than scanning the raw JSON line.
        # The record also embeds the prompt, the rubric, and the grader
        # patterns, all of which mention rule IDs and severity glyphs; scanning
        # the raw line risks counting the test's own scaffolding as findings.
        if ($null -eq $rec.trajectory -or $null -eq $rec.trajectory.PSObject.Properties['output']) { continue }
        $output = "$($rec.trajectory.output)"
        if (-not $output) { continue }

        # Walk the report in order so each finding is charged to the severity
        # section it appears under.
        #
        # Headings are matched by GLYPH or by WORD. The graders were made
        # format-tolerant because presentation costs a human reader nothing,
        # and the regression counter must not be blinded by the same variation: a report
        # writing `### 🚫 Blocking` or `### Blocking Issues` is still declaring
        # a blocking section, and findings under it are still blocking.
        $currentSeverity = 'unsectioned'
        $lastCharged = $null   # which bucket the previous finding went into
        $trialSuggestions = 0
        $trialUnsectioned = 0
        foreach ($ll in ($output -split '\r?\n')) {
            if ($ll -match "^\s*(?:[-*+]\s*|#{1,6}\s*)?`u{1F534}") { $currentSeverity = 'blocking'; $glyphSeen = $true; continue }
            if ($ll -match "^\s*(?:[-*+]\s*|#{1,6}\s*)?`u{1F7E1}") { $currentSeverity = 'nonblocking'; $glyphSeen = $true; continue }
            # Suggestions are tracked separately so the budget can price them,
            # but still roll into NonBlocking so that metric stays comparable
            # with every previous run.
            if ($ll -match "^\s*(?:[-*+]\s*|#{1,6}\s*)?`u{1F4A1}") { $currentSeverity = 'suggestion'; $glyphSeen = $true; continue }
            # A "Questions" heading ends the finding sections. Questions are
            # bullets rather than findings, and the rubrics permit them.
            if ($ll -match '^\s*#{1,6}\s*.*\bQuestions\b') { $currentSeverity = 'questions'; $lastCharged = $null; continue }
            # Glyph-less severity headings. Requires heading position, so prose
            # like "No blocking findings" cannot open a section.
            if ($ll -match '^\s*#{1,6}[^\r\n]*\bBlocking\b') { $currentSeverity = 'blocking'; continue }
            if ($ll -match '^\s*#{1,6}[^\r\n]*\bWarning') { $currentSeverity = 'nonblocking'; continue }
            if ($ll -match '^\s*#{1,6}[^\r\n]*\bSuggestion') { $currentSeverity = 'suggestion'; continue }

            # A retraction withdraws a finding. Un-count it: the report's own
            # conclusion is correct, so it is a format violation rather than a
            # false positive. Graders fail it instead.
            #
            # Two shapes, and they retract DIFFERENT findings:
            #   same line  -- `**[DP-X] title** -- `f:1` (Retracted)` retracts
            #                 ITSELF. Skip it without charging, and leave the
            #                 preceding finding alone.
            #   own line   -- a bare "(Retracted)" or "No Blocking findings"
            #                 line retracts the finding above it.
            # Treating the first as the second silently un-counts an innocent
            # neighbor, which understates the false-positive metric.
            if ($ll -match '\(\s*Retracted\b' -or
                $ll -match '^\s*\**\s*No\s+(Blocking|Warning|Suggestion)\s+findings\b') {
                if ($ll -match $findingPattern) {
                    # Self-retracting: never charged, so nothing to reverse.
                    $lastCharged = $null
                    continue
                }
                if ($null -ne $lastCharged) {
                    if ($lastCharged -eq 'blocking') { $blocking-- }
                    else {
                        $nonBlocking--
                        # A retracted suggestion must also leave the budget,
                        # or a report that withdraws its own padding still
                        # fails the regression run for having written it.
                        if ($lastCharged -eq 'suggestion') { $suggestion--; $trialSuggestions-- }
                    }
                    $lastCharged = $null
                }
                continue
            }

            if ($ll -match $findingPattern) {
                $glyphSeen = $true
                # Questions are not findings. A rule whose declared severity is
                # Question (DP-MODEL-04) belongs in this section as a bullet,
                # and even if the agent writes it in bracketed form it must not
                # be charged to the false-positive metric -- the rubrics permit
                # questions on a true negative.
                if ($currentSeverity -eq 'questions') { $lastCharged = $null; continue }
                # An unsectioned finding is charged to non-blocking: it is real
                # output that should be trended, but promoting it to Blocking
                # on the strength of a missing heading would be unfair.
                if ($currentSeverity -eq 'blocking') { $blocking++; $lastCharged = 'blocking' }
                elseif ($currentSeverity -eq 'suggestion') {
                    $nonBlocking++; $suggestion++; $trialSuggestions++; $lastCharged = 'suggestion'
                }
                else {
                    $nonBlocking++; $lastCharged = 'nonblocking'
                    # A finding under no severity heading at all. Its severity
                    # is genuinely unknowable, so it cannot be charged to the
                    # blocking metric or the suggestion budget -- but it must not
                    # vanish either. One real trial emitted a flat `### Findings`
                    # list of nine, which scored zero suggestions and looked
                    # clean to the budget. Reported as a FORMAT failure, which
                    # is what it is.
                    if ($currentSeverity -eq 'unsectioned') { $trialUnsectioned++ }
                }
            }
        }

        # Record the worst trial for this stimulus. Worst rather than mean:
        # the budget asks "can this stimulus provoke padding", and one trial
        # that produces six suggestions is the answer regardless of what the
        # other two did.
        if (-not $perStimulusSuggestions.ContainsKey($stimName) -or
            $perStimulusSuggestions[$stimName] -lt $trialSuggestions) {
            $perStimulusSuggestions[$stimName] = $trialSuggestions
        }
        if ($trialUnsectioned -gt 0) {
            if (-not $perStimulusUnsectioned.ContainsKey($stimName) -or
                $perStimulusUnsectioned[$stimName] -lt $trialUnsectioned) {
                $perStimulusUnsectioned[$stimName] = $trialUnsectioned
            }
            $unsectioned += $trialUnsectioned
        }

        # Belt and braces for the blocking metric: a severity heading with no
        # parseable finding under it still counts as a blocking false positive,
        # so this metric can only ever be stricter than the glyph-only version
        # it replaced, never looser.
        #
        # Matches the heading by GLYPH **or by word**. The graders were made
        # format-tolerant deliberately; the regression counter must not inherit that
        # tolerance. A bracketless finding under `### 🚫 Blocking` escapes the
        # graders by design -- it is a format failure, not a judgment failure --
        # but it must not escape the counter, which asks only "did the reviewer
        # declare something blocking on a clean spec".
        #
        # Suppressed when the report retracts a finding, otherwise this clause
        # would re-add the very finding the retraction handling just removed:
        # the heading is still present, and the count is back to zero, so the
        # two rules fight and the retraction loses.
        $hasRetraction = $output -match '\(\s*Retracted\b' -or
                         $output -match '(?m)^\s*\**\s*No\s+(Blocking|Warning|Suggestion)\s+findings\b'
        $declaresBlocking = $output -match "(?m)^\s*(?:[-*+]\s*|#{1,6}\s*)?`u{1F534}" -or
                            $output -match '(?m)^\s*#{1,6}[^\r\n]*\bBlocking\b'
        if ($blocking -eq 0 -and -not $hasRetraction -and $declaresBlocking) { $blocking++ }
    }

    $overBudget = @(
        $perStimulusSuggestions.GetEnumerator() |
            Where-Object { $_.Value -gt $SuggestionBudget } |
            Sort-Object -Property Value -Descending |
            ForEach-Object { [PSCustomObject]@{ Stimulus = $_.Key; Count = $_.Value } }
    )

    return [PSCustomObject]@{
        StimulusCount          = $stimulusCount
        Blocking               = $blocking
        NonBlocking            = $nonBlocking
        Suggestion             = $suggestion
        Unsectioned            = $unsectioned
        SuggestionBudget       = $SuggestionBudget
        PerStimulusSuggestions = $perStimulusSuggestions
        PerStimulusUnsectioned = $perStimulusUnsectioned
        OverBudget             = $overBudget
        Observed               = $glyphSeen
    }
}

<#
.SYNOPSIS
    Counts failed true-negative trials from grader outcomes.

.DESCRIPTION
    The severity-glyph metric above measures how LOUD a false positive was.
    This one measures whether one happened at all, by reading the graders'
    verdicts rather than the agent's formatting. It is the metric the
    "a single true-negative failure is blocking" rule is written against.

    Two independent signals are needed because they fail differently: the
    glyph metric goes blind when the report format is absent, and the grader
    metric inherits whatever bugs live in the grader patterns. Neither alone
    is trustworthy; a disagreement between them is itself a finding.

    Returns StimulusCount (trials), FailedTrials, and FailedStimuli (names).
#>
function Get-TrueNegativeGraderFailures {
    param([string]$JsonlPath)

    $failedTrials = 0
    $trials = 0
    $failedNames = New-Object System.Collections.Generic.HashSet[string]

    if (-not (Test-Path $JsonlPath)) {
        return [PSCustomObject]@{ StimulusCount = 0; FailedTrials = 0; FailedStimuli = @() }
    }

    foreach ($line in (Get-Content $JsonlPath)) {
        if (-not $line.Trim()) { continue }
        try { $rec = $line | ConvertFrom-Json } catch { continue }
        if ($null -eq $rec.PSObject.Properties['trajectory'] -or $null -eq $rec.trajectory) { continue }
        if ($null -eq $rec.trajectory.PSObject.Properties['stimulus'] -or $null -eq $rec.trajectory.stimulus) { continue }

        $stimName = $rec.trajectory.stimulus.name
        if (-not $stimName -or $stimName -notlike 'tn-*') { continue }

        $trials++
        $passed = ($null -ne $rec.PSObject.Properties['gradeResult'] -and
                   $null -ne $rec.gradeResult -and
                   $rec.gradeResult.passed -eq $true)
        if (-not $passed) {
            $failedTrials++
            $null = $failedNames.Add($stimName)
        }
    }

    return [PSCustomObject]@{
        StimulusCount = $trials
        FailedTrials  = $failedTrials
        FailedStimuli = @($failedNames)
    }
}

# ---- Resolve paths -----------------------------------------------------------

$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) { $ScriptDir = (Get-Location).Path }

# The eval project root (where the vally CLI's project config lives -- the
# file is named .vally.yaml because that is the filename the vally CLI
# looks for; do not rename it). Selected by -SuiteDir so one script serves
# every suite under .github/skills/evals/.
if ([IO.Path]::IsPathRooted($SuiteDir)) {
    $EvalRoot = $SuiteDir
} else {
    $EvalRoot = Join-Path $ScriptDir $SuiteDir
}

if (-not (Test-Path $EvalRoot)) {
    throw "Eval suite directory not found: $EvalRoot`nAvailable suites: " +
        ((Get-ChildItem -Path $ScriptDir -Directory | Select-Object -ExpandProperty Name) -join ", ")
}

$EvalRoot = (Resolve-Path $EvalRoot).Path
$SuiteName = Split-Path $EvalRoot -Leaf

# Default: clone vally as a sibling to the azure-rest-api-specs repo
if (-not $VallyRepo) {
    # Find the git root of azure-rest-api-specs
    try {
        Push-Location $EvalRoot
        $SpecsRepo = (git rev-parse --show-toplevel 2>&1).ToString().Replace('/', [IO.Path]::DirectorySeparatorChar)
        Pop-Location
    } catch {
        Pop-Location
        # .github/skills/evals/<suite> -> repo root is four levels up
        $SpecsRepo = (Resolve-Path (Join-Path $EvalRoot "..\..\..\..")).Path
    }
    $VallyRepo = Join-Path (Split-Path $SpecsRepo -Parent) "vally"
}

$VallyCli = Join-Path $VallyRepo "packages\cli\dist\index.js"
$ResultsDir = Join-Path $EvalRoot "results"

# ---- Preflight checks --------------------------------------------------------

Write-Host ""
Write-Host "+--------------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "|              API Reviewer -- Evaluation Suite Runner          |" -ForegroundColor Cyan
Write-Host ("|  Suite: {0,-52}|" -f $SuiteName) -ForegroundColor Cyan
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
    $tnMetrics     = [PSCustomObject]@{ StimulusCount = 0; Blocking = 0; NonBlocking = 0 }

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
                #
                # Each hop must be existence-checked, not just null-checked. An
                # ERRORED trial (e.g. a session.idle timeout) emits a record whose
                # `trajectory` has no `stimulus` property at all, and under
                # Set-StrictMode accessing it throws rather than returning $null.
                # That is why this only ever surfaced on the first run that
                # contained an errored trial.
                $name = '(unknown)'
                if ($null -ne $_.PSObject.Properties['gradeResult'] -and $null -ne $_.gradeResult -and $null -ne $_.gradeResult.PSObject.Properties['stimulusName']) {
                    $name = $_.gradeResult.stimulusName
                } elseif ($null -ne $_.PSObject.Properties['trajectory'] -and $null -ne $_.trajectory -and
                          $null -ne $_.trajectory.PSObject.Properties['stimulus'] -and $null -ne $_.trajectory.stimulus -and
                          $null -ne $_.trajectory.stimulus.PSObject.Properties['name']) {
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

        # ---- False-positive metrics on true-negative stimuli ----------------
        #
        # True-negative stimuli are specs where the correct answer is silence.
        # Any finding on one is by definition a false positive.
        #
        #   Blocking FPs   -- FAIL THE REGRESSION RUN.
        #   Non-blocking   -- TRACKED. Warnings and suggestions on a clean spec
        #     FPs             are what actually gets a review bot muted in
        #                     practice. Watch the trend: a rising number is the
        #                     early warning that reviewers are about to start
        #                     ignoring the bot.
        #
        # Counted mechanically from the severity glyphs in the recorded agent
        # output, so no grader change is needed when stimuli are added --
        # but see `Observed` below: when the report format never appears the
        # counts are blind, and a blind metric must not print 0.
        $tnMetrics = Get-TrueNegativeFindingCounts -JsonlPath $jsonlFile
        $tnGrader  = Get-TrueNegativeGraderFailures -JsonlPath $jsonlFile
        # The glyph counts are only trustworthy when they agree with the
        # graders. Graders failing while the glyph counter sees nothing means
        # the counter is blind to whatever the agent actually emitted -- print
        # UNMEASURED rather than a zero that reads like a pass.
        $tnGlyphBlind = ($tnGrader.FailedTrials -gt 0 -and
                         ($tnMetrics.Blocking + $tnMetrics.NonBlocking) -eq 0)
        if ($tnMetrics.StimulusCount -gt 0) {
            Write-Host "  True-negative false positives:" -ForegroundColor DarkGray
            Write-Host ("    Trials evaluated  : {0}" -f $tnMetrics.StimulusCount) -ForegroundColor DarkGray

            if (-not $tnGlyphBlind) {
                $blockingColor = if ($tnMetrics.Blocking -eq 0) { "Green" } else { "Red" }
                Write-Host ("    Blocking FPs      : {0}   [regression -- must be 0]" -f $tnMetrics.Blocking) -ForegroundColor $blockingColor
                Write-Host ("    Non-blocking FPs  : {0}   [tracked -- watch the trend]" -f $tnMetrics.NonBlocking) -ForegroundColor DarkYellow
                $fpPerStimulus = [math]::Round($tnMetrics.NonBlocking / $tnMetrics.StimulusCount, 2)
                Write-Host ("    Non-blocking/stim : {0}" -f $fpPerStimulus) -ForegroundColor DarkYellow

                # Suggestion budget. Padding is a pile of individually
                # defensible suggestions, so it is invisible to a metric that
                # prices suggestions at zero and to graders narrow enough to
                # ignore them. Budgeted rather than banned: the rubrics
                # explicitly allow asking, at 💡, whether a value set is
                # protocol-fixed.
                $budget = $tnMetrics.SuggestionBudget
                $overBudget = @($tnMetrics.OverBudget)
                $sugColor = if ($overBudget.Count -eq 0) { "Green" } else { "Red" }
                Write-Host ("    Suggestion FPs    : {0}   [regression budget {1}/stimulus]" -f $tnMetrics.Suggestion, $budget) -ForegroundColor $sugColor

                if ($overBudget.Count -gt 0) {
                    foreach ($ob in $overBudget) {
                        Write-Host ("      OVER BUDGET: {0} -- {1} suggestion(s) in one trial, budget is {2}" -f $ob.Stimulus, $ob.Count, $budget) -ForegroundColor Red
                    }
                    Write-Host "      A true negative is a spec where the correct answer is silence." -ForegroundColor DarkYellow
                    Write-Host "      Several defensible suggestions on one is what padding looks like." -ForegroundColor DarkYellow
                }

                # Per-stimulus trend, printed whether or not the budget is
                # breached, so the number is trackable across runs rather than
                # only visible on failure.
                $withSuggestions = @(
                    $tnMetrics.PerStimulusSuggestions.GetEnumerator() |
                        Where-Object { $_.Value -gt 0 } | Sort-Object -Property Value -Descending
                )
                if ($withSuggestions.Count -gt 0) {
                    Write-Host "    Suggestions/stim  :" -ForegroundColor DarkGray
                    foreach ($kv in $withSuggestions) {
                        $mark = if ($kv.Value -gt $budget) { "  <-- over" } else { "" }
                        Write-Host ("      {0,-42} {1}{2}" -f $kv.Key, $kv.Value, $mark) -ForegroundColor DarkGray
                    }
                }

                # Findings emitted under no severity heading at all. Their
                # severity is unknowable, so they are charged to neither the
                # blocking metric nor the suggestion budget -- but a flat list of
                # nine on a clean spec is exactly the padding the budget exists
                # to price, and it must not read as a clean run. Reported as the
                # FORMAT failure it is.
                if ($tnMetrics.Unsectioned -gt 0) {
                    Write-Host ("    Unsectioned finds : {0}   [FORMAT -- severity unknowable, excluded from blocking metric and budget]" -f $tnMetrics.Unsectioned) -ForegroundColor DarkYellow
                    foreach ($kv in ($tnMetrics.PerStimulusUnsectioned.GetEnumerator() | Sort-Object -Property Value -Descending)) {
                        Write-Host ("      {0,-42} {1}" -f $kv.Key, $kv.Value) -ForegroundColor DarkYellow
                    }
                    Write-Host "      A report with no severity headings cannot be scored for severity." -ForegroundColor DarkYellow
                }
            } else {
                Write-Host "    Blocking FPs      : UNMEASURED   [regression signal unavailable]" -ForegroundColor Red
                Write-Host "    Non-blocking FPs  : UNMEASURED" -ForegroundColor Red
                Write-Host ("      {0} true-negative trial(s) failed but the severity-glyph counter" -f $tnGrader.FailedTrials) -ForegroundColor DarkYellow
                Write-Host "      found no findings in the mandated report format. The two metrics" -ForegroundColor DarkYellow
                Write-Host "      disagree, so the glyph counts are blind rather than clean." -ForegroundColor DarkYellow
                Write-Host "      Read the failing outputs before trusting any FP number." -ForegroundColor DarkYellow
            }

            # Grader-derived, independent of the agent's formatting. This is
            # the signal the "a single true-negative failure is blocking" rule
            # is written against.
            $tnFailColor = if ($tnGrader.FailedTrials -eq 0) { "Green" } else { "Red" }
            Write-Host ("    TN trials failed  : {0}/{1}   [regression -- must be 0]" -f $tnGrader.FailedTrials, $tnGrader.StimulusCount) -ForegroundColor $tnFailColor
            if ($tnGrader.FailedTrials -gt 0) {
                Write-Host ("      Stimuli: {0}" -f (($tnGrader.FailedStimuli | Sort-Object) -join ", ")) -ForegroundColor Red
            }
            Write-Host ""
        }
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
        TnStimuli   = $tnMetrics.StimulusCount
        TnBlockFp   = $tnMetrics.Blocking
        TnSoftFp    = $tnMetrics.NonBlocking
        TnObserved  = (-not $tnGlyphBlind)
        TnFailed    = $tnGrader.FailedTrials
        DurationMin = [math]::Round($evalDuration.TotalMinutes, 1)
        ExitCode    = $evalExitCode
        OutputDir   = $outputDir
        JsonlFile   = $jsonlFile
    }

    # Surface the worst exit code so CI can report the regression.
    if ($evalExitCode -ne 0 -and $overallExitCode -eq 0) {
        $overallExitCode = $evalExitCode
    }

    # vally's own pass/fail uses `scoring.threshold`, which is an aggregate:
    # a suite can score above threshold while individual stimuli fail. That is
    # reasonable for a capability suite and wrong for a true-negative regression
    # run, where a single failure must remain visible. Observed
    # concretely on the first real run: 12 of 21 trials failed, including one
    # genuine invented finding, and vally still exited 0 at 75% vs a 70%
    # threshold. Fail the run here so CI cannot go green on that.
    if ($tnGrader.FailedTrials -gt 0 -and $overallExitCode -eq 0) {
        Write-Host ("  [REGRESSION] {0} true-negative trial(s) failed." -f $tnGrader.FailedTrials) -ForegroundColor Red
        $overallExitCode = 1
    }

    # Suggestion budget. Deliberately separate from individual graders: graders
    # on a true negative are narrow by design, so a report can
    # satisfy every one of them while burying the author in defensible
    # suggestions. That is what padding is, and it is the failure mode most
    # likely to get the bot muted in practice. Only enforced when the counts are
    # trustworthy -- a blind counter must not manufacture a budget failure.
    if (-not $tnGlyphBlind) {
        $overBudgetFinal = @($tnMetrics.OverBudget)
        if ($overBudgetFinal.Count -gt 0 -and $overallExitCode -eq 0) {
            Write-Host ("  [REGRESSION] {0} true-negative stimulus/stimuli exceeded the {1}-suggestion budget." -f $overBudgetFinal.Count, $tnMetrics.SuggestionBudget) -ForegroundColor Red
            $overallExitCode = 1
        }
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
        Select-Object Run, Total, Passed, Failed, @{Name='PassRate%'; Expression={$_.PassRate}}, @{Name='TN-BlockFP'; Expression={$_.TnBlockFp}}, @{Name='TN-SoftFP'; Expression={$_.TnSoftFp}}, DurationMin, ExitCode |
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

    # Aggregate false-positive metrics across runs. This is a rollout regression
    # signal, not a hard promotion gate. The non-blocking total is reported so a
    # rising trend is visible before reviewers start ignoring the bot.
    $aggTnStimuli = ($runSummaries | Measure-Object -Property TnStimuli -Sum).Sum
    if ($aggTnStimuli -gt 0) {
        $aggTnBlocking = ($runSummaries | Measure-Object -Property TnBlockFp -Sum).Sum
        $aggTnSoft     = ($runSummaries | Measure-Object -Property TnSoftFp  -Sum).Sum
        $aggTnFailed   = ($runSummaries | Measure-Object -Property TnFailed  -Sum).Sum
        $aggObserved   = @($runSummaries | Where-Object { $_.TnObserved }).Count -eq $runSummaries.Count

        Write-Host ""
        Write-Host "  True-negative false positives (all runs):" -ForegroundColor DarkGray
        if ($aggObserved) {
            Write-Host ("    Blocking     : {0}" -f $aggTnBlocking) -ForegroundColor $(if ($aggTnBlocking -eq 0) { "Green" } else { "Red" })
            Write-Host ("    Non-blocking : {0} over {1} TN stimulus runs ({2} per stimulus)" -f `
                $aggTnSoft, $aggTnStimuli, [math]::Round($aggTnSoft / $aggTnStimuli, 2)) -ForegroundColor DarkYellow
        } else {
            Write-Host "    Blocking     : UNMEASURED (glyph counter disagrees with graders)" -ForegroundColor Red
            Write-Host "    Non-blocking : UNMEASURED" -ForegroundColor Red
        }
        Write-Host ("    TN failures  : {0} trial(s)" -f $aggTnFailed) -ForegroundColor $(if ($aggTnFailed -eq 0) { "Green" } else { "Red" })

        if (-not $aggObserved) {
            Write-Host "    [REGRESSION] False positives UNMEASURED." -ForegroundColor Red
        } elseif ($aggTnBlocking -gt 0 -or $aggTnFailed -gt 0) {
            Write-Host "    [REGRESSION] Blocking FPs or TN failures present." -ForegroundColor Red
        } else {
            Write-Host "    [REGRESSION] No blocking FPs or TN failures observed." -ForegroundColor Green
        }
        Write-Host ""
    }

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

# Exit with the worst exit code from all runs so CI can report it
if ($overallExitCode -ne 0) {
    Write-Host "  Eval suite exited with non-zero code: $overallExitCode" -ForegroundColor Red
}

exit $overallExitCode
