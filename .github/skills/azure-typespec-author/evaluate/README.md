# Azure TypeSpec Author Skill Evaluations

This directory contains [Vally](https://aka.ms/vally) evaluation cases for the `azure-typespec-author` skill.

## Prerequisites

- [Vally CLI](https://aka.ms/vally) 0.14.0. A global installation is convenient, but setup
  installs and selects the repository-pinned copy under `eng/common/scripts/eval`.
- Node.js 24.14.1 or newer and npm available on `PATH`; setup installs the pnpm version pinned by
  the spec repository.
- A pinned, approved prebuilt `azsdk-cli` MCP artifact.
- An API key for the model configured (e.g., Anthropic or OpenAI key via environment variable)

> **Platform note:** Run these evaluations on Linux or in WSL when possible. On native Windows,
> installing Vally 0.14.0 may fail while building `better-sqlite3` with `node-gyp`, even with a
> supported Node.js 22 installation. Native Windows installation requires the Visual Studio
> **Desktop development with C++** workload and a VC++ toolset; otherwise use Linux or WSL.

## Environment Setup

### Prepare Vally, fixtures, and a prebuilt MCP binary

Before running any evals, obtain an approved prebuilt MCP artifact and run setup from
this directory. Setup never clones or builds azure-sdk-tools. It validates Vally,
uses the current spec checkout and package catalog, prepares fixture dependencies,
and prints the environment variables needed by local Vally runs:

```powershell
# PowerShell
node scripts/setup-environment.js --mcp-kind live `
  --mcp-root C:\path\to\pinned-mcp-artifact | Invoke-Expression
```

```bash
# Bash / Zsh
eval "$(node scripts/setup-environment.js --mcp-kind live --mcp-root /path/to/pinned-mcp-artifact)"
```

Vally 0.14 isolates the Copilot config home by default. For local runs that authenticate through
`copilot login`, explicitly allow the executor to reuse the host profile:

```powershell
# PowerShell
$env:EVALUATE_USE_HOST_COPILOT_HOME = "1"
```

```bash
# Bash / Zsh
export EVALUATE_USE_HOST_COPILOT_HOME=1
```

Keep this opt-in local.

Setup rewrites scalar eval specs to the selected local environment. Choose `mock`
only when an approved mock artifact is available:

```powershell
node scripts/setup-environment.js --mcp-kind mock `
  --mcp-root C:\path\to\pinned-mcp-artifact | Invoke-Expression
```

Local live and mock runs use `environment: azsdk-mcp-local` and
`environment: azsdk-mcp-mock-local`, respectively. Both run prebuilt DLLs; neither uses
`dotnet run`. Do not rerun setup just to switch MCP kind because setup rebuilds both binaries and
refreshes the fixtures. Instead, change the root environment in the eval files being run:

```yaml
# Local live MCP
environment: azsdk-mcp-local

# Local mock MCP
environment: azsdk-mcp-mock-local

# Committed live MCP environment
environment: azsdk-mcp
```

For a single-case run, change only that eval file. For a suite run, replace the environment in all
participating files under `evals/`. Local environment overrides should not be committed; restore
`environment: azsdk-mcp` before committing.

`setup-environment.js` does the following:

1. Restore and select the repository-pinned Vally 0.14.0 toolchain, then verify the selected
   prebuilt MCP artifact.
2. Set scalar eval specs to the selected local prebuilt environment.
3. Install the pnpm version pinned by the current spec checkout and run
   `pnpm install --frozen-lockfile` at the repository root.
4. Generate the fixture `package.json` from the current checkout's pnpm catalog and copy
   `.github/copilot-instructions.md` into `fixtures/instructions-test/copilot-instructions.md`.
5. Verify fixture dependencies and print shell commands that export `AZSDK_EVAL_REPO_ROOT`,
   `AZSDK_EVAL_MCP_ROOT`, and `FIXTURE_NODE_MODULES`.

Why each piece matters:

- **`FIXTURE_NODE_MODULES`** lets the agent symlink the spec repository's pnpm-installed root
  `node_modules` instead of installing dependencies in every case.
- **Generated fixture package metadata** keeps every dependency version aligned with the spec
  repository's pnpm catalog. Dependency graders read this package directly, so newly added fixture
  dependencies are checked automatically.
- **`copilot-instructions.md`** is copied into each run's `.github/` by the `azsdk-mcp` environments
  in `.vally.yaml`, so evals exercise the _real_ spec-repo authoring guidance. It is generated
  locally, should remain untracked, and is refreshed from the current checkout.

## Running Evaluations Locally

Run local evaluations from this directory (`.github/skills/azure-typespec-author/evaluate`) using
the local/default `evaluate/.vally.yaml`.

The configuration mounts the authoring and shared naming skills, plus the assessment and
SDK-generation skills used by routing-boundary cases. Only `SKILL.md` and references remain
in the mounted copies before the agent starts; evaluator content is removed.

Naming cases `007001` through `007008` compare trigger, forced, and no-skill behavior for
client configuration planning, direct-edit handoffs, opt-outs, and documentation-only changes.
Cases `007009` through `007014` check routing boundaries in trigger mode only.

### Local forced smoke test

Use these commands for the usual local check. Use forced mode only for this remediation work:

```powershell
# Ensure the eval spec uses: environment: azsdk-mcp-local
vally eval --suite forced --workers 1 --runs 1 `
  --output-dir ./results/forced --workspace ./results/forced-workspaces --verbose
```

Do not run trigger or no-skill modes for the remediation validation.

### Which file to use

Use different entry files depending on your goal:

| File                     | When to use                            | Example command                                                                                                                     |
| ------------------------ | -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `evaluate/.vally.yaml`   | Default local entry; run by suite name | `vally eval --suite forced --output-dir ./result --workspace ./debug --verbose`                                                     |
| `evals/00xxxx.eval.yaml` | Debug one specific case file           | `vally eval --eval-spec evals/003001.eval.yaml --tag mode=forced --output-dir ./result-003001 --workspace ./debug-003001 --verbose` |

Notes:

- Use `--suite` for local mode-wide runs because `evaluate/.vally.yaml` defines the Azure TypeSpec
  Author suites.
- Use `--eval-spec` + `--tag` for single-file targeted mode runs.

### Run a named forced suite

Test suites are defined in `evaluate/.vally.yaml` under the `suites` key. This is the preferred
local entry point.

| Suite                         | Description                                    |
| ----------------------------- | ---------------------------------------------- |
| `versioning-forced`           | Versioning cases (001xxx) — forced mode        |
| `armtemplate-forced`          | ARM template cases (002xxx) — forced mode      |
| `longrunningoperation-forced` | Long-running operation cases (003xxx) — forced |
| `decorators-forced`           | Decorator cases (004xxx) — forced mode         |
| `warning-forced`              | Warning cases (005xxx) — forced mode           |
| `dataplane-forced`            | Data-plane cases (006xxx) — forced mode        |
| `naming-forced`               | Client configuration and naming handoffs       |
| `naming-trigger`              | Naming handoffs and skill routing boundaries   |
| `naming-no-skill`             | Naming task quality without installed skills   |
| `forced`                      | All cases — forced mode                        |

Run a suite by name using the configured skill mounts:

```powershell
vally eval --suite forced --output-dir ./result --workspace ./debug --verbose
```

### Run a single forced evaluation file

Use `--eval-spec` + `--tag mode=forced` only when debugging one specific case file.

```powershell
vally eval --eval-spec evals/001001.eval.yaml --tag mode=forced --output-dir ./result-forced --workspace ./debug-forced --verbose
```

### Vally local runs

For local forced runs, use the skills mounted by `evaluate/.vally.yaml`. The prompts still
include the `@azure-typespec-author` prefix, and the evals still use `skill-invocation` graders to
verify that the skill was invoked.

For a no-skill baseline, use a temporary configuration without `environments.*.skills`
and pass `--skill-dir` pointing to an empty directory. Explicit environment skill mounts
take precedence over `--skill-dir`; an empty directory alone does not disable them.
Do not commit local baseline configuration changes.

Result output includes run metadata such as `Turns`, `Tool Calls`, `Executor: copilot-sdk`, and JSONL
fields (`type`, `itemId`, `stimulus`, `durationMs`, `workspacePath`). Because tool-call tracking is
strict, forced-mode failures often mean the agent did not call a required tool such as
`azure-sdk-mcp-azsdk_run_typespec_validation`. When debugging local runs, keep `--verbose` enabled
and inspect the `Tool Calls` column in `eval-results.md` or the trial entries in `results.jsonl`.

### Run a subset suite (optional)

Domain-specific suites are useful for ad-hoc local runs on one scenario family:

```powershell
# Run forced mode for versioning cases only
vally eval --suite versioning-forced
```

### Useful flags

| Flag            | Purpose                                                   |
| --------------- | --------------------------------------------------------- |
| `--runs <n>`    | Override the number of trials per stimulus for local runs |
| `--verbose`     | Show full agent output during the run                     |
| `--workers <n>` | Run multiple stimuli in parallel (default: 5)             |

Use exactly one worker for remediation validation so MCP calls and fixture workspaces
remain attributable to a single trial.

## Results

Results are written to the `results/` directory after each run. You can rerun graders with:

```bash
vally eval --eval-spec evals/001001.eval.yaml --tag mode=forced --skip-grade --output jsonl | vally grade --eval-spec evals/001001.eval.yaml
```

```bash
vally grade --eval-spec evals/001001.eval.yaml < results/results.jsonl
```

The compiled-service grader accepts inline or imported Employee definitions and rejects
unreachable resources or missing standard operations. With fixture dependencies prepared,
run its unit tests from this directory:

```powershell
node --test scripts\check-employee-service.test.mjs
```

## File Structure

```
evaluate/
├── .vally.yaml          # Vally configuration: environments, suites, paths
├── evals/               # Individual eval specs (one per test case, for local dev)
│   ├── 001001.eval.yaml
│   ├── ...
├── fixtures/            # TypeSpec project fixtures referenced by evals
│   ├── 001-share-version-new-feature/
│   ├── Microsoft.Widget/
│   └── ...
├── scripts/             # Setup and utility scripts
├── results/             # Eval run output
└── debug/               # Eval run workspace
```
