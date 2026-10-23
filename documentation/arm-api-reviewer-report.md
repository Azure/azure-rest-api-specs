# ARM API Reviewer Report: Evidence and Maintenance

The [HTML report](arm-api-reviewer-report.html) is the self-contained presentation
for the team and leadership. Its styles, chart library, renderer, and metric
data are embedded. Only the HTML is needed as an email attachment; recipients
open it in a browser. Email-client previews may disable JavaScript.

This Markdown file is the companion for definitions, sources, limits, and
maintenance. A separate JavaScript source file is not a runtime dependency.

## Reporting Windows

| Measure                                          | Source window                                                              |
| ------------------------------------------------ | -------------------------------------------------------------------------- |
| Findings, reach, execution speed, and AI credits | Supplied snapshot collected October 1, 2026; findings begin April 22, 2026 |
| Blocking-feedback turnaround                     | May 1 through October 21 in 2025 and 2026                                  |
| Identified design-review items per change        | Recalculated May 1 through October 21 in 2025 and 2026                     |

The [published audit](https://github.com/Azure/azure-rest-api-specs/blob/1b3157774a0a1db317629cf67a8c20f94a547f66/documentation/arm-api-reviewer-insights.md)
is an additional historical source. Its April-August finding totals are not
interchangeable with the later snapshot embedded in this report.

Source provenance belongs in this companion rather than a report footer. The
October 1 snapshot supplies findings and operational totals, the October 22
label-history collection supplies turnaround, and the feedback collection
completed October 23 UTC supplies the recalculated design-depth comparison.
Those collection dates do not change the stated review windows. Bootstrap
intervals quantify resampling uncertainty; they do not adjust for causal
confounding or classification bias.

## Review Model Usage

The expandable table in the HTML groups recorded automated review runs by
anonymized model configuration. "Model 1", "Model 2", and "Model 3" are
substitute identifiers, not model product names. First and last observed dates
describe available run records for each configuration, not separate annual
comparison cohorts. Median minutes and AI credits summarize those run records.

The three rows cover 701 runs with usage data, not all 728 recorded full review
runs. Model mix and differences in PR size can affect runtime and credit
figures; the table is not a controlled comparison of model performance. AI
credits are billing units, not a currency amount.

### Workflow Usage Coverage

Recorded workflow-usage telemetry begins August 7, 2026. The April-July zeros
in the supplied weekly aggregates indicate missing usage history, not evidence
that AI was unused or that reviews cost zero credits. The usage chart starts at
the first recorded usage interval rather than plotting those unavailable weeks.

Include both partial boundary weeks: August 7-9 and September 28-October 1.
Dropping the last incomplete calendar week would omit 83 runs and 876 recorded
AI credits. All nine displayed intervals reconcile to 728 runs and 48,864
recorded credits. The snapshot ends October 1; it does not establish credit
usage for the rest of October or for the full matched-year review window.

Both runs and credits use line series with separate labeled axes. The latest
four credit values are annotated to remain readable despite the much larger
August values. Lower September values coincide with a changed model mix;
neither this graph nor the model table isolates the effect of that change.

## At a Glance

The supplied snapshot records 681 PRs reviewed, 173 resource providers,
403 developers, and 728 full review runs. It contains 3,731 distinct findings,
including 1,250 blocking findings, 1,900 contract-risk findings, and 151 security
findings. There are 93 reviewed PRs with no findings, or 13.7 percent.

Findings are review signals, not measured labor savings, accepted defects, or
confirmed incident prevention. Critic verification is not a human acceptance rate.

## Blocking-Feedback Turnaround

The two UTC windows are inclusive at the start and exclusive at the end:

- May 1, 2025 to October 22, 2025.
- May 1, 2026 to October 22, 2026.

Measure elapsed calendar hours from adding `WaitForARMFeedback` to adding
`ARMChangesRequested`. Exclude starts already carrying changes-requested or
sign-off labels. Sign-off, not-ready status, closure, replacement requests,
and canceled waiting labels end the cycle without blocking feedback. Allow
waiting-label removal up to 60 seconds before the blocking label because a
label update can remove the old label before adding the new one.

Assign completed cycles by the blocking-label timestamp and take the
earliest-starting qualifying cycle per repository/PR identity in each window.
This gives one observation per PR per year, not one per repeated review.

| Measure                           |     2025 |      2026 |
| --------------------------------- | -------: | --------: |
| Selected PR observations          |      223 |       198 |
| Mean elapsed hours                |    94.68 |     57.60 |
| Median elapsed hours              |    58.17 |     20.06 |
| Blocking feedback within 24 hours | 72 / 223 | 111 / 198 |

The observed mean reduction is 37.08 hours, or 39.2 percent. The 95 percent
bootstrap interval for hours saved is 8.74 to 60.09 hours. Use 20,000
repository-stratified PR-cluster percentile-bootstrap replicates and seed 20261022. Resample PR identities within repository and retain observations
together where a PR appears in both periods.

The scan covered 25,154 PR histories across the public and private specification
repositories. It used full, paginated label histories and did not filter by
current labels or PR state. Events after October 22, 2026 at 21:11:25 UTC were
excluded from that analysis. Recent unresolved requests are not assigned zero
duration. Queue policies, staffing, service mix, and author readiness were not
held constant, so the reduction is not an isolated estimate of AI causation.

An earlier adjacent-period comparison gave 41.89 versus 61.09 hours, with a gain
interval of -44.07 to +0.50 hours. It did not establish an improvement. The
matched-year comparison answers a different question and must not erase that
contrasting result.

The design-depth collection subsequently exposed missing events in the earlier
cached ARM-label history. Discovery for the new feedback analysis was expanded
to compensate. Turnaround figures are retained from the earlier analysis, not
newly recalculated by this feedback-only update; a fresh complete label-history
audit is needed before treating that source as a complete census.

## Design-Review Depth

This full-window recalculation replaces the earlier May-July subset. Both
cohorts use the same calendar dates as the turnaround chart. It is a new,
explicitly defined comment-level metric, not a claim to reproduce the older
audit's broader taxonomy or its 3.3-versus-7.3 values.

| Measure                                 | Human-reviewed 2025 | Agent-assisted 2026 |
| --------------------------------------- | ------------------: | ------------------: |
| Reviewed PRs                            |               1,169 |                 795 |
| Identified design items                 |               1,894 |               2,662 |
| Identified design items per PR          |                1.62 |                3.35 |
| Retained feedback items, all categories |               5,327 |               5,904 |
| Unclassified items                      |               2,587 |               1,615 |
| Classification coverage                 |               51.4% |               72.6% |
| PRs with zero identified design items   |                 541 |                 243 |

The observed identified-item ratio is **2.07 times**. Within the 2026 cohort,
humans contribute 691 identified design items and the agent contributes 1,971,
or 0.87 and 2.48 items per PR. Human feedback classification coverage is 47.6%
and agent coverage is 86.7%; richer agent markers make classification easier.

The 20,000-replicate PR-cluster bootstrap gives a 95% interval of **1.36 to 2.11
additional identified items per PR**, or **1.78 to 2.39** for the rate ratio.
These intervals describe sampling variation in this metric, not classification
accuracy or a causal agent effect.

**Coverage sensitivity is material.** Treating every unclassified baseline item
as a design item raises the baseline rate to 3.83 and lowers the ratio to
**0.87 times**, reversing its direction. This deliberately conservative scenario
is not a best estimate; it shows that unequal classification coverage can
explain the apparent gain. Do not present the observed 2.07-times ratio as proof
that the agent found twice as many valid defects or that humans would miss them.

### Source Coverage

Discovery scanned 27,185 public-repository and 20,783 private-repository review
comments, plus agent-summary search results and the supplied report's known PRs.
The union with cached ARM review history produced **4,801 candidate PRs**:
2,507 public and 2,294 private. Every candidate's review threads, conversation
comments, and submitted reviews were paginated completely. The final collection
completed **October 23, 2026 at 00:50:11 UTC**, after the reporting window closed.
This collection timestamp does not extend the feedback dates past October 21.

The coverage audit recognizes all **168 known public agent-reviewed PRs** in the
supplied report's retained sample. The sample check is not proof that every
historical review can be discovered: deleted comments and unmarked agent output
remain unobservable. Raw private comments, PR identifiers, and per-PR records
remain outside this repository. The publication embeds aggregate design-depth
figures only.

The audit independently reconstructed the counts, dates, unique PRs, item
deduplication, and zero-design denominators from classified records. Public
examples were checked by category. Administrative approval updates, quoted-only
text, and engineering-tooling discussion were excluded or classified outside
design rather than counted as contract findings. There were 592 source records
edited after their original reporting window; the API supplies current text,
not the original pre-edit body.

### Category Counts for the Matched Cohorts

| Design category                | 2025 human | 2026 agent plus human |
| ------------------------------ | ---------: | --------------------: |
| Schema and property design     |      1,049 |                   868 |
| Resource modeling              |        175 |                   280 |
| Versioning and compatibility   |        332 |                   547 |
| Operations and HTTP semantics  |         64 |                   231 |
| Long-running operations        |         66 |                   300 |
| Security and secrets           |         71 |                   245 |
| SDK and client contract impact |        137 |                   191 |
| **Identified design total**    |  **1,894** |             **2,662** |

These are raw counts from different-sized cohorts, not rates per 100 PRs. They
also differ from the October 1 snapshot's overall findings, which has a different
collection cutoff and de-duplication scheme.

### Full-Window Counting Rules

The recalculation uses both specification repositories and the same UTC dates
as the turnaround analysis. PR creation date does not assign the review year;
each feedback item's creation or review-submission date does.

1. Discover candidates from cached ARM review histories, repository-wide review
   comments on ARM paths, structured agent markers, agent-summary searches, and
   the supplied report's known reviewed PRs. Cached labels alone are insufficient:
   source checks found ARM events missing from the earlier cache.
2. Fetch every candidate's complete review-thread, conversation-comment, and
   submitted-review connections. Count root review-thread comments, not thread
   replies. Exclude bots and the PR author's own comments from the human channel.
3. Attribute agent feedback using the hidden `posted-by` or ARM workflow markers,
   not the posting account. A user account can publish an agent finding.
4. Count actionable root comments and itemized finding-table rows. Exclude
   acknowledgments, review summaries, severity-total tables, reconciliation, and
   explicitly marked non-finding clarifications. Deduplicate normalized rule,
   file, and issue text within each repository/PR/channel; repeated line numbers
   or classification badges do not create new items.
5. Design categories are schema/property design, resource modeling, versioning
   and compatibility, HTTP semantics, long-running operations, security/secrets,
   and SDK/client contract impact. Documentation, naming polish, suppressions,
   tooling, and CI readiness are not design items in this calculation.
6. Prefer explicit categories and consistent rule-category mappings. Otherwise
   apply the same conservative rule/issue-heading patterns to both channels.
   Do not classify by keyword matches anywhere in an entire comment. Retain
   unmatched items as unclassified and report coverage rather than guessing.

The baseline denominator is human-reviewed ARM PRs in the earlier window. The
agent-assisted denominator is PRs with a marker-attributed agent review in the
later window. Include qualifying PRs with zero identified design items. These
are distinct observational cohorts, not a paired or randomized experiment.

Report human and agent contributions separately and show a sensitivity bound
that treats every unclassified baseline item as a design item. Bootstrap
intervals describe PR-level sampling variation; they do not resolve
classification bias or changing service and reviewer mix. Current comment text
can include edits after the original window; original deleted or pre-edit text
is not available from the current API response.

## Public Finding Examples

The 896 retained public examples contain abbreviated headings from the supplied
snapshot, not complete comment bodies. Each Finding cell includes a
**Read Full Comment** link to the original public review or conversation comment,
including its comment anchor. The PR column continues to link to the PR itself.

Comment URLs were restored from the supplied snapshot after checking PR, date,
rule, and heading identities. Links are restricted to the matching public PR;
no private comment URLs are embedded. Opening the report and its charts remains
offline-capable, while following a GitHub comment link requires internet access.
Deleted comments may no longer resolve.

## Updating the Standalone Report

1. Update the data in the `snapshot-data` JSON script block. Do not infer
   historical totals from the retained public-finding sample. Keep the Impact
   Summary's rounded figures synchronized with the source metrics and retain
   its review-mix and classification-coverage qualification.
2. Update the renderer in the `report-code` module script block. The separate
   development source is not required for recipients.
3. Preserve the bundled Chart.js license and attribution. Do not add CDN or
   local-file dependencies to the HTML attachment.
4. Open an isolated copy without companion files. Check charts, filters,
   desktop and mobile layouts, average-label bounds, and the absence of private
   PR content. Update the source windows and limitations in this companion.

Formatting uses the repository's installed Prettier:

```powershell
pnpm exec prettier documentation/arm-api-reviewer-report.html documentation/arm-api-reviewer-report.md --embedded-language-formatting off --check
```
