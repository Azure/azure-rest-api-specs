# ARM Review and PR State Reconciliation

The ARM reviewer produces evidence for a particular commit. Shared reconciliation owns the
automation's ARM labels, the next-steps comment, and the aggregate merge status. These outputs
are calculated together; an approval does not need another workflow to consume label artifacts
or notice that the labels changed.

```text
PR events / validation completions
  -> Summarize Checks
       read current PR, checks, impact assessment, and latest status per context
       evaluate intake + ARM policy -> one desired label set
       recheck PR/head/draft/labels
       apply label difference, render next steps, publish merge status
       request the initial ARM review only when eligible and not already requested

ARM reviewer
  -> publish the validated, head-bound ARM Semantic Review result
  -> trusted conclusion finalizes an unpublished result if necessary
  -> call the same reconciliation directly, using this run's trusted PR/SHA artifact
```

The reviewer conclusion reconciles every trigger type and every terminal outcome. It does not
dispatch a signoff workflow, Update Labels, or another Summarize Checks run. A failed
reconciliation fails that step without changing the semantic verdict.

Other validation workflows remain independent. Update Labels still handles unrelated producers,
such as modeling review and SDK labels; it has no ARM auto-signoff dispatch or policy branch.
The next-steps comment and merge status use the desired label set from the same evaluation,
including newly granted or revoked approval and the corresponding queue-label change.

## Initial review and explicit retries

Summarize Checks can request the first eligible review even when `WaitForARMFeedback` was
already present. It checks known holds and `ARMInitialReviewRequested` before scheduling a
dispatch job. That short job is serialized per PR and rechecks the live PR before reserving
the request. There is no extra dispatch runner for an already-marked PR.

The initial reviewer dispatch remains the one asynchronous handoff. Labels written using
`GITHUB_TOKEN` do not trigger label-event workflows. The dispatch uses the trusted default
branch, reviewed head SHA, and a pending-status reservation URL. Activation validates that
reservation before starting the agent. The reviewer never executes code from a fork.

`ARMInitialReviewRequested` is durable, PR-scoped request tracking, not approval evidence.
It is also recorded for explicit reviews and is not automatically removed. New commits revoke
an obsolete automatic approval but do not request another automatic review. A review must
pass for the current head to authorize signoff.

To explicitly review again, comment `/arm-review`, remove and re-add `WaitForARMFeedback`, or
manually dispatch the reviewer with the PR number and no expected head SHA. Existing
authorization gates apply. Keep the marker when retrying; do not delete it as routine cleanup.
Check for a queued or running review before retrying an ambiguous dispatch failure.

The marker is reserved before status publication and dispatch. Failures are logged and leave
the marker in place because an HTTP timeout may still have created a run. Pending-status
cleanup only changes the dispatcher's own reservation. Failures and incomplete reviews require
an explicit retry, not an automatic AI loop.

## Signoff policy and ownership

Automatic approval requires all of:

- A passing `ARM Semantic Review` result for the current head.
- Successful `Swagger LintDiff` and `Swagger Avocado` statuses for that head.
- `ARMReview` present and `NotReadyForARMReview` absent.
- No `ARMChangesRequested`, `ARMManualSignoffRequired`, or unapproved
  `SuppressionReviewRequired` hold after intake reconciliation.

`ARMSignedOff` with `ARMAutoSignedOff` is automation-owned and is revoked when those conditions
do not hold. The legacy `ARMAutoSignedOff-IncrementalTSP` and `ARMAutoSignedOff-Trivial` markers
also identify automatic approval and are replaced or removed on evaluation. An orphaned current
marker can self-heal `ARMSignedOff` when the evidence still passes.

An unmarked `ARMSignedOff` is human approval: the automatic signoff policy neither adopts nor
revokes it. Existing intake rules still govern which review labels apply, including signed-off
precedence over `ARMChangesRequested`. Use `ARMManualSignoffRequired` to block automatic
approval; removing only `ARMSignedOff` allows an eligible automatic approval to self-heal.

| Semantic status | Description starts with    | Effect on automatic approval                 |
| --------------- | -------------------------- | -------------------------------------------- |
| `pending`       | `ARM API semantic review`  | Withheld                                     |
| `success`       | `Passed:`                  | Allowed if the remaining conditions pass     |
| `failure`       | `Changes requested:`       | Withheld                                     |
| `error`         | `Manual review required: ` | Withheld; add the sticky manual-signoff hold |
| `error`         | `Review incomplete: `      | Withheld; explicit retry can recover         |

Trusted code validates the model's output, independently checks claimed full coverage, and
publishes the verdict for its reviewed SHA and run attempt. An old publisher cannot replace a
newer attempt's reservation.

## Freshness and rollout

Reconciliation reuses labels from its required PR lookup and one latest-status read for ARM
policy and check summarization. Before applying the plan it rechecks the PR's head, open state,
draft state, and label snapshot. A changed snapshot causes no writes. A reviewer completion for
an old SHA never substitutes the live head or applies that old result to a newer commit.

This is a shared writer implementation, not a cross-workflow transaction or lock. Initial
review requests are serialized, but independent state evaluations may overlap. GitHub does not
provide atomic compare-and-set for labels; mutations after the freshness check and partial API
failures remain possible. Subsequent evaluations repair derived state.

Drain the retired Universal signoff and its queued Update Labels runs before cutover, then
reevaluate affected open PRs. Use the existing PR/check events to reevaluate state; rerun the
reviewer conclusion when its reconciliation failed. Preserve human approvals and backfill
initial-request markers for pre-rollout reviews where needed.

Before rollout, validate an actual fork PR through automatic review, approval, queue removal,
next-steps rendering, and merge-status refresh without an unrelated event. Exercise a stale head
and failed reviewer too. Local tests and workflow compilation cannot establish GitHub's live
execution and permission behavior.
