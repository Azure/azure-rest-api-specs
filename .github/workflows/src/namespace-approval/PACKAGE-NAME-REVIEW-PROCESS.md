# Package Name Approval Process

## Overview

When a service team adds or modifies SDK package name configuration in their `tspconfig.yaml`, the package name must be approved by authorized architects before the spec PR can merge. The goal is to prevent burning names on package manager systems (PyPI, Maven, npm, etc.).

A "package name" is the published identifier for a language SDK library, for example:

- .NET: `Azure.ResourceManager.Compute`
- Java: `azure-resourcemanager-compute`
- Python: `azure-mgmt-compute`
- TypeScript: `@azure/arm-compute`
- Go: `sdk/resourcemanager/compute/armcompute`
- Rust: `azure_compute`

In `tspconfig.yaml`, these values may appear under different option fields depending on the language emitter (`namespace`, `package-name`, `package-details.name`, `module`), but they all represent the package name that gets published.

This process is automated via GitHub Actions on this repository.

## How It Works

### Detection

When a PR modifies any `tspconfig.yaml` file, the analyze-code workflow:

1. Identifies which languages have package name configuration
2. Runs `tsp compile --emit @azure-tools/typespec-metadata` to extract package names and namespaces
3. Determines if the service is data-plane or management-plane (from the emitter metadata)
4. For management-plane PRs, validates package name format against language-specific naming rules (defined in `.github/package-name-format-rules.yml`)
5. Uploads results for the status workflow

### Status + Approval

The status workflow posts the package name review comment (showing both package name and namespace per language), applies `package-name-<lang>-pending` labels, and validates architect approval labels.

- **Data plane:** Each language architect approves their language by applying `package-name-<lang>-approved`
- **Management plane:** ArthurMa1978 or m-nash can apply `package-name-approved-all` to approve all languages at once

### Status Check

A required status check (`Package Name Approval`) blocks merge until all pending package names are approved. The check:

- Passes when all `package-name-*-pending` labels have corresponding `package-name-*-approved` labels
- Fails when any pending package name lacks approval
- Skipped when the PR doesn't modify tspconfig.yaml (no package name changes)

### Reset on Change

If a service team pushes a commit that changes package name configuration, only the **affected languages** are reset:

- Only languages whose package name actually changed have their `package-name-<lang>-approved` label removed
- Languages with unchanged package names keep their approval
- The `package-name-<lang>-pending` label is re-applied for reset languages
- The status check fails again until re-approved
- The bot comment names which specific languages were reset

### Next Steps to Merge Integration

Package name approval status also appears in the **Next Steps to Merge** comment. When `package-name-review-required` is present but `package-name-approved` is not, the NSTM comment shows a blocker with a link to the detailed package name review table.

## Labels

| Label                          | Applied by       | Meaning                                           |
| ------------------------------ | ---------------- | ------------------------------------------------- |
| `package-name-review-required` | Bot              | PR has package names that need architect approval |
| `package-name-<lang>-pending`  | Bot              | Package name detected, awaiting approval          |
| `package-name-<lang>-approved` | Architect        | Package name approved for this language           |
| `package-name-approved-all`    | Architect (mgmt) | Shortcut: approves all pending languages          |
| `package-name-approved`        | Bot              | All languages approved                            |
| `Mgmt`                         | Bot              | PR is management plane                            |
| `data-plane`                   | Bot              | PR is data plane                                  |

Where `<lang>` is one of: `dotnet`, `java`, `python`, `typescript`, `go`, `rust`

## Authorized Approvers

Defined in [`.github/protected-labels.yml`](../../../protected-labels.yml) (entries use plane-aware format):

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

## Package Name vs Namespace

Architects approve **package names** (what gets registered in package managers), not namespaces.

| Language   | Package Name Example                                      | Namespace Example                        |
| ---------- | --------------------------------------------------------- | ---------------------------------------- |
| .NET       | `Azure.ResourceManager.Compute`                           | `Azure.ResourceManager.Compute`          |
| Java       | `com.azure.resourcemanager:azure-resourcemanager-compute` | `com.azure.resourcemanager.compute`      |
| Python     | `azure-mgmt-compute`                                      | `azure.mgmt.compute`                     |
| TypeScript | `@azure/arm-compute`                                      | `@azure/arm-compute`                     |
| Go         | `sdk/resourcemanager/compute/armcompute`                  | `sdk/resourcemanager/compute/armcompute` |
| Rust       | `azure_resourcemanager_compute`                           | `azure_resourcemanager_compute`          |

The bot comment table shows both columns so architects can verify the package name they are approving.

## For Service Teams

No action needed beyond your normal workflow:

1. Add or modify package name configuration in your `tspconfig.yaml`
2. Open a PR as usual
3. The bot posts a status table and applies pending labels
4. Wait for architects to approve
5. Once approved, the status check passes and the PR can merge

## For Architects

1. Watch for PRs with `package-name-<lang>-pending` labels
2. Review the proposed package name in the PR diff
3. If acceptable, apply `package-name-<lang>-approved` label
4. For management plane PRs, you can use `package-name-approved-all` to approve all at once

## Configuration

To update approvers, submit a PR modifying `.github/protected-labels.yml`. Changes take effect immediately on merge.

## Format Validation

Package name format validation (regex-based naming rules from `.github/package-name-format-rules.yml`) only applies to **management-plane** package names. Data-plane packages follow language-specific conventions that vary too widely for centralized regex rules.

## Security Model

The approval workflow uses `pull_request_target` events, which grant write access to the repository. This is required because `pull_request` events from forks run with read-only permissions and cannot modify labels or commit statuses.

Mitigations:

- **Detection runs in read-only context:** The `pull_request` workflow (`package-name-approval-code.yaml`) checks out the PR and runs `tsp compile` to extract metadata. This workflow has read-only permissions and cannot modify labels or commit statuses.
- **Label/status changes use `pull_request_target` and `workflow_run`:** These workflows have write access but only read configuration files (approvers YAML, format rules) from the base branch, never execute PR code.
- **Unauthorized label reversal:** If an unauthorized user adds an approval label, the workflow removes it and posts a warning comment.
- **Unauthorized removal guard:** If an unauthorized user removes a pending label, the workflow re-applies it.
- **Approver allowlist:** Only users listed in `.github/protected-labels.yml` can approve package names.

## Relationship to API Review

Package name approval is **separate from API review**:

- **Package name approval** (this repo): gates spec PR merge, ensures library package naming is correct for package managers
- **API review** (azure-sdk repo): reviews API surface design (methods, models, parameters)

A new service typically needs package name approval first (on their spec PR), then API review later (when SDK is built).

## Package Name Extraction via typespec-metadata

The workflow uses the `@azure-tools/typespec-metadata` emitter to reliably extract package names
and namespaces from `tspconfig.yaml`. This avoids fragile static YAML parsing, since different
languages derive package names from different fields and some require template variable resolution.

### How it works

The workflow runs:

```
npx tsp compile <tspconfig-dir> --emit @azure-tools/typespec-metadata --output-dir <dir> --option @azure-tools/typespec-metadata.format=json
```

This produces `typespec-metadata.json` with the following structure:

```json
{
  "emitterVersion": "0.2.1",
  "generatedAt": "2025-01-01T00:00:00Z",
  "typespec": {
    "namespace": "Azure.ContainerService",
    "type": "management"
  },
  "languages": {
    "java": [{
      "emitterName": "@azure-tools/typespec-java",
      "packageName": "azure-resourcemanager-containerservice",
      "namespace": "com.azure.resourcemanager.containerservice"
    }],
    "typescript": [{
      "emitterName": "@azure-tools/typespec-ts",
      "packageName": "@azure/arm-containerservice",
      "namespace": "Azure.ContainerService"
    }],
    "python": [{
      "emitterName": "@azure-tools/typespec-python",
      "packageName": "azure-mgmt-containerservice",
      "namespace": "azure.mgmt.containerservice"
    }],
    "csharp": [{
      "emitterName": "@azure-typespec/http-client-csharp-mgmt",
      "packageName": "Azure.ResourceManager.ContainerService",
      "namespace": "Azure.ResourceManager.ContainerService"
    }],
    "go": [{
      "emitterName": "@azure-tools/typespec-go",
      "packageName": "sdk/resourcemanager/containerservice/armcontainerservice",
      "namespace": "armcontainerservice"
    }]
  }
}
```

### What is extracted per language

| Language | `packageName` (what architects approve) | `namespace` | Source in tspconfig |
|----------|----------------------------------------|-------------|---------------------|
| .NET | NuGet package ID (e.g., `Azure.ResourceManager.Compute`) | Same as package name | `namespace` option |
| Java | Maven artifact ID (e.g., `azure-resourcemanager-compute`) | Java namespace (e.g., `com.azure.resourcemanager.compute`) | `package-dir` or output dir |
| Python | PyPI package name (e.g., `azure-mgmt-compute`) | Python module path (e.g., `azure.mgmt.compute`) | Last segment of `emitter-output-dir` |
| TypeScript | npm package name (e.g., `@azure/arm-compute`) | TypeSpec namespace | `package-details.name` |
| Go | Module path (e.g., `sdk/resourcemanager/compute/armcompute`) | Go package name | Combination of `service-dir` + `emitter-output-dir` |
| Rust | Crate name (e.g., `azure_resourcemanager_compute`) | Rust module path | `emitter-output-dir` |

### Dual compile for change detection

To detect only **changed** package names (avoiding false positives when a PR touches a tspconfig
without changing package names), the workflow compiles both the PR head and the base branch:

1. PR head is checked out to the default working directory
2. Base branch is checked out to a separate path (`base-ref/`)
3. `tsp compile` runs on both, producing `typespec-metadata.json` for each
4. Results are compared by language key - only package names that differ are reported

If the base branch file doesn't exist (new TypeSpec) or compilation fails, all package names
from the PR head are treated as new and require approval.

### Language key normalization

The emitter uses language keys like `csharp`, `http-client-csharp`, `http-client-csharp-mgmt`
which are mapped to the workflow's label keys:

| Emitter key | Label key |
|-------------|-----------|
| `csharp` | `dotnet` |
| `http-client-csharp` | `dotnet` |
| `http-client-csharp-mgmt` | `dotnet` |
| `java` | `java` |
| `python` | `python` |
| `typescript` | `typescript` |
| `go` | `go` |
| `rust` | `rust` |

Multiple .NET emitters (e.g., mgmt + provisioning library) are valid. When multiple emitters
map to the same label key, the first entry is used for the approval check.
