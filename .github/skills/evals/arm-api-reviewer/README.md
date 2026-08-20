# ARM API Reviewer -- Evaluation Suite

Evaluation tests for the **ARM API Reviewer** agent using the
[vally](https://github.com/microsoft/vally) framework.

## Directory Structure

```text
arm-api-reviewer/
├── run-evals.ps1          # One-click script: clone, build, run, report
├── .vally.yaml            # Project config; filename fixed by the vally CLI
├── vally/                 # Eval definitions (17 files)
│   ├── eval-arm-resource-structure.yaml
│   ├── eval-property-design.yaml
│   ├── eval-operations.yaml
│   ├── eval-breaking-changes.yaml
│   ├── eval-suppressions.yaml
│   ├── eval-suppressions-yaml.yaml
│   ├── eval-examples.yaml
│   ├── eval-typespec.yaml
│   ├── eval-check-name-availability.yaml
│   ├── eval-true-negatives.yaml
│   ├── eval-classification.yaml
│   ├── eval-report-format.yaml
│   ├── eval-citation-and-parity.yaml
│   ├── eval-typespec-required.yaml
│   ├── eval-fast-path-triage.yaml
│   ├── eval-protocol-safety.yaml
│   └── eval-pattern-validation.yaml
├── fixtures/              # Test fixtures (40 data files + README)
│   ├── arm-openapi/       # ARM OpenAPI specs with seeded violations
│   ├── examples/          # Example JSON files (good and bad)
│   ├── readme/            # readme.md suppression files
│   ├── suppressions-yaml/ # suppressions.yaml fixtures
│   ├── typespec/          # TypeSpec files with seeded violations
│   └── version-pairs/     # Version pairs for breaking change detection
└── README.md              # This file
```

## Test Categories

| ID     | Category                      | Count | Description                                                                                                                                                                                                                                                                                                                                                                                                             |
| ------ | ----------------------------- | ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 01xxxx | ARM resource structure        | 3     | Missing CRUD ops, missing provisioningState, inline types                                                                                                                                                                                                                                                                                                                                                               |
| 02xxxx | Property design               | 4     | Secrets, naming, descriptions, enums                                                                                                                                                                                                                                                                                                                                                                                    |
| 03xxxx | Operations                    | 4     | PATCH, PUT, DELETE, LRO violations                                                                                                                                                                                                                                                                                                                                                                                      |
| 04xxxx | Breaking changes              | 4     | Removed property, type change, enum narrowing, added required                                                                                                                                                                                                                                                                                                                                                           |
| 05xxxx | Suppression analysis (readme) | 2     | Missing reason, security rule suppressions                                                                                                                                                                                                                                                                                                                                                                              |
| 06xxxx | Example file validation       | 2     | Bad resource ID, realistic secrets                                                                                                                                                                                                                                                                                                                                                                                      |
| 07xxxx | TypeSpec review               | 4     | Segment casing, secrets, anti-patterns, x-ms-identifiers                                                                                                                                                                                                                                                                                                                                                                |
| 08xxxx | Check Name Availability       | 1     | Custom CNA models, missing input validation                                                                                                                                                                                                                                                                                                                                                                             |
| 09xxxx | True negatives                | 3     | Clean spec, clean example, clean proxy resource                                                                                                                                                                                                                                                                                                                                                                         |
| 10xxxx | Classification                | 1     | NEW vs EXISTING issue tagging                                                                                                                                                                                                                                                                                                                                                                                           |
| 11xxxx | Report format                 | 2     | Line numbers, rule IDs, structured output; critic invisible on clean                                                                                                                                                                                                                                                                                                                                                    |
| 12xxxx | TypeSpec required             | 3     | TSP-REQUIRED-V1: new versions need TypeSpec; maintenance OK                                                                                                                                                                                                                                                                                                                                                             |
| 13xxxx | Citation & posted parity      | 3     | Rule-ID hyperlinks; chat↔PR byte-for-byte parity; refusal to shorten                                                                                                                                                                                                                                                                                                                                                    |
| 14xxxx | suppressions.yaml continuity  | 2     | Missing reason in new entry; security-rule suppression                                                                                                                                                                                                                                                                                                                                                                  |
| 15xxxx | Fast-path triage              | 3     | Examples-only fast path; schema change forces full; uncertain→full                                                                                                                                                                                                                                                                                                                                                      |
| 16xxxx | Protocol safety               | 14    | Subagent auto-unavailable; empty-response not pass; INVALIDATED stops session; downstream-rule telemetry; happy-path READY TO POST; Step 1 SHA pinning; iteration-2 reconciliation marker; override-reason marker; telemetry-degraded fallback; critic=unknown fallback; ARMChangesRequested skip on clean plan; issue-comment PR target resolution; cross-session top-level deduplication; contradiction clarification |
| 17xxxx | Pattern constraint validation | 3     | Denylist `[^...]` pattern on path param (blocking); denylist on existing vs new property (warning vs blocking); TypeSpec `@pattern` denylist (blocking)                                                                                                                                                                                                                                                                 |

Total: 58 stimuli across 17 eval files.

## Fixtures

All 40 fixture data files live in `fixtures/` (plus a `README.md`). See
[`fixtures/README.md`](fixtures/README.md) for the complete catalog with
descriptions, seeded violations, and guidance on reusing fixtures in other
eval suites.

- **16 ARM OpenAPI specs** in `arm-openapi/` -- 2 clean + 12 with seeded
  violations + 1 TypeSpec-generated + 1 denylist pattern
- **3 example JSON files** in `examples/` -- 1 clean + 2 with issues
- **2 readme.md files** in `readme/` -- suppression scenarios
- **2 suppressions.yaml files** in `suppressions-yaml/` -- missing-reason and security-rule scenarios
- **5 TypeSpec files** in `typespec/` -- segment/naming, secret/type, anti-pattern, x-ms-identifiers, denylist pattern violations
- **12 version-pair files** in `version-pairs/` -- 5 pairs for breaking change detection + 1 pair for denylist pattern severity

## Quick Start

The fastest way to run the eval suite is the **`run-evals.ps1`** script.
It handles everything: cloning the vally framework, installing
dependencies, building, running all tests, and printing a summary.

Prerequisites: [Node.js](https://nodejs.org/) >= 20, npm, Git, and
VS Code with GitHub Copilot active.

```powershell
cd .github/skills/evals/arm-api-reviewer

# Run the full suite (58 stimuli, sequential -- safest)
.\run-evals.ps1

# Point to an existing vally clone instead of re-cloning
.\run-evals.ps1 -VallyRepo "C:\repos\vally"

# Run a single category
.\run-evals.ps1 -Suite "eval-operations"

# Faster iteration: override the model, use 3 workers
.\run-evals.ps1 -Model "claude-sonnet-4.6" -Workers 3

# Skip rebuild if vally is already built
.\run-evals.ps1 -SkipBuild
```

The script will:

1. **Clone** [microsoft/vally](https://github.com/microsoft/vally)
   as a sibling to your azure-rest-api-specs repo (or use `-VallyRepo`
   to point to an existing clone).
2. **Install & build** the vally CLI.
3. **Run** the eval suite and stream color-coded output.
4. **Print a summary** with pass/fail counts, failed stimulus details,
   and per-suite breakdown.
5. **Save results** to `results/<timestamp>/` (includes `results.jsonl`,
   `eval-results.md`, and `eval-results.junit.xml`).

Run `Get-Help .\run-evals.ps1 -Detailed` for all parameters.

## Framework version

This suite runs **locally only** today. No workflow in this repo wires it into
CI: nothing under `.github/workflows/` invokes `run-evals.ps1` or the shard
runner, so the numbers quoted in this README come from local runs.

There are two ways vally gets acquired, and they are pinned differently:

| Path                                         | Source                                                                  | Version                                       |
| -------------------------------------------- | ----------------------------------------------------------------------- | --------------------------------------------- |
| Local (`run-evals.ps1`)                      | `git clone https://github.com/microsoft/vally` built from source        | **Unpinned** -- tracks the default branch     |
| CI shard runner (`eng/common/scripts/eval/`) | `@microsoft/vally-cli` from npm, installed from the committed lock file | **Pinned** (see that folder's `package.json`) |

`run-evals.ps1` clones without a ref and runs `git pull --ff-only` on an
existing clone, so a local run always uses whatever is at the tip of vally's
default branch. That is convenient for inner-loop work but means **local
results are not guaranteed to reproduce**: a vally change to grader semantics
or the copilot-sdk executor can move scores without any change in this repo.
When a score shifts unexpectedly, check whether vally moved before assuming
the reviewer guidance regressed, and record the vally commit alongside any
score you intend to treat as a baseline (`git -C <vally-repo> rev-parse --short HEAD`).

To reproduce against the version CI would use, pass `-VallyRepo` pointing at a
clone checked out to the tag matching the pinned `@microsoft/vally-cli`
version in `eng/common/scripts/eval/package.json`. That folder is synced from
`Azure/azure-sdk-tools`; bump the pin there, not here. If this suite is later
added to CI, it should go through that same pinned shard runner so local and
CI agree.

## Running Manually with the vally CLI

If you prefer to invoke the CLI directly (e.g., on Linux/macOS or in CI),
clone [microsoft/vally](https://github.com/microsoft/vally) and
run `npm install && npm run build`.

The `.vally.yaml` at `.github/skills/evals/arm-api-reviewer/` configures the eval
file location and a named suite for running the full eval suite in a single
command. (The file is named `.vally.yaml` because that is the filename the vally
CLI looks for; do not rename it.) Execution config (`model`, `judge_model`,
`runs`, `timeout`) is set in each individual eval YAML file.

Each eval file declares the skill under test **once**, at the file root:

```yaml
environment:
  skills:
    - "../../../azure-api-review"
```

vally merges the root environment into every stimulus environment (skills, files
and commands are concatenated), so individual stimuli only carry their own
`files` mappings. The path is resolved relative to the eval file, not to the
working directory or to `.vally.yaml`.

This block is required -- `paths.skills` in `.vally.yaml` does **not** load
skills on its own; vally only performs skill discovery when `--skill-dir` is
passed on the command line, and neither `run-evals.ps1` nor the CI shard runner
(`eng/common/scripts/eval/invoke-eval-shard.ts`) passes it. Declaring it in the
eval file is also fail-loud: vally aborts the run when a declared skill directory
has no `SKILL.md`, so a typo cannot silently produce a skill-free run. Do not
remove it when adding stimuli to a file, and include it when adding a new eval
file -- a file without `environment.skills` runs against a bare model and
measures general model knowledge rather than the reviewer's guidance and rule
definitions.

```bash
cd .github/skills/evals/arm-api-reviewer

# Set VALLY_CLI to the built CLI entry point in your local vally clone
# (vally is a monorepo; the CLI binary lives under packages/cli)
export VALLY_CLI="/path/to/vally/packages/cli/dist/index.js"

# Run the full suite (all 58 stimuli, 5 concurrent workers)
node $VALLY_CLI eval --suite all --verbose

# Run a single category
node $VALLY_CLI eval -e vally/eval-arm-resource-structure.yaml --verbose

# Override the agent model for faster inner-loop iteration
node $VALLY_CLI eval --suite all --model claude-sonnet-4.6 --verbose

# Save results to a directory (includes results.jsonl + eval-results.md)
node $VALLY_CLI eval --suite all --output-dir ./results --verbose

# Override the per-stimulus timeout (in milliseconds; default 120000 = 2 min)
node $VALLY_CLI eval --suite all --timeout 600000 --verbose
```

Replace `/path/to/vally` with the path to your local clone of
`microsoft/vally`. The CLI entry point is at
`packages/cli/dist/index.js` inside the vally repo (run `npm run build`
first). See the
[vally documentation](https://github.com/microsoft/vally) for additional
options (`--workers`, `--runs`, `--judge-model`, `--junit`, etc.).

### Avoiding session timeouts

The copilot-sdk executor spawns VS Code Copilot agent sessions for each
stimulus. These sessions can time out (`Timeout after 120000ms waiting for
session.idle`) if they compete for resources with other active sessions.
To avoid timeouts:

- **Close all Copilot chat sessions** before running the eval suite. An
  active chat conversation in the same VS Code window competes with the
  executor for agent sessions.
- **Use `--workers 1`** if timeouts persist. This runs stimuli
  sequentially instead of 5 at a time, eliminating session contention.
- **Run from a dedicated VS Code window** with no other Copilot
  activity (no chat, no inline completions in progress).

### Timeout configuration

The per-stimulus timeout controls how long vally waits for an agent session
to complete. There are three levels, applied in priority order:

| Level     | Location                               | Unit         | Example            |
| --------- | -------------------------------------- | ------------ | ------------------ |
| CLI flag  | `--timeout <ms>`                       | milliseconds | `--timeout 600000` |
| Eval file | `config.timeout` in each `eval-*.yaml` | seconds      | `timeout: 600`     |
| Default   | hardcoded in vally                     | seconds      | `120` (2 min)      |

> **Note:** Each eval file declares its own `config` block (`runs`,
> `timeout`, `model`, `judge_model`). The suite definition in
> `.vally.yaml` specifies `description`, `evals`, and `executor` -- it
> does not carry per-eval execution config. To override values, use the
> CLI flags or edit the individual eval YAML files directly.

## Grader Types

| Grader               | Purpose                                                           |
| -------------------- | ----------------------------------------------------------------- |
| `output-contains`    | Substring match on agent output (keywords, rule IDs)              |
| `output-matches`     | Regex match on agent output                                       |
| `output-not-matches` | Negative regex match (e.g., no em dashes)                         |
| `prompt`             | LLM-as-judge evaluation of agent output against `rubric` criteria |

Vally eval files also use `constraints.expect_skills` to verify the
`azure-api-review` skill is activated during each stimulus. That constraint is an
assertion about the result, not a loader -- the skill itself is loaded by the
eval file's root `environment.skills` (see
[Running Manually with the vally CLI](#running-manually-with-the-vally-cli)).

## Including Test Reports in PRs

When submitting a PR that modifies the ARM API Reviewer agent, its instruction
files, or the `azure-api-review` skill, run the eval suite and include the
results in your PR description or as a comment:

1. Run the eval suite: `.\run-evals.ps1` (or the manual commands above).
2. Attach the `results.jsonl` and/or `eval-results.md` from the
   `results/<timestamp>/` directory to your PR.
3. Summarize pass/fail counts in the PR description so reviewers can quickly
   assess the impact of your changes.

> **Baseline:** results recorded before the eval files declared
> `environment.skills` were produced without the `azure-api-review` skill loaded
> and describe bare-model behaviour on the stimulus prompts. They are not
> comparable to skill-loaded results -- the first skill-loaded run establishes a
> new baseline rather than showing a regression or improvement.

## Non-Deterministic Tests

The `clean-arm-spec-no-blocking-issues` and `clean-proxy-resource-no-blocking-issues`
stimuli (09xxxx) are known to be non-deterministic. They test false-positive
resistance on fully compliant specs and may intermittently fail when the agent
escalates best-practice recommendations to ERROR severity. This is inherent LLM
variability, not a systematic defect -- re-runs typically pass. If you see these
stimuli fail but all other stimuli pass, it is safe to re-run the suite.

## Adding New Tests

1. **Add a fixture** in `fixtures/` (or reuse an existing one).
2. Add a `stimulus` entry in the appropriate `vally/eval-*.yaml`
   file. Include `rubric` criteria for the `prompt` grader.
3. Follow the naming convention: `{category}{sequence}-{description}`.
4. Run the eval to verify the new test works before submitting.
