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

| Term                         | Meaning                                                                                                                                                                                                                               |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Session SHA**              | The PR head commit SHA captured by the Reviewer at Step 1. Binding for every PR-head file fetch by both agents across every iteration of a single review session.                                                                     |
| **Base SHA / base ref**      | The PR base commit SHA or immutable base ref captured by the Reviewer at Step 1. Binding for previous-version file fetches used for breaking-change and classification checks.                                                        |
| **Review session**           | The arc from Step 1 (SHA pinned) through Step 10 (cleanup), within one conversation thread on one PR.                                                                                                                                 |
| **Dispatch**                 | The host's subagent-invocation mechanism: `runSubagent` with `agentName: "ARM API Review Critic"` in VS Code Copilot Chat, the equivalent `agent` tool in other hosts.                                                                |
| **Fast path / Full review**  | Two review-depth tracks selected in Reviewer Step 1. Fast path skips Steps 3, 3.5, 4a, 5; Full review runs all steps.                                                                                                                 |
| **Sentinel string**          | A literal string passed between agents that signals "this input is intentionally absent in a specific way" -- currently only `reconciliation skipped`.                                                                                |
| **Finding-level FAIL**       | A Critic `FAIL` on a specific finding from the Reviewer's report (wrong line, rule misapplied, etc.). Overridable per the override workflow.                                                                                          |
| **Non-overridable FAIL**     | A Critic `FAIL` that cannot be cleared via the `critic: override` per-comment marker. Limited to 6 reasons (see the [Non-overridable FAIL catalog](#non-overridable-fail-catalog)).                                                   |
| **INVALIDATED**              | Critic `Finding accuracy = INVALIDATED` (session SHA moved or unreachable). Kills the entire session; no findings may be posted.                                                                                                      |
| **Next-step recommendation** | An internal label set by the Reviewer at Step 7 based on the Critic's verdicts (`READY TO POST` / `REVISE RECOMMENDED` / `MANUAL DECISION REQUIRED` / `SESSION INVALIDATED`); gates Step 8 posting.                                   |
| **Reconciliation Plan**      | The per-finding posting actions (POST-NEW / SKIP-COVERED / RESOLVE-AND-REPOST / REPLY-LINE-SHIFT) and per-existing-thread dispositions (THANK-AND-RESOLVE / PROPOSE-HUMAN-RESOLVE) built in Reviewer Step 5.5 and executed in Step 8. |
| **Scenarios A/B/C/D/E/F**    | The six reconciliation cases defined in Reviewer Step 5.5. A = SKIP-COVERED, B = RESOLVE-AND-REPOST, C = REPLY-LINE-SHIFT, D = all findings already covered, E = THANK-AND-RESOLVE, F = PROPOSE-HUMAN-RESOLVE.                        |
| **Override workflow**        | Reviewer Step 7 item 13 -- the interactive checkpoint where the human may override a finding-level Critic FAIL with a structured justification validated by the [Override-reason validator](#override-reason-validator).              |
| **Bias filter**              | One of the six lenses in Critic Re-validation step 6 used to surface missed violations (future-breaking shape, operational pain, silent breaking changes, security smell, naming rot, what's missing).                                |
| **Graph-diff**               | The Critic's independent re-derivation of the Reviewer's Mermaid graphs (Step 3.5), compared against the Reviewer output -- the highest-value signal for missed structural violations.                                                |
| **Override-reason**          | The structured justification a human attaches when overriding a finding-level Critic FAIL. Validated in Critic Re-validation step 5; an `override-reason-invalid` FAIL is non-overridable.                                            |
| **Proof-of-fix anchor**      | The file/line citation the Reviewer records on a THANK-AND-RESOLVE or PROPOSE-HUMAN-RESOLVE entry. The Critic re-verifies independently in Re-validation step 7; missing/wrong/unreachable anchors are FAIL.                          |

## Inputs the Reviewer passes to the Critic

The wire format is **tolerant prose**, not a rigid schema. Best-effort
parsing applies; missing optional fields fall back to sensible defaults.
This format replaces an earlier fenced-YAML schema that was too easy to
break (snake_case keys, nested empty-list rules, mandatory header
comment, etc.) and caused silent dispatch failures.

### Canonical input shape

Copy the template at
[`./arm-api-review-critic-inputs.template.md`](./arm-api-review-critic-inputs.template.md)
into every dispatch prompt. The
substantive content is:

```markdown
PR: <owner>/<repo>#<number>
Head SHA: <full-40-char-sha>
Base: <full-40-char-base-sha-or-ref> (or: new service)
Iteration: 1
Graphs: true (or: false on fast path)

## Step 6 findings report

<verbatim Step 6 report from the Reviewer>

## Step 5.5 reconciliation plan

<verbatim Step 5.5 plan from the Reviewer, or the literal string `reconciliation skipped`>
```

### Fields

| Field           | Required?              | Notes                                                                                                                                                         |
| --------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `PR`            | Required               | `owner/repo#number` form.                                                                                                                                     |
| `Head SHA`      | Required               | Full 40-char commit SHA pinned at Reviewer Step 1. Binding for every PR-head file fetch by both agents.                                                       |
| `Base`          | Required if applicable | Full 40-char base SHA or immutable base ref for previous-version fetches, OR the literal string `new service`.                                                |
| `Iteration`     | Required               | `1`, `2`, or `3` (Step 7 hard cap).                                                                                                                           |
| `Graphs`        | Optional               | `true` (default; full graph-diff) or `false` (fast path / no graphs).                                                                                         |
| Findings report | Required               | Verbatim Step 6 report under the `## Step 6 findings report` heading.                                                                                         |
| Reconciliation  | Required               | Verbatim Step 5.5 plan under the `## Step 5.5 reconciliation plan` heading, OR the literal string `reconciliation skipped`. An all-`POST-NEW` plan is a plan. |

### Defaults and tolerance

- If `Base` is omitted, the Critic treats the PR as a new service (no
  previous-version comparison).
- If `Graphs` is omitted, the Critic assumes `true` and attempts the
  graph-diff.
- If `Iteration` is omitted, the Critic assumes `1`.
- Reviewer-iteration carryover (prior FAIL sets, considered-and-declined
  candidates) is folded **inline** into the Step 6 report -- typically
  under a "Considered and declined" heading or a per-finding `**Note:**`
  line. No separate input fields are required; the Critic re-reads the
  report fresh each iteration.

### Compact-mode iteration prompt (iteration >= 2 only)

Default for every iteration is the full report verbatim. Compact mode is
an **escape valve for prompt-size-induced host failures**, not a
routine optimization. Use compact mode only when:

- `Iteration` is `2` or `3`, **AND**
- The Reviewer has observed (or has strong cause to expect) that
  dispatching the full report at the current iteration triggers a
  zero-content / "Agent completed with no output" return on Rung 1 (see
  the Reviewer's Rung-1 retry rule for empty responses).

In compact mode the `## Step 6 findings report` section is replaced
with a two-part body:

```markdown
## Step 6 findings report (compact mode -- iteration N)

### Changed findings (re-verify from scratch)

<verbatim full body of every finding that was added, modified, dropped,
or had its severity / classification / fix recommendation changed since
iteration N-1>

### Carry-over verdicts (unchanged since iteration N-1)

| #   | Rule          | Path:line     | Prior iteration | Prior Critic verdict |
| --- | ------------- | ------------- | --------------- | -------------------- |
| 3   | RPC-Put-V1-01 | foo.json:L57  | 1               | pass                 |
| 5   | OAPI027       | foo.json:L120 | 1               | warn                 |

...
```

Contract for the Critic when it parses a compact-mode prompt:

- The Critic **re-fetches every cited file at `Head SHA`** -- compact
  mode does not relax the session-SHA pin.
- The Critic re-validates each entry in **Changed findings** from
  scratch (independent verdict).
- For each row in **Carry-over verdicts** the Critic re-fetches the
  cited file, confirms the `path:line` is still reachable and the
  underlying code has not shifted, and **adopts the prior verdict
  verbatim**. The Critic does **not** re-quote the entire finding body
  but **does** sanity-check that the citation still resolves on the
  pinned SHA.
- If any carry-over row's `path:line` is now unreachable or its
  underlying code has shifted (different declaration, different rule
  surface) the Critic emits `finding=fail` for that row with the
  per-finding reason `carry-over-stale`, and the Reviewer must re-send
  the full body of that finding on the next iteration. `carry-over-stale`
  is overridable per the standard override workflow.
- An empty **Changed findings** subsection is legal (e.g., iteration 3
  was triggered solely to clear a non-overridable FAIL via a re-fetch).
  An empty **Carry-over verdicts** subsection is equivalent to a
  full-report dispatch.

Compact mode does **not** change the verdict-track shape, the
`<!-- critic-verdict: ... -->` marker shape, or the
`Iteration:` echo. The Reviewer still treats the compact-mode response
as a normal iteration verdict.

### When something cannot be assembled

If `PR`, `Head SHA`, or the findings report cannot be assembled, the
Reviewer must NOT dispatch the Critic. Surface the gap to the human per
Reviewer Step 7's fallback ladder. The Critic does not return a
`missing-inputs` FAIL -- there is no rigid validator -- but a Critic
that cannot identify the PR, SHA, or findings will report the gap in
its body and emit `finding=fail`.

## Critic-unavailable fallback (fallback path)

When subagent dispatch is unavailable after the Reviewer's bounded
retries, the Reviewer does not block on user-provided handoff data. The
Reviewer must continue in `critic-mode=unavailable`, render the required
UNAVAILABLE caution banner, and clearly state that no user action is
required.

## Critic verdict tracks

The Critic returns **one binding verdict** (`finding`) plus three
advisory observations. The advisory tracks may be omitted when nothing
notable applies to a particular run.

| Track                       | Values                                               | Binding?                         | Notes                                                                                                                      |
| --------------------------- | ---------------------------------------------------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Finding accuracy**        | `PASS` / `WARN` / `FAIL` / `INVALIDATED`             | Binding                          | `INVALIDATED` (reasons: `session-sha-moved`, `session-sha-unreachable`) overrides every other track and kills the session. |
| **Graph integrity**         | `PASS` / `WARN` / `FAIL: fabrication` / `N/A`        | Binding when `FAIL: fabrication` | `N/A` when graphs were not produced (fast path or graph derivation failure).                                               |
| **Reconciliation accuracy** | `PASS` / `WARN` / `FAIL` / `N/A`                     | Binding when `FAIL`              | `N/A` when the input was the sentinel `reconciliation skipped`.                                                            |
| **Coverage quality**        | `APPROVE` / `REQUEST EXPANSION` / `NEEDS DISCUSSION` | Advisory                         | Never gates posting.                                                                                                       |

## Sentinel strings

Only one sentinel is currently defined.

- **`reconciliation skipped`** -- pass in place of the Step 5.5 plan
  when reconciliation was skipped (existing-comment fetch failed and
  the human elected to proceed, or the human cancelled reconciliation).
  The Critic records `Reconciliation accuracy = N/A`. A plan whose
  every row is `POST-NEW` is still a plan; pass it verbatim, not the
  sentinel.

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

| Field         | Values                                   | Meaning                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `critic-mode` | `pending`                                | Review session is live after Step 1 pinned SHAs, but the Critic has not returned yet. Only progress, fetch-error, or drift messages may use this value. `pending` is forbidden on responses that contain finding sections (`## API Review:`, `### Blocking Issues`, `### Warnings`, `### Suggestions`, per-finding Mermaid graphs, or a Reconciliation Plan). Use `subagent`, `unavailable`, or `invalidated` once the Critic gate has resolved. |
|               | `subagent`                               | State A: Critic dispatched as subagent and verdict folded in.                                                                                                                                                                                                                                                                                                                                                                                    |
|               | `unavailable`                            | Fallback state when subagent dispatch remains unavailable after bounded retries. `[!CAUTION]` banner rendered. Never `skipped`; that value is forbidden.                                                                                                                                                                                                                                                                                         |
|               | `invalidated`                            | State D: Critic returned `Finding accuracy = INVALIDATED`. SHA-drift report only; no findings rendered.                                                                                                                                                                                                                                                                                                                                          |
| `iteration`   | `1`-`3`; `0` for Reviewer-detected drift | Echo of the `Iteration:` input for the most recent Critic call. See note below on `iteration=0`.                                                                                                                                                                                                                                                                                                                                                 |
| `pr`          | `owner/repo#number`                      | Used by State A's session-boundary check.                                                                                                                                                                                                                                                                                                                                                                                                        |

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

| Field             | Values                                | Notes                                                                                                                                                                                                                                                                          |
| ----------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `posted-by`       | `arm-api-reviewer-agent`              | Used by Step 5.5 to identify agent-origin comments via substring match. **Do not rename** without a backward-compat plan.                                                                                                                                                      |
| `rule`            | Rule ID from instruction files        | e.g., `RPC-Put-V1-01`, `OAPI027`, `SEC-SECRET-DETECT`.                                                                                                                                                                                                                         |
| `severity`        | `blocking` / `warning` / `suggestion` | Lowercase.                                                                                                                                                                                                                                                                     |
| `classification`  | `new` / `existing`                    | From Step 4a.                                                                                                                                                                                                                                                                  |
| `critic`          | `pass`                                | Default -- Critic returned PASS at High confidence.                                                                                                                                                                                                                            |
|                   | `warn`                                | Critic returned PASS at Medium/Low confidence, human accepted as-is.                                                                                                                                                                                                           |
|                   | `override`                            | Human explicitly overrode a finding-level Critic FAIL. **REQUIRES `override-reason`.** Reconciliation FAILs and graph-fabrication FAILs are never `override`.                                                                                                                  |
|                   | `unknown`                             | Fallback value emitted only when the per-finding verdict cannot be looked up (e.g., response-scope `critic-mode` is `unavailable` and no per-finding verdict was produced). See [Telemetry fallback policy](#telemetry-fallback-policy); do not fabricate `pass` in this case. |
| `head-sha`        | Full 40-char session SHA              | Short SHAs forbidden in this marker.                                                                                                                                                                                                                                           |
| `downstream-rule` | Linter rule ID                        | REQUIRED when a finding's fix adds or tightens a type, format, decorator, `x-ms-*` extension, or schema constraint in a conflict-aware area from `linter-rule-coverage.md` (for example, `R3017`). Optional otherwise.                                                         |
| `override-reason` | Structured justification              | REQUIRED iff `critic: override`. Must satisfy the canonical Override-reason validator defined below.                                                                                                                                                                           |

**`critic-mode` vs `critic` field -- different concepts.** `critic-mode` (in
the review-state marker) is response-scope and describes how the Critic
ran for the whole response. `critic` (in the per-comment marker) is
finding-scope and records the per-finding verdict.

### Critic-verdict marker (per Critic response)

Hidden HTML comment as the **preferred first line** of every Critic response.
Mirrors the role of the Reviewer's `review-state` marker: gives a
machine-auditable header before the structured `### Verdict` table that
follows. Required on every Critic dispatch return.

<!-- markdownlint-disable MD013 -->

```html
<!-- critic-verdict: finding={pass|warn|fail|invalidated} | graph={pass|warn|fail-fabrication|na} | reconciliation={pass|warn|fail|na} | coverage={approve|request-expansion|needs-discussion} | iteration={N} | pr={owner/repo#number} -->
```

<!-- markdownlint-enable MD013 -->

| Field            | Values                                               | Notes                                                                                                                    |
| ---------------- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `finding`        | `pass` / `warn` / `fail` / `invalidated`             | Mirrors `Finding accuracy` row of the `### Verdict` table. Lowercase.                                                    |
| `graph`          | `pass` / `warn` / `fail-fabrication` / `na`          | Mirrors `Graph integrity` row. `na` legitimate when the `Graphs:` input was `false` or graph derivation was unavailable. |
| `reconciliation` | `pass` / `warn` / `fail` / `na`                      | Mirrors `Reconciliation accuracy` row. `na` only when the reconciliation-plan input was the sentinel.                    |
| `coverage`       | `approve` / `request-expansion` / `needs-discussion` | Mirrors `Coverage quality` row.                                                                                          |
| `iteration`      | `1`-`3`                                              | Echo of the `Iteration:` input.                                                                                          |
| `pr`             | `owner/repo#number`                                  | Same value the Reviewer passed in the `PR:` input.                                                                       |

**Parsing contract.** The Reviewer prefers parsing the marker first, then
cross-checking against the `### Verdict` table body. To tolerate host
wrappers and transport noise, acceptance is:

- PASS: marker present in the first 20 non-empty lines and semantically
  consistent with the table.
- PASS (degraded): marker missing/malformed but the `### Verdict` table is
  parseable with all four tracks and PR/SHA/Iteration headers match.
- FAIL: neither a usable marker nor a usable `### Verdict` table.

This keeps Critic output programmatically auditable while avoiding false
rejections caused by host-added preamble text.

#### Non-empty response invariant

The Critic MUST emit a non-empty response on every dispatch return. The
marker should be on the first line whenever
possible; if host wrappers prepend text, it must still appear near the
top of the response. The
`<!-- critic-verdict: ... -->` marker is required **even on early-abort paths**
(malformed inputs, session-SHA drift, total fetch failure). A silent
or empty return is forbidden -- the Reviewer's
[Step 7 Rung 1](../arm-api-reviewer.agent.md#step-7-mandatory-critic-review--gate--no-findings-leave-this-step-unverified)
treats zero-content returns as host-side failures and advances to the
unavailable fallback.

When the input cannot be parsed (PR/SHA/findings missing), return
`finding=fail` with a one-paragraph explanation of what was missing
and which fields the Critic was able to identify.

Host-runtime note: if the host prepends wrapper/system lines before model
output, the Reviewer still accepts the response as long as a usable marker
appears within the first 20 non-empty lines or the `### Verdict` table is
fully parseable.

The Critic produces no other HTML markers (no `review-state` and no
`posted-by: arm-api-reviewer-agent`).

## Non-overridable FAIL catalog

Only the FAILs in this table cannot be cleared by a human override
(`critic: override` per-comment marker). Every other FAIL is
overridable when the Reviewer attaches a justification that satisfies
the [Override-reason validator](#override-reason-validator).

| FAIL reason                    | Critic step                     | Recovery                                                                                                                                                                                              |
| ------------------------------ | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `session-sha-moved`            | Re-validation 1                 | Restart from Reviewer Step 1 with a fresh session SHA, or abandon.                                                                                                                                    |
| `session-sha-unreachable`      | Re-validation 1                 | Restart from Reviewer Step 1 with a fresh session SHA, or abandon.                                                                                                                                    |
| `Graph integrity: fabrication` | Independent graph re-derivation | Reviewer drops findings derived from the fabricated node(s)/edge(s), re-derives graphs from re-fetched files, and re-invokes the Critic.                                                              |
| `unescaped-mention`            | Re-validation 6.5               | Reviewer backticks every `@<token>` outside code spans so the post does not notify unrelated GitHub users.                                                                                            |
| `hash-number-autolink`         | Re-validation 6.5               | Reviewer removes the leading `#` on bare finding numbers so GitHub does not autolink them to unrelated issues/PRs.                                                                                    |
| `override-reason-invalid`      | Re-validation 5                 | Reviewer supplies a justification that satisfies the [Override-reason validator](#override-reason-validator), or drops the finding. (A second override on top of a rejected override is not allowed.) |

All other FAILs (`wrong-line`, `rule-not-found`, `rule-misapplied`,
`misclassified`, reconciliation FAILs `skip-not-justified` /
`shift-misclassified` / `fix-not-verified` / `fix-anchor-wrong` /
`fix-anchor-unreachable`, downstream-CI FAILs, etc.) are **overridable**
when the Reviewer attaches a justification. The Reviewer's preferred
recoveries (fix the line, drop the finding, demote SKIP-COVERED to
POST-NEW, etc.) are still encouraged -- override is the last resort.

### Telemetry fallback policy

Telemetry markers are observability metadata, not correctness gates.
If marker assembly fails for any reason, fall back to the minimal form
and proceed; never block posting on a telemetry-assembly issue.

Minimal fallback marker:

<!-- markdownlint-disable MD013 -->

```html
<!-- posted-by: arm-api-reviewer-agent | telemetry: degraded | reason: <one-line-summary> -->
```

<!-- markdownlint-enable MD013 -->

Preferred degradation order: drop optional fields first
(`downstream-rule`, `override-reason` when `critic` is not `override`),
then `head-sha`, then degrade `critic` to `unknown`. Fall back to the
minimal marker only when `severity`, `classification`, or `rule` cannot
be assembled.

The Critic does not FAIL findings for telemetry-marker shape. Marker
field presence and per-field correctness are out of scope for Critic
re-validation; if the Critic notices a malformed marker, it may
surface it as an advisory `Telemetry observations` note.

### Override-reason validator

An `override-reason` is valid if and only if all three checks pass:

1. **Length** -- at least 20 characters after trimming whitespace.
2. **Denylist** -- does not contain (case-insensitive substring) any
   of: `existing pattern`, `reviewer says ok`, `will fix later`, `n/a`,
   `none`, `tbd`, `wontfix`, `ignore`, `looks fine`, `is correct`,
   `is wrong`, `disagree`.
3. **Anchor or counter-quote** -- contains either an instruction-file
   citation in the form `<file>:L<a>-L<b>` (path ending `.md` or
   `.instructions.md`), OR a verbatim quote from the cited rule in
   matched delimiters (`"..."` or `"..."`) of at least 15 characters.

A long justification with neither an anchor nor a quote is paraphrase,
not evidence; it fails check 3.

The validator runs in two places:

- **Reviewer Step 7 item 13** -- before folding a human override into
  the report. A bad reason blocks plan finalization.
- **Critic Re-validation step 5** -- when a fresh override appears in
  the report. A re-run failure produces `FAIL: override-reason-invalid`,
  which is non-overridable; the Reviewer cannot stack a second override
  on top of a rejected one.
