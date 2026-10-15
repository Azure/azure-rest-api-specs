# Agentic doc-refinement for `azure-typespec-author`

Design + implementation of a single-pass agentic refinement workflow that closes the
gap between the skill's reference documentation, the Vally code-quality evals, and the
resulting gap analysis. Rerun the workflow after committing accepted documentation
changes to iterate toward better eval results.

This is maintainer tooling, not part of normal skill invocation. The skill and this
workflow are maintained in `Azure/azure-rest-api-specs`; the evaluation pipeline and
fixtures remain in `Azure/azure-sdk-tools`.

**Current support:** Run local maintenance with `--skip-eval` (steps 1-2).
Full evaluation (steps 3-5) is blocked: the existing tools benchmark resolves skill
refs against its own repository and does not support the `SkillRepository` parameter
sent by this workflow. The companion tools PR only removes the old maintenance
directory; it does not change evaluation. Cross-repository benchmark support requires
a separate follow-up and is not included in this relocation.

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

- **Script**: `doc-refinement.ts` (this folder). Run `npm ci`, then
  `node doc-refinement.ts --skip-eval`.
  Node.js runs the TypeScript entry point directly using built-in type stripping;
  no compilation step is needed to run the workflow.
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

  This integration is currently blocked. The script sends
  `SkillRepository=https://github.com/Azure/azure-rest-api-specs.git` and `SkillBranch`,
  but the existing benchmark cannot fetch specs-hosted refs. Do not run steps 3-5
  until separately requested cross-repository support is implemented. `--skip-eval`
  does not require that pipeline.

> **Steps 1 & 2 never commit.** The agent leaves the reference-doc and skill edits
> **unstaged in the working tree** so you can review them and decide whether to commit.
> The orchestrator's system message and the step 1/2 prompts forbid `git add`/`commit`/
> `push`, and shell access is denied by the permission handler, so an autonomous run
> cannot commit them on your behalf.
>
> **Pipeline boundary:** ADO can evaluate only committed and pushed content. If Steps
> 1-2 create local changes, the full run stops before queueing the pipeline. Run once
> with `--skip-eval`, then review/commit/push the changes. Rerunning without
> `--skip-eval` also requires the separate benchmark integration described above.

### Flow

```
npm run refine (full flow; currently blocked)
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

- By default, the script attempts all five steps, but full evaluation is currently
  blocked by the missing cross-repository benchmark integration.
- Use `--skip-eval` to run supported steps 1-2 only and skip steps 3-5 (Vally,
  analysis, and report).

```
npm run refine -- -- --skip-eval --model gpt-5.6-sol
node doc-refinement.ts --skip-eval
node doc-refinement.ts --help
node doc-refinement.ts --skip-eval --model gpt-5.5 --idle-timeout 1800
```

The removed `--update-skill-only` mode is replaced by `--skip-eval`.
When passing options through npm on Windows, use the second standalone `--` shown above
so npm forwards the option name instead of converting it to `npm_config_*`. Direct
`node doc-refinement.ts ...` invocation does not need the extra separator.

`--skill-ref` is resolved against `Azure/azure-rest-api-specs`. After the separate
benchmark integration is available, a full run can use `--skill-ref refs/heads/main`
or a specs pull-request ref such as `refs/pull/<number>/head`. `--results-dir` selects
the base directory for those evaluation artifacts and reports.

### Prerequisites

- Node.js >= 24.14.1, matching the repository's minimum version and supporting
  direct TypeScript execution.
- `npm ci` in this folder (installs the Copilot SDK/CLI and ZIP extraction dependency).
- GitHub Copilot CLI installed & authenticated - the SDK spawns it (`copilot login`), or
  set `COPILOT_GITHUB_TOKEN`.
- For future full runs: separate cross-repository benchmark support, plus Azure CLI
  installed and authenticated to the `azure-sdk/internal` ADO project (`az login`).
- For future full runs: the evaluated `SKILL.md` and `references/` changes committed and pushed to the current
  upstream branch or GitHub PR ref. Use `--skill-ref` when auto-detection is not suitable.
- Use `--skip-eval` for local reference-document and skill updates; this is the
  currently supported workflow.

### Development checks

Install the repository's shared development dependencies with `pnpm install` at the
repository root, then run `npm ci` in this folder. Run `npm run check` and `npm test`
here for strict TypeScript checking and hermetic workflow tests. The tests mock
Copilot, Git/Azure CLI commands, and Azure DevOps responses; they do not queue live
agents or benchmark builds.

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
|- doc-refinement.ts      # Copilot SDK + ADO pipeline orchestrator
|- doc-refinement.test.ts # hermetic workflow tests
|- tsconfig.json          # shared strict TypeScript settings
|- vitest.config.ts       # focused test project
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
