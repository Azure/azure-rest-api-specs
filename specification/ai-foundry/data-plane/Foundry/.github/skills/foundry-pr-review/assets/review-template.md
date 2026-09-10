# Foundry PR #{{PR_NUMBER}} review

> Status: DRAFT - not published

| Field | Value |
| --- | --- |
| PR | [{{PR_TITLE}}]({{PR_URL}}) |
| Author | `{{PR_AUTHOR}}` |
| Base | `{{BASE_BRANCH}}` |
| Head | `{{HEAD_BRANCH}}` at `{{HEAD_SHA}}` |
| Reviewed at | `{{REVIEWED_AT_UTC}}` |
| Foundry files | {{FOUNDRY_FILE_COUNT}} |

## Recommendation

`{{APPROVE_OR_COMMENT_OR_REQUEST_CHANGES}}`

{{ONE_OR_TWO_SENTENCE_REVIEW_SUMMARY}}

## Candidate Comments

<!-- Repeat this section for each inline comment. If there are none, replace it with "No publishable findings." -->

### 1. `{{FILE_PATH}}:{{RIGHT_SIDE_LINE}}`

- Priority: `{{BLOCKING_OR_NON_BLOCKING}}`
- Side: `RIGHT`
- Commit: `{{HEAD_SHA}}`

> {{COMMENT_BODY}}

## PR-Level Comment

<!-- Use only when a finding cannot be accurately anchored to a changed line. Otherwise write "None." -->

> {{PR_LEVEL_COMMENT_OR_NONE}}

## Evidence

- Status checks: {{STATUS_CHECK_SUMMARY}}
- Generated artifacts: {{GENERATED_ARTIFACT_SUMMARY}}
- Validation not run: {{VALIDATION_NOT_RUN}}

## Reviewer Notes

<!-- Keep uncertain or non-publishable observations here. These are never copied into the GitHub review. -->

{{REVIEWER_NOTES_OR_NONE}}

## Manual Confirmation

- [ ] The PR number and head SHA still match GitHub.
- [ ] Each candidate comment is accurate, concise, and correctly anchored.
- [ ] The recommendation and PR-level comment are approved.
- [ ] Publication is explicitly authorized in a separate request.
