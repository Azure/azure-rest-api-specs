# Build Authoring Plan

> Prerequisite: Steps 1 (Analyze Project) and 2 (Intake) must be complete.

## 3.1 General (All Cases)

### 3.1.1 Reuse the grounding selected during intake

Step 2 already read the reference catalog and used Agentic Search to ground the
request before collecting any missing decisions. Verify that its Web grounding record
covers the complete request and the finalized intake result.

Do not call Agentic Search again or call a knowledge-retrieval or authoring-plan MCP
during planning. If the existing grounding is insufficient, return to Agentic Search,
refine the Web guidance, and update the intake result if the additional guidance
changes a material decision. Otherwise, report a blocker.

### 3.1.2 Build the authoring plan locally

Synthesize the selected guidance and finalized intake result into a concrete plan.

Document your final plan with references to supporting documents, and ensure the plan follows the retrieved context above.

Never call `azsdk_typespec_generate_authoring_plan`. Reuse the existing grounding
record when writing the plan and later citations; do not perform a second lookup only
to cite it.

---

## 3.2 Case-Specific Authoring Plan

### API Versioning

> API Versioning **is covered** by [reference-document-links.md](reference-document-links.md), so Step 2 **MUST** use **Agentic Search** and call `web_fetch` on the matching versioning document before finalizing intake. Reuse that guidance here. Do **not** call `azsdk_typespec_retrieve_knowledge` or `azsdk_typespec_generate_authoring_plan`.

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
