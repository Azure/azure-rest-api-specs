# Backlog triage

[Backlog Triage](../.github/workflows/backlog-triage.md) investigates up to five
oldest eligible open issues every six hours. It acts automatically: evidence-backed
resolved, obsolete, or duplicate issues are closed with an explanation and an
invitation to reopen. When a specific fact from the reporter is needed, it posts
the question and adds `needs-author-feedback`.

## What qualifies for cleanup

| Outcome | Required basis | Action |
| --- | --- | --- |
| Resolved | The reported scope is satisfied by a merged fix, current source/consumer, or a concrete answer. | Explain the evidence and close as completed. |
| Obsolete | The exact feature, service, tool, or workflow is retired or superseded without remaining applicable scope. | Explain the evidence and close as not planned. |
| Duplicate | Another open issue preserves the same requirement. | Link the canonical issue and close as not planned. |
| Author feedback | A focused question the reporter can answer would establish applicability or unblock investigation. | Ask the question and add `needs-author-feedback`. |
| Keep open | An actionable defect, owner decision, or explicit dependency remains. | Record the next action in the run summary without a redundant public comment. |
| Blocked investigation | Required evidence is inaccessible or a tool failed. | Report the missing evidence and retry after 24 hours; do not close or ask the reporter to resolve our infrastructure problem. |

Age, silence, Swagger terminology, an unavailable historical CI log, or a changed
file path are not closure criteria. TypeSpec still generates OpenAPI; schema,
response-code, paging, compatibility, and generated-client defects can survive
migration. Conversely, an issue need not remain open for hypothetical old
consumers after its actual reported need is fixed.

The workflow distinguishes reporter questions from service-owner support/design
decisions. It does not put an internal owner decision into the author's timeout.
The existing [stale policy](../.github/policies/issues.stale.yml) handles feedback
reminders and inactivity closure: it marks waiting issues stale after seven days
of inactivity and closes stale issues after fourteen days of inactivity. The
triage workflow does not add `no-recent-activity` or introduce a second timer.

## Run and review

Use **Actions > Backlog Triage > Run workflow** on `main`:

- Leave `issue_number` empty to process the next oldest batch, or provide one
  issue number to revisit it.
- `dry_run` defaults to `true`: inspect the Actions summary and agent output
  without changing issues or progress.
- Set `dry_run` to `false` to apply the decisions. Scheduled runs apply them
  automatically.

Only maintainers with write access can dispatch it. Runs are restricted to
`Azure/azure-rest-api-specs` on `main`; adding the workflow to a fork or a PR
branch does not enable backlog mutations. It uses the same organization-billed
Copilot authentication as the API reviewers, a 30-minute agent timeout, and a
1,000-AI-credit per-run cap. It does not need a personal access token.

The trusted selection step also caches each issue's body, all comments, and
timeline events. The agent reads this evidence from the run artifact and
investigates sequentially without subagents. If the shared GitHub MCP becomes
unavailable, it stops retrying that service and records unresolved investigations
as blocked, without closing issues or asking authors to fix the tool failure.

Inspect the run's agent output for the decisions and evidence, and the application
job for actions and skipped/stale decisions. The source workflow is compiled with:

```bash
gh aw compile backlog-triage
```

Commit both the Markdown source and its generated `.lock.yml`. The initial lock
was compiled with `gh-aw` v0.88.7.

## Progress and safety

The agent has read-only GitHub tools. A separate safe-output job validates that
each decision belongs to the trusted batch, checks closure confidence/evidence,
and re-fetches issue activity before posting. Changes during investigation are
skipped, not acted on using stale context. There can be at most five affected
issues per run. Review the full discussion when reopening a mistaken closure;
the workflow will not automatically close it again.

The serialized workflow records successful outcomes on the dedicated orphan branch
`automation/backlog-triage`, in `state.json`. Only the trusted application step
writes this state; the agent cannot mark work complete before its requested action
succeeds. API and state-write failures fail the job visibly. The state branch must
permit the workflow's GitHub Actions token to create and update it.

The agent submits one checkpoint as soon as each issue is investigated, before
starting the next. These proposals are collected in the run artifacts even if
the agent later exhausts its budget or fails. The application job can process a
partial batch, but only after an explicit successful threat-detection verdict.
It still checks freshness and saves progress after each applied issue. Cancellation
or missing/failed detection prevents application; checkpointing does not bypass
those guards.

Checkpoint submission does not immediately post to GitHub: application happens
after the agent job ends. An issue without a submitted checkpoint remains eligible
for the next run, and a failed agent run remains failed even when earlier
checkpoints were recovered. Dry runs preview checkpoints without persisting progress.
The safe-output allowance matches the five-issue batch. If output collection
rejects a checkpoint, accepted checkpoints can still be applied, but the
application job reports failure instead of presenting the partial batch as a
clean run.

Unchanged keep-open issues are revisited after 90 days, or sooner when their
activity changes or a maintainer explicitly selects them. Blocked investigations
retry after 24 hours. Issues already awaiting feedback, marked stale, locked, or
labeled `skip-backlog-triage` are excluded. Maintainers can create and apply
`skip-backlog-triage` to opt out a tracker; no new labels are created automatically.
Existing service labels are preserved.

Public comments have a workflow marker to avoid duplicates when retrying a partial
failure. If an issue was reopened after an automatic closure, it stays with human
maintainers, including during manual dispatch. No report issues are created by the
triage logic.

This workflow adapts the oldest-first investigation pattern from
[Repo Assist](https://github.com/githubnext/agentics/blob/main/workflows/repo-assist.md)
and the batch processing approach in
[Daily Issue Triage](https://github.com/githubnext/agentics/blob/main/workflows/daily-issue-triage.md).
Unlike generic labeling templates, it investigates already-labeled issues and
checks current source, API versions, downstream consumers, and retirement evidence.
