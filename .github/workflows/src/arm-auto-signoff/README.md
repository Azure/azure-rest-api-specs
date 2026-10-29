# ARM Review and PR State Reconciliation

The ARM reviewer produces evidence for a particular commit. Shared reconciliation computes
intake and ARM approval labels together, then renders the next-steps comment and aggregate
merge status from that desired label set. Approval and queue removal do not require another
workflow to consume label artifacts or notice label changes.

```text
PR events / validation completions
  -> Summarize Checks
       read current PR, checks, impact assessment, and latest status per context
       evaluate intake + ARM policy -> one desired label set
       recheck PR/head/base/draft/labels
       apply label difference, render next steps, publish merge status
       request the first eligible ARM review if not already requested

ARM reviewer
  -> publish the validated, head-bound ARM Semantic Review result
  -> trusted conclusion finalizes an unpublished result if necessary
  -> call the same reconciliation using this run's trusted PR/SHA artifact
```

The conclusion reconciles every trigger type and terminal outcome. A failed reconciliation
fails that step without changing the semantic verdict. Other validation workflows remain
independent; Update Labels still handles unrelated producers such as modeling review and SDK
labels.

## Initial review and explicit retries

After readiness reconciliation, a serialized, non-cancelling PR-scoped job dispatches the initial
review. Labels written with `GITHUB_TOKEN` do not trigger label-event workflows, so this initial
dispatch remains necessary. The dispatcher rechecks live PR/head, draft and hold labels, and
the durable `ARMInitialReviewRequested` marker. It reserves the marker before publishing pending
and dispatching on the trusted default branch. The reviewer validates the expected head,
queue/marker labels, and pending-status reservation before starting.

`ARMInitialReviewRequested` tracks the initial request, not approval. Once present it prevents
another automatic review, including after a push. An existing current-head semantic status
backfills a missing marker without rerunning AI. Summary evaluation rejects known markers and
holds before scheduling a dispatch runner.

To explicitly review again, comment `/arm-review`, remove and re-add `WaitForARMFeedback`,
remove `ARMChangesRequested`, or manually dispatch the reviewer with the PR number and no
expected head SHA. Existing authorization gates apply. Keep the marker when retrying; do not
delete it as routine cleanup. Check for a queued or running review before retrying an ambiguous
dispatch failure.

Dispatch failures leave the marker in place because a timeout may still have created a run.
Failure cleanup changes only the dispatcher's own pending reservation. Review failures,
cancellations, and incomplete results require explicit retries, not an automatic AI loop.
Reviewer concurrency queues requests instead of interrupting an active review; an old publisher
cannot replace a newer attempt's status.

## Signoff policy and ownership

Automatic approval requires all of:

- A passing `ARM Semantic Review` result for the current head.
- Successful `Swagger LintDiff` and `Swagger Avocado` statuses for that head.
- `ARMReview` present and `NotReadyForARMReview` absent.
- No `ARMChangesRequested`, `ARMManualSignoffRequired`, or unapproved
  `SuppressionReviewRequired` hold after intake reconciliation.

`ARMSignedOff` with `ARMAutoSignedOff` is automation-owned and is revoked when those conditions
do not hold. Legacy `ARMAutoSignedOff-IncrementalTSP` and `ARMAutoSignedOff-Trivial` markers also
identify automatic approval and are replaced or removed on evaluation. An orphaned current
marker can self-heal `ARMSignedOff` when the evidence passes. Revocation removes `ARMSignedOff`
before its markers so a partial failure cannot make an automatic approval look human-owned.

An unmarked `ARMSignedOff` is human approval: automatic policy neither adopts nor revokes it.
Existing intake rules still govern applicable review labels, including signed-off precedence
over `ARMChangesRequested`. Use `ARMManualSignoffRequired` to block automatic approval;
removing only `ARMSignedOff` allows an eligible approval to self-heal.

The automated-review cap is 50 non-example files or 5,000 added+deleted lines under
`specification/`. Files in an `examples` directory remain in scope but do not consume either
limit. A rename counts if either path is a non-example specification. GitHub's 3,000-file
listing cap still applies because a truncated list cannot prove full coverage.

| Semantic status | Description starts with    | Effect on automatic approval                 |
| --------------- | -------------------------- | -------------------------------------------- |
| `pending`       | `ARM API semantic review`  | Withheld                                     |
| `success`       | `Passed:`                  | Allowed if the remaining conditions pass     |
| `failure`       | `Changes requested:`       | Withheld                                     |
| `error`         | `Manual review required: ` | Withheld; add the sticky manual-signoff hold |
| `error`         | `Review incomplete: `      | Withheld; explicit retry can recover         |

Trusted code validates model output and independently checks claimed full coverage before
publishing the verdict for its reviewed SHA and run attempt.

## Freshness and recovery

Reconciliation uses the live PR's draft state and target branch, rather than snapshots in
impact artifacts. It supports legacy and service-scoped impact artifacts through the shared
reader and existing review policy. One latest-status read supplies both ARM policy and check
summarization.

Before applying a plan, reconciliation rechecks the head, open state, base branch, draft state,
and label snapshot. A changed snapshot causes no writes. An old review's head is never replaced
with the live head. Independent evaluations may overlap: this is not a cross-workflow lock or
transaction, and GitHub label mutations are not atomic. Subsequent evaluations repair derived
state after partial failures.

Use existing PR/check events to reevaluate state, or rerun the reviewer conclusion when its
reconciliation failed; do not rerun AI merely to refresh approval or the summary.
