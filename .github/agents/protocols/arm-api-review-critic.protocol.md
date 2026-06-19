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

| Term                             | Meaning                                                                                                                                                                                                                               |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Session SHA**                  | The PR head commit SHA captured by the Reviewer at Step 1. Binding for every PR-head file fetch by both agents across every iteration of a single review session.                                                                     |
| **Base SHA / base ref**          | The PR base commit SHA or immutable base ref captured by the Reviewer at Step 1. Binding for previous-version file fetches used for breaking-change and classification checks.                                                        |
| **Review session**               | The arc from Step 1 (SHA pinned) through Step 10 (cleanup), within one conversation thread on one PR.                                                                                                                                 |
| **Dispatch**                     | The host's subagent-invocation mechanism: `runSubagent` with `agentName: "ARM API Review Critic"` in VS Code Copilot Chat, the equivalent `agent` tool in other hosts.                                                                |
| **Fast path / Full review**      | Two review-depth tracks selected in Reviewer Step 1. Fast path skips Steps 3, 3.5, 4a, 5; Full review runs all steps.                                                                                                                 |
| **Sentinel string**              | A literal string passed between agents that signals "this input is intentionally absent in a specific way" -- currently only `reconciliation skipped`.                                                                                |
| **Finding-level FAIL**           | A Critic `FAIL` on a specific finding from the Reviewer's report (wrong line, rule misapplied, etc.). Overridable per the override workflow.                                                                                          |
| **Reconciliation FAIL**          | A Critic `FAIL` on a Step 5.5 reconciliation-plan entry. Overridable with a validated justification; see [Non-overridable FAIL catalog](#non-overridable-fail-catalog).                                                               |
| **Graph-fabrication FAIL**       | A Critic `Graph integrity = FAIL: fabrication` verdict. **Non-overridable**; the Reviewer must drop dependent findings and re-derive.                                                                                                 |
| **INVALIDATED**                  | Critic `Finding accuracy = INVALIDATED` (session SHA moved or unreachable). Kills the entire session; no findings may be posted.                                                                                                      |
| **Next-step recommendation**     | An internal label set by the Reviewer at Step 7 based on the Critic's verdicts (`READY TO POST` / `REVISE RECOMMENDED` / `MANUAL DECISION REQUIRED` / `SESSION INVALIDATED`); gates Step 8 posting.                                   |
| **Reconciliation Plan**          | The per-finding posting actions (POST-NEW / SKIP-COVERED / RESOLVE-AND-REPOST / REPLY-LINE-SHIFT) and per-existing-thread dispositions (THANK-AND-RESOLVE / PROPOSE-HUMAN-RESOLVE) built in Reviewer Step 5.5 and executed in Step 8. |
| **Scenarios A/B/C/D/E/F**        | The six reconciliation cases defined in Reviewer Step 5.5. A = SKIP-COVERED, B = RESOLVE-AND-REPOST, C = REPLY-LINE-SHIFT, D = all findings already covered, E = THANK-AND-RESOLVE, F = PROPOSE-HUMAN-RESOLVE.                        |
| **Considered-and-declined list** | Critic Input #8: prior-iteration `Likely missed violations` candidates the Reviewer evaluated and chose not to promote, each with a one-line rationale. Required to prevent advisory-item oscillation across iterations.              |
| **Override workflow**            | Reviewer Step 7 item 13 -- the interactive checkpoint where the human may override a finding-level Critic FAIL with a structured justification validated by the [Override-reason validator](#override-reason-validator).              |
| **Bias filter**                  | One of the six lenses in Critic Re-validation step 6 used to surface missed violations (future-breaking shape, operational pain, silent breaking changes, security smell, naming rot, what's missing).                                |
| **Graph-diff**                   | The Critic's independent re-derivation of the Reviewer's Mermaid graphs (Step 3.5), compared against the Reviewer output -- the highest-value signal for missed structural violations.                                                |
| **Override-reason**              | The structured justification a human attaches when overriding a finding-level Critic FAIL. Validated in Critic Re-validation step 5; an `override-reason-invalid` FAIL is non-overridable.                                            |
| **Proof-of-fix anchor**          | The file/line citation the Reviewer records on a THANK-AND-RESOLVE or PROPOSE-HUMAN-RESOLVE entry. The Critic re-verifies independently in Re-validation step 7; missing/wrong/unreachable anchors are FAIL.                          |

## Inputs the Reviewer passes to the Critic

Pass all ten on every Critic invocation. The Critic uses **tolerant prose
parsing**: it reads labeled fields in any order from the dispatch prompt
and applies the documented default for any optional field that is absent.
A required field (PR URL, Session SHA, Iteration) that is absent or
malformed causes the Critic to return `Finding accuracy = FAIL` with
reason `missing-inputs`.

### Canonical input-block format

The template both agents use is in a dedicated file:
[`./arm-api-review-critic-inputs.template.md`](./arm-api-review-critic-inputs.template.md).
Copy that template into every dispatch prompt; the Critic accepts any
reasonable prose rendering of the labeled fields. The schema below
restates field meanings for in-file readability.

| #   | Input                              | Default when absent             | Notes                                                                                                                                                                                                                                                                                                                                                                                          |
| --- | ---------------------------------- | ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | PR URL                             | **Required -- no default**      | `owner/repo#number` form.                                                                                                                                                                                                                                                                                                                                                                      |
| 2   | Session SHA                        | **Required -- no default**      | Full 40-char commit SHA pinned at Reviewer Step 1. **Binding for every PR-head file fetch.**                                                                                                                                                                                                                                                                                                   |
| 3   | Step 6 findings report             | **Required -- no default**      | Verbatim, under the `## Step 6 findings report` heading.                                                                                                                                                                                                                                                                                                                                       |
| 4   | List of files reviewed             | Derive from the findings report | Workspace-relative paths. If absent, the Critic infers from cited files in Input #3.                                                                                                                                                                                                                                                                                                          |
| 5   | Previous-version source            | `None - new service`            | The base-branch path **and base SHA/ref** used for `[NEW]`/`[EXISTING]` classification, or `None - new service`. Changed PR files are fetched at Input #2; previous-version files at this source.                                                                                                                                                                                             |
| 6   | Step 5.5 reconciliation plan       | `reconciliation skipped`        | Verbatim, under the `## Step 5.5 reconciliation plan` heading, or the sentinel `reconciliation skipped`. If absent, the Critic treats as the sentinel and records `Reconciliation accuracy = N/A`.                                                                                                                                                                                             |
| 7   | Prior iterations' FAIL set summary | Empty (none)                    | The two most recent prior iterations' rule-ID + file/line tuples. Empty on iteration 1. Used to suppress already-considered failures across iterations.                                                                                                                                                                                                                                        |
| 8   | Considered-and-declined list       | Empty (none)                    | Prior-iteration `Likely missed violations` candidates the Reviewer evaluated and chose not to promote, each with a one-line rationale. The Critic MUST suppress these unless fresh evidence justifies re-surfacing.                                                                                                                                                                             |
| 9   | Graphs flag                        | `false`                         | `Graphs: true` = Mermaid graphs in the Step 6 report; full graph-diff. `Graphs: false` = fast path or graph derivation unavailable; Critic records `Graph integrity = N/A`. On full-review PRs where the size guardrail tripped, pass `Graphs: false` and the Critic still re-derives the sensitive-data-flow view in summary form. The four-value `downgraded/degraded` split is deprecated. |
| 10  | Current iteration number           | `1`                             | `1` through `3`. The Critic's output header echoes this verbatim.                                                                                                                                                                                                                                                                                                                              |

### Compact-mode dispatch (iterations 2 and 3)

When the Reviewer re-invokes the Critic after revisions (iteration 2 or 3),
it MAY use a **compact-mode** payload to reduce dispatch size:

- Pass only the **changed findings** (findings that were added, dropped, or
  modified since the prior iteration) under the `## Step 6 findings report`
  heading.
- Include a **carry-over verdict summary**: a brief inline list of unchanged
  findings with their prior-iteration Critic verdicts, labeled
  `## Carry-over verdicts`.
- **Re-pin the session SHA** before each compact-mode dispatch: run
  `gh pr view <n> --json headRefOid` (or `get_pull_request`) to confirm
  `head.sha` still equals the pinned session SHA. If it has moved, abort
  per the session-invalidation rule.
- **File-drift check (`carry-over-stale`).** For each carry-over finding,
  re-fetch the cited file at the session SHA. If the file content at the
  cited line has changed since the prior iteration, mark the finding
  `carry-over-stale` and promote it from the carry-over list to the
  changed-findings section so the Critic re-verifies it fully.

The Critic treats compact-mode input as equivalent to a full payload for
the carried-over items: carry-over verdicts are binding unless the
`carry-over-stale` flag is set, in which case the Critic re-evaluates
from scratch.

### Non-empty response invariant

An empty return or "Agent completed with no output" from a Critic dispatch
is a **host-side failure**, not a Critic PASS. The Reviewer MUST:

1. Treat the empty return as a dispatch failure.
2. Retry the dispatch up to **3 total attempts** (the first attempt counts;
   attempts 2 and 3 use the compact-mode payload if available).
3. After 3 failed attempts, automatically fall back to
   `critic-mode=unavailable` per the `[!CAUTION]` banner rules -- **no
   user action required**. The Reviewer MUST disclose the auto-fallback in
   the report.

An empty return MUST NEVER be interpreted as a clean PASS or as an implicit
`Finding accuracy = PASS`. A missing Critic verdict is always a host-side
failure until the Critic explicitly returns a verdict.

## Critic verdict tracks

The Critic returns four verdicts in its output header. Three are binding,
one is advisory.

| Track                       | Values                                               | Binding?                         | Notes                                                                                                                                                                                                                                                                                                                                                                            |
| --------------------------- | ---------------------------------------------------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Finding accuracy**        | `PASS` / `WARN` / `FAIL` / `INVALIDATED`             | Binding                          | `INVALIDATED` (reasons: `session-sha-moved`, `session-sha-unreachable`) overrides every other track and kills the session.                                                                                                                                                                                                                                                       |
| **Graph integrity**         | `PASS` / `WARN` / `FAIL: fabrication` / `N/A`        | Binding when `FAIL: fabrication` | `N/A` legitimate when `Graphs: false`. When `Graphs: false` without a Step-3.5-failure banner (fast path), re-derivation is fully skipped. When `Graphs: false` with the banner (full-review derivation failed), the Critic still re-derives the sensitive-data-flow view; missed leaks surface in the advisory `Likely missed violations` section, not in the Graph-integrity track. The deprecated four-value `graphs-produced` schema is still accepted for backward compatibility; `downgraded` and `degraded` are treated as `Graphs: false`. |
| **Reconciliation accuracy** | `PASS` / `WARN` / `FAIL` / `N/A`                     | Binding when `FAIL`              | `N/A` only legitimate when Input #6 was the sentinel `reconciliation skipped`.                                                                                                                                                                                                                                                                                                   |
| **Coverage quality**        | `APPROVE` / `REQUEST EXPANSION` / `NEEDS DISCUSSION` | Advisory only                    | Never gates posting.                                                                                                                                                                                                                                                                                                                                                             |

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
<!-- review-state: critic-mode={pending|subagent|unavailable|invalidated} | iteration={N} | pr={owner/repo#number} -->
```

<!-- markdownlint-enable MD013 -->

| Field         | Values                                                                                                | Meaning                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `critic-mode` | `pending`                                                                                             | Review session is live after Step 1 pinned SHAs, but the Critic has not returned yet. Only progress, fetch-error, or retry messages may use this value. **`pending` is forbidden on any response that contains finding sections** (`## API Review:`, `### Blocking Issues`, `### Warnings`, `### Suggestions`, per-finding Mermaid graphs, or a Reconciliation Plan). Emitting findings under `pending` is a constraint violation; use `subagent`, `unavailable`, or `invalidated` once the Critic gate has resolved. |
|               | `subagent`                                                                                            | State A: Critic dispatched as subagent and verdict folded in.                                                                                                                                                                                                                                                                                                                                                                         |
|               | `unavailable`                                                                                         | State C: all dispatch attempts failed (empty-response or error) and the auto-fallback fired. `[!CAUTION]` banner rendered. **Never `skipped` -- that value is forbidden.**                                                                                                                                                                                                                                                            |
|               | `invalidated`                                                                                         | State D: Critic returned `Finding accuracy = INVALIDATED`. SHA-drift report only; no findings rendered.                                                                                                                                                                                                                                                                                                                               |
| `iteration`   | `1`-`3` (Critic iteration this response reflects); `0` for Reviewer-detected drift between iterations | Echo of Input #10 for the most recent Critic call. See note below on `iteration=0`.                                                                                                                                                                                                                                                                                                                                                   |
| `pr`          | `owner/repo#number`                                                                                   | Used by State A's session-boundary check.                                                                                                                                                                                                                                                                                                                                                                                             |

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

| Field             | Values                                | Notes                                                                                                                                                                                                                                                                                       |
| ----------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `posted-by`       | `arm-api-reviewer-agent`              | Used by Step 5.5 to identify agent-origin comments via substring match. **Do not rename** without a backward-compat plan.                                                                                                                                                                   |
| `rule`            | Rule ID from instruction files        | e.g., `RPC-Put-V1-01`, `OAPI027`, `SEC-SECRET-DETECT`.                                                                                                                                                                                                                                      |
| `severity`        | `blocking` / `warning` / `suggestion` | Lowercase.                                                                                                                                                                                                                                                                                  |
| `classification`  | `new` / `existing`                    | From Step 4a.                                                                                                                                                                                                                                                                               |
| `critic`          | `pass`                                | Default -- Critic returned PASS at High confidence.                                                                                                                                                                                                                                         |
|                   | `warn`                                | Critic returned PASS at Medium/Low confidence, human accepted as-is.                                                                                                                                                                                                                        |
|                   | `override`                            | Human explicitly overrode a finding-level Critic FAIL. **REQUIRES `override-reason`.** The 6 non-overridable FAIL reasons (`override-reason-invalid`, `unescaped-mention`, `hash-number-autolink`, `Graph integrity: fabrication`, `session-sha-moved`, `session-sha-unreachable`) are never `override`; all other FAIL reasons are overridable with a valid `override-reason`. See [Non-overridable FAIL catalog](#non-overridable-fail-catalog) for the authoritative list.                                                                                                                                                                                             |
|                   | `unknown`                             | Fallback value emitted only when the per-finding verdict cannot be looked up (e.g., response-scope `critic-mode` is `unavailable` and no per-finding verdict was produced). See [Telemetry fallback policy](#telemetry-fallback-policy-load-bearing); do not fabricate `pass` in this case. |
| `head-sha`        | Full 40-char session SHA              | Short SHAs forbidden in this marker.                                                                                                                                                                                                                                                        |
| `downstream-rule` | Linter rule ID                        | REQUIRED when a finding's fix adds or tightens a type, format, decorator, `x-ms-*` extension, or schema constraint in a conflict-aware area from `linter-rule-coverage.md` (for example, `R3017`). Optional otherwise.                                                                      |
| `override-reason` | Structured justification              | REQUIRED iff `critic: override`. Must satisfy the canonical Override-reason validator defined below.                                                                                                                                                                                        |

**`critic-mode` vs `critic` field -- different concepts.** `critic-mode` (in
the review-state marker) is response-scope and describes how the Critic
ran for the whole response. `critic` (in the per-comment marker) is
finding-scope and records the per-finding verdict.

### Critic-verdict marker (per Critic response)

Hidden HTML comment as the **literal first line** of every Critic response.
Mirrors the role of the Reviewer's `review-state` marker: gives a
machine-auditable header before the structured `### Verdict` table that
follows. Required on every Critic dispatch return.

<!-- markdownlint-disable MD013 -->

```html
<!-- critic-verdict: finding={pass|warn|fail|invalidated} | graph={pass|warn|fail-fabrication|na} | reconciliation={pass|warn|fail|na} | coverage={approve|request-expansion|needs-discussion} | iteration={N} | pr={owner/repo#number} -->
```

<!-- markdownlint-enable MD013 -->

| Field            | Values                                               | Notes                                                                                                                   |
| ---------------- | ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `finding`        | `pass` / `warn` / `fail` / `invalidated`             | Mirrors `Finding accuracy` row of the `### Verdict` table. Lowercase.                                                   |
| `graph`          | `pass` / `warn` / `fail-fabrication` / `na`          | Mirrors `Graph integrity` row. `na` legitimate when Input #9 was `Graphs: false`.                                       |
| `reconciliation` | `pass` / `warn` / `fail` / `na`                      | Mirrors `Reconciliation accuracy` row. `na` only when Input #6 was the sentinel.                                        |
| `coverage`       | `approve` / `request-expansion` / `needs-discussion` | Mirrors `Coverage quality` row.                                                                                         |
| `iteration`      | `1`-`3`                                              | Echo of Input #10.                                                                                                      |
| `pr`             | `owner/repo#number`                                  | Same value the Reviewer passed in Input #1.                                                                             |

**Parsing contract.** The Reviewer parses this marker first, then
cross-checks the values against the `### Verdict` table body. If the
marker is missing, malformed, or disagrees with the table body, the
Reviewer treats the response as a dispatch failure and applies the
bounded-retry / auto-unavailable policy (see "Non-empty response
invariant" above). This makes Critic output programmatically auditable
without depending on markdown-table parsing alone.

The Critic produces no other HTML markers. In particular, the Critic
MUST NOT emit a `review-state` marker (that is the Reviewer's
response-scope marker) or a `posted-by: arm-api-reviewer-agent`
marker (that is the Reviewer's per-comment marker).

## Non-overridable FAIL catalog

Single source of truth for which Critic `FAIL` reasons can be cleared by a
human override (`critic: override` per-comment marker) and which cannot.
Both agent files reference this table; do not restate the contents
elsewhere.

The catalog has been reduced to **6 non-overridable reasons** (marked
**Yes** below). All other FAIL reasons are overridable with a validated
`override-reason` justification.

| FAIL reason                    | Critic step                     | Non-overridable?         | Recovery                                                                                                        |
| ------------------------------ | ------------------------------- | ------------------------ | --------------------------------------------------------------------------------------------------------------- |
| `wrong-line`                   | Re-validation 2                 | No                       | Reviewer fixes the line number and re-invokes the Critic.                                                       |
| `line-in-conflict-region`      | Re-validation 2                 | No (`WARN`)              | Reviewer drops the finding or waits for conflict resolution.                                                    |
| `rule-not-found`               | Re-validation 3                 | Override allowed         | Override-reason must cite the corrected instruction-file anchor.                                                |
| `rule-misapplied`              | Re-validation 3                 | Override allowed         | Override-reason must quote the rule text that supports the finding.                                             |
| `misclassified`                | Re-validation 4                 | No                       | Reviewer applies the Critic's `[NEW]`/`[EXISTING]` correction.                                                  |
| `downstream-ci-conflict`       | Re-validation 4.5               | Override allowed         | Override-reason must cite the reference file section that justifies the shape change; OR correct per Recovery.  |
| `suppression-path-mismatch`    | Re-validation 4.5               | Override allowed         | Override-reason must quote the jsonpath and justify the mismatch; OR re-render `where:` segment-for-segment.    |
| `override-reason-invalid`      | Re-validation 5                 | **Yes**                  | Reviewer supplies a valid justification or drops the finding.                                                   |
| `unescaped-mention`            | Re-validation 6.5               | **Yes**                  | Reviewer backticks every `@<token>` outside code spans.                                                         |
| `hash-number-autolink`         | Re-validation 6.5               | **Yes**                  | Reviewer removes `#` prefix on bare finding numbers.                                                            |
| `skip-not-justified`           | Re-validation 7                 | Override allowed         | Override-reason must justify why the existing coverage is adequate; OR demote SKIP-COVERED to POST-NEW.         |
| `shift-misclassified`          | Re-validation 7                 | Override allowed         | Override-reason must justify the scenario choice; OR reclassify between Scenarios B and C.                      |
| `fix-not-verified`             | Re-validation 7                 | Override allowed         | Override-reason must cite the proof-of-fix anchor; OR drop the Scenario E/F entry; thread stays open.          |
| `fix-anchor-wrong`             | Re-validation 7                 | Override allowed         | Override-reason must supply the corrected anchor; OR drop the Scenario E/F entry; thread stays open.            |
| `fix-anchor-unreachable`       | Re-validation 7                 | Override allowed         | Override-reason must explain why the anchor is correct; OR drop the Scenario E/F entry; thread stays open.      |
| `Graph integrity: fabrication` | Independent graph re-derivation | **Yes**                  | Reviewer drops dependent findings, re-derives graphs, re-invokes Critic.                                        |
| `file-fetch-failed`            | Re-validation 1                 | No                       | Reviewer drops the finding and reports the fetch failure to the human.                                          |
| `session-sha-moved`            | Re-validation 1                 | **Yes** (kills session)  | Only legal action: restart from Reviewer Step 1 or abandon.                                                     |
| `session-sha-unreachable`      | Re-validation 1                 | **Yes** (kills session)  | Only legal action: restart from Reviewer Step 1 or abandon.                                                     |
| `missing-inputs`               | Input validation                | No                       | Reviewer fixes the input block (see canonical format) and re-dispatches.                                        |

"Non-overridable" means the `critic: override` per-comment marker
(human-supplied `override-reason`) does NOT clear the FAIL. The Reviewer's
only legal responses are the ones listed in "Recovery". The 6
non-overridable reasons are: `override-reason-invalid`, `unescaped-mention`,
`hash-number-autolink`, `Graph integrity: fabrication`, `session-sha-moved`,
and `session-sha-unreachable`. A graph-fabrication FAIL that the human
disagrees with escalates the whole review to `MANUAL DECISION REQUIRED`
for per-row human consent -- not to an override.

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
