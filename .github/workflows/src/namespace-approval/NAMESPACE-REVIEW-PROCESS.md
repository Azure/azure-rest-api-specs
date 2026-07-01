# Namespace Approval Process

## Overview

When a service team adds or modifies SDK namespace configuration in their `tspconfig.yaml`, the namespace must be approved by authorized architects before the spec PR can merge.

This process is automated via GitHub Actions on this repository.

## How It Works

### Detection

When a PR modifies any `tspconfig.yaml` file, the analyze-code workflow:

1. Identifies which languages have namespace/package-name configuration
2. Extracts namespaces by parsing `tspconfig.yaml` emitter options directly
3. Determines if the service is data-plane or management-plane (via path and linter config)
4. For management-plane PRs, validates namespace format against language-specific naming rules (defined in `.github/namespace-format-rules.yml`)
5. Uploads namespace results for the status workflow

### Status + Approval

The status workflow posts the namespace review comment, applies `<lang>-namespace-pending` labels, and validates architect approval labels.

- **Data plane:** Each language architect approves their language by applying `<lang>-namespace-approved`
- **Management plane:** ArthurMa1978 or m-nash can apply `namespace-approved-all` to approve all languages at once

### Status Check

A required status check (`Namespace Approval`) blocks merge until all pending namespaces are approved. The check:

- ✅ Passes when all `*-namespace-pending` labels have corresponding `*-namespace-approved` labels
- ❌ Fails when any pending namespace lacks approval
- ⏭️ Skipped when the PR doesn't modify tspconfig.yaml (no namespace changes)

### Reset on Change

If a service team pushes a commit that changes namespace configuration, only the **affected languages** are reset:

- Only languages whose namespace actually changed have their `<lang>-namespace-approved` label removed
- Languages with unchanged namespaces keep their approval
- The `<lang>-namespace-pending` label is re-applied for reset languages
- The status check fails again until re-approved
- The bot comment names which specific languages were reset

## Labels

| Label                        | Applied by       | Meaning                                       |
| ---------------------------- | ---------------- | --------------------------------------------- |
| `namespace-review-required`  | Bot              | PR has namespaces that need architect approval |
| `<lang>-namespace-pending`   | Bot              | Namespace detected, awaiting approval          |
| `<lang>-namespace-approved`  | Architect        | Namespace approved for this language           |
| `namespace-approved-all`     | Architect (mgmt) | Shortcut: approves all pending languages       |
| `namespace-approved`         | Bot              | All languages approved                         |
| `Mgmt`                       | Bot              | PR is management plane                         |
| `data-plane`                 | Bot              | PR is data plane                               |

Where `<lang>` is one of: `dotnet`, `java`, `python`, `typescript`, `go`, `rust`

## Authorized Approvers

Defined in [`.github/namespace-approvers.yml`](../../../namespace-approvers.yml):

<!-- cspell:disable -->

| Scope                | Approvers                     |
| -------------------- | ----------------------------- |
| .NET                 | @jsquire, @m-nash             |
| Java                 | @JonathanGiles, @alzimmermsft |
| Python               | @xirzec, @kashifkhan          |
| TypeScript           | @xirzec, @maorleger           |
| Go                   | @jhendrixMSFT                 |
| Mgmt (all languages) | @ArthurMa1978, @m-nash        |

<!-- cspell:enable -->

## For Service Teams

No action needed beyond your normal workflow:

1. Add or modify namespace in your `tspconfig.yaml`
2. Open a PR as usual
3. The bot posts a status table and applies pending labels
4. Wait for architects to approve
5. Once approved, the status check passes and the PR can merge

## For Architects

1. Watch for PRs with `<lang>-namespace-pending` labels
2. Review the proposed namespace in the PR diff
3. If acceptable, apply `<lang>-namespace-approved` label
4. For management plane PRs, you can use `namespace-approved-all` to approve all at once

## Configuration

To update approvers, submit a PR modifying `.github/namespace-approvers.yml`. Changes take effect immediately on merge.

## Relationship to API Review

Namespace approval is **separate from API review**:

- **Namespace approval** (this repo): gates spec PR merge, ensures library naming is correct
- **API review** (azure-sdk repo): reviews API surface design (methods, models, parameters)

A new service typically needs namespace approval first (on their spec PR), then API review later (when SDK is built).
