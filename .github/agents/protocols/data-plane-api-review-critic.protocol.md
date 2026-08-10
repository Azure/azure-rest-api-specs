<!-- This is a shared protocol reference, not a standalone agent file.
     It is the single source of truth for the contract between the
     `Data-Plane API Reviewer` agent and the `Data-Plane API Review Critic`
     agent. Both agents reference this file by section anchor. Keep canonical
     schemas here; agent files may include short operational summaries, but
     this file wins whenever summaries drift. -->

# Data-Plane Reviewer <-> Critic Protocol

Wire contract between the `Data-Plane API Reviewer` and the
`Data-Plane API Review Critic`.

If either agent file contradicts this document, **this document wins**. File a
bug against the agent that drifted.

This protocol is deliberately much smaller than
[`arm-api-review-critic.protocol.md`](arm-api-review-critic.protocol.md). The
ARM protocol carries ten inputs, six verdict tracks, an override workflow, a
reconciliation plan, iteration state, and two telemetry-marker schemas -- all of
which exist to support a multi-turn interactive session where a human arbitrates
disagreements and the Reviewer posts its own comments. This reviewer runs
unattended, posts nothing, and does not iterate. Three inputs and three verdicts
are sufficient. **Do not grow this file toward the ARM one without a concrete
failure that requires it.**

## Glossary

| Term             | Meaning                                                                                                                                |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| **Session SHA**  | The PR head commit SHA pinned by the Reviewer at Step 1. Binding for every file fetch by both agents for the whole run.                |
| **Base SHA**     | The PR base commit SHA, used for previous-version reads during the versioning pass. Optional.                                          |
| **Dispatch**     | The host's subagent invocation: `runSubagent` with `agentName: "Data-Plane API Review Critic"` in VS Code, the `agent` tool elsewhere. |
| **Finding**      | One entry in the Reviewer's Step 6 report: rule ID, `file:line`, quoted source, severity, reason, fix.                                 |
| **Verdict**      | The Critic's per-finding decision: `PASS`, `DOWNGRADE`, or `FAIL`.                                                                     |
| **Change class** | `new-service` / `new-version` / `maintenance-edit`, decided by the Reviewer at Step 1. Sets the severity ceiling.                      |

## Inputs the Reviewer passes to the Critic

The Critic uses tolerant prose parsing: labeled fields in any order, documented
defaults for anything absent.

| #   | Input             | Default when absent          | Notes                                                                          |
| --- | ----------------- | ---------------------------- | ------------------------------------------------------------------------------ |
| 1   | PR reference      | **Required -- no default**   | `owner/repo#number`.                                                           |
| 2   | Session SHA       | **Required -- no default**   | Full 40-char SHA. Binding for every fetch.                                     |
| 3   | Findings report   | **Required -- no default**   | Verbatim, under a `## Findings` heading.                                       |
| 4   | Change class      | `new-version`                | `new-service` / `new-version` / `maintenance-edit`. Sets the severity ceiling. |
| 5   | Files reviewed    | Derive from the report       | Repo-relative paths.                                                           |
| 6   | Base SHA          | `none`                       | Needed only when the report contains `DP-VERSION-*` findings.                  |
| 7   | Interlock version | Read from the reference file | The `@azure-tools/typespec-azure-core` version the Reviewer validated against. |

Any of #1, #2, #3 missing or malformed → the Critic returns a single
`FAIL / missing-inputs` for the whole report and stops. It does not guess.

### Dispatch template

```markdown
You are the Data-Plane API Review Critic. Verify the findings below.

PR: Azure/azure-rest-api-specs#<n>
Session SHA: <40-char sha>
Base SHA: <40-char sha | none>
Change class: <new-service | new-version | maintenance-edit>
Interlock version: @azure-tools/typespec-azure-core <x.y.z>
Files reviewed:

- <path>
- <path>

## Findings

<verbatim Step 6 report>
```

## Verdicts

| Verdict     | Meaning                                        | Reviewer action                                  |
| ----------- | ---------------------------------------------- | ------------------------------------------------ |
| `PASS`      | Independently verified.                        | Keep as-is.                                      |
| `DOWNGRADE` | Real, but over-stated.                         | Lower severity as directed; keep.                |
| `FAIL`      | Not verifiable, out of scope, or linter-owned. | **Drop.** Unattended runs have no override path. |

### Reason codes

Every non-`PASS` verdict carries exactly one:

| Code                 | Verdict   | Meaning                                                    |
| -------------------- | --------- | ---------------------------------------------------------- |
| `missing-inputs`     | FAIL      | Required input absent or malformed (report-level).         |
| `citation-mismatch`  | FAIL      | Line number or quoted text does not match at session SHA.  |
| `unreachable`        | FAIL      | File not fetchable at session SHA.                         |
| `not-in-diff`        | FAIL      | Cited line is pre-existing and unchanged.                  |
| `linter-owned`       | FAIL      | Interlock status 🔒 -- CI already reports it.              |
| `runtime-behavioral` | FAIL      | Interlock status 🚫 -- not observable in a spec.           |
| `no-coverage-row`    | FAIL      | No interlock row; coverage was invented.                   |
| `unknown-rule-id`    | FAIL      | Rule ID does not exist in the cited reference file.        |
| `no-fix`             | FAIL      | No concrete fix supplied.                                  |
| `harmful-fix`        | FAIL      | The fix would break compilation or introduce a break.      |
| `out-of-scope`       | FAIL      | ARM, `client.tsp`, emitter config, or generated swagger.   |
| `over-escalated`     | DOWNGRADE | Severity exceeds the ceiling for the rule or change class. |
| `weak-anchor`        | DOWNGRADE | Guideline section not identifiable; re-phrase as question. |
| `unresolved-rule`    | DOWNGRADE | Interlock status ❓; must be a Suggestion-level question.  |

The reason-code list is closed. A Critic that needs a code not on this list must
use the closest match and note the gap in the calibration line; adding a code
requires editing this file.

## Severity ceilings by change class

The Critic enforces these; the Reviewer should apply them pre-emptively.

| Change class       | Maximum severity                                                               |
| ------------------ | ------------------------------------------------------------------------------ |
| `new-service`      | 🔴 Blocking permitted.                                                         |
| `new-version`      | 🔴 Blocking permitted.                                                         |
| `maintenance-edit` | 💡 Suggestion, **except** secret exposure and breaking changes, which stay 🔴. |

Independent of change class:

| Finding kind                                             | Maximum severity |
| -------------------------------------------------------- | ---------------- |
| Naming (`DP-NAME-*`) or documentation (`DP-DOC-*`)       | 💡 Suggestion    |
| Anything from `data-plane-design-decisions.md` (`DDP-*`) | 💡 Suggestion    |

## Critic output

The schema is in
[`data-plane-api-review-critic.agent.md`](../data-plane-api-review-critic.agent.md)
§"Output format". Summary: a header with session SHA and finding count, one
table row per finding (`# | Finding | Verdict | Reason`), a counts summary, and
a single optional calibration line.

The Critic emits **no findings of its own**. A critique containing a new
finding is a protocol violation; the Reviewer must ignore it and note the
violation in its report.

## Failure handling

| Situation                             | Reviewer behavior                                                                        |
| ------------------------------------- | ---------------------------------------------------------------------------------------- |
| Dispatch fails / no critique          | Say so in the report and **downgrade every Blocking finding to Warning**.                |
| Critique malformed / cannot be parsed | Treat as dispatch failure.                                                               |
| Critique FAILs every finding          | Emit "No findings" plus a note that the critic rejected all candidates. Do not override. |
| Critique returns extra findings       | Ignore them; note the protocol violation.                                                |

## Non-goals

Explicitly **not** in this protocol, and not to be added without cause:

- Iteration. One dispatch per run. If the Critic FAILs a finding, it is dropped,
  not revised and resubmitted.
- Human override. Unattended runs have no human in the loop; interactive runs
  let the human decide outside the protocol.
- Missed-violation hunting. See the Critic agent file for why.
- Telemetry markers and review-state comments. The Reviewer posts nothing, so
  there is no posted state to track.
- Graph re-derivation by the Critic. Citation verification (check 1) covers the
  fabrication risk at a fraction of the cost.
