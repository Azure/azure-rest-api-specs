# Build Authoring Plan

> Prerequisite: Steps 1 (Analyze Project) and 2 (Intake) must be complete.

## 3.1 General (All Cases)

### 3.1.1 Select and use one grounding source

After Steps 1 and 2, complete this catalog-access gate before classifying coverage:

1. Read the installed
   [reference-document-links.md](reference-document-links.md).
2. If that read fails, retry the installed skill path.
3. If local access remains unavailable, recover the canonical repository copy through
   an available repository-file reader. If recovery requires `web_fetch`, the Web
   family is selected for this execution; never call retrieval afterward. If that
   recovered catalog does not fully cover the request, report a blocker rather than
   switching source families.
4. If the catalog still cannot be read, report a blocker without calling retrieval or
   editing.

A failed catalog read, unavailable skill-reference path, related keyword, or
uncertainty never proves that a request is uncovered. Only after a successful catalog
read, classify the complete request and select one source for the entire execution:

1. **Entire request covered → Agentic Search.** Run [agentic search](agentic-search.md) and call
   `web_fetch` only for the matching URLs. Do not call
   `azsdk_typespec_retrieve_knowledge`.

2. **Entirely or partly uncovered after a successful non-Web catalog read:**
   - When `azsdk_typespec_retrieve_knowledge` is exposed, call it for the complete
     request and do not use Web before or after it:
     - `request`: user request (verbatim)
     - `typeSpecProjectRootPath`: project root path
   - When the retrieval tool is not exposed, select the Web fallback before
     grounding. Run [agentic search](agentic-search.md) for the complete request,
     locating additional authoritative TypeSpec or Azure documentation when the
     installed catalog has no matching link. Do not call retrieval later in that
     execution.

If the selected source is insufficient, refine or retry within that same family, or
report a blocker. Never switch source families during an execution.

Tool absence means the tool is not exposed in the current environment. An invocation
error, authentication failure, or timeout from an exposed retrieval tool is not
absence; report the blocker rather than switching to Web.

### 3.1.2 Build the authoring plan locally

Synthesize the selected guidance from step 3.1.1 into a concrete plan.

Document your final plan with references to supporting documents, and ensure the plan follows the retrieved context above.

Never call `azsdk_typespec_generate_authoring_plan`. Reuse the existing grounding
record when writing the plan and later citations; do not perform a second lookup only
to cite it.

---

## 3.2 Case-Specific Authoring Plan

### API Versioning

> API Versioning **is covered** by [reference-document-links.md](reference-document-links.md), so use **Agentic Search** (per [3.1.1 Select and use one grounding source](#311-select-and-use-one-grounding-source)) — you **MUST** call `web_fetch` on the matching versioning doc and follow its steps. Do **not** call `azsdk_typespec_retrieve_knowledge` or `azsdk_typespec_generate_authoring_plan`.

For requests that add, replace, or promote a version:

1. Preserve every released stable wire contract. Use versioning decorators so a
   source-level rename, default, or type change does not change earlier emitted
   stable schemas.
2. Carry forward only the features selected during intake. Retarget their transition
   decorators to the new version instead of deleting decorators and restoring an old
   source shape. Fully remove excluded features and their transitional scaffolding.
3. When a preview is superseded rather than retained, remove its enum value and
   examples, and rebase every decorator that referenced it. Do not leave dangling
   version references.
4. Create the new version's `examples/<new-version>/` folder by copying the latest
   retained version's examples, then update each example's `api-version`.
5. Update `readme.md`.

> These steps apply to both ARM and data-plane services. The same versioning decorators (`@added`, `@removed`, `@renamedFrom`, `@typeChangedFrom`) apply regardless of service type.

### ARM Resource Operations

For PATCH operations that update tags and mutable resource properties:

1. Use `ArmCustomPatchSync` or `ArmCustomPatchAsync` with
   `ResourceUpdateModel<Resource, Properties>` or an equivalent explicit update
   model.
2. Do not use `ArmResourcePatchSync` or `ArmResourcePatchAsync`; those wrappers derive
   their payload from lifecycle visibility and are not the explicit update-model
   contract required here.
3. Verify the emitted PATCH body contains tags and mutable properties, excludes
   read-only properties such as provisioning state, and has the requested sync/async
   behavior.

### Data-Plane Operations

Key guidance for data-plane:

1. Use `Azure.Core` resource operation templates (see [intake.md](intake.md) Case 4 for the template table).
2. Define operations inside an `interface` block.
3. Add `/** */` documentation to all operations.
4. Data-plane services use `@azure-tools/typespec-azure-core`, not `@azure-tools/typespec-azure-resource-manager`.
