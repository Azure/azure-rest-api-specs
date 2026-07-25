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

Both the metric and the `output-not-matches` graders anchor severity glyphs
to the **start of a line**, optionally behind a list bullet or a heading
marker. That is deliberate. A bare substring match scores `no 🔴 blocking
findings` -- which is the output we want -- as a blocking false positive,
inverting the metric it exists to measure. A glyph that is not the first
token on its line is prose _about_ findings, not a finding.

The consequence is that the metric depends on the report format in
[`data-plane-api-reviewer.agent.md`](../../../agents/data-plane-api-reviewer.agent.md)
-- specifically on findings appearing under a `### 🔴 Blocking` heading or as
glyph-led entries. If that format changes, change the anchoring in
`run-evals.ps1` and in the graders in the same pull request, or the gate
silently stops measuring anything.

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

### `runs` vs `-Repeat`

These multiply, and it is easy to burn four times the intended budget by
setting both. `runs: 3` in `defaults` means vally executes each stimulus three
times _within one suite run_; `-Repeat 3` executes the whole suite three times.
The phase-2 gate wants three executions per stimulus, which `runs: 3` already
provides — so `-Repeat` is for checking stability _across_ suite runs, not for
reaching the gate's trial count. Leave it at 1 unless that is what you want.

## First real run (2026-07-25)

The suite's first end-to-end execution. Recorded because a clean-looking
summary here was actively misleading and the details matter more than the
score.

**Configuration:** `eval-true-negatives`, `claude-opus-4.6`, judge
`claude-sonnet-4.6`, `runs: 3`, `--workers 1`.

**Result:** 21 trials, 9 passed, 12 failed. 30.2 min wall clock, ~2.44M tokens,
~496 AIU (≈24 AIU per trial). vally itself reported the suite as **passing** at
75% against its 0.7 `scoring.threshold`, and exited 0.

**Three harness defects it exposed, all now fixed:**

1. **Skills were never loaded.** `paths.skills` in `.vally.yaml` is only read
   when `--skill-dir` is passed, which neither `run-evals.ps1` nor any eval
   file did. Every stimulus ran against a bare Copilot CLI: 25K tokens, 1 tool
   call, `Skills used 0`. Fixed by declaring `environment.skills` per stimulus,
   which vally treats as fail-loud (a missing `SKILL.md` aborts the run) rather
   than the silent no-op `--skill-dir` gives you. After the fix: 116K tokens,
   7 tool calls, `Skills used 1`. **The ARM suite has the same defect** — it
   was inherited, not introduced here.
2. **The false-positive metric was blind.** It counts 🔴/🟡/💡 glyphs, but
   vally has no concept of an agent file, so the report format defined in
   `.github/agents/data-plane-api-reviewer.agent.md` is never in play. It
   reported `Blocking FPs: 0 [GATING -- must be 0]` on a run containing a real
   invented finding. It now reconciles against a grader-derived count and
   prints `UNMEASURED` when the two disagree.
3. **The runner exited 0 on a failed gate.** vally's `scoring.threshold` is an
   aggregate, so a suite can clear it while individual stimuli fail. For a
   true-negative gate whose stated rule is that a single failure is blocking,
   that is wrong. `run-evals.ps1` now fails the run when any `tn-` trial fails.

**What the agent actually did:** mostly well. Of the five stimuli that failed
at least one trial, four failed on grader artifacts rather than agent error —
see the caveat below. The one real false positive was on
`tn-linter-owned-violations-silent`, where in 2 of 3 trials the agent invented
a `DP-MODEL-04` "missing delete operation" finding on a fixture whose defects
are all linter-owned. The judge caught it; the mechanical graders did not.

### Known-unsound: the graders and the fixtures

Do not read a pass here as evidence until these two are resolved.

- **The `output-not-matches` graders are mention-based, not
  assertion-based.** They fail when a rule ID appears anywhere in the output.
  But the ideal true-negative answer _cites the rule it considered and explains
  why it does not fire_ — so the graders punish the correct answer. Three
  stimuli (`tn-bounded-list-and-singleton`, `tn-legitimate-action-not-crud`,
  `tn-runtime-behavioral-not-static`) failed 0/3 this way while producing
  textbook-correct output.
- **The fixtures leak their own labels.** Every `tn-*.tsp` opens with a comment
  saying `FIXTURE (TRUE NEGATIVE ...)` and, in some cases, "the correct review
  output is silence. Any blocking finding on this file is a test failure." The
  agent reads the file. A true-negative suite that tells the agent the answer
  measures instruction-following, not false-positive resistance — and the agent
  still produced a false positive on one of them anyway.

## Model pinning

Two separate pins, with two separate rules.

### `model` — must equal production

`model` in every eval file **must** stay equal to `engine.model` in
[`.github/workflows/data-plane-api-review.md`](../../../workflows/data-plane-api-review.md).
Both are currently `claude-opus-4.6`.

This coupling is the whole reason the workflow pins a model at all. The
false-positive rate is the promotion criterion for rollout phases 2 and 3;
measuring it on one model and running production on another certifies a
configuration that is never shipped.

`vally`'s `model:` and gh-aw's `engine.model` are nominally different
namespaces — gh-aw passes `engine.model` through to the Copilot CLI as
`COPILOT_MODEL` without validating it. `claude-opus-4.6` was verified to be a
valid Copilot CLI model identifier, so for this value the two namespaces
coincide and no mapping is needed. If a future model's identifiers differ
between the two, document the mapping next to both pins.

### `judge_model` — frozen, deliberately not equal to production

`judge_model` is `claude-sonnet-4.6` here, matching every ARM suite. It is
**not** coupled to production and must not be changed to follow a model
upgrade. The judge does not need to match production; it needs to be _stable_.
Changing it invalidates comparison against every historical run — including the
ARM suite's numbers, which are the only baseline available for judging whether
the ≥40% true-negative ratio is actually doing its job.

### Upgrading the model

Do **not** upgrade to a newer model piecemeal, even when a newer one exists. A
newer model loses comparability with the ARM baseline and requires re-baselining
the entire true-negative set. Treat a model change as a deliberate, separately
evaluated change:

1. Bump `model` in every `vally/eval-*.yaml` **and** `engine.model` in the
   workflow, in the same pull request.
2. Re-run the full suite and compare against the previous baseline run.
3. Leave `judge_model` alone.
4. Do not fold the bump into an unrelated change.

[`.github/workflows/data-plane-review-alignment.yaml`](../../../workflows/data-plane-review-alignment.yaml)
enforces steps 1 and 3 mechanically: it fails when the workflow model and any
eval model diverge, and when `judge_model` drifts from the frozen baseline.

### What is _not_ coupled

The gh-aw threat-detection step has its own `engine.model`
(`safe-outputs.threat-detection.engine` in the workflow), pinned to
`claude-sonnet-4.6`. Without that override it inherits `engine.model` and runs
the expensive review model on a cheap classification task. It is intentionally
decoupled: this suite measures review output, not threat-detection decisions,
and the alignment check does not constrain it.

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
