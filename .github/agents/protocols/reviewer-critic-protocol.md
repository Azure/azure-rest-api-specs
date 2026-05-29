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
| 7   | Prior iterations' FAIL set summary | The two most recent prior iterations' rule-ID + file/line tuples. Empty on iteration 1. Used for wave-thrash detection at iteration >= 3.                                                                                                                |
| 8   | Considered-and-declined list       | Prior-iteration `Likely missed violations` candidates the Reviewer evaluated and chose not to promote, each with a one-line rationale. The Critic MUST suppress these unless fresh evidence justifies re-surfacing. Empty on iteration 1.                |
| 9   | Graph production flag              | `graphs-produced: true\|false`. `false` on fast path or when graph derivation failed; the Critic records `Graph integrity = N/A`.                                                                                                                        |
| 10  | Current iteration number           | `1` through `5`. The Critic's output header echoes this verbatim; do not infer from input length.                                                                                                                                                        |

## Session-handoff verification (fallback path)

When subagent dispatch is unavailable and the Reviewer accepts a
human-pasted Critic output, the Reviewer MUST validate the pasted output
before folding it into the report:

- The Critic header field `PR:` exactly matches the current PR under review.
- The Critic header field `Head SHA:` exactly matches the session SHA pinned
  in Reviewer Step 1.
- The Critic header field `Base SHA/Ref:` matches Input #5 when present, or is
  omitted / `n/a` only when Input #5 is `None - new service`.
- The Critic header field `Iteration:` is a valid `1` through `5` and is
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

| Field         | Values                                                                                                 | Meaning                                                                                                                                                                                |
| ------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `critic-mode` | `pending`                                                                                              | Review session is live after Step 1 pinned SHAs, but the Critic has not returned yet. Only progress, fetch-error, or handoff messages may use this value; no findings may be rendered. |
|               | `subagent`                                                                                             | State A: Critic dispatched as subagent and verdict folded in.                                                                                                                          |
|               | `session-handoff`                                                                                      | State A via human-pasted verdict from the fallback prompt.                                                                                                                             |
|               | `unavailable`                                                                                          | State C: human explicitly opted out at Step 7 fallback step 2. `[!CAUTION]` banner rendered. **Never `skipped` -- that value is forbidden.**                                           |
|               | `invalidated`                                                                                          | State D: Critic returned `Finding accuracy = INVALIDATED`. SHA-drift report only; no findings rendered.                                                                                |
| `iteration`   | `1`-`5` (Critic iteration the response reflects); `0` if drift detected by Reviewer between iterations | Echo of Input #10 for the most recent Critic call.                                                                                                                                     |
| `pr`          | `owner/repo#number`                                                                                    | Used by State A's session-boundary check.                                                                                                                                              |

Exempt from the marker: responses emitted **before** Step 1 pins the
session SHA (e.g., out-of-scope-repo decline messages).

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

| Field             | Values                                | Notes                                                                                                                                                                                                                               |
| ----------------- | ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `posted-by`       | `arm-api-reviewer-agent`              | Used by Step 5.5 to identify agent-origin comments via substring match. **Do not rename** without a backward-compat plan.                                                                                                           |
| `rule`            | Rule ID from instruction files        | e.g., `RPC-Put-V1-01`, `OAPI027`, `SEC-SECRET-DETECT`.                                                                                                                                                                              |
| `severity`        | `blocking` / `warning` / `suggestion` | Lowercase.                                                                                                                                                                                                                          |
| `classification`  | `new` / `existing`                    | From Step 4a.                                                                                                                                                                                                                       |
| `critic`          | `pass`                                | Default -- Critic returned PASS at High confidence.                                                                                                                                                                                 |
|                   | `warn`                                | Critic returned PASS at Medium/Low confidence, human accepted as-is.                                                                                                                                                                |
|                   | `override`                            | Human explicitly overrode a finding-level Critic FAIL. **REQUIRES `override-reason`.** Reconciliation FAILs and graph-fabrication FAILs are never `override`.                                                                       |
| `head-sha`        | Full 40-char session SHA              | Short SHAs forbidden in this marker.                                                                                                                                                                                                |
| `downstream-rule` | Linter rule ID                        | REQUIRED when a finding's fix adds or tightens a type, format, decorator, `x-ms-*` extension, or schema constraint in a conflict-aware area from `linter-rule-coverage.md` (for example, `R3017`). Optional otherwise.              |
| `override-reason` | Structured justification              | REQUIRED iff `critic: override`. Must satisfy all of: (a) >= 20 chars trimmed, (b) no denylist substring, (c) at least one structured anchor (instruction-file `<file>:L<a>-L<b>` OR verbatim counter-quote in matched delimiters). |

**`critic-mode` vs `critic` field -- different concepts.** `critic-mode` (in
the review-state marker) is response-scope and describes how the Critic
ran for the whole response. `critic` (in the per-comment marker) is
finding-scope and records the per-finding verdict.

**Override-reason denylist** (case-insensitive substring match): `existing
pattern`, `reviewer says ok`, `will fix later`, `n/a`, `none`, `tbd`,
`wontfix`, `ignore`, `looks fine`, `is correct`, `is wrong`, `disagree`.
