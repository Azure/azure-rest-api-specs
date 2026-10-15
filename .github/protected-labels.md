# Protected Labels

Protected labels can be applied only by their configured approvers.

## How it works

1. `.github/protected-labels.yml` maps labels to authorized GitHub users or teams.
2. The Azure SDK Automation App handles `pull_request.labeled` events for PRs targeting `main`.
3. The App reads policy from the PR's immutable base commit.
4. If an unauthorized user applies a protected label, the App removes it and posts a warning.

Warning comments mention the unauthorized actor and direct them to the **Next Steps to Merge**
comment and the [review and merge process](https://aka.ms/azsdk/specreview/merge).
Authorized users appear in a collapsed **See allowed approvers** section without `@mentions`.

## Configuration

```yaml
# .github/protected-labels.yml

# Global approvers can apply ANY protected label
global-approvers:
  - user1
  - user2

# Simple list: these users can apply this label on any PR
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
# is open to anyone (the label is never removed on management-plane PRs).
typespec-suppressions-approved:
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
- Neither → plane-aware labels are not enforced (no action taken)

A plane may be set to the literal `unprotected` instead of a list, which opts that
plane out of enforcement (anyone may apply the label). An **omitted** plane stays
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

## Security Model

- **Approver allowlist** - only users listed in the YAML can apply protected labels
- **Unauthorized label reversal** - if an unauthorized user applies a protected label, the bot removes it and posts a warning
- **Base branch config** - the YAML is always read from the base branch (not the PR branch) to prevent self-authorization via config changes

## Adopting

Add the label and its authorized users or teams to `.github/protected-labels.yml`. The
Automation App handles enforcement without a repository workflow.
