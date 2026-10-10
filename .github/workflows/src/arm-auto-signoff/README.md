# ARM Semantic Review and Universal Auto-Signoff

The ARM API Reviewer is an AI agent, so auto-signoff does not trust it directly. Its verdict is
turned into one commit status, `ARM Semantic Review`, on the reviewed SHA. Universal Auto-Signoff
reads that status alongside `Swagger LintDiff` and `Swagger Avocado`.

Universal runs in parallel with the legacy ARM Auto SignOff workflows, which remain the
production path. It only manages the pilot label `ARMAutoSignedOff-Test` and never changes
`ARMSignedOff`.

## Flow

```text
arm-api-review (reviewer)
  pre_activation               post status PENDING, upload one head-sha=<sha>;issue-number=<n> artifact
  agent                        review the PR, request record_arm_semantic_review
  record_arm_semantic_review   validate the result, post SUCCESS / FAILURE / ERROR
  conclusion                   if no result was posted, turn this run's PENDING into ERROR

arm-universal-auto-signoff     re-check the PR is open at the evaluated head, read the newest status
                               per context on that SHA + labels, decide the label action
update-labels                  add or remove the label
```

The model proposes; trusted code validates and publishes. Any doubt ends as "not Passed".

## Signoff policy

```text
ARM Semantic Review passed for the current PR head
AND Swagger LintDiff and Swagger Avocado passed for the current PR head
AND labels and approvals allow signoff
= add ARMAutoSignedOff-Test
```

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

The design rationale, validation rules, invariants, edge cases, and debugging steps are in the
[arm-semantic-review skill](../../../skills/arm-semantic-review/SKILL.md).
