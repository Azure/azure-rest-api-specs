# ARM Semantic Review and Universal Auto-Signoff

The ARM API Reviewer is an AI agent, so auto-signoff does not trust it directly. Its verdict is
turned into one commit status, `ARM Semantic Review`, on the reviewed SHA. Universal Auto-Signoff
reads that status alongside `Swagger LintDiff` and `Swagger Avocado`.

Universal is the production auto-signoff path. It owns `ARMSignedOff` only while the
`ARMAutoSignedOff` marker is present.

## Flow

```text
arm-api-review (reviewer)
  pre_activation               post status PENDING, upload one head-sha=<sha>;issue-number=<n> artifact
  agent                        review the PR, request record_arm_semantic_review
  record_arm_semantic_review   validate the result, post SUCCESS / FAILURE / ERROR
  conclusion                   if no result was posted, turn this run's PENDING into ERROR

arm-universal-auto-signoff     re-check the PR is open at the evaluated head, read labels and the
                               newest status per context on that SHA, decide the label actions
update-labels                  apply the label actions (then Summarize Checks runs)
```

The reviewer never adds or removes signoff labels. Starting a re-review does not itself revoke
auto-signoff. Universal re-evaluates when the review completes or another configured event occurs;
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

| File                                                                     | Role                                                                |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| [arm-semantic-review.ts](./arm-semantic-review.ts)                       | Pure policy: validate the result, map it to a status, read statuses |
| [arm-semantic-review-workflow.ts](./arm-semantic-review-workflow.ts)     | Publish the status; resolve an unpublished one                      |
| [arm-universal-auto-signoff.ts](./arm-universal-auto-signoff.ts)         | Read statuses and labels, decide label actions                      |
| [arm-api-review.md](../../arm-api-review.md)                             | Reviewer workflow source (the `.lock.yml` is generated from it)     |
| [arm-universal-auto-signoff.yaml](../../arm-universal-auto-signoff.yaml) | Universal workflow                                                  |
