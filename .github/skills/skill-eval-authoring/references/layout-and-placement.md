# Layout and placement

## Why `vallyRoot`-relative, not a fixed absolute path

Different repos in the Azure SDK ecosystem put their eval suites at
different roots:

- `azure-sdk-tools` treats the repo root as its effective `vallyRoot`:
  `evals/tools/`, `evals/workflows/{mock,live}/`, and
  `.github/skills/<skill>/evals/` all sit as top-level/near-top-level
  folders.
- This repo (`azure-rest-api-specs`) scopes everything under
  `.github/skills` — declared as `vallyRoot: .github/skills` in
  `eng/pipelines/skill-eval.yml`. A root-level `evals/` folder here would sit
  awkwardly next to `specification/`, which dominates this repo's root.

The canonical tree below is therefore expressed **relative to whatever
`vallyRoot` a given repo declares**, not as fixed absolute paths. Always read
the repo's own pipeline config first.

## Canonical tree (relative to `vallyRoot`)

```
<vallyRoot>/
    <skill-name>/
        SKILL.md
        references/
        evals/
            trigger.eval.yaml        # routing (skill-invocation grader), required
            <capability>.eval.yaml   # tool-use / output-shape / judgment coverage
    evals/
        tools/
            prompt-to-tool-<area>.eval.yaml
        workflows/
            mock/                    # hermetic, PR-gate
            live/                    # real services, nightly, --workers 1
```

In this repo, `vallyRoot` = `.github/skills`, so the equivalent tiers are:

```
.github/skills/<skill-name>/evals/*.eval.yaml
.github/skills/evals/tools/*.eval.yaml            # not created yet in this repo
.github/skills/evals/workflows/{mock,live}/        # not created yet in this repo
```

## Current state in this repo

- `.github/skills/.vally.yaml`'s `paths.evals` enumerates one `evals/`
  folder per skill (`azsdk-common-*/evals/`, `azure-api-review/evals/`,
  `openai-typespec-update/evals/`, plus this skill's own
  `skill-eval-authoring/evals/`).
- `.github/skills/evals/arm-api-reviewer/` is a **legacy exception**: it
  evaluates the `arm-api-reviewer` *agent* (multi-skill, multi-tool,
  full-PR-review scenarios), which conceptually belongs under
  `evals/workflows/mock/` (or `live/` for scenarios that hit real PRs), not
  in its own bespoke `vally/`/`fixtures/`/`run-evals.ps1` structure. Migrating
  it is real, separate work (its own eval files, fixtures, README, and the
  pipeline's `evalGlobs`/`shardTimeoutInMinutes` all need updating) — track
  it as its own change, don't fold it into an unrelated eval PR.
- Do **not** add new per-skill routing/capability evals under
  `.github/skills/evals/` — that path is reserved for the `tools`/`workflows`
  tiers (plus the legacy `arm-api-reviewer` entry above). New skill evals go
  in `<skill-name>/evals/`, a sibling of `evals/`, directly under
  `vallyRoot`.

## Registering a new tier or skill folder

- New skill, new `<skill-name>/evals/` folder → already covered by the
  existing `*/evals/*.eval.yaml` glob in `eng/pipelines/skill-eval.yml`; only
  add the folder to `.github/skills/.vally.yaml`'s `paths.evals` list.
- First `evals/tools/` or `evals/workflows/` file ever added in this repo →
  needs a new `evalGlobs` entry in `eng/pipelines/skill-eval.yml` (e.g.
  `evals/tools/**/*.eval.yaml`, `evals/workflows/**/*.eval.yaml`) in addition
  to the `.vally.yaml` `paths.evals` entry — otherwise the CI pipeline won't
  pick the new files up at all.
