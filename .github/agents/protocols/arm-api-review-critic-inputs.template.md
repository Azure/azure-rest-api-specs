<!-- Source of truth for the Critic-invocation input block. Both the
     Reviewer (Step 7) and the Critic (Operating mode) link here.
     Schema definitions and the non-empty response invariant live in
     `arm-api-review-critic.protocol.md`; this file is the **reference
     template** the Reviewer uses when constructing dispatch prompts. -->

# Critic input block template

The Reviewer includes a labeled input block in every Critic dispatch
prompt. The Critic uses **tolerant prose parsing**: it reads the labeled
fields in any order, and applies the documented default for any optional
field that is absent or unclear. Review target, Session SHA, the Step 6 findings
report, and the Step 5.5 reconciliation plan or explicit sentinel are required.

## Template (copy and fill in; fields in any order are accepted)

```text
Review target: PR https://github.com/<owner>/<repo>/pull/<number>
Session SHA: <full-40-char-sha>
Iteration: 1
Graphs: true
Files reviewed: path/to/file-a.json, path/to/file-b.tsp
Previous version: specification/<service>/.../stable/<prev-version> at <full-40-char-base-sha>
Prior fail sets: none
Considered and declined: none
```

## Step 6 findings report

<verbatim Step 6 report from the Reviewer>

## Step 5.5 reconciliation plan

Discussion inventory: inline threads <count> (pagination complete: yes/no);
top-level PR comments <count> (pagination complete: yes/no); review bodies
<count> (pagination complete: yes/no)

<verbatim Step 5.5 plan from the Reviewer, or the literal string `reconciliation skipped`>

For a local review, replace the first six fields with:

```text
Review target: local workspace: <absolute-file-or-directory>
Session SHA: local-sha256:<64-lowercase-hex>
Iteration: 1
Graphs: true
Source manifest: <reviewed|previous-version|head>:<source>@sha256:<hash>, ...
Previous version: <local-path>@sha256:<hash> (or None - new service); Repository HEAD: <full-40-char-sha>
```

Local review always uses the literal `reconciliation skipped` under
`## Step 5.5 reconciliation plan`.

## Field reference

| Field                            | Required?              | Default when absent            | Notes                                                                                                                               |
| -------------------------------- | ---------------------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| Review target                    | **Yes**                | —                              | Full PR URL / `owner/repo#number`, or `local workspace: <absolute-target>`.                                                         |
| Session SHA                      | **Yes**                | —                              | PR: full 40-char head SHA. Local: `local-sha256:<64-lowercase-hex>` manifest digest.                                                |
| Iteration                        | No                     | `1`                            | `1` through `3`.                                                                                                                    |
| Graphs                           | No                     | `false; graph-mode: fast-path` | `true` = full graph diff. When false, mode is `fast-path`, `size-downgrade`, or `derivation-failed`.                                |
| Files reviewed / source manifest | PR: No; local: **Yes** | PR: derived from findings      | PR: workspace-relative reviewed paths. Local: complete `reviewed`, `previous-version`, and applicable `head` source manifest.       |
| Previous version                 | **Yes**                | —                              | PR path or `None - new service`, always with full base commit SHA. Local path/hash or `None - new service`, plus repository `HEAD`. |
| Prior fail sets                  | No                     | Empty (none)                   | Rule-ID + file/line tuples from prior iterations; `none` on iteration 1.                                                            |
| Considered and declined          | No                     | Empty (none)                   | Candidates the Reviewer chose not to promote, with one-line rationales.                                                             |
| Step 6 findings report           | **Yes**                | —                              | Verbatim, under the `## Step 6 findings report` heading.                                                                            |
| Step 5.5 reconciliation plan     | **Yes**                | —                              | Verbatim, including all three discussion-surface counts/pagination status, or the explicit sentinel `reconciliation skipped`.       |

## Compact-mode template (iterations 2 and 3)

For iterations 2 and 3, the Reviewer MAY send a compact payload. Include
only the changed findings under `## Step 6 findings report` and a brief
carry-over summary under `## Carry-over verdicts`. Re-pin the session SHA
and run the file-drift check before sending.

```text
Review target: PR https://github.com/<owner>/<repo>/pull/<number>
Session SHA: <full-40-char-sha>   (re-verified before this dispatch)
Previous version: <path or None - new service>; Base SHA: <full-40-char-base-sha>
Iteration: 2
Graphs: true
Prior fail sets: <rule-ID + file/line tuples from iteration 1>
Considered and declined: <candidates declined in iteration 1 with rationales>
```

<!-- markdownlint-disable MD024 -->

## Step 6 findings report

<only the changed/added findings since iteration 1>

## Carry-over verdicts

<brief list: finding label — prior verdict — carry-over-stale: no/yes>

## Step 5.5 reconciliation plan

<verbatim plan, or `reconciliation skipped`>

<!-- markdownlint-enable MD024 -->

For a local compact dispatch, use `Review target: local workspace:
<absolute-target>`, repeat the complete path/hash manifest, recompute the
`local-sha256:` value before dispatch, repeat `Previous version: <path/hash or
None - new service>; Repository HEAD: <full-40-char-sha>`, and keep
`reconciliation skipped`.
