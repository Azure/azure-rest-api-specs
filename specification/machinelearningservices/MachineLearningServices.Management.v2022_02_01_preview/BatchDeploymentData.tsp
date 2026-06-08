import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchEndpointData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(BatchEndpointData)
model BatchDeploymentData
  is Azure.ResourceManager.TrackedResource<BatchDeploymentDetails, false> {
  ...ResourceNameParameter<
    Resource = BatchDeploymentData,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface BatchDeployments {
  /**
   * Gets a batch inference deployment by id.
   */
  get is ArmResourceRead<BatchDeploymentData>;

  /**
   * Creates/updates a batch inference deployment (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BatchDeploymentData,
    LroHeaders = ArmLroLocationHeader<FinalResult = BatchDeploymentData> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a batch inference deployment (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BatchDeploymentData,
    PatchModel = PartialBatchDeploymentPartialTrackedResource
  >;

  /**
   * Delete Batch Inference deployment (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchDeploymentData,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Batch inference deployments in the workspace.
   */
  list is ArmResourceListByParent<
    BatchDeploymentData,
    Parameters = {
      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Top of list.
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<BatchDeploymentTrackedResourceArmPaginatedResult>
  >;
}

@@doc(BatchDeploymentData.name, "The identifier for the Batch deployments.");
@@doc(
  BatchDeploymentData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  BatchDeployments.createOrUpdate::parameters.resource,
  "Batch inference deployment definition object."
);
@@doc(
  BatchDeployments.update::parameters.properties,
  "Batch inference deployment definition object."
);
