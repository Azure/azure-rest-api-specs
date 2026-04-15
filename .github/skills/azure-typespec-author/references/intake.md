# Intake

> Prerequisite: Step 1 (Analyze Project) must be complete.

## General Intake (All Cases)

1. Read [reference-document-links.md](reference-document-links.md) and select URLs relevant to the user's request and Step 1 results. If unsure, select all.
2. Run [agentic search](agentic-search.md) with the selected URLs and a query derived from the user's request.
3. Identify the case from the table below. If no case matches, skip to Step 3 with Step 1 analysis and the user's request.

| Case | Name                    | Description                                           | Service Type   |
| ---- | ----------------------- | ----------------------------------------------------- | -------------- |
| 1    | Add Resource Type       | Define a new ARM resource with operations             | ARM            |
| 2    | Add Resource Operations | Add CRUD or custom actions on an existing resource    | ARM            |
| 3    | API Version Evolution   | Add, bump, or promote an API version (preview/stable) | ARM |

---

## Case-Specific Intake

### Case 1 — Add Resource Type (ARM)

Collect: target API version, resource name (PascalCase), hierarchy (top-level or nested + parent), properties (name, type, required/optional).

Defaults: top-level → `TrackedResource`, child → `ProxyResource`. Operations: `createOrReplace` (PUT/async), `get`, `update/patch`, `delete` (async), list by parent. Top-level adds list by subscription.

> Use `createOrReplace` (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.
> Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`.

### Case 2 — Add Resource Operations (ARM)

Collect: target resource, operation type (CRUD or custom), operation name (custom actions), request/response models (custom actions).

Defaults: never async → GET, LIST, HEAD. Default async → PUT, DELETE. Default sync → PATCH. Always ask user → POST/action.

> Use `createOrReplace` (not `createOrUpdate`). Use `ArmCustomPatch` for PATCH.
> For async POST, use ARM combined headers: `LroHeaders = ArmCombinedLroHeaders<FinalResult = ExportResult>`.

### Case 3 — API Version Evolution (ARM)

> ⚠️ **Scope constraint**: Case 3 covers version evolution **only** — carrying over or excluding existing features. **Do NOT add new resources, operations, models, or properties** as part of Case 3. If the user's request includes new features, complete those as a separate Case 1 or Case 2 task first, then return to Case 3 to promote the resulting version.

Determine the versioning pattern from Step 1 existing versions and the user's target:

| Pattern           | When                                              |
| ----------------- | ------------------------------------------------- |
| preview → preview | Bump preview date                                 |
| preview → stable  | Promote to stable                                 |
| stable → preview  | Add new preview alongside stable                  |
| stable → stable   | Bump stable date                                  |

Collect from user:
1. **Target version** (e.g. `2026-01-01-preview` or `2026-01-01`)
2. **Features to exclude** — all existing features are carried over by default; follow this procedure exactly:
   1. Read the latest version's `.tsp` files and enumerate all resources, operations, models, and properties.
   2. Present the list to the user as a numbered checklist.
   3. Ask: *"All features will be carried over to the new version. Are there any you want to exclude? List by number, or say 'none'."*
   4. Wait for the user's response before proceeding. **Do not assume the user wants to add new features.**

---

## Confirm

Display and wait for user confirmation:

```
Case:           [Name]
Target Version: [version]
Changes:        [summary]
Defaults:       [applied defaults]
```
