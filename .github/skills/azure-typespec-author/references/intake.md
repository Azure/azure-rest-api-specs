# Intake

> Prerequisite: Step 1 (Analyze Project) must be complete.

## 2.1 General Intake (All Cases)

1. Run [agentic search](agentic-search.md) using the Step 1 result and the user's request.
2. Identify the case from the table below and gather more information if case matches. If no case matches, skip Step 2.2.

| Case | Name                       | Description                                            | Service Type     |
| ---- | -------------------------- | ------------------------------------------------------ | ---------------- |
| 1    | Add ARM Resource Type      | Define a new ARM resource with operations              | ARM              |
| 2    | Add ARM Resource Operation | Add CRUD or custom actions on an existing resource     | ARM              |
| 3    | API Versioning             | Add, bump, or promote an API version (preview/stable)  | ARM / Data-plane |
| 4    | Add Data-Plane Operations  | Add CRUD or custom operations on a data-plane resource | Data-plane       |

---

## 2.2 Case-Specific Intake

### Case 1 — Add ARM Resource Type

Collect: target API version, resource name (PascalCase), hierarchy (top-level or nested + parent), properties (name, type, required/optional).

Defaults: top-level → `TrackedResource`, child → `ProxyResource`. Operations: `createOrReplace` (PUT/async), `get`, `update/patch`, `delete` (async), list by parent. Top-level adds list by subscription.

> Use `createOrReplace` (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.
> Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`.

### Case 2 — Add ARM Resource Operation

Collect: target resource, operation type (CRUD or custom), operation name (custom actions), request/response models (custom actions).

Defaults: never async → GET, LIST, HEAD. Default async → PUT, DELETE. Default sync → PATCH. Always ask user → POST/action.

> Use `createOrReplace` (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.
> For async POST, use ARM combined headers: `LroHeaders = ArmCombinedLroHeaders<FinalResult = ExportResult>`.

### Case 3 — API Versioning

Collect from user:

1. **Target version** (e.g. `2026-01-01-preview` or `2026-01-01`)
2. **Features to exclude, Do not assume the user wants to carry over all features** — follow this procedure exactly:
   1. Read the latest version's `.tsp` files and enumerate all resources, operations, models, and properties.
   2. Present the list to the user as a numbered checklist.
   3. Ask: _"All features will be carried over to the new version. Are there any you want to exclude? List by number, or say 'none'."_
   4. Wait for the user's response before proceeding.

---

> This case applies to both ARM and data-plane services. The same versioning decorators (`@added`, `@removed`, `@renamedFrom`, `@typeChangedFrom`) apply regardless of service type.

### Case 4 — Add Data-Plane Operations

Collect: target resource, operation type (CRUD, list, or custom action), operation name.

> Data-plane services use `Azure.Core` (not `Azure.ResourceManager`). No `@armProviderNamespace` decorator.
> All operations, models, enums/unions, and properties should have `/** */` documentation.
> For async operations (long-running), refer to the [Deep Dive: Long-running (Asynchronous) Operations](https://azure.github.io/typespec-azure/docs/howtos/azure-core/long-running-operations/) documentation

---

## 2.3 Confirm

Display and wait for user confirmation:

```
Case:           [Name]
Target Version: [version]
Changes:        [summary]
Defaults:       [applied defaults]
```
