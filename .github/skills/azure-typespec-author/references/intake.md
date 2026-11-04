# Intake

> Prerequisite: Step 1 (Analyze Project) must be complete.

## 2.1 General Intake (All Cases)

Select and execute one knowledge route before deciding what additional information
to collect:

1. Read the installed
   [reference-document-links.md](reference-document-links.md). If that read fails,
   retry the installed skill path. If local access remains unavailable, recover the
   canonical repository copy through an available repository-file reader.
2. Classify the complete request:
   - **Covered** — the catalog covers every material authoring topic.
   - **Uncovered** — one or more material authoring topics are absent from the
     catalog. A partially covered request is classified as uncovered for its complete
     knowledge route.
3. Execute exactly one route for the complete request:
   - **Covered** — run [agentic search](agentic-search.md).
   - **Uncovered** — call `azsdk_typespec_retrieve_knowledge` when it is exposed. If
     it is not exposed, run Agentic Search against authoritative TypeSpec or Azure
     documentation instead.
   - **Catalog unavailable** — run Agentic Search against authoritative TypeSpec or
     Azure documentation. Catalog access failure is not a blocker and does not by
     itself select retrieval.
4. Do not call both Agentic Search and retrieval for the same request. Retain the
   selected route's fetched content for Step 3; the authoring-plan step must reuse it
   without another knowledge call.
5. Use the fetched guidance to determine the material intake decisions and retain it
   for the authoring plan.
6. Using the selected guidance, the Step 1 result, and the user's request, identify
   every matching case from the table below.
7. Gather only material information that is not already supplied or directly
   available from the project. If no case matches, skip Step 2.2.

Do not call an authoring-plan or validation MCP tool during intake. If the selected
knowledge route cannot obtain sufficient authoritative guidance, report a blocker
instead of switching routes. Do not plan, edit, or validate during intake. Step 3
must reuse this grounding record without repeating Agentic Search or retrieval.

| Case | Name                    | Description                                            | Service Type     | Knowledge route          |
| ---- | ----------------------- | ------------------------------------------------------ | ---------------- | ------------------------ |
| 1    | ARM Resource Types      | Define a new ARM resource with operations              | ARM              | Covered — Agentic Search |
| 2    | ARM Resource Operations | Add CRUD or custom actions on an existing resource     | ARM              | Covered — Agentic Search |
| 3    | API Versioning          | Add, bump, or promote an API version (preview/stable)  | ARM / Data-plane | Covered — Agentic Search |
| 4    | Data-Plane Operations   | Add CRUD or custom operations on a data-plane resource | Data-plane       | Covered — Agentic Search |

---

## 2.2 Case-Specific Intake

### Case 1 — ARM Resource Types

Collect: target API version, resource name (PascalCase), hierarchy (top-level or
nested + parent), properties (name, type, required/optional), and whether PUT,
PATCH, and DELETE complete before the initial response or require LRO polling.

Defaults: top-level → `TrackedResource`, child → `ProxyResource`. Operations:
`createOrUpdate` (PUT), `get`, `update` (PATCH), `delete`, list by parent.
Top-level adds list by subscription.

> Use `createOrUpdate` as the operation name with an
> `ArmResourceCreateOrReplaceSync` or `ArmResourceCreateOrReplaceAsync`
> template. Choose sync or async templates for PUT, PATCH, and DELETE to match
> actual runtime behavior; do not infer completion behavior from the HTTP
> method. Use `ArmCustomPatch` for PATCH.
> Top-level tracked resources MUST have `listByResourceGroup` and `listBySubscription`.

### Case 2 — ARM Resource Operations

Collect: target resource, operation type (CRUD or custom), operation name
(custom actions), request/response models (custom actions), and whether the
operation completes before the initial response or requires LRO polling.

Defaults: GET, LIST, and HEAD are synchronous. For PUT, PATCH, DELETE, and
POST/action, choose sync or async to match actual runtime behavior; ask the user
when completion behavior is not supplied.

> Use `createOrUpdate` as the operation name with an
> `ArmResourceCreateOrReplaceSync` or `ArmResourceCreateOrReplaceAsync`
> template. Use `ArmCustomPatch` for PATCH.
> For an async ARM operation, start with the standard template's LRO header
> defaults. Collect the service's actual polling-header contract and whether
> the resource provider is subject to the January 2025 greenfield header
> requirements. Greenfield async PATCH, DELETE, and POST operations require
> both `Location` and `Azure-AsyncOperation`; new async PUT templates already
> include `Azure-AsyncOperation` by default. Override `LroHeaders` when the
> contract or ARM policy requires it, include `RetryAfterHeader`, and set
> `FinalResult` to the resource or action response type, or `void` when the
> operation has no final response body. See the
> [ARM LRO customization guidance](https://azure.github.io/typespec-azure/docs/howtos/arm/long-running-operations/).

### Case 3 — API Versioning

First distinguish the request shape:

1. **Add, replace, or promote an API version.** Collect from the user only when
   not already supplied:
   - Target version (for example `2026-01-01-preview` or `2026-01-01`).
   - Features to carry forward or exclude. Do not assume all features carry
     forward. An explicit instruction to "carry over all features", carry
     everything from the latest version, or make no exclusions is a complete
     decision: record it and proceed without enumerating the existing surface
     for confirmation. When this decision is missing:
     1. Read the latest version's `.tsp` files and enumerate all resources,
        operations, models, and properties.
     2. Present the list as a numbered checklist.
     3. Ask: _"All features will be carried over to the new version. Are there
        any you want to exclude? List by number, or say 'none'."_
     4. Wait for the response.
2. **Version-scope an existing feature without adding or promoting a version.**
   Collect only the target symbol or change and its introduced, removed,
   renamed, optional, or type-changed version. A request such as "introduce this
   property in version X only" supplies the material scope decision; do not ask
   for an unrelated service-wide carry-forward decision.

---

> This case applies to both ARM and data-plane services. The same versioning decorators (`@added`, `@removed`, `@renamedFrom`, `@typeChangedFrom`) apply regardless of service type.

### Case 4 — Data-Plane Operations

Collect: target resource, operation type (CRUD, list, or custom action), operation
name, and sync/async behavior when the selected create, update, delete, or action
template has both forms.

Defaults: GET/read and LIST are synchronous. Use the target resource's existing key,
route, request, and response contract unless the user explicitly requests a custom
shape; do not ask the user to restate information already present in the project.
When a full CRUD request explicitly supplies sync/async behavior, that decision
applies to its create/update/delete operations unless the request distinguishes them.

> Data-plane services use `Azure.Core` (not `Azure.ResourceManager`). No `@armProviderNamespace` decorator.
> All operations, models, enums/unions, and properties should have `/** */` documentation.
> For async operations (long-running), refer to the [Deep Dive: Long-running (Asynchronous) Operations](https://azure.github.io/typespec-azure/docs/howtos/azure-core/long-running-operations/) documentation

---

## 2.3 Confirm

Display the intake result. Continue without another question when the user already
supplied all material decisions. The displayed result is informational, not a request
for approval: do not append "confirm", "is this correct?", or an equivalent question.
Otherwise, ask only for the missing decision and wait.

```
Case:           [Name]
Target Version: [version]
Changes:        [summary]
Defaults:       [applied defaults]
```
