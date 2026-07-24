# Protected Labels

A system that enforces "only authorized people can apply this label."

## How it works

1. A YAML config file maps labels to authorized GitHub handles
2. A single workflow watches for `labeled` events
3. If an unauthorized user applies a protected label, the bot removes it
4. Supports plane-aware policies: different approvers for management-plane vs data-plane PRs

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
# is management-plane (has Mgmt/resource-manager label) or data-plane
namespace-dotnet-approved:
  management-plane:
    - user1
    - user2
  data-plane:
    - user3
    - user4
```

Values are GitHub handles (case-insensitive). Plane detection uses PR labels explicitly:

- `Mgmt` or `resource-manager` → management-plane
- `data-plane` → data-plane
- Neither → plane-aware labels are not enforced (no action taken)

## Security Model

- **Approver allowlist** - only users listed in the YAML can apply protected labels
- **Unauthorized label reversal** - if an unauthorized user applies a protected label, the bot removes it and posts a warning
- **Base branch config** - the YAML is always read from the base branch (not the PR branch) to prevent self-authorization via config changes

## Adopting

1. Add your labels and authorized users to `.github/protected-labels.yml`
2. Done - the shared workflow handles enforcement
