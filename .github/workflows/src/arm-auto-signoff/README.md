# ARM Semantic Review and Universal Auto-Signoff

The ARM API Reviewer is an AI agent, so auto-signoff does not trust it directly. Its verdict is
turned into one commit status, `ARM Semantic Review`, on the reviewed SHA. Universal Auto-Signoff
reads that status alongside `Swagger LintDiff` and `Swagger Avocado`.

Universal is the production auto-signoff path. The incremental TypeSpec and trivial-change
analyzers still run and maintain their diagnostic labels, but cannot grant or revoke
`ARMSignedOff`. Their markers are not approval evidence. Old approval artifacts from those
workflows are ignored by Update Labels.

## Flow

```text
summarize-checks              reconcile readiness / WaitForARMFeedback using current-head impact
  dispatch-arm-review        re-read live PR; reserve ARM Semantic Review PENDING; workflow_dispatch
arm-api-review (reviewer)
  pre_activation               post status PENDING, upload one head-sha=<sha>;issue-number=<n> artifact
                               dispatch universal to revoke earlier automatic approval on a rerun
  agent                        review the PR, request record_arm_semantic_review
  record_arm_semantic_review   validate the result, post SUCCESS / FAILURE / ERROR
  conclusion                   if no result was posted, turn this run's PENDING into ERROR

arm-universal-auto-signoff     workflow_run after reviewer / deterministic checks
                               revalidate and publish ARMSignedOff + ARMAutoSignedOff directly
summarize-checks               reconcile the resulting queue state; do not repeat a completed review
```

The explicit dispatch works for labels written by `GITHUB_TOKEN` and resets the `workflow_run`
chain, including summary paths already three levels deep. A PR-scoped, non-cancelling dispatch
job and the existing head-bound pending status prevent duplicate automatic requests. Existing
pending/results are reused; a passing review can explicitly dispatch universal re-evaluation
after readiness changes, without running the agent again. No-op dispatch runs publish no
correlation artifacts, so summary/re-evaluation does not loop.

Maintainers can still use `/arm-review` or manually dispatch the reviewer. Dispatches from
summary carry the expected head SHA; stale dispatches fail before the agent starts. Failed,
cancelled, or incomplete reviews require an explicit retry, not an automatic review loop.
A failed dispatch is reported and a later summary can retry it. If activation fails before it
publishes its own pending status, use a manual reviewer retry to replace the queued status.

The model proposes; trusted code validates and publishes. Any doubt ends as "not Passed".

## Signoff policy

```text
ARM Semantic Review passed for the current PR head
AND Swagger LintDiff and Swagger Avocado passed for the current PR head
AND labels and approvals allow signoff
= add ARMSignedOff + ARMAutoSignedOff (automation ownership marker)
```

The policy honors draft/skip rules, changes-requested and manual-review holds, versioning and
breaking-change approvals, RPaaS exceptions, suppressions, and modeling review requirements.
Modeling lease approvals are unchanged: `ARMModelingAutoSignedOff` does not itself grant API
signoff or override `ARMModelingReviewRequired`.

Unattended clean reviews no longer clear `ARMChangesRequested`; a human must clear that hold.
The reviewer's label safe outputs cannot grant signoff or remove that decision. Universal
preserves manual `ARMSignedOff`, even if an old automation marker remains, by checking the latest
signoff label event before revoking automatic approval. Existing pilot labels are not approvals.

## Status contract

| State     | Description starts with    | Adds `ARMManualSignoffRequired`  |
| --------- | -------------------------- | -------------------------------- |
| `pending` | `ARM API semantic review`  | No                               |
| `success` | `Passed:`                  | No                               |
| `failure` | `Changes requested:`       | No                               |
| `error`   | `Manual review required: ` | Yes (scoped or oversized PR)     |
| `error`   | `Review incomplete: `      | No (transient, a re-run can fix) |

Only the exact validated full-review `success` result can lead to signoff. Its URL must identify
the successful, completed reviewer run's current attempt, with matching trusted PR/head
artifacts. A newer same-PR run (including one still queued without artifacts) supersedes older
results. Publishers cannot overwrite another attempt's pending status.

Universal evaluates again at publication and checks the live PR head immediately before writing.
After adding approval it repeats the full head, policy, status, and reviewer freshness validation.
If a competing run already finished before the stale write, this same publisher compensates by
removing bot-owned approval, even if a diagnostic updater removed its marker. A human's newer
signoff event is preserved. Compensation is direct, not a reconciliation dispatch that can fail
after the write. Verification errors also attempt compensation and fail the run; compensation
errors are surfaced, never reported as success. Correlation outputs are recorded before verification
so existing completion handling can also observe a partially failed publication.

There is no delayed approval artifact or dependency on an unrelated later event for this
post-write guard. GitHub still has no atomic conditional label write: a human can change ownership
between the compensation ownership read and deletion, and process termination or unavailable APIs
can prevent compensation. Those are not claimed to be solved by a lifecycle lock or durable
protocol. Runs that fail before their pending status is established may need an explicit maintainer
retry. Deploy the workflow source and generated lock together in both specs repositories before
enabling this path.

## Files

| File                                                                     | Role                                                                |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| [arm-semantic-review.ts](./arm-semantic-review.ts)                       | Pure policy: validate the result, map it to a status, read statuses |
| [arm-semantic-review-workflow.ts](./arm-semantic-review-workflow.ts)     | Publish the status; resolve an unpublished one                      |
| [arm-universal-auto-signoff.ts](./arm-universal-auto-signoff.ts)         | Read statuses and labels, decide label actions                      |
| [arm-review-dispatch.ts](./arm-review-dispatch.ts)                       | Explicit summary-to-reviewer handoff                                |
| [arm-review-run.ts](./arm-review-run.ts)                                 | Existing run/attempt/artifact freshness checks                      |
| [arm-review-policy.ts](./arm-review-policy.ts)                           | Shared readiness/policy holds                                       |
| [arm-api-review.md](../../arm-api-review.md)                             | Reviewer workflow source (the `.lock.yml` is generated from it)     |
| [arm-universal-auto-signoff.yaml](../../arm-universal-auto-signoff.yaml) | Universal workflow                                                  |
