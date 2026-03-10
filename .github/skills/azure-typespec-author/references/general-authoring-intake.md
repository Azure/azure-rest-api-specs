# Intake — General Authoring

> Step 1 (Analyze Project) must be complete. Do not re-collect those inputs.

### Step 2.1: Identify the Case

| Case | Name              | Description                                            | Service Type |
| ---- | ----------------- | ------------------------------------------------------ | ------------ |
| 1    | Add Resource Type | Define a new ARM resource with operations              | ARM          |
| 2    | Add Operations    | Add CRUD or custom actions on a resource               | ARM          |
| 3    | Add LRO           | Add or configure an async/long-running operation       | ARM          |
| 4    | Add Patch         | Add a PATCH/update operation                           | ARM          |
| 5    | Add Paging        | Add or configure pagination on list operations         | ARM          |

- **Match found** → collect case-specific inputs (Step 2.2).
- **No match** → skip to Step 3 using Step 1 analysis and the user's request.

### Step 2.2: Collect Inputs

**Case 1 — Add Resource Type**
Collect: target API version, resource name (PascalCase), hierarchy (top-level or nested + parent), properties (name, type, required/optional).
Defaults: top-level → `TrackedResource`, child → `ProxyResource`. Operations: `createOrReplace` (PUT/async), `get`, `update/patch`, `delete` (async), list by parent. Top-level adds list by subscription. Use `createOrReplace` (not `createOrUpdate`), `ArmCustomPatch` for PATCH.

> Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`.

**Case 2 — Add Operations**
Collect: target resource, operation type (CRUD or custom), operation name (custom actions), request/response models (custom actions).
Defaults: never async → GET, LIST, HEAD. Default async → PUT, DELETE. Default sync → PATCH. Always ask user → POST/action.

> Use `createOrReplace` templates (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.

**Case 3 — Add LRO**
Collect: target resource/operation, LRO template (e.g., `ArmResourceCreateOrReplaceAsync`), final state polling (if non-standard).

> PUT and DELETE default to async. GET, LIST, HEAD can never be async.

**Case 4 — Add Patch**
Collect: target resource, patchable properties.

> Use `ArmCustomPatch` with updatable properties from the resource and its `properties` bag. PATCH defaults to sync.

**Case 5 — Add Paging**
Collect: target list operation(s), paging type (default ARM or custom).

> ARM list operations (`ArmResourceListByParent`, `ArmListBySubscription`) include paging by default.

### Step 2.3: Confirm

Display collected information and wait for user confirmation:

```
Case:              [Name]
Target Version:    [version]
Requested Changes: [summary]
```

