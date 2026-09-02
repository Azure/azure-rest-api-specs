---
name: skill-eval-authoring
license: MIT
metadata:
  version: "1.0.0"
description: 'Author and place Vally evals for Agent Skills under .github/skills. USE FOR: "add an eval for my new skill", "write a trigger eval", "where should this eval go", "add eval coverage for <skill>", "create a workflow/tool eval". DO NOT USE FOR: authoring the SKILL.md content itself, TypeSpec authoring (use azure-typespec-author), SDK generation, debugging an already-failing eval run (inspect the vally output directly).'
compatibility: "vally CLI (@microsoft/vally-cli), this repo's .github/skills/.vally.yaml and eng/pipelines/skill-eval.yml"
---

# Skill Eval Authoring

Authors new Vally eval files for skills in this repo and places them in the
correct existing or newly-created folder, following the repo's `vallyRoot`
convention instead of guessing a path.

## Rules

- **Always discover before placing.** Read `.github/skills/.vally.yaml`
  (`paths.evals`) and `eng/pipelines/skill-eval.yml` (`evalGlobs`,
  `vallyRoot`) before writing a file — never assume a hardcoded path. See
  [layout-and-placement.md](references/layout-and-placement.md).
- **Never introduce a new top-level eval tier silently.** If a new
  `evals/tools/` or `evals/workflows/{mock,live}/` folder is created for the
  first time, register it in both `.github/skills/.vally.yaml`
  (`paths.evals`) and confirm it's covered by `eng/pipelines/skill-eval.yml`
  (`evalGlobs`) — flag the change instead of leaving the pipeline blind to
  the new files.
- **Routing evals are always named `trigger.eval.yaml`**, with `type:
  capability`, a `skill-invocation` grader, and both trigger and anti-trigger
  stimuli (mount at least one sibling/competing skill so anti-triggers are
  meaningful — an anti-trigger test with no competing skill mounted always
  trivially "passes").
- **Follow the four-layer pattern** (routing → tool-use → output-shape →
  judgment) when deciding what grader(s) an eval needs — see
  [eval-design-patterns.md](references/eval-design-patterns.md).
- `scoring.weights` (if present) must sum to `1.0`; always set
  `scoring.threshold` explicitly (repo convention: `0.8`).

## Workflow

- [ ] Step 1 — Determine this repo's `vallyRoot` and existing layout
- [ ] Step 2 — Classify the eval: skill routing/capability, single-tool, or multi-skill/workflow
- [ ] Step 3 — Place the file (existing folder, or create one per convention)
- [ ] Step 4 — Write the eval content
- [ ] Step 5 — Register any new tier/path
- [ ] Step 6 — Validate locally

### Step 1: Determine `vallyRoot` and existing layout

This repo's `vallyRoot` is `.github/skills` (declared in
`eng/pipelines/skill-eval.yml`) — **not** the repo root. All eval paths in
this repo are relative to that, unlike repos where evals live at the repo
root. See [layout-and-placement.md](references/layout-and-placement.md) for
the full canonical tree and why it's `vallyRoot`-relative rather than a
fixed absolute path.

### Step 2: Classify the eval

| Category | What it tests | Canonical location (relative to `vallyRoot`) |
| --- | --- | --- |
| Skill routing/capability | One skill in isolation: does it trigger correctly, does it call the right tools, is the output shaped right | `<skill-name>/evals/*.eval.yaml` |
| Tool | A single hermetic MCP tool, prompt → tool selection | `evals/tools/*.eval.yaml` |
| Workflow | Multi-skill, multi-turn, or full-agent scenarios (e.g. a PR-review agent driving several skills/tools) | `evals/workflows/{mock,live}/*.eval.yaml` |

### Step 3: Place the file

- **Existing skill, new eval file** → drop it into that skill's existing
  `evals/` folder (e.g. `azure-api-review/evals/`).
- **Brand-new skill** → create `<skill-name>/evals/trigger.eval.yaml`
  alongside the new `SKILL.md`, mirroring an existing skill folder's shape
  (`SKILL.md`, `references/`, `evals/`).
- **Tool or workflow eval** → these tiers do not exist yet under
  `.github/skills/evals/` in this repo (only the legacy
  `evals/arm-api-reviewer/` suite is there today, pending its own migration
  — tracked separately). Create `evals/tools/` or
  `evals/workflows/{mock,live}/` under `vallyRoot` the first time one is
  needed, rather than nesting it inside a single skill's folder.

### Step 4: Write the eval content

Apply the four-layer pattern and pick graders per
[eval-design-patterns.md](references/eval-design-patterns.md). Avoid the
documented anti-patterns (vacuous `output-contains`-only grading, tautological
prompt/grader substrings, missing `scoring.threshold`, anti-triggers with no
competing skill mounted).

### Step 5: Register any new tier/path

If Step 3 created a new top-level folder under `vallyRoot` (a new skill, or
the first `evals/tools/`/`evals/workflows/` file), add the path to
`.github/skills/.vally.yaml`'s `paths.evals` list and confirm
`eng/pipelines/skill-eval.yml`'s `evalGlobs` already matches it (the existing
`*/evals/*.eval.yaml` glob covers any new `<skill-name>/evals/` folder
automatically; a new `evals/tools/` or `evals/workflows/` tier needs its own
glob entry added).

### Step 6: Validate locally

Run `vally lint <skill> --strict`, then `vally eval` on the new/changed file
before treating the eval as done. See this folder's
[README.md](../README.md) and `.github/skills/evals/arm-api-reviewer/README.md`
for local run instructions.
