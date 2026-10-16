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

Keep this opt-in local. Pipeline runs authenticate with their injected token and should retain the
default isolated Copilot home.

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

# Pipeline
environment: azsdk-mcp
```

For a single-case run, change only that eval file. For a suite run, replace the environment in all
participating files under `evals/`. Local environment overrides should not be committed; restore
`environment: azsdk-mcp` before committing. Pipeline live/mock selection remains controlled by
`AZSDK_EVAL_MCP_KIND`.

`setup-environment.js` does the following:

1. Restore and select the repository-pinned Vally 0.14.0 toolchain, then verify the selected
   prebuilt MCP artifact.
2. Set scalar eval specs to the selected local prebuilt environment.
3. Install the pnpm version pinned by the current spec checkout and run
   `pnpm install --frozen-lockfile` at the repository root.
4. Generate the fixture `package.json` from the current checkout's pnpm catalog and copy
   `.github/copilot-instructions.md` into `fixtures/instructions-test/copilot-instructions.md`.
5. Preflight all 38 forced definitions, workspace-contained destinations, writable copied
   workspaces, and untouched compilation for the historically failing fixture groups.
6. Print shell commands that export `AZSDK_EVAL_REPO_ROOT` and `FIXTURE_NODE_MODULES`.

The MCP build uses `GitHub.Copilot.SDK`, which downloads platform-specific `@github/copilot-*`
assets through MSBuild. The setup script passes
`/p:CopilotNpmRegistryUrl=https://packagefeedproxy.microsoft.io/npm/` so the download URL uses the
Microsoft package feed proxy instead of `registry.npmjs.org`. To use a different registry, set
`COPILOT_NPM_REGISTRY_URL` before running the setup script.

Why each piece matters:

- **`FIXTURE_NODE_MODULES`** lets the agent symlink the spec repository's pnpm-installed root
  `node_modules` instead of installing dependencies in every case.
- **Generated fixture package metadata** keeps every dependency version aligned with the spec
  repository's pnpm catalog. Dependency graders read this package directly, so newly added fixture
  dependencies are checked automatically.
- **`copilot-instructions.md`** is copied into each run's `.github/` by the `azsdk-mcp` environments
  in `.vally.yaml`, so evals exercise the _real_ spec-repo authoring guidance. It is intentionally
  **not** checked in (it is git-ignored) and is refreshed from the current checkout.

CI builds MCP binaries in a shared build job and runs `setup-fixture-files.js` during pre-eval setup,
so the binaries and fixtures are always present in pipeline runs.

## Running Evaluations Locally

Run local evaluations from this directory (`.github/skills/azure-typespec-author/evaluate`). Local
runs intentionally use the local/default `evaluate/.vally.yaml`; the benchmark pipelines use the
outer `.github/skills/.vally.yaml` integration described later.

### Local forced smoke test

Use these commands for the usual local check. Use forced mode only for this remediation work:

```powershell
# Ensure the eval spec uses: environment: azsdk-mcp-local
vally eval --suite forced --skill-dir .. --workers 1 --runs 1 `
  --output-dir ./results/forced --workspace ./results/forced-workspaces --verbose
```

Do not run trigger or no-skill modes for the remediation validation.

### Which file to use

Use different entry files depending on your goal:

| File                     | When to use                            | Example command                                                                                                                                    |
| ------------------------ | -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `evaluate/.vally.yaml`   | Default local entry; run by suite name | `vally eval --suite forced --skill-dir .. --output-dir ./result --workspace ./debug --verbose`                                                     |
| `evals/00xxxx.eval.yaml` | Debug one specific case file           | `vally eval --eval-spec evals/003001.eval.yaml --tag mode=forced --skill-dir .. --output-dir ./result-003001 --workspace ./debug-003001 --verbose` |

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
| `forced`                      | All cases — forced mode                        |

Run a suite by name and point it at the local skill directory:

```powershell
vally eval --suite forced --skill-dir .. --output-dir ./result --workspace ./debug --verbose
```

### Run a single forced evaluation file

Use `--eval-spec` + `--tag mode=forced` only when debugging one specific case file.

```powershell
vally eval --eval-spec evals/001001.eval.yaml --tag mode=forced --skill-dir .. --output-dir ./result-forced --workspace ./debug-forced --verbose
```

### Vally local runs

For local forced runs, pass `--skill-dir ..` from the `evaluate/` directory so Vally
discovers the `azure-typespec-author` skill directory that contains `SKILL.md`. The prompts still
include the `@azure-typespec-author` prefix, and the evals still use `skill-invocation` graders to
verify that the skill was invoked.

Result output includes run metadata such as `Turns`, `Tool Calls`, `Executor: copilot-sdk`, and JSONL
fields (`type`, `itemId`, `stimulus`, `durationMs`, `workspacePath`). Because tool-call tracking is
strict, forced-mode failures often mean the agent did not call a required tool such as
`azure-sdk-mcp-azsdk_run_typespec_validation`. When debugging local runs, keep `--verbose` enabled
and inspect the `Tool Calls` column in `eval-results.md` or the trial entries in `results.jsonl`.

Summarize the actual source-family calls and ordering from a completed run's event logs:

```powershell
node scripts/analyze-routing.js .\results\forced\<timestamp>
```

For the current 38 covered cases, the expected result is 38 Web-only trials, zero retrieval calls,
zero planner calls, grounding before the first mutation, and validation after mutation. For an
uncovered request outside this suite, Agentic Search still runs first; retrieval is permitted only
after Web cannot obtain sufficient authoritative guidance.

Run deterministic positive and negative examples for corrected syntax graders:

```powershell
node scripts/test-grader-contracts.js
node scripts/test-routing-analyzer.js
node scripts/test-skill-workflow.js
node scripts/preflight-harness.js
```

### Run a subset suite (optional)

Domain-specific suites are useful for ad-hoc local runs on one scenario family:

```powershell
# Run forced mode for versioning cases only
vally eval --suite versioning-forced --skill-dir ..
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
vally eval --eval-spec evals/001001.eval.yaml --tag mode=forced --skill-dir .. --skip-grade --output jsonl | vally grade --eval-spec evals/001001.eval.yaml
```

```bash
vally grade --eval-spec evals/001001.eval.yaml < results/results.jsonl
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
├── pipeline/            # Repo-owned Azure Pipelines templates
│   └── skill/           # Forced/trigger/no-skill benchmark templates
├── scripts/             # Setup and utility scripts
├── results/             # Eval run output
└── debug/               # Eval run workspace
```

## Pipeline Architecture

The CI runs Vally from `.github/skills` and uses the merged eval files in
`azure-typespec-author/evaluate/evals/*.eval.yaml`. Each stimulus has dual tags, for example
`{ suite: versioning, mode: forced }`. The pipeline matrix is generated from the eval files, then
each track passes its mode through `TypeSpecAuthorEvalExtraArgs`.

| Pipeline           | Template shape                                                   | Extra args                                             | MCP binding                       | Purpose                                        |
| ------------------ | ---------------------------------------------------------------- | ------------------------------------------------------ | --------------------------------- | ---------------------------------------------- |
| benchmark          | Manual two-track stages with `pipeline` templates                | `--tag mode=forced --skill-dir azure-typespec-author`  | Uses the run's selected `McpKind` | Forced skill invocation + code-quality graders |
| benchmark          | Manual two-track stages with `pipeline` templates                | `--tag mode=trigger --skill-dir azure-typespec-author` | Uses the run's selected `McpKind` | Skill trigger detection                        |
| benchmark-no-skill | Common `archetype-eval.yml` + `pipeline` no-skill invoke wrapper | `--tag mode=no-skill --skill-dir /tmp/no-skills`       | Uses its run's selected `McpKind` | Baseline run without loading the skill         |

The forced and trigger tracks are composed manually so they can run and summarize independently in
one pipeline run. Both tracks use the same live or mock MCP implementation selected by `McpKind`.
The no-skill pipeline stays on the common `archetype-eval.yml` entry point and only uses a repo-owned
wrapper for Vally invocation.

### Pipeline Parameters and Extensions

`TypeSpecAuthorEvalExtraArgs` is the primary extension point for Vally CLI options. The repo-local
invoke wrapper appends it to the final `vally eval` command, so run-level options such as
`--workers`, `--verbose`, and additional tag filters can be added without changing the templates.

Examples:

```yaml
variables:
  TypeSpecAuthorEvalExtraArgs: "--tag mode=trigger --skill-dir azure-typespec-author --workers 3"
```

```yaml
variables:
  TypeSpecAuthorEvalExtraArgs: "--tag mode=no-skill --skill-dir /tmp/no-skills --workers 2"
```

Keep mode selection in the extra args (`--tag mode=...`) because all three tracks consume the same
merged eval files.
