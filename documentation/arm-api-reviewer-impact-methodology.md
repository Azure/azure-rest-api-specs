# ARM API Reviewer Impact: Evidence and Method

This appendix supports the [impact briefing](arm-api-reviewer-impact.md).
It separates directly measured outcomes from possible benefits that have not
yet been measured.

## Sources and Windows

| Measure                                                     | Window                          | Source                                         |
| ----------------------------------------------------------- | ------------------------------- | ---------------------------------------------- |
| Label transitions, PR volume, and human label participation | May 1-October 21, 2025 and 2026 | GitHub PR histories collected October 22, 2026 |
| Feedback items per change                                   | May-July 2025 and 2026          | Published findings audit                       |
| Category counts, severity, and reach                        | April 22-August 24, 2026        | Published findings audit                       |
| Automated review execution time                             | August 7-24, 2026               | 126 workflow runs in the published audit       |

The [published findings audit](https://github.com/Azure/azure-rest-api-specs/blob/1b3157774a0a1db317629cf67a8c20f94a547f66/documentation/arm-api-reviewer-insights.md)
is pinned to its August 26 source revision. Its finding counts were reused, not
recollected or independently reclassified through October. Its methodology
de-duplicates findings by PR, rule, file, and heading and excludes summaries and
follow-up replies.

## Matched-Year Turnaround

Both windows use UTC, inclusive start and exclusive end:

- Before: `2025-05-01T00:00:00Z` to `2025-10-22T00:00:00Z`.
- After: `2026-05-01T00:00:00Z` to `2026-10-22T00:00:00Z`.

The scan covered **25,154 PR histories**: **13,855** in
`Azure/azure-rest-api-specs` and **11,299** in `Azure/azure-rest-api-specs-pr`.
PRs were enumerated by descending update time until updates predated May 1, 2025. No current-label, PR-creation, merge, or open-state filter was applied.
Each label timeline was paginated completely, including older events needed
to determine label state. Events after the original observation cutoff,
**October 22, 2026 at 21:11:25 UTC**, were excluded. Collection was extended
through **22:01:40 UTC**, with an overlapping boundary page to avoid gaps.

### Pairing and Cohort Rules

1. Start a review cycle when `WaitForARMFeedback` is added. Exclude starts with
   `ARMChangesRequested` or `ARMSignedOff` already present.
2. Finish at the next addition of `ARMChangesRequested`. An intervening sign-off,
   not-ready label, closure, replacement request, or other waiting-label removal
   ends the cycle without a blocking completion.
3. Allow waiting-label removal up to 60 seconds before the blocking label,
   because a label update can remove the old label before adding the new one.
4. Assign completed cycles to a year by the blocking-label timestamp. Select
   the earliest-starting qualifying completed cycle per repository/PR identity
   in that window. A PR can contribute once in each year.
5. Measure elapsed calendar hours, including nights and weekends. Nonblocking
   and unresolved requests are not assigned zero duration.

| Main result                       |         2025 |         2026 |
| --------------------------------- | -----------: | -----------: |
| Selected PR observations          |          223 |          198 |
| Mean                              |  94.680985 h |  57.598843 h |
| Median                            |  58.173333 h |  20.062778 h |
| 90th percentile                   | 223.333000 h | 116.205056 h |
| Blocking feedback within 24 hours |     72 / 223 |    111 / 198 |

Hours saved is `94.680985 - 57.598843 = 37.082143 hours`.
The percentage reduction is that difference divided by the 2025 mean:
**39.1654%**. These are elapsed waiting hours, not engineering labor hours.

### Uncertainty and Sensitivity

Confidence intervals use **20,000 repository-stratified, PR-cluster percentile
bootstrap replicates**, with random seed **20261022**. Resample PR identities
within each repository, retaining both observations together where a PR appears
in both years. Use the 2.5th and 97.5th percentiles of the before-minus-after
mean difference. Unequal sample sizes do not require discarding observations.

| Comparison                                                 |       Before mean |        After mean | Hours saved | 95% interval for hours saved |
| ---------------------------------------------------------- | ----------------: | ----------------: | ----------: | ---------------------------: |
| Main: completed-review date                                | 94.68 h (223 PRs) | 57.60 h (198 PRs) |     37.08 h |              8.74 to 60.09 h |
| Waiting-request date                                       | 93.04 h (222 PRs) | 48.33 h (196 PRs) |     44.71 h |             26.31 to 62.28 h |
| Exclude selected first cycles over 30 days                 | 94.68 h (223 PRs) | 44.21 h (196 PRs) |     50.47 h |             33.63 to 66.75 h |
| Keep selected cycles with both labels inside the window    | 93.85 h (220 PRs) | 48.07 h (195 PRs) |     45.78 h |             27.21 to 63.30 h |
| Equal count: first 198 completed PR observations each year |          103.03 h |           57.60 h |     45.43 h |             16.89 to 69.54 h |

All checks show a positive observed year-over-year gain. Sensitivity intervals
are descriptive, not adjusted multiple hypothesis tests. Request-date cohorts
have unequal follow-up for unresolved requests; the completed-review comparison
does not estimate the waiting time of those unresolved requests either.

Results by repository are **82.75 to 63.15 hours** for the public repository
(98 versus 133 PR observations) and **104.03 to 46.23 hours** for the private
repository (125 versus 65). The public-repository confidence interval includes
zero; the private-repository interval does not. Repository mix and service mix
were not held constant.

### Contrasting Adjacent-Period Result

The previously fixed comparison of October 22, 2025-April 22, 2026 against
April 22-October 22, 2026 produced **41.89 versus 61.09 hours**, with a gain
interval of **-44.07 to +0.50 hours**. It did not establish an improvement.
The matched-year comparison answers a different question and uses the same
calendar months to reduce seasonal differences. Neither design isolates the
agent's causal effect. The differing results show why the baseline matters;
the favorable year-over-year result must not erase the adjacent-period result.

## Demand and Participation

| Measure                           |  2025 |  2026 | Definition                                                         |
| --------------------------------- | ----: | ----: | ------------------------------------------------------------------ |
| New PRs                           | 6,182 | 6,909 | Creation timestamp inside the matched window; all PR types         |
| ARM feedback request cycles       |   847 | 1,020 | Eligible waiting-label additions; includes repeat reviews          |
| PRs with an ARM feedback request  |   519 |   595 | Unique repository/PR identities in those request cycles            |
| Human blocking-label contributors |    20 |     9 | Distinct GitHub actors of type `User` adding `ARMChangesRequested` |

The last row is not a staffing census, an FTE estimate, or a count of all people
who read or reviewed a PR. It includes occasional contributors and excludes
reviewers who never applied that label. Formal reviewer headcount was not
available. Overall PR volume also includes changes outside ARM API review.

## Finding Categories

| Category                       | Distinct findings |
| ------------------------------ | ----------------: |
| Schema and property design     |               502 |
| Documentation and examples     |               221 |
| Resource modeling              |               193 |
| Suppressions and tooling       |               173 |
| Long-running operations        |               162 |
| Operations and HTTP semantics  |               156 |
| Versioning and compatibility   |               154 |
| Naming, enums, and identifiers |                80 |
| Security and secrets           |                68 |
| SDK and client impact          |                20 |
| Review readiness and CI        |                 4 |
| Uncategorized                  |               291 |
| **Total**                      |         **2,024** |

The 291 uncategorized findings are the difference between 2,024 total and 1,733
categorized findings. They were not assigned to guessed categories. Contract
risk totals 665 across resource modeling, long-running operations, HTTP
semantics, and versioning. Counts do not establish acceptance, remediation,
precision, prevented incidents, or defects uniquely missed by a human.

The May-July feedback comparison reports 529 human-reviewed changes in 2025
and 259 agent-reviewed changes in 2026. Design review items per change were
3.3 for human-only review and 7.3 for agent plus human review; the agent
contributed 5.2. Thus `7.3 / 3.3 = 2.21`, displayed as **2.2 times**.
The source warns that human and agent comment categorization has different
coverage. More review items are not automatically more valid defects.

## Validation and Limits

Focused tests cover cycle pairing, repeat reviews, cancellations, timestamp
boundaries, unique PR counts, and bootstrap behavior. The headline matched-year
means were independently reconstructed from the cycle records. A published
security example was checked against its original public review comment.
Raw private-repository data remains outside the repository.

The label-transition result reflects all eligible completed blocking reviews,
not only reviews linked to an agent run. Staffing, service mix, queue policies,
auto-signoff, and author readiness can explain part of the change. Agent
execution time must not be substituted for end-to-end turnaround. No estimate
of human labor saved or causal AI contribution is made.
