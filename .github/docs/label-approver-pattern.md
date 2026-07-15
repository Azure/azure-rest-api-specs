# Protected Labels

A system that enforces "only authorized people can apply this label."

## How it works

1. A YAML config file maps labels to authorized users
2. A single workflow watches for `labeled` events
3. If an unauthorized user applies a protected label, the bot removes it

## Configuration

```yaml
# .github/protected-labels.yml
BreakingChange-Approved-Benign:
  - ArthurMa1978
  - m-nash
BreakingChange-Approved-BugFix:
  - ArthurMa1978
  - m-nash
Versioning-Approved-Benign:
  - ArthurMa1978
  - m-nash
Versioning-Approved-BugFix:
  - ArthurMa1978
  - m-nash
Approved-OkToMerge:
  - ArthurMa1978
  - m-nash
```

## Behavior

- Someone applies `BreakingChange-Approved-Benign` on a PR
- Workflow checks: is this person in the authorized list?
- Yes: label stays
- No: label removed, bot comments "only @ArthurMa1978 and @m-nash can apply this label"

## Security Model

- **Approver allowlist** - only users listed in the YAML can apply protected labels
- **Unauthorized label reversal** - if an unauthorized user applies a protected label, the bot removes it and posts a warning
- **Base branch config** - the YAML is always read from the base branch (not the PR branch) to prevent self-authorization via config changes

## Integration with existing workflows

This is designed as a reusable primitive. Workflows that need label-based approval (like [namespace approval](../workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md)) can call this as a sub-routine for their authorization check, rather than implementing their own label enforcement logic.

## Adopting

1. Add your labels and authorized users to `.github/protected-labels.yml`
2. Done - the shared workflow handles enforcement
