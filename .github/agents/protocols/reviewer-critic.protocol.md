<!-- This is a shared protocol reference, not a standalone agent file.
     It is the single source of truth for the contract between the
     `ARM API Reviewer` agent and the `ARM API Review Critic` agent.
    Both agents reference this file by section anchor. Keep canonical schemas
    here; agent files may include short operational summaries, but this file
    wins whenever summaries drift. -->

# Reviewer <-> Critic Protocol

This file defines the wire contract between the `ARM API Reviewer` and the
`ARM API Review Critic` agents: the inputs the Reviewer passes, the verdict
tracks the Critic returns, the sentinel strings both sides accept, and the
two telemetry-marker schemas.

If the Reviewer or Critic file contradicts this document, **this document
wins**. File bugs against the agent that drifted.

## Glossary

| Term                        | Meaning                                                                                                                                                                        |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Session SHA**             | The PR head commit SHA captured by the Reviewer at Step 1. Binding for every PR-head file fetch by both agents across every iteration of a single review session.              |
| **Base SHA / base ref**     | The PR base commit SHA or immutable base ref captured by the Reviewer at Step 1. Binding for previous-version file fetches used for breaking-change and classification checks. |
| **Review session**          | The arc from Step 1 (SHA pinned) through Step 10 (cleanup), within one conversation thread on one PR.                                                                          |
| **Dispatch**                | The host's subagent-invocation mechanism: `runSubagent` with `agentName: "ARM API Review Critic"` in VS Code Copilot Chat, the equivalent `agent` tool in other hosts.         |
| **Fast path / Full review** | Two review-depth tracks selected in Reviewer Step 1. Fast path skips Steps 3, 3.5, 4a, 5; Full review runs all steps.                                                          |
| **Sentinel string**         | A literal string passed between agents that signals "this input is intentionally absent in a specific way" -- currently only `reconciliation skipped`.                         |
| **Finding-level FAIL**      | A Critic `FAIL` on a specific finding from the Reviewer's report (wrong line, rule misapplied, etc.). Overridable per the override workflow.                                   |
| **Reconciliation FAIL**     | A Critic `FAIL` on a Step 5.5 reconciliation-plan entry. **Non-overridable**; only correct, drop, demote, or escalate.                                                         |
| **Graph-fabrication FAIL**  | A Critic `Graph integrity = FAIL: fabrication` verdict. **Non-overridable**; the Reviewer must drop dependent findings and re-derive.                                          |
| **INVALIDATED**             | Critic `Finding accuracy = INVALIDATED` (session SHA moved or unreachable). Kills the entire session; no findings may be posted.                                               |

## Inputs the Reviewer passes to the Critic

Pass all ten on every Critic invocation in this exact order. Missing or
malformed inputs MUST cause the Critic to return `Finding accuracy = FAIL`
with reason `missing-inputs`.

| #   | Input                              | Notes                                                                                                                                                                                                                                                    |
| --- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | PR URL                             | `owner/repo#number` form.                                                                                                                                                                                                                                |
| 2   | Session SHA                        | Full 40-char commit SHA pinned at Reviewer Step 1. **Binding for every PR-head file fetch.**                                                                                                                                                             |
| 3   | Step 6 findings report             | Verbatim.                                                                                                                                                                                                                                                |
| 4   | List of files reviewed             | Workspace-relative paths.                                                                                                                                                                                                                                |
| 5   | Previous-version source            | The base-branch path **and base SHA/ref** used for `[NEW]`/`[EXISTING]` classification, e.g. `base-sha: <sha>; path: <path>`, or `None - new service`. Changed PR files are fetched at Input #2; previous-version files are fetched at this base source. |
| 6   | Step 5.5 reconciliation plan       | Verbatim. If reconciliation was skipped, pass the literal string `reconciliation skipped` (see Sentinel strings).                                                                                                                                        |
| 7   | Prior iterations' FAIL set summary | The two most recent prior iterations' rule-ID + file/line tuples. Empty list on iteration 1 (see note below). Used for wave-thrash detection at iteration 3.                                                                                             |
| 8   | Considered-and-declined list       | Prior-iteration `Likely missed violations` candidates the Reviewer evaluated and chose not to promote, each with a one-line rationale. The Critic MUST suppress these unless fresh evidence justifies re-surfacing. Empty list on iteration 1.           |
| 9   | Graph production flag              | `graphs-produced: true\|false`. `false` on fast path or when graph derivation failed; the Critic records `Graph integrity = N/A`.                                                                                                                        |
| 10  | Current iteration number           | `1` through `3`. The Critic's output header echoes this verbatim; do not infer from input length.                                                                                                                                                        |

> **Iteration-1 empty-list rule (load-bearing).** On iteration 1, Inputs #7
> and #8 MUST be passed as an **explicit** empty list -- literally `[]` or
> the literal string `none`. Omission is **not** equivalent and causes
> `Finding accuracy = FAIL` with reason `missing-inputs`. The contract is
> "pass all ten inputs on every invocation"; iteration 1 satisfies that
> contract for #7 and #8 by passing an explicit empty container, not by
> dropping the field.

## Session-handoff verification (fallback path)

When subagent dispatch is unavailable and the Reviewer accepts a
human-pasted Critic output, the Reviewer MUST validate the pasted output
before folding it into the report:

- The Critic header field `PR:` exactly matches the current PR under review.
- The Critic header field `Head SHA:` exactly matches the session SHA pinned
  in Reviewer Step 1.
- The Critic header field `Base SHA/Ref:` matches Input #5 when present, or is
  omitted / `n/a` only when Input #5 is `None - new service`.
- The Critic header field `Iteration:` is a valid `1` through `3` and is
  consistent with the Reviewer's current iteration loop.
- The pasted output includes, verbatim, both the `### Verdict` section and
  the `### Per-finding annotations` section.

If any check fails, the Reviewer MUST reject the pasted output as invalid
handoff data and request a corrected verbatim paste. Free-form acknowledgments
such as "looks fine" are never valid substitutes.

## Critic verdict tracks

The Critic returns four verdicts in its output header. Three are binding,
one is advisory.

| Track                       | Values                                               | Binding?                         | Notes                                                                                                                      |
| --------------------------- | ---------------------------------------------------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Finding accuracy**        | `PASS` / `WARN` / `FAIL` / `INVALIDATED`             | Binding                          | `INVALIDATED` (reasons: `session-sha-moved`, `session-sha-unreachable`) overrides every other track and kills the session. |
| **Graph integrity**         | `PASS` / `WARN` / `FAIL: fabrication` / `N/A`        | Binding when `FAIL: fabrication` | `N/A` only legitimate when Input #9 was `graphs-produced: false`.                                                          |
| **Reconciliation accuracy** | `PASS` / `WARN` / `FAIL` / `N/A`                     | Binding when `FAIL`              | `N/A` only legitimate when Input #6 was the sentinel `reconciliation skipped`.                                             |
| **Coverage quality**        | `APPROVE` / `REQUEST EXPANSION` / `NEEDS DISCUSSION` | Advisory only                    | Never gates posting.                                                                                                       |

## Sentinel strings

Only one sentinel is currently defined.

- **`reconciliation skipped`** -- pass as Input #6 when the Reviewer could
  not produce a reconciliation plan (existing-comment fetch failed and the
  human elected to proceed, or the human cancelled reconciliation). The
  Critic responds by recording `Reconciliation accuracy = N/A`. An empty
  plan, empty string, or omitted Input #6 is **not** equivalent -- the
  Critic FAILs the run on those.
- A plan whose every row is `POST-NEW` is still a plan; pass it verbatim,
  not the sentinel.

## Telemetry-marker schemas

The Reviewer emits two distinct marker types. They live in different
places and serve different purposes. Do not confuse them.

### Review-state marker (per response)

Hidden HTML comment as the **literal first line** of every Reviewer
response after Step 1 begins, through Step 10 (or session abandonment /
invalidation). Required regardless of content -- findings, error reports,
approval prompts, SHA-drift reports.

<!-- markdownlint-disable MD013 -->

```html
<!-- review-state: critic-mode={pending|subagent|session-handoff|unavailable|invalidated} | iteration={N} | pr={owner/repo#number} -->
```

<!-- markdownlint-enable MD013 -->

| Field         | Values                                                                                                | Meaning                                                                                                                                                                                |
| ------------- | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `critic-mode` | `pending`                                                                                             | Review session is live after Step 1 pinned SHAs, but the Critic has not returned yet. Only progress, fetch-error, or handoff messages may use this value; no findings may be rendered. |
|               | `subagent`                                                                                            | State A: Critic dispatched as subagent and verdict folded in.                                                                                                                          |
|               | `session-handoff`                                                                                     | State A via human-pasted verdict from the fallback prompt.                                                                                                                             |
|               | `unavailable`                                                                                         | State C: human explicitly opted out at Step 7 fallback Rung 2. `[!CAUTION]` banner rendered. **Never `skipped` -- that value is forbidden.**                                           |
|               | `invalidated`                                                                                         | State D: Critic returned `Finding accuracy = INVALIDATED`. SHA-drift report only; no findings rendered.                                                                                |
| `iteration`   | `1`-`3` (Critic iteration this response reflects); `0` for Reviewer-detected drift between iterations | Echo of Input #10 for the most recent Critic call. See note below on `iteration=0`.                                                                                                    |
| `pr`          | `owner/repo#number`                                                                                   | Used by State A's session-boundary check.                                                                                                                                              |

Exempt from the marker: responses emitted **before** Step 1 pins the
session SHA (e.g., out-of-scope-repo decline messages).

> **`iteration=0` rule.** `iteration=0` is reserved for Reviewer-detected
> session-SHA-drift or session-invalidation reports emitted **between**
> Critic iterations -- never on a response that folds in a fresh Critic
> verdict. When `iteration=0`, the response body MUST be the drift or
> invalidation report only (no findings, no posting prompts) and
> `critic-mode` carries whatever value the prior iteration ended with
> (typically `subagent`). Responses that fold in a Critic verdict require
> `iteration` in `1`-`3`.

### Per-comment telemetry marker (Step 6 canonical body and Step 8 posting)

<!-- cspell:ignore REPOST -->

Hidden HTML comment as the **last line** of every posted PR comment
(POST-NEW and RESOLVE-AND-REPOST). To satisfy Reviewer-Posted Parity, the
Reviewer also renders this exact marker in any Step 6 canonical comment body
that is shown to the human and later posted. Not on reply-only comments
(REPLY-LINE-SHIFT, THANK-AND-RESOLVE, PROPOSE-HUMAN-RESOLVE replies).

<!-- markdownlint-disable MD013 -->

```html
<!-- posted-by: arm-api-reviewer-agent | rule: <RULE-ID> | severity: blocking|warning|suggestion | classification: new|existing | critic: pass|warn|override | head-sha: <full-40-char-sha> [| downstream-rule: <LINTER-RULE-ID>] [| override-reason: <required-when-critic=override>] -->
```

<!-- markdownlint-enable MD013 -->

| Field             | Values                                | Notes                                                                                                                                                                                                                  |
| ----------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `posted-by`       | `arm-api-reviewer-agent`              | Used by Step 5.5 to identify agent-origin comments via substring match. **Do not rename** without a backward-compat plan.                                                                                              |
| `rule`            | Rule ID from instruction files        | e.g., `RPC-Put-V1-01`, `OAPI027`, `SEC-SECRET-DETECT`.                                                                                                                                                                 |
| `severity`        | `blocking` / `warning` / `suggestion` | Lowercase.                                                                                                                                                                                                             |
| `classification`  | `new` / `existing`                    | From Step 4a.                                                                                                                                                                                                          |
| `critic`          | `pass`                                | Default -- Critic returned PASS at High confidence.                                                                                                                                                                    |
|                   | `warn`                                | Critic returned PASS at Medium/Low confidence, human accepted as-is.                                                                                                                                                   |
|                   | `override`                            | Human explicitly overrode a finding-level Critic FAIL. **REQUIRES `override-reason`.** Reconciliation FAILs and graph-fabrication FAILs are never `override`.                                                          |
| `head-sha`        | Full 40-char session SHA              | Short SHAs forbidden in this marker.                                                                                                                                                                                   |
| `downstream-rule` | Linter rule ID                        | REQUIRED when a finding's fix adds or tightens a type, format, decorator, `x-ms-*` extension, or schema constraint in a conflict-aware area from `linter-rule-coverage.md` (for example, `R3017`). Optional otherwise. |
| `override-reason` | Structured justification              | REQUIRED iff `critic: override`. Must satisfy the canonical Override-reason validator defined below.                                                                                                                   |

**`critic-mode` vs `critic` field -- different concepts.** `critic-mode` (in
the review-state marker) is response-scope and describes how the Critic
ran for the whole response. `critic` (in the per-comment marker) is
finding-scope and records the per-finding verdict.

### Telemetry fallback policy (load-bearing)

**Telemetry MUST NEVER block the Reviewer or Critic from doing their
job.** The markers in this section are observability metadata, not
correctness gates. If marker assembly fails for any reason -- a field
value cannot be computed, a value contains a character that would
break HTML-comment syntax, a string-template lookup throws, etc. -- the
correct behavior is to fall back, not to skip posting the comment or
abort the review.

**Fallback minimal marker.** When the full per-comment marker cannot
be assembled, emit this minimal marker in its place and proceed with
the comment as if the full marker had been emitted:

<!-- markdownlint-disable MD013 -->

```html
<!-- posted-by: arm-api-reviewer-agent | telemetry: degraded | reason: <one-line-summary-of-what-failed> -->
```

<!-- markdownlint-enable MD013 -->

The minimal marker preserves the single contract Step 5.5 depends on
(`posted-by: arm-api-reviewer-agent` for agent-origin detection) and
records that the per-finding fields were not captured. The
`reason:` value SHOULD be a short machine-friendly identifier
(`head-sha-unavailable`, `rule-id-missing`, `override-reason-truncated`,
`assembly-error`) so the gap is queryable later, but any free-text
one-liner is acceptable.

**Per-field degradation order.** Before falling back to the minimal
marker, try the following in order; each step degrades one field
without dropping the others:

1. **Optional fields** (`downstream-rule`, `override-reason` when
   `critic` is not `override`): omit the field entirely if its value
   cannot be assembled. The marker is still well-formed.
2. **`head-sha` field**: if the full 40-char SHA is unavailable but a
   short SHA or branch name is, omit `head-sha` rather than violate
   the "short SHAs forbidden" rule. Do not substitute a different
   identifier into the `head-sha` slot.
3. **`critic` field**: if the per-finding verdict cannot be looked up
   (e.g., the response-scope `critic-mode` is `unavailable` and no
   per-finding verdict was produced), emit `critic: unknown` rather
   than fabricating `pass`. The minimal marker is preferred over a
   fabricated `pass`.
4. **`severity`, `classification`, `rule`**: these three fields are
   the highest-signal observability fields. If any one of them cannot
   be assembled, fall back to the minimal marker -- a marker missing
   the rule ID or severity creates a misleading audit trail and is
   worse than no per-comment marker at all.

**Posting is non-negotiable.** Once the human has approved the plan
in Step 8, every approved finding posts. A telemetry-assembly failure
on finding N MUST NOT prevent the posting of findings N, N+1, ..., or
the bundled Step 9 label changes. Log the failure (chat output, not
a posted PR comment) and continue.

**Critic must not FAIL a finding for telemetry shape.** The Critic's
re-validation procedure validates rule citations, line numbers, file
content, and reconciliation anchors. Marker field presence, value
shape, and per-field correctness are **out of scope** for the Critic
and never produce a `FAIL`. If the Critic notices a malformed marker
in the Reviewer's Step 6 canonical body, surface it under
`Telemetry observations` (advisory, separate from `Likely missed
violations`) so the Reviewer or human can correct future markers, but
never block the current review on it.

### Override-reason validator

This section is the **single source of truth** for the override-reason
contract. Both the Reviewer (Step 7 item 13) and the Critic (Re-validation
step 5) reference this section; neither file restates the rules. If the
validator changes, this section is the only edit point.

An `override-reason` is valid if and only if **all three** of the following
checks pass against the trimmed value:

1. **Length.** At least 20 characters after trimming leading and trailing
   whitespace.
2. **Denylist.** Does not contain (case-insensitive substring match) any of
   the boilerplate phrases below.
3. **Structured anchor or verbatim counter-quote.** Contains at least one of:
   - an instruction-file citation in the form `<file>:L<a>-L<b>` -- a path
     ending in `.md` or `.instructions.md`, followed by `:L<digits>-L<digits>`
     or `:L<digits>` (the Reviewer's counter-citation); **OR**
   - a verbatim counter-quote from the cited rule, enclosed in matched
     delimiters (`"..."` or `"..."`), of at least 15 characters.

A justification that is long enough but contains neither an anchor nor a
quote is paraphrase or assertion, not evidence -- it fails check 3.

**Override-reason denylist** (case-insensitive substring match, used by
check 2): `existing pattern`, `reviewer says ok`, `will fix later`, `n/a`,
`none`, `tbd`, `wontfix`, `ignore`, `looks fine`, `is correct`, `is wrong`,
`disagree`.

**Where this validator runs.**

- The **Reviewer** runs the validator in Step 7 item 13 **before** folding a
  human override into the report. A bad reason blocks plan finalization, not
  posting.
- The **Critic** re-runs the validator in Re-validation step 5 when a fresh
  override appears in the report. A re-run failure produces
  `FAIL: override-reason-invalid`, which is **non-overridable** -- the
  Reviewer cannot fold a second override on top of a rejected override.
