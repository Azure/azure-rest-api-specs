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

Prerequisites: [Node.js](https://nodejs.org/) >= 20, npm, Git, an
authenticated GitHub Copilot CLI on `PATH`, and access to the private
`microsoft/vally` repository. **This runs headless** — vally's default
`copilot-sdk` executor spawns the Copilot CLI directly, so VS Code is not
required.

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

### `runs` vs `-Repeat` — these multiply

`runs: 3` in `defaults` means vally executes each stimulus three times _within
one suite run_. `-Repeat 3` executes the whole suite three times. Setting both
gives **nine** executions per stimulus, not three.

The phase-2 gate wants three executions per stimulus, and `runs: 3` already
provides that, so:

| Goal                                  | Setting                           | Executions per stimulus |
| ------------------------------------- | --------------------------------- | ----------------------- |
| The phase-2 gate                      | `runs: 3` (default), no `-Repeat` | 3                       |
| Stability _across_ suite runs         | `runs: 3` + `-Repeat 3`           | 9                       |
| Fast iteration while editing a grader | `--runs 1`                        | 1                       |

Earlier versions of this file and of `run-evals.ps1` showed
`-Suite "eval-true-negatives" -Repeat 3` as _the_ gate command. That was wrong
and invited a 9× run.

### Cost and duration

Measured on the first real run: **7 stimuli at `runs: 3` = 21 trials, 30.2
minutes wall clock, ~2.44M tokens, ~496 AIU** — roughly 24 AIU and 86 seconds
per trial, at `--workers 1`.

It scales close to linearly with fixture count, so a 20-fixture true-negative
suite is on the order of **1,400 AIU and 90 minutes**. That is affordable for a
deliberate pre-merge gate run by a maintainer. It is _not_ affordable as
per-PR CI, and that constraint should be assumed by anyone proposing to wire
the suite into a required check.

`--workers` above 1 shortens wall clock but contends with any other Copilot
session on the machine; the failure mode is a timeout, which reads as a
stimulus failure.

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

### Both defects that run exposed are now fixed

Neither was fixed at the time the run was recorded, so the numbers above were
produced against the defective versions. **The run's per-stimulus results are
not a valid baseline** and the suite needs re-running.

- **Mention-based graders → assertion-based.** They failed when a rule ID
  appeared anywhere, but the ideal true-negative answer _cites the rule it
  considered and explains why it does not fire_ — so they punished the correct
  answer. Three stimuli failed 0/3 this way while producing textbook-correct
  output. See "Grader audit" below.
- **Fixtures no longer leak their labels.** Every `tn-*.tsp` used to open with
  `FIXTURE (TRUE NEGATIVE ...)` and, in some cases, "the correct review output
  is silence. Any blocking finding on this file is a test failure." Positive
  fixtures were worse: they annotated each seeded defect inline with
  `// VIOLATION (DP-MODEL-01)`, handing the agent the exact string the
  `output-contains` grader matched. All provenance now lives in
  [`fixtures/MANIFEST.md`](fixtures/MANIFEST.md), which the agent never reads.

## Grader audit: assertions satisfiable by negation

Prompted by a real defect: a grader matching `🔴` or `blocking` anywhere scored
`"No blocking findings"` — the _ideal_ true-negative output — as a blocking
false positive. That was not an isolated slip. Every rubric that has never been
executed is an untested hypothesis, so all 24 mechanical graders in this suite
were audited for the same class: **a match that can be satisfied, or tripped,
by negation, absence phrasing, or a quotation.**

The finding is that the class is pervasive. **One of 24 graders is immune.**

### A. Positive graders satisfiable by negation — false PASS

Nine graders assert the agent _found_ something by looking for a rule-ID
prefix:

```yaml
- type: output-contains
  config: { strings: ["DP-MODEL-01"] }
```

An agent that **misses** the violation still satisfies this, because the
observed house style is to tabulate every rule considered:

| Rule                             | Verdict | Rationale     |
| -------------------------------- | ------- | ------------- |
| **DP-MODEL-01** (actions ≠ CRUD) | ✅ Pass | _…reasoning…_ |

That table is not hypothetical — it is copied from the agent's real output in
the first run. `output-contains "DP-MODEL-01"` passes on it.

This is the **more dangerous direction** of the bug. On a true-negative
stimulus, mention-matching causes a false alarm: loud, visible, annoying. On a
positive stimulus it causes a silent false pass, which reads as evidence the
reviewer works. All nine are affected: `DP-ERR-`, `DP-LRO-`, `DP-PAGE-`,
`DP-NAME-`, `DP-DOC-`, `DP-MODEL-01`, `DP-MODEL-`, `DP-VERSION-`, `DP-VIS-`
(×2). None has ever been executed — only the true-negative file has been run —
so this is inference from observed agent behaviour, not a measured failure.

### B. Negative graders trippable by legitimate mention — false FAIL

Thirteen graders. Ten are confirmed defective by the first run; the rest are
latent. Representative cases:

| Grader                                                  | Trips on                                                        |
| ------------------------------------------------------- | --------------------------------------------------------------- |
| `\bDP-MODEL-01\b\|\bcrud in disguise\b`                 | "…is **not** CRUD in disguise" — confirmed, 0/3                 |
| runtime-word list (`sort order`, `retention window`, …) | the agent listing what it _declined_ to flag — confirmed, 0/3   |
| `\b(no-enum\|casing-style\|…)\b`                        | "deferred to the linter: no-enum, casing-style" — confirmed     |
| `\bmissing (delete\|DELETE)\b`                          | "no missing delete operation" — confirmed                       |
| `\bDP-(MODEL\|DOC\|NAME\|VIS)-0[0-9]\b` on `tn-clean-…` | a ✅ Pass table — latent, passed 3/3 only because none appeared |

### C. Greedy `.*` spanning a negation

Two patterns join a topic and a verdict word with `.*`, which matches across a
whole line and so joins clauses that negate each other:

- `\bbreaking change\b.*\b(violat|not permitted|must not|prohibited)\b` matches
  _"this **is** a breaking change, but preview versions are **not prohibited**
  from making them"_ — confirmed, cost `tn-preview-breaking-change-allowed` 1
  of 3 trials.
- `\bclosed (enum|union)\b.*\b(violat|error|blocking)\b` matches _"the closed
  union is justified; this is **not** a violation"_ — latent.

### D. Half-fixed severity pattern

`(?im)^\s*(?:[-*+]\s*|#{1,6}\s*)?🔴|\bseverity\W{0,6}blocking\b` appears in
nine graders. The earlier fix anchored the **glyph** alternative to line start
but left the **word** alternative unanchored, so `Severity: Blocking` in a
summary table or legend still matches regardless of the count beside it. It
requires that literal token order, so "at blocking severity" does not trip it,
and nothing in the first run did — latent, not active. Noting it because it is
the same defect, half-corrected: fixing the visible half of a pattern bug and
leaving the rest is how this class survives review.

### E. Immune — and the template to copy

One grader: **`does not recommend the ARM polling contract`**
(`Azure-AsyncOperation`, `final-state-via`,
`x-ms-long-running-operation-options`). These tokens have no legitimate reason
to appear in a data-plane review in any polarity, so mention _is_ the defect.

**This is the property a sound mechanical grader has**, and it is the test to
apply to any new one: match vocabulary that cannot appear innocently, never
topic words that appear in both a finding and its refutation. If a candidate
grader cannot meet it, prefer the LLM judge over a cleverer regex.

### Status: fixed

All 30 mechanical graders are now assertion-based, and a CI check keeps them
that way.

**The discriminator is the report's own finding syntax.** The format defined in
[`data-plane-api-reviewer.agent.md`](../../../agents/data-plane-api-reviewer.agent.md)
renders a finding as:

```markdown
**[DP-VIS-02] Secret readable in response** -- `path/models.tsp:42`
```

A rule the agent merely _considered_ appears as a plain bold rule ID in a
table, with no brackets. So `\[DP-VIS-0[0-9]\]` means "reported a finding" and
`\bDP-VIS-0[0-9]\b` means "mentioned the rule at all". Switching every rule-ID
grader to the bracketed form fixes both polarities at once — the positive
graders stop passing on a miss, and the negative graders stop firing on a
refutation.

Where no bracketed form applies, the pattern was narrowed to phrasing that is
_inherently_ an assertion (`should be camelCase`, `must not be nullable`), or
replaced with "no finding of any kind was raised". Two graders that banned
topic vocabulary — the runtime-behaviour word list and the linter rule names —
could not be made sound at all, because the correct answer uses exactly that
vocabulary to say what it is declining to flag; both were replaced with a
bracketed-rule-ID ban, which as a bonus catches the one real false positive the
first run found.

**Enforced by** `checkGraderSoundness` in
[`.github/workflows/src/data-plane-review-alignment.js`](../../../workflows/src/data-plane-review-alignment.js).
Every grader is tested against two probes: a "correctly declining" sample it
must _not_ match, and a real report it _must_ match. A grader that fires on the
first is unsound; one that misses the second is inert and passes vacuously.

The LLM-judge `prompt` grader remains the load-bearing signal regardless. In
the first run it was the only grader that caught the real false positive and
the only one that manufactured none — and that is evidence about **mechanical
matchers in this domain generally**, not just about the specific broken
patterns. Review output is prose that argues; a regex cannot tell an assertion
from its refutation without a structural hook, and the bracketed-rule-ID form
is the only such hook available. Where a candidate grader cannot be made to
satisfy the "mention _is_ the defect" property that the ARM-polling grader has,
**do not contort the regex — drop it and let the judge handle it.** A mechanical
grader that is 90% right is worse than none, because its failures are silent
and are trusted.

The mechanical graders exist to make regressions cheap to spot, not to
adjudicate quality.

### Order the two fixes were applied, and why

Fixtures first, graders second.

The two interact — grader patterns are written against what the agent actually
emits, and what the agent emits was being shaped by the leaked labels. Tuning
graders against leaked-fixture behaviour would have calibrated them to an
artifact: an agent told "silence is correct" produces different, shorter output
than one reasoning from the spec alone, so a grader that looked sound against
the former could be unsound against the latter.

De-labelling also has no design content — it is unconditionally correct and
there is no version of the suite that wants it left in. The grader rewrite did
have a design decision (which structural hook distinguishes a finding from a
mention), and that decision is better made once the inputs are clean.

The ordering had no effect on the outcome in the end, because the hook turned
out to come from the **report format** rather than from fixture content. But it
would have mattered had the answer been "match the phrasing the agent tends to
use", which was the other candidate and would have been calibrated to leaked
behaviour.

## Known limitation: these evals test the skill, not the agent

vally has no concept of an agent file. A stimulus loads the
[`azure-api-review`](../../azure-api-review/SKILL.md) skill via
`environment.skills` and runs a bare Copilot CLI against the prompt. So this
suite exercises the **skill's guidance and rule definitions** and nothing else.

Untested by every eval in this directory:

| Untested                              | Defined in                                                                                    |
| ------------------------------------- | --------------------------------------------------------------------------------------------- |
| Persona and severity calibration      | `data-plane-api-reviewer.agent.md` §Severity                                                  |
| Report format and self-identification | `data-plane-api-reviewer.agent.md` §Report format                                             |
| The 15-finding cap                    | `data-plane-api-reviewer.agent.md` §Report format                                             |
| The silence checklist                 | `data-plane-api-reviewer.agent.md`                                                            |
| Critic dispatch and FAIL handling     | `data-plane-api-review-critic.agent.md`, `protocols/data-plane-api-review-critic.protocol.md` |
| Scope gate and PR-diff handling       | `.github/workflows/data-plane-api-review.md`                                                  |

This is **accepted for v1** rather than worked around. Two consequences worth
holding onto:

1. Graders keyed on the report format (the `🔴` and `\[DP-XXX-NN\]` patterns)
   assume a vocabulary the agent under evaluation was never given. They work
   because the skill's own examples use it, not because anything enforces it.
   That is why the false-positive metric in `run-evals.ps1` now reconciles
   against a grader-derived count instead of trusting glyph counts alone.
2. **Phase 0 dark launch is what exercises the agent file**, running the real
   workflow with the real agent over already-merged PRs. Nothing here
   substitutes for it.

## Known coverage gaps

Read this before concluding anything from the "41% true negatives" figure.

### The padding class is not stimulated at all

The false-positive mode most likely to get this bot muted in practice is
**not** a confident wrong finding on a clean spec. It is a spec that is 90%
fine and has one genuine issue, where the reviewer reports the real finding and
then pads with three or four adjacent low-value ones to look thorough.
Reviewers tolerate a wrong finding; they stop reading a bot that buries a good
finding in noise.

**Nothing in this suite stimulates that.** Every true negative is all-clean or
all-legitimate, and every positive fixture is seeded densely enough that
padding is indistinguishable from thoroughness. There is no mixed-signal
fixture — one real defect plus a large correct remainder — and so the
non-blocking false-positive metric, which exists precisely to catch this trend,
currently has nothing to count on. A flat non-blocking FP number today is a
measurement of absence, not of good behaviour.

### The true-negative denominator is 5, not 7

Three of the seven true-negative stimuli (`tn-legitimate-action-not-crud`,
`tn-bounded-list-and-singleton`, `tn-closed-union-justified`) all run against
the same fixture, `fixtures/typespec-data-plane/tn-legitimate-deviation.tsp`.
Counting stimuli overstates independence:

| Fixture                       | Stimuli |
| ----------------------------- | ------- |
| `tn-legitimate-deviation.tsp` | 3       |
| `tn-clean-service.tsp`        | 1       |
| `tn-linter-owned.tsp`         | 1       |
| `tn-runtime-behavioral.tsp`   | 1       |
| `version-pairs/preview-*.tsp` | 1       |

Any fixture-level flaw — the label leakage above, an unrealistic construction,
a compile error — hits all three at once. Their _graders_ are distinct, so they
do not necessarily pass or fail together (in the first run,
`tn-closed-union-justified` passed 3/3 while the other two failed 0/3), but
they share a single input and a single author's idea of what a legitimate
deviation looks like. Five distinct fixtures is a thin base for a promotion
gate.

### Consequence for the promotion gate

Because of these gaps, the synthetic true-negative suite cannot by itself
qualify the reviewer for phase 2. See the phase 0 dark launch in
[`.github/workflows/data-plane-api-review.md`](../../../workflows/data-plane-api-review.md):
real merged data-plane pull requests are a better false-positive source than
synthetic fixtures, and are the only place the padding class shows up at all.

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

1. **Write the fixture so it reads like a real spec.** No header comment
   naming what it is, no `// VIOLATION (DP-...)` annotations, no statement
   about what the reviewer should report. The agent reads this file. In-world
   `@doc` text a real service author would plausibly have written is fine and
   often the point — `tn-legitimate-deviation.tsp` documents _why_ its list is
   unpaged, and reading that correctly is the reviewer's job.
2. **Record the provenance in [`fixtures/MANIFEST.md`](fixtures/MANIFEST.md)**
   — what it seeds or guards against, and which stimuli consume it.
3. Prefix a true-negative **filename** with `tn-`. The agent never sees it; it
   only ever sees the neutral `dest` path.
4. Add the stimulus to the matching `vally/eval-*.yaml`, and declare
   `environment.skills: ["../../../azure-api-review"]`. **Without it the
   stimulus runs against a bare model** — see the first-run notes above.
5. Prefix a true-negative **stimulus name** with `tn-` too, so it counts toward
   the false-positive metric and the blocking gate.
6. Keep the true-negative share at or above 40%, and prefer a **new** fixture
   over a fourth stimulus against an existing one — see "The true-negative
   denominator is 5, not 7".
7. Give each stimulus a mechanical grader **and** an LLM-judge `prompt` grader
   with a rubric. The mechanical grader makes a regression cheap to spot; the
   rubric catches the reviewer being technically right and useless.
8. **Write mechanical graders against the finding syntax, not the vocabulary.**
   Use `output-matches` with the bracketed form `\\[DP-XXX-NN\\]`, never
   `output-contains` with a bare rule ID: a rule the agent considered and
   declined appears as a plain bold ID in a table, so a bare match cannot tell
   a finding from its refutation. `checkGraderSoundness` fails the build if a
   grader fires on a correctly-silent answer or is inert against a real report.
