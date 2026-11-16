---
name: engineering-code-review
description: "Review engineering tooling and GitHub Actions changes for system design, correctness, and GitHub API request efficiency. Use for pull request reviews affecting eng/tools/**, eng/scripts/**, eng/pipelines/**, eng/README.md, .github/actions/**, .github/shared/**, or .github/workflows/**. Do not use for mirrored eng/common/** changes, API specification review, TypeSpec authoring, or SDK generation."
---

# Engineering Code Review

Use this procedure only for engineering changes in the paths above. In a mixed pull request,
review API specifications separately with their applicable instructions.
Skip deep review of mirrored `eng/common/**` updates; fixes belong upstream in `azure-sdk-tools`.
Read mirrored code only as needed to understand a repo-owned caller's integration.

## Establish the Design Context

Read the applicable standards instead of duplicating or inventing them:

- [Engineering guide](../../../eng/README.md) and the affected tool or shared package's README.
- [Engineering tools instructions](../../instructions/eng-tools.instructions.md) for tool changes.
- [GitHub Actions instructions](../../instructions/github-actions.instructions.md) for workflows,
  actions, and GitHub API consumers, especially the GitHub API efficiency standards.

Inspect existing callers and a comparable implementation. Identify which component owns each
decision, state transition, and side effect. Check whether the change reuses existing utilities and
preserves the established boundaries between tools, shared packages, and workflow orchestration.

## Trace the Complete Execution Path

Follow the affected entry point through its callers, helpers, and consumers. For Actions, include
event filters, jobs, composite actions, artifacts, and downstream `workflow_run` consumers.
Determine where PR numbers, head SHAs, run attempts, and results originate and how they are
validated before statuses, labels, or comments are changed.

Walk through normal execution, skipped work, retries or reruns, cancellation, and stale completion
where relevant. Check that producer and consumer contracts agree and that tests cover behavior
across those boundaries, not only isolated helper outputs.

## Account for GitHub API Calls

When a change affects GitHub API requests or their execution frequency, ordering, pagination,
or data reuse, build a request inventory from the code. Include indirect effects from callers
and workflow triggers, but skip inventories for unrelated edits such as log wording changes.
Record the endpoint, purpose, available payload or response data, pagination, and frequency.
Compare the before and after paths, including downstream jobs and repeated event triggers.

Separate fixed requests from costs that scale with pages, files, jobs, or retries. State assumptions
when estimating counts; do not present a single-page estimate as an upper bound. Distinguish HTTP
request counts from GraphQL rate-limit cost, and distinguish overlapping requests from reducing
their number.

Use that inventory to check the shared API efficiency standards. For each apparent duplicate,
determine whether it is redundant or an intentional freshness check before recommending reuse.
Identify where shared data could be passed between helpers or steps without weakening correctness.

For example, if one step fetches artifacts and then calls a helper that fetches the same completed
run's artifacts, trace whether the existing list can serve both consumers. In contrast, a live PR
read immediately before publishing may be necessary after a long-running review.

## Report Actionable Findings

Tie each finding to changed code, a concrete execution scenario, and its impact. For API-efficiency
findings, identify the avoidable requests and how often they occur, with a safe reuse or early-exit
approach. Distinguish new regressions from pre-existing costs.

Keep comments concise. Do not report speculative architecture preferences, unrelated existing
issues, or formatting already enforced by tooling. Check relevant tests and request targeted
regression coverage when the identified behavior or call-count reduction is not exercised.
