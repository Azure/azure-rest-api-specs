# ARM Semantic Review and Universal Auto-Signoff

The ARM API Reviewer is an AI agent, so auto-signoff does not trust it directly. Its verdict is
turned into one commit status, `ARM Semantic Review`, on the reviewed SHA. Universal Auto-Signoff
reads that status alongside `Swagger LintDiff` and `Swagger Avocado`.

Universal is the production auto-signoff path. It owns `ARMSignedOff` only while the
`ARMAutoSignedOff` marker is present.

## Flow

After Summarize Checks successfully evaluates readiness, a separate PR-scoped,
non-cancelling job explicitly dispatches the reviewer for a newly ready head when
`WaitForARMFeedback` is present. Label writes using `GITHUB_TOKEN` do not trigger
label-event workflows. Already-present queue labels are supported so a later
summary can request a review even if the label was added by an earlier run.
Summary evaluation reads the live PR and rechecks its head, draft state, and label
snapshot before applying label actions; a changed snapshot is left for the next
evaluation instead of applying an obsolete decision.

The handoff checks the live PR/head, draft and hold labels, then reads the current head's
`ARM Semantic Review` status. Any existing status prevents another automatic attempt on
that head: pending reservations, passing reviews, changes requested, incomplete or cancelled
reviews, and manual-review holds all count. An older head's status does not block a ready
new head. No reviewer workflow history is listed.

`ARMInitialReviewRequested` remains a compatibility marker required by automatic activation,
not approval evidence or a per-PR veto. Only the dispatcher writes it, only when missing,
including backfilling from an explicit review's current-head status. It is never automatically
removed. Removing it does not reset current-head request tracking.

For a head without semantic evidence, the dispatcher rechecks readiness, ensures the marker
exists, and checks current-head statuses again before writing pending and dispatching.
The second status read avoids replacing an explicit review that started between reads.
Repeated automatic dispatch jobs are serialized. The reviewer validates the expected head,
queue/marker labels, and the dispatcher's pending-status URL before
starting. Reviewer requests use non-cancelling PR concurrency; reruns wait for the
active review instead of interrupting it. Old publishers cannot replace a newer attempt's
pending/result status once ownership has changed.

The reviewer does not run directly on PR opens, pushes, or ready-for-review events.
Repeated Summarize Checks runs, pushes, and automatic queue-label re-additions do
not request another review of an already-requested head. After a push, a newly ready head
without semantic evidence can receive one automatic review. To explicitly review again,
remove and re-add `WaitForARMFeedback`, comment `/arm-review`, or manually dispatch
the reviewer with the PR number and no expected SHA. Existing authorization gates
remain in force. Explicit label/comment/manual requests bypass automatic per-head
deduplication; leave the compatibility marker in place when explicitly retrying.

A dispatch failure is logged, fails the job, and changes its own queued reservation
to an error if no reviewer has taken ownership. Current-head status evidence is retained
because a failed HTTP response may still have created a reviewer run. Use an explicit retry
after dispatch failure instead of automatically risking a duplicate. Review failures, cancellations,
and incomplete results require an explicit retry; they cannot create an AI loop.
If publishing pending fails, no workflow dispatch is attempted. If GitHub saved the status
despite the error, it still prevents automatic retries; cleanup changes it to an error only
while this dispatcher owns it. If no status was saved, a later summary may retry the handoff,
but no AI request has been sent by the failed attempt. Failure status descriptions point to
`/arm-review`. Before retrying, check the Actions page or reviewer status link
for a queued/running review: a timed-out dispatch may have been accepted.
If another review is needed, use `/arm-review`, remove and re-add
`WaitForARMFeedback`, or manually dispatch with the PR number and no `head_sha`.
Keep `ARMInitialReviewRequested` and current-head status evidence in place; rerunning
Summarize Checks is not a review retry once that evidence exists.
If a runner is lost after reserving but before dispatch, or activation rejects a
stale head, use an explicit retry. There is no atomic GitHub transaction spanning
status reservation, workflow dispatch, and label reads. Activation rejects a head or
reservation that is no longer current. A concurrent explicit request may supersede a
reservation, but a request between the final status read and write can still race with
reservation creation. These checks do not guarantee exactly-once dispatch against concurrent
explicit requests. GitHub concurrency keeps
only one pending run per group, so rapid requests may coalesce; the latest pending
request replaces an earlier pending request, not the running review.
Signoff still requires a passing review of the current head: a push does not reuse
an old approval.

Request costs: an ineligible dispatch uses one PR lookup and no status query. Existing
current-head evidence needs one PR lookup and one paginated current-status read, plus a marker
write only if missing. A new request uses two PR lookups and two paginated current-status
reads, optionally writes the marker, then writes pending and dispatches. There are no
per-SHA labels or workflow-history scans.
Failure cleanup reads status ownership before writing an error. Automatic activation
checks the queued reservation using current-head statuses, not workflow history.
Summary reuses PR labels from its live PR read
and rechecks the snapshot before label writes.

```text
summarize-checks               reconcile WaitForARMFeedback -> serialized per-head review dispatch
arm-api-review (reviewer)
  pre_activation               post status PENDING, upload one head-sha=<sha>;issue-number=<n> artifact
  agent                        review the PR, request record_arm_semantic_review
  record_arm_semantic_review   validate the result, post SUCCESS / FAILURE / ERROR
  conclusion                   if no result was posted, turn this run's PENDING into ERROR
                               explicitly dispatch Universal using trusted PR/SHA artifacts

arm-universal-auto-signoff     re-check the PR is open at the evaluated head, read labels and the
                               newest status per context on that SHA, decide the label actions
                               upload actions/correlation, explicitly dispatch Update Labels
update-labels                  apply Universal's label artifacts
                               (workflow_run route: Summarize Checks runs on completion;
                               dispatch route: explicitly dispatch Summarize Checks)
```

Update Labels applies Universal's label artifacts as-is. Universal re-evaluates on every relevant
change (push, review result, label), so a newer evaluation reconciles any label written from an
older one. GitHub does not support atomic compare-and-set for labels, so a short window where
labels reflect a slightly older evaluation is expected.

The explicit Reviewer -> Universal -> Update Labels handoffs do not depend on
GitHub delivering more `workflow_run` events after a long upstream chain. Both
dispatches use `GITHUB_TOKEN`, the trusted default branch, and minimal identity
inputs; no App credentials are needed. Existing completion/event triggers remain
fallbacks. Duplicate evaluations are expected and re-evaluate the current state.
The Update Labels dispatch validates that its source run is the trusted Universal
workflow (never a `pull_request` run), then reads its uploaded correlation and
label artifacts. The Universal run can still be finishing when the dispatched
consumer starts; all required artifacts are uploaded before dispatch.

Labels written with `GITHUB_TOKEN` fire no `labeled` events, and a run created by a dispatch does
not fire `workflow_run` consumers. So a dispatched Update Labels run dispatches Summarize Checks
itself, with only the PR number and evaluated head SHA, after applying the labels; this removes
`WaitForARMFeedback` once `ARMSignedOff` is present and refreshes the comment and merge status.
A `workflow_run`-route Update Labels run does not dispatch, because Summarize Checks already runs
on its completion.

Every explicit handoff is gated on the current run being a `workflow_dispatch` run (the reviewer
dispatching Universal, Universal dispatching Update Labels, Update Labels dispatching Summarize
Checks). Those are the runs `GITHUB_TOKEN` creates, so their completion fires no `workflow_run`
consumer. Runs from user events already chain through `workflow_run`, and dispatching there too
would evaluate and apply labels twice. A person manually dispatching a run can still get one
duplicate, which applies the same labels and is harmless. The Summarize Checks dispatch is its own job, so
only it holds `actions: write` in Update Labels.

Dispatch errors fail the handoff step, without changing a valid semantic result.
Retry a missed signoff evaluation by manually dispatching Universal with the
reviewed PR number and SHA, rather than re-running AI. Update Labels can be
manually dispatched with that Universal run's `source_run_id`. End-to-end fork
validation must demonstrate automatic review -> Universal -> approval labels
without an unrelated PR/check event; local tests do not establish GitHub's mixed
workflow-chain delivery behavior.

The reviewer never adds or removes signoff labels. Starting a re-review does not itself revoke
auto-signoff. Universal re-evaluates after trusted review finalization or another configured event;
if it evaluates while required statuses are pending or missing, it requests revocation.

The model proposes; trusted code validates and publishes. Any doubt ends as "not Passed".

## Signoff policy

```text
ARM Semantic Review passed for the current PR head
AND Swagger LintDiff and Swagger Avocado passed for the current PR head
AND ARMReview present, NotReadyForARMReview absent
AND no ARMChangesRequested, ARMManualSignoffRequired, or unapproved SuppressionReviewRequired
= add ARMSignedOff + ARMAutoSignedOff
```

Otherwise an automation-owned `ARMSignedOff` and its marker are removed.

## Ownership

| Labels                              | Owner      | Universal does                                          |
| ----------------------------------- | ---------- | ------------------------------------------------------- |
| `ARMSignedOff` + `ARMAutoSignedOff` | Automation | Keeps or revokes it on every evaluation                 |
| `ARMAutoSignedOff` only             | Automation | Re-adds `ARMSignedOff` if eligible, else cleans up      |
| `ARMSignedOff` + a legacy marker    | Automation | Replaces the marker with `ARMAutoSignedOff`, or revokes |
| `ARMSignedOff` without a marker     | Human      | Nothing (does not read statuses)                        |

Legacy markers are `ARMAutoSignedOff-IncrementalTSP` and `ARMAutoSignedOff-Trivial`, from the
retired workflow. They are always removed.

- **Take over an auto-signoff:** remove `ARMAutoSignedOff` and keep `ARMSignedOff`.
- **Revoke an auto-signoff:** add `ARMManualSignoffRequired`. (`ARMChangesRequested` does not
  work here: Summarize Checks removes it while `ARMSignedOff` is present.)
- Removing only `ARMSignedOff` is not a revocation: Universal re-adds it while the PR is eligible.

## Status contract

The automated-review cap is 50 non-example files or 5,000 added+deleted lines under
`specification/`. Files in an `examples` directory, including TypeSpec source examples and
compiled Swagger examples, do not consume either limit but remain in review scope.
A rename counts if either path is a non-example specification. GitHub's 3,000-file listing
cap still applies to all PR files because a truncated list cannot prove full coverage.

| State     | Description starts with    | Adds `ARMManualSignoffRequired`  |
| --------- | -------------------------- | -------------------------------- |
| `pending` | `ARM API semantic review`  | No                               |
| `success` | `Passed:`                  | No                               |
| `failure` | `Changes requested:`       | No                               |
| `error`   | `Manual review required: ` | Yes (scoped or oversized PR)     |
| `error`   | `Review incomplete: `      | No (transient, a re-run can fix) |

Only `success` can lead to signoff. A status is bound to its SHA, so a result for a commit that is
no longer the PR head is never read for the new head.

## Files

| File                                                                     | Role                                                                                              |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------- |
| [arm-semantic-review.ts](./arm-semantic-review.ts)                       | Pure policy: validate the result, map it to a status, read statuses                               |
| [arm-semantic-review-workflow.ts](./arm-semantic-review-workflow.ts)     | Publish the status; resolve an unpublished one                                                    |
| [arm-signoff-dispatch.ts](./arm-signoff-dispatch.ts)                     | Explicit reviewer-to-Universal and Universal-to-Update-Labels handoffs, validated dispatch inputs |
| [arm-universal-auto-signoff.ts](./arm-universal-auto-signoff.ts)         | Read statuses and labels, decide label actions                                                    |
| [arm-api-review.md](../../arm-api-review.md)                             | Reviewer workflow source (the `.lock.yml` is generated from it)                                   |
| [arm-universal-auto-signoff.yaml](../../arm-universal-auto-signoff.yaml) | Universal workflow                                                                                |
