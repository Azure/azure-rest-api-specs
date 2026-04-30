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
@parentResource(Project)
model Workbench is Azure.ResourceManager.ProxyResource<WorkbenchProperties, false> {
  ...ResourceNameParameter<
    Resource = Workbench,
    KeyName = "workbenchName",
    SegmentName = "workbenches",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_-]*[a-zA-Z0-9])?$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The location of the workbench resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'location' on the ProxyResource envelope to track workbench region independently from the parent project"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'tags' on the resource envelope for backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> type used for 'Workbench' to support extensible key-value pairs matching service behavior"
  tags?: Record<string>;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'identity' on the resource envelope for managed identity support"
  identity?: Identity;
}

@added(Versions.v2026_03_15_preview)
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

  /**
   * Updates a workbench associated with the project.
   */
  @tag("Workbenches")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Workbench, PatchModel = Workbench>;

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
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  start is ArmResourceActionAsync<Workbench, void, void>;

  /**
   * Stops a running workbench resource.
   * This is a long-running operation that returns 202 Accepted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  stop is ArmResourceActionAsync<Workbench, void, void>;

  /**
   * Restarts a running workbench resource.
   * This is a long-running operation that returns 202 Accepted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Workbenches")
  restart is ArmResourceActionAsync<Workbench, void, void>;
}

@@maxLength(Workbench.name, 63);
@@minLength(Workbench.name, 1);
@@doc(Workbench.name,
  "The name of the workbench associated with the project."
);
@@doc(Workbench.properties,
  "Properties of the workbench resource."
);
@@doc(Workbenches.createOrUpdate::parameters.resource, "The workbench properties.");
@@doc(Workbenches.update::parameters.properties,
  "The workbench properties to update."
);
