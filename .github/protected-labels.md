# Protected Labels

Protected labels can be added or removed only by their configured approvers.

## How it works

1. `.github/protected-labels.yml` maps labels to authorized GitHub users or teams.
2. The Azure SDK Automation App handles `pull_request.labeled` and `pull_request.unlabeled` events for PRs targeting `main`.
3. The App reads policy from the PR's immutable base commit.
4. If an unauthorized user applies a protected label, the App removes it and posts a warning.
5. If an unauthorized user removes a protected label, the App restores it and updates its warning comment.

Warning comments mention the unauthorized actor and direct them to the **Next Steps to Merge**
comment and the [review and merge process](https://aka.ms/azsdk/specreview/merge).
Warnings for unauthorized additions list label approvers in a collapsed **See allowed approvers**
section without `@mentions`.

## Configuration

```yaml
# .github/protected-labels.yml

# Global approvers can add or remove ANY protected label
global-approvers:
  - user1
  - user2

# Simple list: these users can add or remove this label on any PR
some-approval-label:
  - user1
  - user2

# Plane-aware: different approvers depending on whether the PR
# is management-plane (has resource-manager label) or data-plane
package-name-dotnet-approved:
  management-plane:
    - user1
    - user2
  data-plane:
    - user3
    - user4

# Per-plane opt-out: gate one plane and leave the other open.
# Here data-plane is restricted to its approvers while management-plane
# is open to anyone (the App does not reverse changes on management-plane PRs).
some-plane-approved-label:
  data-plane:
    - user3
  management-plane: unprotected

# Team alias with explicit exceptions
some-team-approved-label:
  team: azure-sdk-team
  users:
    - user-outside-team
```

User values are GitHub handles and are matched case-insensitively. A team policy may use
`team`, `teams`, and optional `users`, either for the complete label or within a plane.
Team names are Azure organization team slugs, and membership is resolved live by the App.

Plane detection uses PR labels explicitly:

- `resource-manager` → management-plane
- `data-plane` → data-plane
- Neither → plane-aware additions are not enforced; removals require a global
  approver or trusted automation

A plane may be set to the literal `unprotected` instead of a list, which opts that
plane out of enforcement (anyone may add or remove the label). An **omitted** plane stays
fail-closed and resolves to `global-approvers` only; only the explicit `unprotected`
keyword opens a plane.

Package-name approval remains Actions-hosted and supports only login lists, plane-aware login
lists, and `unprotected`. Team policy on a `package-name-*-approved` key is rejected until
package-name approval moves to the App.

When several labels share one policy, define it once with a YAML anchor:

```yaml
BreakingChange-Go-Sdk-Approved: &sdk-breaking-change-approvers
  team: azure-sdk-team
  users:
    - user-outside-team
BreakingChange-Go-Sdk-Suppression-Approved: *sdk-breaking-change-approvers
BreakingChange-Python-Sdk-Approved: *sdk-breaking-change-approvers
```

## ARM review labels

On management-plane PRs, members of `arm-api-reviewers` may apply `ARMSignedOff`,
`Approved-Suppression`, `Approved-LintDiff`, and `typespec-suppressions-approved`.
Existing global approvers remain authorized.

Members of any of `arm-api-reviewers`, `azure-sdk-team`, or `azure-arm-sdk-reviewers`
may apply `Approved-ModelValidation`, `Approved-Avocado`, and
`Approved-SemanticValidation` on management-plane PRs.

Members of `arm-breaking-change-reviewers` may apply the configured
`BreakingChange-Approved-` and `Versioning-Approved-` labels on both management-plane
and data-plane PRs. These policies are not plane-scoped.
Each label is listed explicitly in the configuration; new approval labels must be
added individually, not as wildcard patterns.

The ARM signoff, suppression, and validation policies leave data-plane behavior unchanged.
`typespec-suppressions-approved` retains its existing `azure-data-plane-api-reviewers`
policy on data-plane PRs; the other ARM policies explicitly opt data-plane PRs out.
`WaitForARMFeedback` and `ARMChangesRequested` remain unprotected.

The same approval policies protect both label additions and removals.

## Removal protection

Every configured label is protected against unauthorized removal using its existing
team aliases or users, plus global approvers and trusted automation. There is no
separate removal list. Plane-specific approvers and `unprotected` values apply to
both operations. Labels absent from the file remain unprotected.

Package-name label removal stays with its existing GitHub Actions workflow,
which already restores unauthorized removals. The App skips those removal events.

## Security Model

- **Approver allowlist** - only configured users or team members, global approvers, and trusted automation can add or remove protected labels
- **Unauthorized label reversal** - if an unauthorized user applies a protected label, the bot removes it and posts a warning
- **Removal protection** - the bot restores configured labels removed by unauthorized actors
- **Base branch config** - the YAML is always read from the base branch (not the PR branch) to prevent self-authorization via config changes

## Adopting

Add the label and its authorized users or teams to `.github/protected-labels.yml`. The
Automation App handles enforcement without a repository workflow.
