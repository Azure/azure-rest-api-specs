import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Workbench resource under a Cognitive Services project.
 * Provides interactive compute with data access for AI development.
 */
@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_15_preview)
@removed(Versions.v2026_07_01)
@added(Versions.v2026_07_15_preview)
@removed(Versions.v2026_09_01)
@added(Versions.v2026_09_15_preview)
@parentResource(Project)
model Workbench is Azure.ResourceManager.ProxyResource<
  WorkbenchProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = Workbench,
    KeyName = "workbenchName",
    SegmentName = "workbenches",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_-]*[a-zA-Z0-9])?$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Workbench requires etag on the resource envelope for optimistic concurrency control"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The location of the workbench resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Published preview versions retain location for backward compatibility"
  @added(Versions.v2026_03_15_preview)
  @removed(Versions.v2026_05_01)
  @added(Versions.v2026_05_15_preview)
  @removed(Versions.v2026_07_01)
  @added(Versions.v2026_07_15_preview)
  @removed(Versions.v2026_09_01)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  // Keep tags only in historical projections; the legacy name prevents unprojected
  // ARM PATCH lint from requiring tags in the new update body.
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Published preview versions retain tags for backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> type used for tags to support extensible key-value pairs"
  @renamedFrom(Versions.v2026_09_15_preview, "tags")
  @added(Versions.v2026_03_15_preview)
  @removed(Versions.v2026_05_01)
  @added(Versions.v2026_05_15_preview)
  @removed(Versions.v2026_07_01)
  @added(Versions.v2026_07_15_preview)
  @removed(Versions.v2026_09_01)
  tagsLegacy?: Record<string>;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Workbench requires identity on the resource envelope for managed identity support"
  identity?: Identity;
}

/**
 * The mutable fields of a workbench resource.
 */
@added(Versions.v2026_09_15_preview)
model WorkbenchUpdate {
  /**
   * Properties of the workbench to update.
   */
  properties?: WorkbenchUpdateProperties;

  /**
   * Identity for the resource. May be changed while the workbench is running and takes effect after restart.
   */
  identity?: Identity;
}

@added(Versions.v2026_03_15_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_15_preview)
@removed(Versions.v2026_07_01)
@added(Versions.v2026_07_15_preview)
@removed(Versions.v2026_09_01)
@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface Workbenches {
  /**
   * Gets the specified workbench associated with the project.
   */
  @tag("Workbenches")
  get is ArmResourceRead<Workbench>;

  /**
   * Creates or updates a workbench associated with the project.
   */
  @tag("Workbenches")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workbench>;

  // Keep the legacy template so historical PATCH projections retain their LRO metadata.
  /**
   * Updates a workbench associated with the project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-patch-body" "Published preview versions retain the full Workbench PATCH body for backward compatibility"
  @sharedRoute
  @added(Versions.v2026_03_15_preview)
  @removed(Versions.v2026_05_01)
  @added(Versions.v2026_05_15_preview)
  @removed(Versions.v2026_07_01)
  @added(Versions.v2026_07_15_preview)
  @removed(Versions.v2026_09_01)
  @renamedFrom(Versions.v2026_09_15_preview, "update")
  @tag("Workbenches")
  @patch(#{ implicitOptionality: false })
  updateLegacy is ArmCustomPatchAsync<Workbench, PatchModel = Workbench>;

  /**
   * Updates a workbench associated with the project.
   */
  @sharedRoute
  @added(Versions.v2026_09_15_preview)
  @tag("Workbenches")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Workbench, PatchModel = WorkbenchUpdate>;

  /**
   * Deletes the specified workbench associated with the project.
   */
  @tag("Workbenches")
  delete is ArmResourceDeleteWithoutOkAsync<Workbench>;

  /**
   * Gets the workbenches associated with the project.
   */
  @tag("Workbenches")
  list is ArmResourceListByParent<Workbench, Response = WorkbenchListResult>;

  /**
   * Starts a stopped workbench resource.
   * This is a long-running operation that returns 202 Accepted.
   * Returns 204 if the workbench is already in the target state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  start is ArmResourceActionAsync<Workbench, void, void>;

  /**
   * Stops a running workbench resource.
   * This is a long-running operation that returns 202 Accepted.
   * Returns 204 if the workbench is already in the target state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  stop is ArmResourceActionAsync<Workbench, void, void>;

  /**
   * Restarts a running workbench resource.
   * This is a long-running operation that returns 202 Accepted.
   * Returns 204 if the workbench is already in the target state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  restart is ArmResourceActionAsync<Workbench, void, void>;
}

@@maxLength(Workbench.name, 63);
@@minLength(Workbench.name, 1);
@@doc(Workbench.name, "The name of the workbench associated with the project.");
@@doc(Workbench.properties, "Properties of the workbench resource.");
@@doc(
  Workbenches.createOrUpdate::parameters.resource,
  "The workbench properties."
);
@@doc(
  Workbenches.updateLegacy::parameters.properties,
  "The workbench properties to update."
);
@@doc(
  Workbenches.update::parameters.properties,
  "The workbench properties to update."
);
