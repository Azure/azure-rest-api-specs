# Label-Based Approval Pattern

A reusable pattern for gating PR merges on human approval via GitHub labels and a YAML-defined approver list.

## Overview

Instead of relying on email chains or manual triage, workflows can use this pattern to:

1. **Detect** something that needs approval (namespace change, breaking change, etc.)
2. **Apply** a `<prefix>-<scope>-pending` label
3. **Post** a bot comment with details and who can approve
4. **Gate** merge via a required status check
5. **Approve** by an authorized user applying a `<prefix>-<scope>-approved` label
6. **Reset** approval if the underlying change is modified after approval

## Components

### 1. Approver Configuration (YAML)

A YAML file in `.github/` defines who can approve what:

```yaml
# .github/<topic>-approvers.yml
<category>:
  global:           # fallback approvers for any scope
    - user1
  <scope-1>:
    - user2
    - user3
  <scope-2>:
    - user4
```

**Live example:** [`.github/namespace-approvers.yml`](../namespace-approvers.yml)

### 2. Labels

| Label pattern | Applied by | Meaning |
|---|---|---|
| `<prefix>-review-required` | Bot | PR has items needing approval |
| `<prefix>-<scope>-pending` | Bot | Specific item awaiting approval |
| `<prefix>-<scope>-approved` | Authorized human | Item approved |

Implementations may add convenience labels based on their needs (e.g., `<prefix>-approved-all` as a shortcut for approving everything at once).

### 3. Workflow Events (Recommended)

These event patterns are established in the [namespace approval workflow](../workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md) and recommended for any new adoption:

- **`pull_request` / `pull_request_target`** - detect changes, apply pending labels, post bot comment
- **`pull_request_target` (synchronize)** - re-detect on new commits, reset approvals only for changed items
- **`pull_request_target` (labeled/unlabeled)** - validate approval labels against the approver YAML

### 4. Security Model

- **Approver allowlist** - only users listed in the YAML can approve
- **Unauthorized label reversal** - if an unauthorized user adds an approval label, the bot removes it and posts a warning
- **Unauthorized removal guard** - if an unauthorized user removes a pending label, the bot re-applies it
- **Base branch config** - approver YAML is always read from the base branch (not the PR branch) to prevent self-approval via config changes

### 5. Status Check

A required status check blocks merge:

- Passes when all `*-pending` labels have matching `*-approved` labels
- Fails when any pending item lacks approval
- Skipped when the PR has no relevant changes

## Current Implementations

| Use case | Approver file | Process doc | PR |
|---|---|---|---|
| Namespace approval | [`namespace-approvers.yml`](../namespace-approvers.yml) | [NAMESPACE-REVIEW-PROCESS.md](../workflows/src/namespace-approval/NAMESPACE-REVIEW-PROCESS.md) | [#44085](https://github.com/Azure/azure-rest-api-specs/pull/44085) |

## Future Direction

The namespace approval workflow is the first implementation of this pattern. The approval, label management, and reset logic currently lives in the namespace-specific code:

- `validate-approval.js` - label authorization and approver checks
- `post-results.js` - bot comment posting, label application, reset detection

These have bindings to namespace-specific concepts (hardcoded label prefixes, namespace-specific comment markers). The target is to separate domain-specific detection from reusable approval machinery:

```
  ┌──────────────────────────────┐
  │   DETECTION (per use case)   │  Domain-specific, you write this
  │   "found items to approve"   │
  │   outputs: scopes + metadata │
  └──────────────┬───────────────┘
                 │
                 ▼
  ┌──────────────────────────────┐
  │   APPROVAL ENGINE (shared)   │  Write once, reuse
  │   - Apply pending labels     │
  │   - Post bot comment         │
  │   - Validate approver labels │
  │   - Reset changed items      │
  │   - Set status check         │
  └──────────────────────────────┘
                 │
                 ▲
  ┌──────────────┴───────────────┐
  │   CONFIG (per use case)      │
  │   - labelPrefix              │
  │   - approverFile path        │
  │   - checkName                │
  │   - commentMarker            │
  └──────────────────────────────┘
```

Each new use case would provide:

1. A **detection script** that outputs scopes and metadata (e.g., which languages changed, what namespaces were found)
2. An **approver YAML file** listing authorized users per scope
3. A **config block** telling the shared engine what label prefix, check name, and comment marker to use

The shared engine would handle all label lifecycle, authorization, reset, and status check logic identically across use cases, extracted into `.github/shared/src/label-approval/`.

When a second use case adopts this pattern, we refactor the namespace-specific code into shared helpers rather than duplicating it.

## Adopting This Pattern

To add a new approval gate:

1. Create `.github/<topic>-approvers.yml` with your approver list
2. Write a detection script that identifies what needs approval and outputs scopes
3. Wire up the shared approval engine (or use the namespace code as reference until the shared engine is extracted)
4. Register a required status check in branch protection settings
5. Document the process in a `<TOPIC>-REVIEW-PROCESS.md` alongside your workflow source
