# Data-Plane API Reviewer -- Evaluation Suite

Evaluation suite for the **data-plane API reviewer** agent
([`.github/agents/data-plane-api-reviewer.agent.md`](../../../agents/data-plane-api-reviewer.agent.md))
and the data-plane half of the
[`azure-api-review`](../../azure-api-review/SKILL.md) skill.

Built on [microsoft/vally](https://github.com/microsoft/vally), the same
framework as the [ARM suite](../arm-api-reviewer/README.md).

## What this suite is actually for

The ARM suite measures whether the reviewer **finds** things. This suite
measures that too, but its center of gravity is the opposite question:
whether the reviewer **stays quiet** when it should.

That inversion is deliberate. The data-plane reviewer runs unattended against
pull requests in a repository with high PR volume. Its failure mode is not
missing a violation -- a human reviewer catches that. Its failure mode is
crying wolf, being muted, and then catching nothing at all. A muted reviewer
has zero value regardless of how good its true positives are.

So the true-negative file is not an afterthought here. It is the load-bearing
regression suite.

## Directory structure

```
data-plane-api-reviewer/
  .vally.yaml                    # suite definitions: `all` and `true-negatives`
  ROLLOUT.md                     # production rollout phases and decision criteria
  vally/
    eval-resource-modeling.yaml
    eval-error-design.yaml
    eval-naming-and-docs.yaml
    eval-lro-and-paging.yaml
    eval-visibility-and-secrets.yaml
    eval-versioning.yaml
    eval-true-negatives.yaml     # the regression suite -- see below
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
compiled by the `compile-fixtures` CI job, and are not intended to be shipped
or copied into a real service. Positive fixtures contain deliberate API-design
defects, but every fixture is valid TypeSpec.

Fixtures do not contain headers or comments naming their class, seeded rules,
or expected output. The agent reads them. Provenance lives in
[`fixtures/MANIFEST.md`](fixtures/MANIFEST.md), which the agent never sees.
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

`eval-true-negatives.yaml` covers five classes plus the preview carve-out:

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
5. **Additive stable evolution** -- a terse stable-to-stable pair that adds an
   optional property and an open-union member with the correct `@added`
   decorators. Assert silence on a common, compatible version bump.

Plus **preview breaking changes**, which are permitted and are the single
most likely versioning false positive.

### Rules for this file that exist to be defended

These are load-bearing. Changing any of them changes what the regression
results mean.

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

The blocking count fails the regression run. The non-blocking count is tracked
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
`run-evals.ps1` and in the graders in the same pull request, or the suite
silently stops measuring anything.

### Rollout regression signal

[Rollout Phase 2](ROLLOUT.md) keeps the workflow manually label-gated while
adding inline review comments. Human feedback on selected real pull requests is
the primary rollout signal. The true-negative suite remains the repeatable
regression check: run it after reviewer, prompt, rule, or model changes and
investigate blocking false positives or rising non-blocking noise.

```powershell
cd .github/skills/evals
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "true-negatives"
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

# True-negative regression suite (`runs: 3` already executes each stimulus three times)
.\run-evals.ps1 -SuiteDir "data-plane-api-reviewer" -Suite "true-negatives"

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

The standard true-negative regression run wants three executions per stimulus,
and `runs: 3` already provides that, so:

| Goal                                  | Setting                           | Executions per stimulus |
| ------------------------------------- | --------------------------------- | ----------------------- |
| Standard true-negative regression run | `runs: 3` (default), no `-Repeat` | 3                       |
| Stability _across_ suite runs         | `runs: 3` + `-Repeat 3`           | 9                       |
| Fast iteration while editing a grader | `--runs 1`                        | 1                       |

Earlier versions of this file and of `run-evals.ps1` showed
`-Suite "eval-true-negatives" -Repeat 3` as the rollout command. That was wrong
and invited a 9× run; `-Repeat` is only for an explicit cross-run stability
study.

### Cost and duration

Measured on the first real run: **7 stimuli at `runs: 3` = 21 trials, 30.2
minutes wall clock, ~2.44M tokens, ~496 AIU** — roughly 24 AIU and 86 seconds
per trial, at `--workers 1`.

It scales close to linearly with fixture count, so a 20-fixture true-negative
suite is on the order of **1,400 AIU and 90 minutes**. That is affordable for a
deliberate pre-merge regression run by a maintainer. It is _not_ affordable as
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
3. **The runner exited 0 when true-negative trials failed.** vally's
   `scoring.threshold` is an
   aggregate, so a suite can clear it while individual stimuli fail. For a
   true-negative regression suite, that hides the signal. `run-evals.ps1` now
   fails the run when any `tn-` trial fails.

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
so this is inference from observed agent behavior, not a measured failure.

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
topic vocabulary — the runtime-behavior word list and the linter rule names —
could not be made sound at all, because the correct answer uses exactly that
vocabulary to say what it is declining to flag; both were replaced with a
bracketed-rule-ID ban, which as a bonus catches the one real false positive the
first run found.

**Enforced by** `checkGraderSoundness` in
[`.github/workflows/src/data-plane-review-alignment.js`](../../../workflows/src/data-plane-review-alignment.js).
Every grader is tested against two probes: a "correctly declining" sample it
must _not_ match, and a real report it _must_ match. A grader that fires on the
first is unsound; one that misses the second is inert and passes vacuously.

### Non-DP rule IDs — widened 2026-07-27

The smoke test showed the agent raising `**[SEC-SECRET-DETECT] ...**`, applying
the bracketed convention to a **cross-cutting** rule ID. Three true-negative
graders assumed the `DP-XXX-NN` shape and so could not see such a finding,
meaning the suite would have reported a _cleaner_ false-positive rate than
reality — the one direction an FP-defense suite cannot afford.

Widened to the general finding form, which spans all 9 rule-ID families
enumerated in
[`data-plane-report-format.md`](../../azure-api-review/references/data-plane-report-format.md)
§"Rule-ID vocabulary", including mixed-case IDs like `RPC-Put-V1-11`:

```
\*\*\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\]
```

Validated against 21 real recorded trials plus the contract and an adversarial
set: **zero over-matches.** It does not match `**[Note]**` (no hyphen),
`**[RFC 2119]**` (space), `[DP-VIS-02](link)` (not bold), checkboxes, or the
considered-rules table.

Two things this surfaced beyond the original gap:

- **Positive graders lacked the bold anchor.** `\[DP-VIS-0[0-9]\]` would match
  `See [DP-VIS-02](../references/…)` — a link the agent plausibly writes while
  explaining why a rule does _not_ apply. All 10 specific graders now carry
  `\*\*`, which makes them **more** precise without widening their rule family.
- **`checkGraderSoundness` was blind to the same gap.** It now carries a
  `NON_DP_FINDING_PROBE` and flags any _family-agnostic_ grader — one matching
  two different DP families, so it is asserting "no finding of any kind" —
  that cannot see non-DP IDs. Specific-trap graders naming a single rule are
  deliberately exempt. Verified it fails on a re-narrowed grader.

**Residual gap: measurement half now closed, tolerance question left open.**
Four true-negative stimuli (`tn-legitimate-action-not-crud`,
`tn-bounded-list-and-singleton`, `tn-closed-union-justified`,
`tn-preview-breaking-change-allowed`) carry only specific-trap graders plus a
severity-glyph grader. Measured precisely:

|                  | blocking non-DP FP                             | non-blocking non-DP FP |
| ---------------- | ---------------------------------------------- | ---------------------- |
| All 7 TN stimuli | **caught** (glyph graders are family-agnostic) | 3 of 7 caught          |

So the **blocking false-positive regression metric is fully covered** — a
blocking false positive of any family is caught on every stimulus. What the
_graders_ do not catch on those four is a non-blocking non-DP finding.

That is now **counted** even where no specific grader covers it.
`Get-TrueNegativeFindingCounts` in [`run-evals.ps1`](../run-evals.ps1) tallies
every bracketed finding in finding position, at every severity,
family-agnostically, charging each to the severity section it appears under.
Non-blocking findings feed the tracked metric and do not fail the run.

**The four rubrics' tolerance of suggestion-severity output is deliberate, not
an oversight.** "Asking whether the 200-entry bound is contractual, at
💡 Suggestion severity, is acceptable" is a real editorial position: a true
negative may ask a question without being wrong. Banning bracketed findings
outright would contradict it and manufacture false failures. So the split is
the tracked-vs-gated rule applied consistently — suggestions on a true negative
are **counted and trended, never gated**. Whether a true negative should be
allowed to contain a suggestion at all remains open, and is an editorial
question rather than a pattern question.

### The padding class's first instrument

That counter is the first thing in this suite able to measure **padding** at
all — the failure mode where the reviewer finds one real issue and pads with
adjacent low-value ones. Until now nothing could see it: the graders ask "did
rule X fire?", and the previous counter counted severity _sections_, so five
padded findings under one `### 🔴 Blocking` heading scored as one.

The smoke test produced a concrete instance. On a fixture seeded only with
`DP-VIS-*`, the agent additionally raised `**[DP-MODEL-04] Create/update
without delete**` — defensible on the file's actual content, phrased as a
question, at Warning severity, but off the stimulus's focus. That is the shape
padding takes, and the counter now records it.

**What the counter still does not cover**, so the instrument is not mistaken
for a solution:

- **It counts on true negatives only.** Padding around a _genuine_ finding on a
  positive stimulus is not part of this aggregate metric.
- **It is a count, not a judgment.** A rising number is a reason to read the
  reports; it does not distinguish weak-but-valid findings from invented ones.

A direct positive probe now covers the first limitation locally.
`single-write-only-property-without-padding` presents one durable write-only
property in an otherwise conventional service. Its mechanical grader accepts
one bold-bracketed finding before `### Questions` and fails on a second; the
LLM rubric requires that one finding to be `DP-VIS-01` at Warning severity.

The threshold is intentionally **exactly one**, with no courtesy allowance.
The fixture was built to remove adjacent ambiguity: complete CRUD and list
operations, correct key and timestamp visibility, an extensible union, clear
names, substantive docs, and the `url` scalar. Allowing one extra finding would
make the probe unable to distinguish focused review from the padding it exists
to elicit. Questions remain excluded because the report contract defines them
as non-findings, and `run-evals.ps1` makes the same exclusion.

### Known divergence: malformed Questions

The finding counter and the true-negative graders disagree about one case, and
the disagreement is deliberate but unresolved.

`DP-MODEL-04`'s declared severity is **Question**, so a well-formed report puts
it in the `### Questions` section as a bullet. Verified: a well-formed Question
bullet trips **zero** graders and is counted by **neither** metric.

A _malformed_ Question — the agent writing `**[DP-MODEL-04] …**` in bracketed
finding form under the Questions heading — is treated differently by the two:

|                        | verdict                                                                                                                      |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Finding counter        | **excluded** — the rubrics permit questions on a true negative, so counting one as a false positive would inflate the metric |
| TN graders (4 of them) | **fail** — a bracketed rule ID is a finding wherever it appears                                                              |

Both positions are defensible: the counter measures noise the author
experiences, the graders enforce the report contract. The practical effect is
that a run whose only failures are malformed Questions shows failed trials with
zero counted false positives — which the reconciliation check reports as
`UNMEASURED`, correctly telling you the two metrics disagree.

**Unresolved.** Left as-is pending a decision on whether a contract violation
of this shape should fail the regression run.

### Unrun graders are untested hypotheses

**Four grader defects have now been found, and every one was in a grader that
had never been executed.** Listed in the order they surfaced:

| #   | Defect                                                                                             | Found by                        |
| --- | -------------------------------------------------------------------------------------------------- | ------------------------------- |
| 1   | `🔴` matched anywhere, so `"No blocking findings"` — the ideal output — scored as a blocking FP    | code review before any run      |
| 2   | Bare rule IDs matched a considered-but-declined table, punishing the correct answer                | first real run                  |
| 3   | Positive graders lacked `\*\*`, so a markdown link to a rule satisfied "did it report X?"          | adding a link line to the probe |
| 4   | `**MUST** be extensible` evaded `\bmust be extensible\b` — markdown emphasis breaks literal spaces | full run                        |

Defects 1 and 3 were found by _reasoning about_ the graders; 2 and 4 only by
running them. All four share one shape: **the grader matched the vocabulary of
a claim rather than the claim.** Each looked plainly correct when written.

The rule this justifies: **a grader that has never executed is a hypothesis,
not working code.** Treat a green result from a first-run grader as
unvalidated, and prefer the LLM judge's verdict where the two disagree — in the
first run the judge was the only grader that caught the real false positive and
the only one that manufactured none.

`checkGraderSoundness` exists to convert some of this class into a
pull-request-time failure, but it can only test the properties someone thought
to encode. Defect 4 passed it.

### The pattern generalized: ten defects, none in the reviewer

The four grader defects above are part of a larger and now unambiguous pattern.
**Ten instrumentation defects have been found across this project's life, and
every one was in the measurement apparatus rather than in the reviewer under
test.** The later six:

| #   | Defect                                                                                                                                                                                                                                                | Found by                                     |
| --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| 5   | The finding counter's `else` branch swallowed `### Questions` bullets into the non-blocking count, so its documented Questions exclusion silently did nothing                                                                                         | testing the counter against a crafted report |
| 6   | A new grader used inline `(?i:...)` groups, which JS regex rejects outright, so the pattern never compiled                                                                                                                                            | `checkGraderSoundness`                       |
| 7   | `DP-VERSION-04` was used as a _fabricated_ rule ID in `REAL_FINDINGS_PROBE`, then became a real rule — the probe would have read as that rule misfiring, and a `DP-VERSION-04` grader would have been inert                                           | writing the rule that took the ID            |
| 8   | A rubric item was silently a YAML **map**, not a string — an unquoted colon inside the sentence — and vally's judge calls `criterion.split()`, so the stimulus scored as a FAILURE on a grader crash while all three of its mechanical graders passed | third full run                               |
| 9   | The failed-stimuli reporter threw `The property 'stimulus' cannot be found` on an errored trial: each hop was null-checked but not existence-checked, and StrictMode throws on a missing property                                                     | third full run — first with an errored trial |
| 10  | Eval artifacts are gitignored, but Prettier does not read `.gitignore`, so `npm run format:check` failed locally for anyone who had run the suite; `session-state/` was not ignored at all                                                            | running `npm run check` after a suite        |

Defect 8 is the sharpest of the ten. A single unquoted colon changed a rubric's
_type_, and the resulting crash was reported in the same column as a genuine
behavioral failure — so the headline number was wrong in the direction that
makes the reviewer look worse, and nothing in the output said "this is a harness
fault".

**Standing warning to whoever maintains this next:** when a measured run
disagrees with your expectation, the prior should be that the instrument is
wrong, not the reviewer. Ten for ten. The corollary is that a number from this
harness is only as trustworthy as the last time its graders were executed and
its counter was tested against a report whose correct score you already knew —
re-reading either one has never once found a defect that running it did not.

### Suggestion budget on true negatives

**At most 2 Suggestion-severity findings per true-negative trial. Exceeding the
budget fails the regression run.**

Suggestions used to be free, and that was a hole in the measurement. TN graders
are narrow by design — each names a specific trap — so a report could satisfy
every grader while burying the author in individually-defensible 💡 findings.
**Padding is precisely that pile.** A regression metric that prices suggestions
at zero cannot measure the failure mode most likely to get the bot muted.

Banning them outright would be the opposite error, and would contradict the
rubrics: `eval-true-negatives.yaml` explicitly permits asking, at 💡, whether a
value set is protocol-fixed. So it is a **budget, not a ban** — curiosity is
affordable, a pile is not.

Mechanics:

- Counted per **trial**, not per stimulus-average. The per-stimulus number
  reported is the **worst** trial, because the question is "can this stimulus
  provoke padding", and one six-suggestion trial answers it.
- Suggestions still roll into `NonBlocking`, so that metric stays comparable
  with every earlier run.
- A retracted suggestion leaves the budget, matching the existing
  tracked-vs-gated split for retractions.
- Enforced only when the counter is trustworthy — a blind counter (graders
  failing while the glyph counter sees nothing) must not manufacture a budget
  failure.
- The per-stimulus count prints on every run, not only on breach, so it is a
  **tracked trend** rather than a pass/fail flash.

Verified against 7 crafted reports whose correct score was known in advance
(exactly-at-budget passes, three fails, Questions are free, Warnings are not
Suggestions, retraction leaves the budget, Blocking does not leak in), plus 5
regression probes proving the blocking detector is unchanged.

### Two changes that push in opposite directions — watch this in the next run

Landing at the same time as the budget is the
[two-step exception test](../../azure-api-review/SKILL.md) replacing the old
"is the rationale plausible" rule. **They do not logically conflict, but they
pull TN behavior in opposite directions and the next run is the test:**

- The two-step test makes the reviewer **less** willing to accept a stated
  rationale, which pushes toward _more_ findings on true negatives.
- The suggestion budget makes low-grade findings **more** costly, which pushes
  toward fewer.

Three TN stimuli depend on a rationale being accepted —
`tn-closed-union-justified`, `tn-bounded-list-and-singleton`, and
`tn-standard-mandated-route-segment`. In all three the rationale is genuinely
_on-condition_ (the symbol set cannot grow; the collection is capped at 200; an
external protocol dictates the path), so a **correct** application of the
two-step test still accepts all three. The risk is over-application, not the
rule itself.

If the next run shows those three degrading while the persuasive-rationale
positive is now caught, the two-step test is right and mis-calibrated. If they
hold and the positive is caught, both changes landed. **Neither has been
verified behaviorally — only by tracing the guidance against the fixtures.**

### Adjudicating a finding on a true negative — standing process

A finding on a true negative has exactly three possible causes. **Name which one
you are selecting, and say why you rejected the other two.** Writing it down is
the point: the failure mode is not picking wrong once, it is picking the same
way every time without noticing.

| Cause              | Means                                                                               |
| ------------------ | ----------------------------------------------------------------------------------- |
| **Bad fixture**    | The fixture really does contain the defect. The reviewer was right.                 |
| **Bad rule**       | The rule is mis-scoped or contradicts upstream. The reviewer applied it faithfully. |
| **Noisy reviewer** | Fixture and rule are both fine. The reviewer was wrong.                             |

**Presumption: any finding below 3/3 determinism is presumed reviewer noise
until argued otherwise.** 2/3 on _identical input_ is definitionally noise in
part — the same spec, the same rules, a different answer. It also carries
information: on the `enabled` false positive, 2/3 was the signature of an agent
genuinely torn between two of our own files, and chasing that split found a
live contradiction. A deterministic 3/3, by contrast, means consistent
reasoning, which points at the fixture or the rule.

**Why this rule exists.** Across the first five adjudications on this project,
"the reviewer was noisy" was selected **zero** times — five went to bad fixture,
one to bad rule and only when explicitly directed. Every individual call was
defensible and three were confirmed by independent review. But the mechanical
consequence of never selecting the third cause is that **every contested
construct eventually leaves the corpus.** Each edit is reasonable; the aggregate
converges on the same place as deliberate bias would. You do not pass the
measurement, you lose it.

The counter-evidence is worth recording too, because the bias is narrower than
it first looked: over the same period the corpus got measurably _harder_, not
easier — TN prose blocks fell to 1.40/file against 0.92 for positives, from a
12-to-1 separation — and the rule most often narrowed was the reviewer's own,
under a newly enforced Suggestion budget. The bias is in _attribution_, not in
corpus difficulty.

### Removing a provocation requires a regression stimulus

**When a fixture is edited to remove the construct that provoked a finding, add
a stimulus that keeps the original provocation and asserts the correct
behaviour.**

Deleting the provocation makes the fixture pass. It does not show the reviewer
would now stay silent if the construct returned — and when the rule was
re-scoped in the same change, that is a _testable claim left untested_. It is
also the only way to distinguish **a fixed reviewer from an avoided input**,
which is precisely the distinction this suite exists to make.

Two such guards exist today, both retroactive:

- `tn-genuine-booleans-not-modes` — keeps `enabled: boolean` after adjudication
  found the reviewer wrong and the fixture right.
- `tn-error-prose-without-codes` — restores the "distinct failure conditions in
  prose, no enumerated codes" paragraph that was deleted from
  `tn-runtime-behavioral` when `DP-ERR-01` was re-scoped. It asserts no
  _bracketed_ `DP-ERR-01`; a Questions bullet is correct, because that trigger
  is capped at Question severity.

A false positive on a correct fixture is a **measurement worth keeping**. Under
the Suggestion budget it costs one of two, which is affordable and is the point.

### Format tolerance in the graders

**The strict report format exists so grading can be mechanical. It is not a
product requirement.** A human reading a PR comment does not care whether the
heading glyph is 🔴 or 🚫, or whether findings are numbered. Measured across two
runs, format instability caused **more trial failures than judgment did** —
roughly 1 trial in 20, migrating between stimuli. That is an instrument whose
precision requirement exceeds the product's, so the instrument was loosened
rather than the contract lengthened. More contract prose had already been tried
and did not help.

What was loosened, and what was not:

| Element               | Before             | Now                                                                  |
| --------------------- | ------------------ | -------------------------------------------------------------------- |
| Severity heading      | `🔴` at line start | any heading containing the severity **word**, with any glyph or none |
| Finding position      | line start only    | line start, bullet, or numbered list item                            |
| **Bracketed rule ID** | **required**       | **still required — not negotiable**                                  |

**The bracket is the discriminator and cannot be loosened.** The considered-rules
table writes plain bold IDs without brackets —
`| **DP-MODEL-01** (actions ≠ CRUD) | ✅ Pass |` — so accepting a bracketless
bold ID would make correct silence indistinguishable from a finding. That is
grader defect #2, which cost a full run.

This has a consequence worth stating plainly: **the observed
`stable-version-breaking-changes` regression is not fixed by tolerance.** That
trial emitted _zero brackets anywhere_ — `**1. DP-VERSION-01 — Property type
changed**` — while finding and explaining all four breaking changes correctly.
Tolerance rescues glyph and position errors; it cannot rescue a dropped bracket
without destroying the discriminator. That failure mode remains, and the honest
position is that ~1 trial in 20 will fail on presentation.

**Graders are tolerant; the regression counter is not.** The counter matches a Blocking
heading by glyph **or word**, so a bracketless finding under `### 🚫 Blocking`
escapes the graders — correctly, it is a format failure — but is still charged
to the blocking metric, which asks only whether the reviewer declared something
blocking on a clean spec. Verified by probe in both directions.

**Unsectioned findings are reported, not silently absorbed.** A flat
`### Findings` list with no severity heading has genuinely unknowable severity,
so it is charged to neither the blocking metric nor the suggestion budget — but it is now
counted and printed as a format failure. This closes the budget blind spot in
the right place: an unsectioned pile is a formatting violation, not a budgeting
problem.

### Wall-clock ceiling

The third run took **~2h for 40 trials**, against 54 min for 31 trials
previously. Per-trial cost was **flat**, but per-trial **wall time nearly
doubled** — 1.7 → 3.0 min. One trial hit the harness's 600s per-trial cap and
errored: `Timeout after 600000ms waiting for session.idle`, on
`tn-linter-owned`, the 28-warning fixture and the densest in the corpus.

That is the ceiling to watch. It is a **wall-clock** limit, not a token or cost
limit, so it bites the biggest fixtures first and does not show up in a cost
estimate. If the corpus grows or fixtures get denser, raise `-Timeout` on
`run-evals.ps1` (default 600000 ms) before starting a long run rather than
discovering it 90 minutes in. An errored trial is excluded from the finding
counts — it is not a false positive and must not be counted as one.

## Second full run (2026-07-27) — first uncontaminated measurement

Both suites, `claude-opus-4.6`, judge `claude-sonnet-4.6`. TN at `runs: 3`
(21 trials), positives at `runs: 1` (10 trials). **31 trials, 981 AIU,
43 min** — 33% over the ~740 AIU estimate, because de-labeled fixtures make
the agent actually analyze rather than be told the answer (3.07M tokens on TN
vs 2.44M in the labeled run).

### Detection works — the first validated evidence

**10/10 positive stimuli found their seeded defect**, in finding position, with
the right rule family, every grader match verified by position rather than
taken on trust. Suite scores 75–100%. This answered the question the project
had been unable to answer: the reviewer does detect violations.

### The historical rollout bar fails

| Metric           | Value          | Verdict               |
| ---------------- | -------------- | --------------------- |
| Blocking FPs     | 1              | **FAILS** (must be 0) |
| Non-blocking FPs | 44 (2.1/trial) | tracked               |
| TN trials failed | 17/21          | fails                 |
| TN pass rate     | 19%            | —                     |

The 19% is the honest number, and it is far worse than the 42.9% of the first
run — because the first run measured fixtures that told the agent silence was
correct. **This is the first FP measurement not contaminated by label
leakage.**

The blocking false positive was the agent overriding a documented rationale:
on `tn-closed-union-justified` it wrote _"the inline doc comment argues the set
is intentionally closed, but the Guidelines do not permit this"_ and raised it
Blocking. Both halves were wrong — the Guidelines say
`YOU SHOULD ... unless you are positive the symbol set will NEVER change`, and
a `SHOULD` cannot support a Blocking finding. It appeared in **1 of 3** trials,
the worst profile for a regression.

### Two failures were not the agent's fault

- **`tn-clean-service` 0/3 was a fixture defect.** The fixture used British
  `colour`/`NotebookColour`; Azure uses US English. The agent was right, all
  three trials, and the judge agreed. **Those three trials are miscounted as
  false positives, so the true rate is better than 19%.** A second fixture had
  the same defect (`analyze`); both are now corrected.
- **`DP-MODEL-04` appeared in 12 of 31 trials**, which looked like padding.
  It was a corpus artifact: 9 of 11 fixtures had no delete operation, so the
  agent was making a consistent, defensible observation about a uniform
  silhouette. The fixtures have since been diversified.

### Fixes applied in response

1. Skill-wide guidance on **normative strength and documented rationale** — a
   `SHOULD` can never be Blocking, and a documented rationale is the exception
   the Guideline grants, to be assessed for plausibility rather than overridden.
2. `enum-best-practices.md` had flattened the Guideline's `SHOULD ... unless`
   into **"Every enum MUST be modeled as extensible"** — the direct source of
   the blocking FP. Corrected, with the exception restored.
3. `DP-PAGE-01` and `DP-MODEL-04` reworded to carry their upstream conditions
   and to say plainly that a documented rationale ends the enquiry.
4. Fixture spelling corrected; fixture silhouettes diversified.
5. Preview-versioning grader narrowed from the `DP-VERSION-` family to
   `DP-VERSION-01`, the rule the rubric actually forbids.

### Coverage restored after the rewrite

The bracketed-ID rewrite made two graders strictly narrower than their names
claimed, which is its own kind of dishonesty — a grader whose name overstates
what it tests is worse than an absent one. Both were renamed to what they
actually assert, and a companion grader was added to restore the lost coverage
soundly:

| Grader                                               | Now asserts                                        |
| ---------------------------------------------------- | -------------------------------------------------- |
| `no finding raised on a linter-owned file`           | no finding of any kind (was "no duplicate report") |
| `no linter-owned rule raised as a finding`           | no linter rule name in **finding-title position**  |
| `no finding raised on a runtime-behavioral file`     | no finding of any kind (was "not invented from…")  |
| `no runtime behavior raised as a finding`            | no runtime topic in **finding-title position**     |
| `does not raise casing-style as a finding`           | `casing-style` in finding-title position           |
| `does not raise documentation-required as a finding` | `documentation-required` in finding-title position |

The companion graders anchor to `**[DP-XXX-NN] …`, so a deferral sentence
("Deferred to the linter: `no-enum`, `casing-style`") does not trip them while
a finding titled "casing-style violation on `accountID`" does. That is the same
structural hook as everywhere else, applied to vocabulary that could not
otherwise be banned. `no restatement of linted defects in prose` also regained
`avoid @format` and `missing @doc`, both inherently assertive; the unsound bare
`snake_case` alternative stays dropped.

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
graders against leaked-fixture behavior would have calibrated them to an
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
behavior.

## Known limitation: these evals test the skill, not the agent

vally has no concept of an agent file. A stimulus loads the
[`azure-api-review`](../../azure-api-review/SKILL.md) skill via
`environment.skills` and runs a bare Copilot CLI against the prompt. So this
suite exercises the **skill's guidance and rule definitions** and nothing else.

Untested by every eval in this directory:

| Untested                          | Defined in                                                                                    |
| --------------------------------- | --------------------------------------------------------------------------------------------- |
| Persona and severity calibration  | `data-plane-api-reviewer.agent.md` §Persona                                                   |
| Self-identification as an agent   | `data-plane-api-reviewer.agent.md`                                                            |
| The 15-finding cap                | enforced by the agent, not by the format contract                                             |
| The silence checklist             | `data-plane-api-reviewer.agent.md`                                                            |
| Critic dispatch and FAIL handling | `data-plane-api-review-critic.agent.md`, `protocols/data-plane-api-review-critic.protocol.md` |
| Scope gate and PR-diff handling   | `.github/workflows/data-plane-api-review.md`                                                  |

This is **accepted for v1** rather than worked around. Two consequences worth
holding onto:

1. **The report format is deliberately not in that list any more.** It used to
   be, and that was a defect rather than a limitation — see the correction
   below.
2. **Phase 0 dark launch is what exercises the agent file**, running the real
   workflow with the real agent over already-merged PRs. Nothing here
   substitutes for it.

### Correction: the report format now lives in the skill

**An earlier version of this section claimed the format-keyed graders "work
because the skill's own examples use it, not because anything enforces it."
That was asserted without checking, and it was false.** If you remember that
framing, discard it.

At the time it was written the finding syntax and severity glyphs were defined
**only** in `data-plane-api-reviewer.agent.md`, which vally never loads. The
skill contained zero bracketed rule IDs and no report-format definition at all.
Measured across the 21 recorded trials of the first run, the agent emitted:

| Form                    | Trials containing it |
| ----------------------- | -------------------- |
| Bracketed `[DP-XXX-NN]` | **0**                |
| `🔴`                    | **0**                |
| Bare `DP-XXX-NN`        | 18                   |

Run in that state, every positive detection grader would have failed and every
true-negative grader would have passed vacuously — a ~100% false-failure rate
on the positive suite, discovered only after a 30-minute, ~500-AIU run.

The fix was to move the contract into the skill, where both production and the
evals read it:
[`references/data-plane-report-format.md`](../../azure-api-review/references/data-plane-report-format.md).
The agent file now defers to it and does not restate it. `checkReportFormatContract`
in
[`data-plane-review-alignment.js`](../../../workflows/src/data-plane-review-alignment.js)
asserts the contract is present in what vally loads, that every positive grader
matches a syntax the contract teaches, and that the agent has not grown a
second copy — so this class of drift fails at pull-request time rather than
after an eval run.

**Still unverified:** that an agent loading the skill actually emits the
bracketed form. The 21 recorded trials are _pre-change_ output and can only
confirm what the agent does **without** the contract. Confirming the fix
requires a fresh run.

## Known coverage gaps

Read this before concluding anything from the 40% true-negative share.

### The prose-length confound is neutralized in aggregate

The initial corpus had 12 multi-line `@doc("""` blocks across the four
single-version true-negative fixtures and one across all positive fixtures.
That let a model use "is this file arguing with me?" as a proxy for silence.

The current source files contain **10** such blocks in true negatives and
**11** in positives. `tn-clean-service`, `tn-linter-owned`, and the additive
stable pair are terse; `notification-routing` and
`unpaged-search-rationale` each contain five confident multi-line blocks while
retaining a real defect. Long prose is now evidence on both sides, not a class
label.

This closes the obvious corpus-wide shortcut, not every linguistic shortcut.
Only an eval run can show whether the model actually reads the rationales.

### The new stimuli have never executed

As of 2026-07-30, neither persuasive-prose positive
(`single-write-only-property-without-padding` and
`persuasive-rationale-does-not-excuse-unpaged-search`) nor the additive
stable-to-stable true negative (`tn-stable-additive-version-allowed`) has run
under vally. Historical suite results therefore say nothing about them.

The padding grader is also entirely new and unexercised against model output.
Its exactly-one-finding threshold passes static soundness and count-position
probes, but remains a designed hypothesis until an authorized eval run measures
it. Do not treat the threshold as empirical calibration.

### Padding has one direct probe, not representative coverage

The false-positive mode most likely to get this bot muted in practice is
**not** a confident wrong finding on a clean spec. It is a spec that is 90%
fine and has one genuine issue, where the reviewer reports the real finding and
then pads with three or four adjacent low-value ones to look thorough.
Reviewers tolerate a wrong finding; they stop reading a bot that buries a good
finding in noise.

The family-agnostic counter records findings on true negatives, and the
notification-routing stimulus now directly grades padding around one genuine
finding. Its exactly-one threshold is deliberately strict for the reasons
above.

One synthetic service is not representative coverage. Padding can be triggered
by many other contexts -- mixed old and new surface, multi-file graphs,
versioned changes, and partially documented legacy APIs -- none of which this
probe spans.

### The true-negative denominator is 6, not 8

Three of the eight true-negative stimuli (`tn-legitimate-action-not-crud`,
`tn-bounded-list-and-singleton`, `tn-closed-union-justified`) all run against
the same fixture, `fixtures/typespec-data-plane/tn-legitimate-deviation.tsp`.
Counting stimuli overstates independence:

| Fixture                                   | Stimuli |
| ----------------------------------------- | ------- |
| `tn-legitimate-deviation.tsp`             | 3       |
| `tn-clean-service.tsp`                    | 1       |
| `tn-linter-owned.tsp`                     | 1       |
| `tn-runtime-behavioral.tsp`               | 1       |
| `version-pairs/preview-*.tsp`             | 1       |
| `version-pairs/stable-additive-property/` | 1       |

Any fixture-level flaw — the label leakage above, an unrealistic construction,
a compile error — hits all three at once. Their _graders_ are distinct, so they
do not necessarily pass or fail together (in the first run,
`tn-closed-union-justified` passed 3/3 while the other two failed 0/3), but
they share a single input and a single author's idea of what a legitimate
deviation looks like. Six distinct fixtures is still a thin regression corpus.

### Suppression coverage is narrow

`tn-legitimate-deviation.tsp` contains a real `#suppress` for a protocol-closed
union with a specific technical justification. It covers the most important
positive case: a reviewer should read and accept a sound suppression rather
than restating its warning.

There is still no positive fixture for an inaccurate, blanket, or placeholder
suppression, and no coverage of suppression review outside union
extensibility. This rebuild did not add one because prose confounding and
padding were the higher-risk measurement failures.

### Consequence for rollout decisions

Because of these gaps, and because the new stimuli have not yet had an
authorized vally run, the synthetic suite cannot bound a production
false-positive rate or decide a rollout phase by itself. It can catch specific
regressions. During the manually controlled
[Phase 2 canary](ROLLOUT.md#phase-2-is-a-human-feedback-canary), real author
feedback is the primary signal because merged data-plane pull requests provide
the distribution the synthetic corpus cannot.

## Model pinning

Two separate pins, with two separate rules.

### `model` — must equal production

`model` in every eval file **must** stay equal to the top-level `model:` in
[`.github/workflows/data-plane-api-review.md`](../../../workflows/data-plane-api-review.md).
Both are currently `gpt-5.6-sol`.

This coupling is the whole reason the workflow pins a model at all. The
false-positive trend is useful only when the eval and production run the same
model; otherwise the measurement describes a configuration that is never
shipped.

`vally`'s `model:` and gh-aw's are nominally different namespaces — gh-aw
passes its pin through to the Copilot CLI as `COPILOT_MODEL` without validating
it. Both use `gpt-5.6-sol`, so no mapping is needed. If a future model's
identifiers differ between the two, document the mapping next to both pins.

The workflow pin was spelled `engine.model` until gh-aw v0.83.1 deprecated that
form in favor of a top-level `model:`. The alignment check accepts both, so a
rebase onto an older branch does not break the invariant.

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

1. Bump `model` in every `vally/eval-*.yaml` **and** the top-level `model:` in
   the workflow, in the same pull request.
2. Re-run the full suite and compare against the previous baseline run.
3. Leave `judge_model` alone.
4. Do not fold the bump into an unrelated change.

[`.github/workflows/data-plane-review-alignment.yaml`](../../../workflows/data-plane-review-alignment.yaml)
enforces steps 1 and 3 mechanically: it fails when the workflow model and any
eval model diverge, and when `judge_model` drifts from the frozen baseline.

### What is _not_ coupled

The gh-aw threat-detection step has its own engine model
(`safe-outputs.threat-detection.engine.model` in the workflow), pinned to
`claude-sonnet-4.6`. Without that override it inherits the workflow's `model:`
and runs the expensive review model on a cheap classification task. It is
intentionally decoupled: this suite measures review output, not
threat-detection decisions, and the alignment check does not constrain it.

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
   the false-positive and blocking regression metrics.
6. Keep the true-negative share at or above 40%, and prefer a **new** fixture
   over a fourth stimulus against an existing one — see "The true-negative
   denominator is 6, not 8".
7. Give each stimulus a mechanical grader **and** an LLM-judge `prompt` grader
   with a rubric. The mechanical grader makes a regression cheap to spot; the
   rubric catches the reviewer being technically right and useless.
8. **Write mechanical graders against the finding syntax, not the vocabulary.**
   Use `output-matches` with the bold-bracketed form
   `\\*\\*\\[DP-XXX-NN\\]`, never
   `output-contains` with a bare rule ID: a rule the agent considered and
   declined appears as a plain bold ID in a table, so a bare match cannot tell
   a finding from its refutation. `checkGraderSoundness` fails the build if a
   grader fires on a correctly-silent answer or is inert against a real report.
