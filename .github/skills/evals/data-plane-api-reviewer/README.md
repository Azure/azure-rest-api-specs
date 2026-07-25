# Data-Plane API Reviewer -- Evaluation Suite

Evaluation suite for the **data-plane API reviewer** agent
([`.github/agents/data-plane-api-reviewer.agent.md`](../../../agents/data-plane-api-reviewer.agent.md))
and the data-plane half of the
[`azure-api-review`](../../azure-api-review/SKILL.md) skill.

Built on [microsoft/vally](https://github.com/microsoft/vally), the same
framework as the [ARM suite](../arm-api-reviewer/README.md).

## What this suite is actually for

The ARM suite measures whether the reviewer **finds** things. This suite
measures that too, but its centre of gravity is the opposite question:
whether the reviewer **stays quiet** when it should.

That inversion is deliberate. The data-plane reviewer runs unattended against
pull requests in a repository with high PR volume. Its failure mode is not
missing a violation -- a human reviewer catches that. Its failure mode is
crying wolf, being muted, and then catching nothing at all. A muted reviewer
has zero value regardless of how good its true positives are.

So the true-negative file is not an afterthought here. It is the gate.

## Directory structure

```
data-plane-api-reviewer/
  .vally.yaml                    # suite definitions: `all` and `true-negatives`
  vally/
    eval-resource-modeling.yaml
    eval-error-design.yaml
    eval-naming-and-docs.yaml
    eval-lro-and-paging.yaml
    eval-visibility-and-secrets.yaml
    eval-versioning.yaml
    eval-true-negatives.yaml     # the gate -- see below
  fixtures/
    typespec-data-plane/         # single-version .tsp fixtures
    version-pairs/               # previous + new version, for versioning evals
```

Stimulus and fixture counts are deliberately **not** stated in this README.
The ARM suite states them in two places
([`skills/README.md`](../../README.md) and
[`arm-api-reviewer/README.md`](../arm-api-reviewer/README.md)) and the two
numbers already disagree. Run the suite if you want a count.

## Fixtures

Fixtures are illustrative TypeSpec. They live outside `specification/`, are
not compiled by CI, and are not intended to be shipped or copied into a real
service. Several of them contain deliberate compile-level defects, because
that is what is under test.

Every fixture carries a header comment naming the seeded violations, or --
for a true negative -- naming the false positive it exists to catch.
Fixtures whose name begins with `tn-` are true negatives.

Credentials appearing in fixtures are obviously fake placeholders.

## Test categories

| File                               | Rule families           | What it measures                                                                                                                                                                   |
| ---------------------------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `eval-resource-modeling.yaml`      | `DP-MODEL-*`            | CRUD in disguise, addressability, collection vs singleton, operation symmetry.                                                                                                     |
| `eval-error-design.yaml`           | `DP-ERR-*`              | Stable `code` values, `target`, actionable messages, `innererror` nesting. Almost no linter coverage, so almost pure judgment.                                                     |
| `eval-naming-and-docs.yaml`        | `DP-NAME-*`, `DP-DOC-*` | Clarity, **not** casing. Substance, **not** presence. Both stimuli also assert that the reviewer does not restate the linter's casing / doc-presence findings.                     |
| `eval-lro-and-paging.yaml`         | `DP-LRO-*`, `DP-PAGE-*` | Status-monitor contract, terminal states, paging shape and cross-operation consistency. Also asserts the reviewer does not recommend the ARM polling contract.                     |
| `eval-visibility-and-secrets.yaml` | `DP-VIS-*`              | Secret exposure, write-only non-secret properties, server-assigned-but-writable, optional-and-nullable. The one area where a Blocking finding is expected rather than discouraged. |
| `eval-versioning.yaml`             | `DP-VERSION-*`          | Breaking changes in a **stable** version. Entirely agent-owned: `non-breaking-versioning` is disabled in the data-plane ruleset.                                                   |
| `eval-true-negatives.yaml`         | --                      | False-positive resistance. See below.                                                                                                                                              |

## The true-negative file

`eval-true-negatives.yaml` covers four classes plus the preview carve-out:

1. **Clean spec** -- a fully compliant `Azure.Core` service. Assert silence.
2. **Legitimate deviation** -- input that looks wrong and is right: a genuine
   `:analyze` computation that is not CRUD in disguise, a documented bounded
   unpaged list, a singleton with no collection and no delete, a genuinely
   protocol-closed union.
3. **Linter-owned** -- a fixture full of violations that shipped
   `@azure-tools/typespec-azure-core` rules already catch. Assert silence.
   This is the
   [linter interlock](../../azure-api-review/references/data-plane-linter-rule-coverage.md),
   regression-tested rather than merely documented.
4. **Runtime-behavioral** -- a spec whose documentation describes sort
   ordering, retention windows, throttling, and idempotency. None of it is
   statically checkable. Assert that the reviewer does not manufacture a
   finding out of prose.

Plus **preview breaking changes**, which are permitted and are the single
most likely versioning false positive.

### Rules for this file that exist to be defended

These are load-bearing. Changing any of them changes what the gate means.

- **`runs: 3`**, not `runs: 1`. A single run cannot distinguish an
  intermittent false positive from a flake. Three can.
- **A true-negative failure is a regression until proven otherwise.**
  Do not add "safe to re-run" guidance to this file the way the ARM suite
  does for its non-deterministic tests. If a true-negative stimulus fails,
  the reviewer is over-reporting; investigate before re-running.
- **True-negative stimuli are at least 40% of the whole suite.** If you add
  positive stimuli, add true negatives to match. The ARM suite is around 5%,
  which is the level at which a false-positive regression ships unnoticed.
- **Every stimulus name begins with `tn-`.** `run-evals.ps1` identifies
  true-negative stimuli by that prefix in order to compute the
  false-positive metric. Renaming one without the prefix silently removes it
  from the metric.
- **When a linter rule flips to 🔒 Linted** in
  [`data-plane-linter-rule-coverage.md`](../../azure-api-review/references/data-plane-linter-rule-coverage.md),
  the same pull request adds a true-negative stimulus asserting the reviewer
  no longer reports it.

### The false-positive metric

`run-evals.ps1` reports, per run and in aggregate:

- **blocking false positives** -- 🔴 findings on true-negative stimuli;
- **non-blocking false positives** -- 🟡 and 💡 findings on the same.

Only the blocking count gates promotion. The non-blocking count is tracked
and trended because it is the number that actually predicts a reviewer being
muted: nobody disables a bot over one wrong blocking finding, they disable it
over forty low-value suggestions. Watch it climb _before_ reviewers start
ignoring the bot, not after.

### Promotion gate

Rollout phase 2 -- switching on inline review comments in
[`data-plane-api-review.md`](../../../workflows/data-plane-api-review.md) --
requires **zero blocking false positives across three runs of the full
true-negative suite**:

```powershell
cd .github/skills/evals
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "true-negatives" -Repeat 3
```

## Quick start

Prerequisites: [Node.js](https://nodejs.org/) >= 20, npm, Git, and VS Code
with GitHub Copilot active.

`run-evals.ps1` lives at the evals root and serves every suite; select one
with `-SuiteDir`.

```powershell
cd .github/skills/evals

# Full data-plane suite
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer"

# True negatives only, three times -- the phase-2 gate
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "true-negatives" -Repeat 3

# A single category
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "eval-error-design"

# Point at an existing vally clone instead of re-cloning
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -VallyRepo "C:\repos\vally"
```

Run `Get-Help .\run-evals.ps1 -Detailed` for all parameters.

## Model pinning

`model` and `judge_model` in every eval file **must** stay equal to
`engine.model` in
[`.github/workflows/data-plane-api-review.md`](../../../workflows/data-plane-api-review.md).

This coupling is the whole reason the workflow pins a model at all. The
false-positive rate is the promotion criterion for rollout phases 2 and 3;
measuring it on one model and running production on another transfers
nothing. If you want to move to a cheaper model, re-run this suite on the
cheaper model **first**, then change both.

## Adding tests

1. Add a fixture under `fixtures/`, with a header comment naming the seeded
   violations -- or, for a true negative, naming the false positive it
   guards against and prefixing the filename with `tn-`.
2. Add the stimulus to the matching `vally/eval-*.yaml`.
3. If it is a true negative, prefix the **stimulus name** with `tn-` as well,
   so it counts toward the false-positive metric.
4. Keep the true-negative share at or above 40%.
5. Give each stimulus both a mechanical grader (`output-contains` /
   `output-not-matches`) and an LLM-judge `prompt` grader with a rubric. The
   mechanical grader catches the obvious regression; the rubric catches the
   reviewer being technically right and useless.
