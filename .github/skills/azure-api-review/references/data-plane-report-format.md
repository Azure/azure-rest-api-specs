# Data-Plane Review Report Format

**This file is the single, authoritative definition of the data-plane
reviewer's finding syntax and severity vocabulary.** Everything that produces
or grades a data-plane review reads it from here:

| Consumer                                                                                         | Uses this file for                                       |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------- |
| [`data-plane-api-reviewer.agent.md`](../../../agents/data-plane-api-reviewer.agent.md)           | The format it emits (§"Report format" defers to here)    |
| [`data-plane-api-review-critic.agent.md`](../../../agents/data-plane-api-review-critic.agent.md) | The severity ceilings it enforces                        |
| [`evals/data-plane-api-reviewer/vally/eval-*.yaml`](../../evals/data-plane-api-reviewer/vally/)  | The syntax every mechanical grader matches on            |
| [`data-plane-review-alignment.js`](../../../workflows/src/data-plane-review-alignment.js)        | The contract it asserts is present and grader-compatible |

## Why it lives in the skill and not in the agent file

It used to live only in the agent file, and that caused a real defect.

The eval harness (vally) has **no concept of an agent file**. A stimulus loads
this skill and runs a bare agent against a prompt. So a format defined only in
the agent file is invisible to every eval — while the graders were matching on
that very format. The result: graders keyed on `[DP-XXX-NN]` and `🔴` against
an agent that had never been told to emit either. Measured across the 21
recorded trials of the first real run: **0 bracketed rule IDs, 0 `🔴`, 18 bare
`DP-XXX-NN`.** Every positive detection grader would have failed, and every
true-negative grader would have passed vacuously.

Defining the format here makes production and evaluation share one source. If
you change anything in this file, the agent, the critic, and every grader
change with it — which is the point.

## Finding syntax

Every finding is a bolded, **bracketed** rule ID, a short title, and a
`file:line`:

```markdown
**[DP-VIS-02] Secret readable in response** --
`specification/foo/data-plane/Foo/models.tsp:42`
```

Then, in order: a quoted source excerpt, the reason with a link to the
authoritative source, and a concrete fix as a code block.

### The brackets are load-bearing — do not drop them

They are what distinguishes **reporting a finding** from **citing a rule you
considered and declined to raise**. A competent review does both, often in the
same output:

| Text                                                                         | Meaning                        |
| ---------------------------------------------------------------------------- | ------------------------------ |
| `**[DP-PAGE-01] Unbounded collection returned unpaged** -- \`main.tsp:102\`` | A finding. Graders must match. |
| `\| **DP-PAGE-01** (list ops paged) \| ✅ Pass \| Collection is bounded. \|` | Considered, not raised.        |
| `DP-VERSION-01: N/A -- no prior version to compare against.`                 | Considered, not raised.        |

A grader keyed on a bare `DP-PAGE-01` cannot tell these apart, so it fires on
the second and third — punishing the correct answer on a true negative, and
passing on a missed violation in the positive direction. Both failure modes
were live in this suite before the bracketed form was adopted.

**Therefore:** use the bracketed form **only** for findings you are actually
raising. When you mention a rule you considered and did not raise, write the
rule ID bare, without brackets.

### Rule-ID vocabulary

The grading scheme depends on knowing every ID family a review can cite, so it
is recorded here. Enumerated from citation contexts across `SKILL.md` and all
`references/*.md`: **60 distinct IDs in 9 families.**

| Family       | Shape                    | Example                  | Source                                  |
| ------------ | ------------------------ | ------------------------ | --------------------------------------- |
| `DP-`        | `DP-<AREA>-NN`           | `DP-VIS-02`              | the six data-plane references           |
| `DDP-`       | `DDP-NNN`                | `DDP-002`                | `data-plane-design-decisions.md`        |
| `SEC-`       | `SEC-<WORD>-<WORD>`      | `SEC-SECRET-DETECT`      | `secret-detection.md` (cross-cutting)   |
| `EX-`        | `EX-<WORD>`              | `EX-ORPHAN`              | `example-quality.md` (cross-cutting)    |
| `OAPI-`      | `OAPI-<WORD>-<WORD>`     | `OAPI-PATTERN-ALLOWLIST` | `pattern-validation.md` (cross-cutting) |
| `RPC-`       | mixed case, multi-hyphen | `RPC-Put-V1-11`          | ARM references — must not be cited here |
| `PREFLIGHT-` | `PREFLIGHT-NNN`          | `PREFLIGHT-001`          | ARM references — must not be cited here |
| `WHATIF-`    | `WHATIF-NNN`             | `WHATIF-001`             | ARM references — must not be cited here |
| `SECRET-`    | legacy alias             | `SECRET-DETECT`          | `secret-detection.md`                   |

Two consequences the graders depend on:

- **Not every ID starts with `DP-`.** A data-plane review legitimately cites
  `SEC-SECRET-DETECT` and `EX-ORPHAN`; this was observed in a live run. Any
  grader asserting "no finding of any kind" must therefore match the general
  form, not the `DP-` shape:
  ```
  \*\*\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\]
  ```
- **Not every ID is all-caps.** `RPC-Put-V1-11` is mixed case. The ARM families
  are listed because a _mistaken_ citation of one is still a finding a
  true-negative grader must be able to see — not because a data-plane review
  should ever cite them.

The pattern above requires at least one hyphen, which is what keeps it from
matching bolded prose like `**[Note]**` or `**[TODO]**`.

## Severity

| Severity   | Glyph | Meaning                                                      | Use when                                                                                                        |
| ---------- | ----- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| Blocking   | 🔴    | Ships a defect that is expensive or impossible to fix later. | Secret exposure; breaking change in a stable version; CRUD-in-disguise in a new service's first stable version. |
| Warning    | 🟡    | Should be fixed; will cause customer or SDK pain.            | Most `DP-*` rule violations.                                                                                    |
| Suggestion | 💡    | Improvement, or a grey-area trade-off.                       | Everything from [`data-plane-design-decisions.md`](data-plane-design-decisions.md); most doc findings.          |
| Question   | --    | You are not sure, and the author has context you lack.       | Whenever the honest answer is "it depends". See "Questions are not findings".                                   |

### Questions are not findings

A rule whose declared severity is **Question** — `DP-MODEL-04`, and every
`DDP-*` design-decision framework — does not produce a finding at all. It
produces a bullet in the `### Questions` section, and it obeys different rules
from the three glyph severities:

|                       | Findings (🔴 🟡 💡)                | Questions                       |
| --------------------- | ---------------------------------- | ------------------------------- |
| Form                  | `**[RULE-ID] Title** -- file:line` | plain markdown bullet           |
| Bracketed rule ID     | required                           | **must not** be used            |
| `file:line`           | required                           | encouraged, inline in the prose |
| Quoted source excerpt | required                           | optional                        |
| Concrete fix          | required — no fix, no finding      | **must not** propose one        |
| Counts toward the cap | yes                                | no                              |

A Question asks; it does not assert. Write it so the author can answer "yes,
because…" and be done:

```markdown
### Questions

- `Item` has create, read, and list but no delete (`inventory.tsp:82`). Is an
  item genuinely permanent, or is deletion handled elsewhere?
- `AnalysisMode` is a closed union (`analyzer.tsp:41`). The doc says the wire
  protocol fixes the value set — is that contractual?
```

**A rule may also cap a single trigger at Question while the rule itself is
Warning.** `DP-ERR-01` does: its "unusable code values" and "one code for many
failures" triggers are bracketed Warning findings, while its "nothing enumerated
to distinguish the conditions" trigger is a Questions bullet. The emission form
follows **the trigger that fired**, not the rule's headline severity — check the
rule's own trigger table before choosing a form.

**Do not** write a Question as a bracketed finding, do not give it a severity
glyph, and do not attach a `**Fix:**` block. If you are proposing the fix, you
are not asking a question — you are making a finding, and it must meet the
finding bar or be dropped.

If a Question has no answer that would change anything, drop it. A list of
rhetorical questions is the same noise as a list of weak findings.

Severity glyphs appear as section headings — `### 🔴 Blocking` — and nowhere
else. Do not use a glyph mid-sentence: graders anchor on line position to avoid
counting `"no 🔴 blocking findings"` as a blocking finding, and prose glyphs
defeat that.

### The three severity glyphs are the only glyphs. Never borrow the interlock's

**🔴 🟡 💡 are the entire severity vocabulary.** Nothing else marks severity.

The reference files use a **second, unrelated** emoji vocabulary for linter
interlock _status_ — 🔒 Linted, ⏳ Landing, 📋 Planned, 🤖 Agent-only,
🚫 Runtime, ❓ Unresolved, 🚷 Not a rule. Those glyphs say **who owns a rule**,
never **how severe a finding is**, and they must never appear in a report as a
severity marker.

The collision is easy to make and has been made: 🚫 and 🚷 read as strong
prohibitions, several rule files carry them a few lines from the rule text, and
`DP-VERSION-04` in particular points at the interlock's 🚷 section. A real run
emitted `| 🚫 Blocking |` in a findings table. **If you find yourself reaching
for a glyph that is not one of the three, you are reaching into the wrong
vocabulary.**

### Findings are never a table

Emit findings in the bracketed form defined above — `**[RULE-ID] Title** --
`file:line``— under a severity **heading**. Do not summarize them as a markdown
table with a`Severity`or`Rule ID` column, however tidy it looks. A table
loses the bracketed anchor every grader keys on, moves severity out of heading
position, and invites a glyph in a cell.

This has happened in a real run, on a rule the agent had not exercised before,
which is exactly when the pull toward improvising a format is strongest. **A
rule you have never raised before uses the same format as every other rule.**

**Blocking is rare.** For a maintenance-edit PR it is reserved for secret
exposure and breaking changes, nothing else. More than three Blocking findings
in one run means you are over-escalating — the documented failure mode of the
ARM reviewer (`evals/arm-api-reviewer/README.md` §Known limitations).

**Blocking requires a `DO` / `DO NOT` Guideline, or a correctness or security
defect.** A `YOU SHOULD` / `YOU SHOULD NOT` statement can never justify a
Blocking finding, however strongly you disagree with the spec's choice — cap it
at Warning. And where the spec documents a rationale for a `SHOULD`-level
choice, check it in two steps: does the Guideline grant an exception at all, and
does the rationale meet **that condition** rather than merely reading well? If
both hold, raise nothing; if you raise the finding anyway, name the rationale
and say why it fails. See "Normative strength and documented rationale" in
[`SKILL.md`](../SKILL.md).

## Document shape

````markdown
## Data-Plane API Review

_Automated review by Copilot (data-plane API reviewer agent). Reviewed `<n>`
TypeSpec file(s) at `<short-sha>` against the Azure REST API Guidelines. This
is advisory and does not replace human API review._

<!-- when there are no findings -->

No findings. The changed data-plane TypeSpec looks consistent with the
Guidelines in the areas this review covers (resource modeling, versioning,
error design, LRO/paging, visibility, naming clarity, documentation quality).

<!-- when there are findings -->

### 🔴 Blocking

**[DP-VIS-02] Secret readable in response** --
`specification/foo/data-plane/Foo/models.tsp:42`

```tsp
accountKey: string;
```

`accountKey` is readable, so it is returned by both `get` and `list`. Per
[Azure REST API Guidelines -- Sensitive data](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md),
credentials must not be returned in resource bodies.

**Fix:** mark it `@secret` with write-only visibility, and expose it through a
dedicated `:listKeys` operation.

```tsp
@secret
@visibility(Lifecycle.Create, Lifecycle.Update)
accountKey: string;
```

### 🟡 Warning

...

### 💡 Suggestion

...

### Questions

- ... (plain bullets — grey areas from `data-plane-design-decisions.md`, and
  `DP-MODEL-04` operation asymmetries. Present the trade-off, do not decide,
  do not propose a fix.)

---

**Not reviewed:** items enforced by `@azure-tools/typespec-azure-core`
(reported by CI, not here) and guideline statements about runtime service
behavior, which are not observable in a specification.
````

### Unattended inline projection

The document above is the **canonical report** used by interactive sessions and
the eval suite. An unattended workflow may project that report across validated
safe-output channels without inventing a second finding format:

- An inline comment contains one complete canonical finding body, without its
  severity heading, attached to the finding's verified changed line.
- The summary indexes inline findings with **bare** rule IDs so it does not
  duplicate them as bracketed findings.
- Findings beyond the configured inline cap, findings without a valid diff
  anchor, and all Questions remain in the summary.
- The inline cap is a ceiling, not a quota. Never create weak findings to fill
  it.

Unless a workflow explicitly provides this projection, emit the canonical
document shape unchanged.

## Rules for the report

- **Identify yourself as an agent in the first line.** The report may be posted
  verbatim to a pull request, and readers must know it is machine-generated.
- **Order:** Blocking, Warning, Suggestion, Questions. Within a severity, by
  file then line.
- **Cap:** at most 15 findings. If more survive, keep the highest-severity 15
  and state the count omitted. A 40-item report does not get read.
- **Group** naming and documentation findings of the same kind into one entry
  with multiple line references.
- **Every finding** carries a bracketed rule ID, a `file:line`, a quoted source
  excerpt, a reason, and a concrete fix. No fix, no finding.
- **Link both layers of authority.** Link the local rule for its reviewer-specific
  interpretation and, when that rule lists an authoritative upstream source,
  also link the most specific upstream Guidelines or TypeSpec anchor. The local
  reference explains the check; the upstream link lets authors verify the
  original contract.
- **No praise sections, no summary of what the PR does, no restating the diff.**
  The author knows what they wrote.
- **Never** claim CI status you have not read, and never duplicate a finding CI
  already reported.

## Silence is a valid report

If nothing survives the interlock filter, self-verification, and the critic,
emit the "no findings" form above. Do not pad. A clean specification receiving
a clean review is the system working, and it is the outcome the true-negative
eval suite exists to protect.

## Never emit a finding you then retract

Revise before you emit, not after. A report must not contain a finding
followed by a retraction — no "_(Retracted — on reflection this is contact
info, not a secret.)_", no finding under a `### 🔴 Blocking` heading followed
by "No Blocking findings."

This has happened. The reviewer raised `**[DP-VIS-02] Secret readable in
response**`, then retracted it two lines later and concluded "No Blocking
findings" — leaving both in the report. The conclusion was correct and the
self-correction was good judgment, but the output was worse than either
outcome alone: a reader skimming headings sees a blocking secret-exposure
finding that the author has already withdrawn.

Self-correction belongs in your reasoning, not in the report. If you write a
finding and then decide it does not hold, **delete it** — including its
severity heading if nothing else sits under it. The report is a conclusion, not
a transcript.

A retracted finding is scored as a **format violation**: it does not count as a
false positive, because the report's own conclusion is correct, but it fails
the report contract.
