# Protected Labels

A system that enforces "only authorized people can apply this label."

## How it works

1. A YAML config file maps labels to authorized GitHub handles
2. A single workflow watches for `labeled` events
3. If an unauthorized user applies a protected label, the bot removes it
4. Supports plane-aware policies: different approvers for management-plane vs data-plane PRs

Warning comments mention the unauthorized actor and direct them to the **Next Steps to Merge**
comment and the [review and merge process](https://aka.ms/azsdk/specreview/merge).
Authorized approvers' GitHub profile links are kept in a
collapsed **See allowed approvers** section without `@mentions`.

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
```

Values are GitHub handles (case-insensitive). Plane detection uses PR labels explicitly:

- `resource-manager` → management-plane
- `data-plane` → data-plane
- Neither → plane-aware labels are not enforced (no action taken)

A plane may be set to the literal `unprotected` instead of a list, which opts that
plane out of enforcement (anyone may apply the label). An **omitted** plane stays
fail-closed and resolves to `global-approvers` only; only the explicit `unprotected`
keyword opens a plane.

## Security Model

- **Approver allowlist** - only users listed in the YAML can apply protected labels
- **Unauthorized label reversal** - if an unauthorized user applies a protected label, the bot removes it and posts a warning
- **Base branch config** - the YAML is always read from the base branch (not the PR branch) to prevent self-authorization via config changes

## Adopting

1. Add your labels and authorized users to `.github/protected-labels.yml`
2. Done - the shared workflow handles enforcement
