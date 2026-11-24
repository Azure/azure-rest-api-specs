# Build TypeSpec Source Plan

> Prerequisite: Steps 1 (Analyze Project) and 2 (Intake) must be complete.

## 3.1 General (All Cases)

### 3.1.1 Reuse the authoring grounding

Step 2 already called `azsdk_typespec_retrieve_knowledge` for the complete request
and project analysis before collecting any missing decisions. Reuse the returned
context here.

Do not call `azsdk_typespec_retrieve_knowledge` or an authoring-plan MCP during
planning. If the grounding is insufficient, return to Step 2 and refine the
retrieval request there; never switch guidance sources or make an ungrounded plan.

### 3.1.2 Build the authoring plan locally

Synthesize the retrieved guidance and finalized intake result into a concrete plan.

Document your final plan with references to supporting documents, and ensure the plan follows the retrieved context above.

Never call `azsdk_typespec_generate_authoring_plan`. Reuse the Step 2 grounding
record when writing the plan and later citations; do not perform a second lookup only
to plan or cite it.

The plan produced here covers ordinary TypeSpec source declarations only. Do not
mix `client.tsp` customizations into it. Continue to the separate
[client configuration step](client-configuration.md) after this plan is complete;
SDK-visible changes include that analysis by default unless the user opts out.

---

## 3.2 Case-Specific TypeSpec Source Plan

### API Versioning

> Reuse the API versioning context returned by `azsdk_typespec_retrieve_knowledge`
> during Step 2; do not call retrieval during planning.

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

> Reuse the ARM resource operations context returned by
> `azsdk_typespec_retrieve_knowledge` during Step 2, including existence checks,
> custom actions, LRO behavior, and response/header changes. Do not call retrieval
> during planning.

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

> Reuse the data-plane operations context returned by
> `azsdk_typespec_retrieve_knowledge` during Step 2; do not call retrieval during
> planning.

Key guidance for data-plane:

1. Use `Azure.Core` resource operation templates (see [intake.md](intake.md) Case 4 for the template table).
2. Define operations inside an `interface` block.
3. Add `/** */` documentation to all operations.
4. Data-plane services use `@azure-tools/typespec-azure-core`, not `@azure-tools/typespec-azure-resource-manager`.
5. Use synchronous templates for GET/read and LIST. For create, update, delete,
   and custom actions, apply the sync/async behavior selected during intake.
6. Preserve the target resource's existing key, route, request, and response
   contracts unless the user explicitly requested a custom shape. Do not ask the
   user to restate project information already discovered during analysis.
7. When a full CRUD request supplies one sync/async decision, apply it to create,
   update, and delete unless the request distinguishes their behavior.
