# ARM API Reviewer -- Evaluation Suite

Evaluation tests for the **ARM API Reviewer** agent using the
[evaluate](https://github.com/microsoft/evaluate) (vally) framework.

## Directory Structure

```text
arm-api-reviewer/
├── .vally.yaml            # Vally project config (skill discovery, eval paths, suites)
├── evaluate/              # Evaluate (vally) eval definitions (11 files)
│   ├── eval-arm-resource-structure.yaml
│   ├── eval-property-design.yaml
│   ├── eval-operations.yaml
│   ├── eval-breaking-changes.yaml
│   ├── eval-suppressions.yaml
│   ├── eval-examples.yaml
│   ├── eval-typespec.yaml
│   ├── eval-check-name-availability.yaml
│   ├── eval-true-negatives.yaml
│   ├── eval-classification.yaml
│   └── eval-report-format.yaml
├── fixtures/              # Test fixtures (31 files)
│   ├── arm-openapi/       # ARM OpenAPI specs with seeded violations
│   ├── examples/          # Example JSON files (good and bad)
│   ├── readme/            # readme.md suppression files
│   ├── typespec/          # TypeSpec files with seeded violations
│   └── version-pairs/     # Version pairs for breaking change detection
└── README.md              # This file
```

## Test Categories (28 test cases across 11 eval files)

| ID     | Category                | Count | Description                                                   |
| ------ | ----------------------- | ----- | ------------------------------------------------------------- |
| 01xxxx | ARM resource structure  | 3     | Missing CRUD ops, missing provisioningState, inline types     |
| 02xxxx | Property design         | 4     | Secrets, naming, descriptions, enums                          |
| 03xxxx | Operations              | 4     | PATCH, PUT, DELETE, LRO violations                            |
| 04xxxx | Breaking changes        | 4     | Removed property, type change, enum narrowing, added required |
| 05xxxx | Suppression analysis    | 2     | Missing reason, security rule suppressions                    |
| 06xxxx | Example file validation | 2     | Bad resource ID, realistic secrets                            |
| 07xxxx | TypeSpec review         | 3     | Segment casing, secrets, anti-patterns                        |
| 08xxxx | Check Name Availability | 1     | Custom CNA models, missing input validation                   |
| 09xxxx | True negatives          | 3     | Clean spec, clean example, clean proxy resource               |
| 10xxxx | Classification          | 1     | NEW vs EXISTING issue tagging                                 |
| 11xxxx | Report format           | 1     | Line numbers, rule IDs, structured output                     |

## Fixtures

All 32 fixture files live in `fixtures/`. See
[`fixtures/README.md`](fixtures/README.md) for the complete catalog with
descriptions, seeded violations, and guidance on reusing fixtures in other
eval suites.

- **14 ARM OpenAPI specs** in `arm-openapi/` -- 2 clean + 12 with seeded violations
- **3 example JSON files** in `examples/` -- 1 clean + 2 with issues
- **2 readme.md files** in `readme/` -- suppression scenarios
- **3 TypeSpec files** in `typespec/` -- segment/naming, secret/type, anti-pattern violations
- **10 version-pair files** in `version-pairs/` -- 5 pairs for breaking change detection

## Running with Evaluate (vally)

Prerequisites: [Node.js](https://nodejs.org/) >= 20 and npm >= 11.11.1.
Clone [microsoft/evaluate](https://github.com/microsoft/evaluate),
then `npm install && npm run build`.

The `.vally.yaml` at `.github/skills/evals/arm-api-reviewer/` configures skill
auto-discovery (via `paths.skills`), eval file location, and a named suite for
running the full eval suite in a single command. Execution config (`model`,
`judge_model`, `runs`, `timeout`) is set in each individual eval YAML file.
Skills are discovered automatically -- individual eval files do not need to
declare `environment.skills`.

```bash
cd .github/skills/evals/arm-api-reviewer

# Set VALLY_CLI to the built CLI entry point in your local evaluate clone
# (evaluate is a monorepo; the vally binary lives under packages/cli)
export VALLY_CLI="/path/to/evaluate/packages/cli/dist/index.js"

# Run the full suite (all 28 stimuli, 5 concurrent workers)
node $VALLY_CLI eval --suite all --verbose

# Run a single category
node $VALLY_CLI eval -e evaluate/eval-arm-resource-structure.yaml --verbose

# Override the agent model for faster inner-loop iteration
node $VALLY_CLI eval --suite all --model claude-sonnet-4.6 --verbose

# Save results to a directory (includes results.jsonl + eval-results.md)
node $VALLY_CLI eval --suite all --output-dir ./results --verbose

# Override the per-stimulus timeout (in milliseconds; default 120000 = 2 min)
node $VALLY_CLI eval --suite all --timeout 600000 --verbose
```

Replace `/path/to/evaluate` with the path to your local clone of
`microsoft/evaluate`. The CLI entry point is at
`packages/cli/dist/index.js` inside the evaluate repo (run `npm run build`
first). See the
[evaluate documentation](https://github.com/microsoft/evaluate) for additional
options (`--workers`, `--runs`, `--judge-model`, `--junit`, etc.).

> **PowerShell users:** Use `$env:VALLY_CLI` instead of `$VALLY_CLI`:
>
> ```powershell
> $env:VALLY_CLI = "C:\repos\evaluate\packages\cli\dist\index.js"
> node $env:VALLY_CLI eval --suite all --verbose
> ```

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
> `.vally.yaml` only specifies `description` and `evals` -- it does not
> carry execution config. To override values, use the CLI flags or edit
> the individual eval YAML files directly.

## Grader Types

| Grader               | Purpose                                                           |
| -------------------- | ----------------------------------------------------------------- |
| `output-contains`    | Substring match on agent output (keywords, rule IDs)              |
| `output-matches`     | Regex match on agent output                                       |
| `output-not-matches` | Negative regex match (e.g., no em dashes)                         |
| `prompt`             | LLM-as-judge evaluation of agent output against `rubric` criteria |

Vally eval files also use `constraints.expect_skills` to verify the
`azure-api-review` skill is activated during each stimulus.

## Including Test Reports in PRs

When submitting a PR that modifies the ARM API Reviewer agent, its instruction
files, or the `azure-api-review` skill, run the eval suite and include the
results in your PR description or as a comment:

1. Run the eval suite (see commands above).
2. Attach the `results.jsonl` and/or `eval-results.md` from the
   `--output-dir` directory to your PR.
3. Summarize pass/fail counts in the PR description so reviewers can quickly
   assess the impact of your changes.

## Non-Deterministic Tests

The `clean-arm-spec-no-blocking-issues` and `clean-proxy-resource-no-blocking-issues`
stimuli (09xxxx) are known to be non-deterministic. They test false-positive
resistance on fully compliant specs and may intermittently fail when the agent
escalates best-practice recommendations to ERROR severity. This is inherent LLM
variability, not a systematic defect -- re-runs typically pass. If you see these
stimuli fail but all other stimuli pass, it is safe to re-run the suite.

## Adding New Tests

1. **Add a fixture** in `fixtures/` (or reuse an existing one).
2. Add a `stimulus` entry in the appropriate `evaluate/eval-*.yaml`
   file. Include `rubric` criteria for the `prompt` grader.
3. Follow the naming convention: `{category}{sequence}-{description}`.
4. Run the eval to verify the new test works before submitting.
