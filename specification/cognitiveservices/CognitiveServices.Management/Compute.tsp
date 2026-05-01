import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Cognitive Services compute resource. Supports polymorphic compute types
 * (Cluster, ContainerInstance) via the computeType discriminator in properties.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(Account)
model Compute is Azure.ResourceManager.ProxyResource<ComputeProperties, false> {
  ...ResourceNameParameter<
    Resource = Compute,
    KeyName = "computeName",
    SegmentName = "computes",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9_-]*[a-zA-Z0-9])?$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The location of the compute resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'location' on the ProxyResource envelope to track compute region independently from the parent account"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'tags' on the resource envelope for backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<string> type used for 'Compute' to support extensible key-value pairs matching service behavior"
  tags?: Record<string>;

  /**
   * The kind (type) of compute resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'kind' on the resource envelope to distinguish compute sub-types at the resource level"
  kind?: string;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'identity' on the resource envelope for managed identity support"
  identity?: Identity;
}

@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface Computes {
  /**
   * Gets the specified compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  get is ArmResourceRead<Compute>;

  /**
   * Creates or updates a compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Compute>;

  /**
   * Updates a compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Compute, PatchModel = Compute>;

  /**
   * Deletes the specified compute associated with the Cognitive Services account.
   */
  @tag("Computes")
  delete is ArmResourceDeleteWithoutOkAsync<Compute>;

  /**
   * Gets the computes associated with the Cognitive Services account.
   */
  @tag("Computes")
  list is ArmResourceListByParent<Compute, Response = ComputeListResult>;

  /**
   * Starts a stopped ContainerInstance compute resource.
   * This is a long-running operation that returns 202 Accepted.
   * Only applicable when computeType is ContainerInstance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Computes")
  start is ArmResourceActionAsync<Compute, void, void>;

  /**
   * Stops a running ContainerInstance compute resource.
   * This is a long-running operation that returns 202 Accepted.
   * Only applicable when computeType is ContainerInstance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Computes")
  stop is ArmResourceActionAsync<Compute, void, void>;

  /**
   * Restarts a running ContainerInstance compute resource.
   * This is a long-running operation that returns 202 Accepted.
   * Only applicable when computeType is ContainerInstance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST with no response body requires 202+204 per Swagger LintDiff PostResponseCodes rule"
  @tag("Computes")
  restart is ArmResourceActionAsync<Compute, void, void>;
}

@@maxLength(Compute.name, 63);
@@minLength(Compute.name, 1);
@@doc(Compute.name,
  "The name of the compute associated with the Cognitive Services Account."
);
@@doc(Compute.properties,
  "Polymorphic properties of the compute resource. Use computeType to select Cluster or ContainerInstance."
);
@@doc(Computes.createOrUpdate::parameters.resource, "The compute properties.");
@@doc(Computes.update::parameters.properties,
  "The compute properties to update."
);
