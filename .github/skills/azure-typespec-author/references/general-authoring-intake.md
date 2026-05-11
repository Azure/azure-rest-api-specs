# Intake — General Authoring

> Step 1 (Analyze Project) must be complete. Do not re-collect those inputs.

### Step 2.1: Identify the Case

| Case | Name                    | Description                               | Service Type |
| ---- | ----------------------- | ----------------------------------------- | ------------ |
| 1    | Add Resource Type       | Define a new ARM resource with operations | ARM          |
| 2    | Add Resource Operations | Add CRUD or custom actions on a resource  | ARM          |

- **Match found** → collect case-specific inputs (Step 2.2).
- **No match** → skip to Step 3 using Step 1 analysis and the user's request.

### Step 2.2: Collect Inputs

**Case 1 — Add Resource Type (For ARM service only)**
Collect: target API version, resource name (PascalCase), hierarchy (top-level or nested + parent), properties (name, type, required/optional).

Defaults: top-level → `TrackedResource`, child → `ProxyResource`. Operations: `createOrReplace` (PUT/async), `get`, `update/patch`, `delete` (async), list by parent. Top-level adds list by subscription. Use `createOrReplace` (not `createOrUpdate`),

> MUST use `ArmCustomPatch` for PATCH `update/patch`.
> Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`.

**Case 2 — Add Resource Operations (For ARM service only)**  
Collect: target resource, operation type (CRUD or custom), operation name (custom actions), request/response models (custom actions).

Defaults: never async → GET, LIST, HEAD. Default async → PUT, DELETE. Default sync → PATCH. Always ask user → POST/action.

> Use `createOrReplace` templates (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.
> For POST async operation, make sure use ARM combined headers. ` LroHeaders = ArmCombinedLroHeaders<FinalResult = ExportResult>`.

### Step 2.3: Confirm

Display collected information and wait for user confirmation:

```
Case:              [Name]
Target Version:    [version]
Requested Changes: [summary]
Defaults:          [defaults guidelines]
```
