<!-- Source of truth for the Critic-invocation input block. Both the
     Reviewer (Step 7) and the Critic (Operating mode) link here.
     Schema definitions and the non-empty response invariant live in
     `arm-api-review-critic.protocol.md`; this file is the **reference
     template** the Reviewer uses when constructing dispatch prompts. -->

# Critic input block template

The Reviewer includes a labeled input block in every Critic dispatch
prompt. The Critic uses **tolerant prose parsing**: it reads the labeled
fields in any order, and applies the documented default for any optional
field that is absent or unclear. Only PR URL, Session SHA, and the
Step 6 findings report are required.

## Template (copy and fill in; fields in any order are accepted)

```text
PR: https://github.com/<owner>/<repo>/pull/<number>
Session SHA: <full-40-char-sha>
Iteration: 1
Graphs: true
Files reviewed: path/to/file-a.json, path/to/file-b.tsp
Previous version: specification/<service>/.../stable/<prev-version> at <sha-or-ref>
Prior fail sets: none
Considered and declined: none
```

## Step 6 findings report

<verbatim Step 6 report from the Reviewer>

## Step 5.5 reconciliation plan

<verbatim Step 5.5 plan from the Reviewer, or the literal string `reconciliation skipped`>

## Field reference

| Field                        | Required? | Default when absent      | Notes                                                                           |
| ---------------------------- | --------- | ------------------------ | ------------------------------------------------------------------------------- |
| PR                           | **Yes**   | —                        | Full GitHub URL or `owner/repo#number`.                                         |
| Session SHA                  | **Yes**   | —                        | Full 40-char commit SHA pinned at Reviewer Step 1.                              |
| Iteration                    | No        | `1`                      | `1` through `3`.                                                                |
| Graphs                       | No        | `false`                  | `true` = Mermaid graphs in report; full graph-diff. `false` = graph N/A.        |
| Files reviewed               | No        | Derived from findings    | Comma-separated or line-separated workspace-relative paths.                     |
| Previous version             | No        | `None - new service`     | Path and SHA/ref used for [NEW]/[EXISTING] classification.                      |
| Prior fail sets              | No        | Empty (none)             | Rule-ID + file/line tuples from prior iterations; `none` on iteration 1.        |
| Considered and declined      | No        | Empty (none)             | Candidates the Reviewer chose not to promote, with one-line rationales.         |
| Step 6 findings report       | **Yes**   | —                        | Verbatim, under the `## Step 6 findings report` heading.                        |
| Step 5.5 reconciliation plan | No        | `reconciliation skipped` | Verbatim, under the `## Step 5.5 reconciliation plan` heading, or the sentinel. |

## Compact-mode template (iterations 2 and 3)

For iterations 2 and 3, the Reviewer MAY send a compact payload. Include
only the changed findings under `## Step 6 findings report` and a brief
carry-over summary under `## Carry-over verdicts`. Re-pin the session SHA
and run the file-drift check before sending.

```text
PR: https://github.com/<owner>/<repo>/pull/<number>
Session SHA: <full-40-char-sha>   (re-verified before this dispatch)
Iteration: 2
Graphs: true
Prior fail sets: <rule-ID + file/line tuples from iteration 1>
Considered and declined: <candidates declined in iteration 1 with rationales>
```

## Step 6 findings report

<only the changed/added findings since iteration 1>

## Carry-over verdicts

<brief list: finding label — prior verdict — carry-over-stale: no/yes>

## Step 5.5 reconciliation plan

<verbatim plan, or `reconciliation skipped`>
