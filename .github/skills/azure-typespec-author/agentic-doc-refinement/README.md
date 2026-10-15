# Agentic doc-refinement for `azure-typespec-author`

Design + implementation of a single-pass agentic refinement workflow that closes the
gap between the skill's reference documentation, the Vally code-quality evals, and the
resulting gap analysis. Rerun the workflow after committing accepted documentation
changes to iterate toward better eval results.

This is maintainer tooling, not part of normal skill invocation. The skill and this
workflow are maintained in `Azure/azure-rest-api-specs`; the evaluation pipeline and
fixtures remain in `Azure/azure-sdk-tools`.

## Goal

Automate the manual loop we run today:

1. Update the skill's **reference documents** using a defined prompt.
2. Update the skill **markdown** (`SKILL.md` / `references/*`) if needed.
3. Run the **Vally code-quality evals**.
4. Analyze the results to find, per case, **why it failed** and whether the failure is
   caused by a **documentation-coverage gap**.
5. Produce an **analysis report** with two sections: per-case failure reasons and the
   identified documentation gaps.

## Which steps are agent vs. deterministic

| Step                    | Kind                        | Driven by                                           |
| ----------------------- | --------------------------- | --------------------------------------------------- |
| 1 Update reference docs | Agent (reasoning)           | Copilot SDK + `prompts/01-update-reference-docs.md` |
| 2 Update skill markdown | Agent (reasoning)           | Copilot SDK + `prompts/02-update-skill.md`          |
| 3 Run Vally evals       | Deterministic (infra-heavy) | ADO benchmark pipeline (definition 8178)            |
| 4 Analyze results       | Agent (reasoning)           | Copilot SDK + `prompts/04-analyze-results.md`       |
| 5 Generate report       | Agent (reasoning)           | Copilot SDK + `prompts/05-generate-report.md`       |

## Run it as code with the Copilot SDK

**Chosen approach.** A single Node program updates the documentation locally, then
triggers the internal Azure DevOps benchmark pipeline for the Vally run and downloads
that build's code-quality artifact for analysis.

Why this is the default: the _forced_ (code-quality) eval is infra-heavy. Vally spawns the
`azsdk-cli` MCP server and needs the **QA-bot KB backend** reachable on `:8088`
(`AZURE_SDK_KB_ENDPOINT`), plus a model-backed executor. That backend is internal, so the
eval runs on the ADO benchmark pool instead of requiring that infrastructure on the
local machine.

- **Script**: `doc-refinement.mjs` (this folder). Run with `npm ci && npm run refine`.
- **Agent steps (1, 2, 4, 5)** use the **Copilot SDK** (`@github/copilot-sdk`):
  `new CopilotClient()` -> `createSession({ model, workingDirectory, skillDirectories,
onPermissionRequest, systemMessage })` -> `session.sendAndWait({ prompt }, timeout)`.
  Steps 1-2 share one session, as do Steps 4-5, so related steps retain context. The
  permission handler denies shell access and restricts local reads/writes to the
  repository and each phase's approved output directories.
- **Step 3** queues
  [`azure-typespec-author-benchmark`](https://dev.azure.com/azure-sdk/internal/_build?definitionId=8178&_a=summary),
  waits for completion, downloads `eval-results-code-quality-<buildId>`, and extracts it
  into the current timestamped result directory.

  The benchmark receives `SkillRepository=https://github.com/Azure/azure-rest-api-specs.git`
  and `SkillBranch` so it evaluates the specs-hosted skill, not the tools repository's
  copy. The tools pipeline must support the `SkillRepository` parameter before running
  steps 3-5; `--skip-eval` does not require that pipeline.

  > **Steps 1 & 2 never commit.** The agent leaves the reference-doc and skill edits

> **unstaged in the working tree** so you can review them and decide whether to commit.
> The orchestrator's system message and the step 1/2 prompts forbid `git add`/`commit`/
> `push`, and shell access is denied by the permission handler, so an autonomous run
> cannot commit them on your behalf.
>
> **Pipeline boundary:** ADO can evaluate only committed and pushed content. If Steps
> 1-2 create local changes, the full run stops before queueing the pipeline. Run once
> with `--skip-eval`, review/commit/push the changes, then rerun without `--skip-eval`.

### Flow

```
npm run refine
  |
  |- 1. agent -> references/reference-document-links.md
  |- 2. agent -> SKILL.md / references/*   (only if needed)
  |- 3. queue ADO definition 8178 -> download code-quality artifact
  |      -> results/<run-id>/**/results.jsonl
  |- 4. agent -> results/<run-id>/analysis.md
  |- 5. agent -> results/<run-id>/document-gaps.md
```

### CLI

The workflow has one phase switch:

- By default, run all five steps.
- `--skip-eval` runs steps 1-2 only and skips steps 3-5 (Vally, analysis, and report).

```
npm run refine
npm run refine -- -- --skip-eval --model gpt-5.6-sol
node doc-refinement.mjs --skip-eval
node doc-refinement.mjs --skill-ref refs/heads/main
npm run refine -- -- --skill-ref refs/heads/main
node doc-refinement.mjs --help
node doc-refinement.mjs --model gpt-5.5 --idle-timeout 1800
node doc-refinement.mjs --results-dir C:\temp\typespec-author-results
```

The removed `--update-skill-only` mode is replaced by `--skip-eval`.
When passing options through npm on Windows, use the second standalone `--` shown above
so npm forwards the option name instead of converting it to `npm_config_*`. Direct
`node doc-refinement.mjs ...` invocation does not need the extra separator.

`--skill-ref` is resolved against `Azure/azure-rest-api-specs`. To evaluate a pull
request, pass its specs-repository ref, such as `refs/pull/<number>/head`.

### Prerequisites

- `npm ci` in this folder (installs the Copilot SDK/CLI and ZIP extraction dependency).
- GitHub Copilot CLI installed & authenticated - the SDK spawns it (`copilot login`), or
  set `COPILOT_GITHUB_TOKEN`.
- Azure CLI installed and authenticated to the `azure-sdk/internal` ADO project
  (`az login`) for Step 3.
- The evaluated `SKILL.md` and `references/` changes committed and pushed to the current
  upstream branch or GitHub PR ref. Use `--skill-ref` when auto-detection is not suitable.
- Use `--skip-eval` when only the local reference-document and skill updates are needed.

## Prompt -> file mapping

| Prompt                                | Reads                              | Writes                                      |
| ------------------------------------- | ---------------------------------- | ------------------------------------------- |
| `prompts/01-update-reference-docs.md` | typespec-azure + typespec.io docs  | `references/reference-document-links.md`    |
| `prompts/02-update-skill.md`          | updated references                 | `SKILL.md`, `references/*` (only if needed) |
| `prompts/04-analyze-results.md`       | current build's `**/results.jsonl` | `results/<run-id>/analysis.md`              |
| `prompts/05-generate-report.md`       | step-4 analysis                    | `results/<run-id>/document-gaps.md`         |

## Layout

```
agentic-doc-refinement/
|- README.md              # this design + usage
|- doc-refinement.mjs     # Copilot SDK + ADO pipeline orchestrator
|- package.json           # pins Copilot SDK/CLI + artifact ZIP dependency
|- package-lock.json      # reproducible standalone npm install
|- prompts/
   |- 01-update-reference-docs.md
   |- 02-update-skill.md
   |- 04-analyze-results.md
   |- 05-generate-report.md
```

`results/` in this folder is gitignored. Each complete run writes to a new timestamped
subdirectory so failed runs cannot reuse earlier JSONL, analysis, or report files.

## Open assumptions

- "Defined prompts" = the four `prompts/*.md` files (seeded from the existing
  reference-doc sync prompt and the timestamped `document-gaps.md`
  report format). Edit those files to change agent behaviour - the orchestrator is stable.
- Default agent model is `gpt-5.5`; override with `--model` / `AGENT_MODEL`.
