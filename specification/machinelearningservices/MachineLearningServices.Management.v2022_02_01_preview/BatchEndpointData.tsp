import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(Workspace)
model BatchEndpointData
  is Azure.ResourceManager.TrackedResource<BatchEndpointDetails, false> {
  ...ResourceNameParameter<
    Resource = BatchEndpointData,
    KeyName = "endpointName",
    SegmentName = "batchEndpoints",
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
interface BatchEndpoints {
  /**
   * Gets a batch inference endpoint by name.
   */
  get is ArmResourceRead<BatchEndpointData>;

  /**
   * Creates a batch inference endpoint (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BatchEndpointData,
    LroHeaders = ArmLroLocationHeader<FinalResult = BatchEndpointData> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a batch inference endpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BatchEndpointData,
    PatchModel = PartialBatchEndpointPartialTrackedResource
  >;

  /**
   * Delete Batch Inference Endpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchEndpointData,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Batch inference endpoint in the workspace.
   */
  list is ArmResourceListByParent<
    BatchEndpointData,
    Parameters = {
      /**
       * Number of endpoints to be retrieved in a page of results.
       */
      @query("count")
      count?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<BatchEndpointTrackedResourceArmPaginatedResult>
  >;

  /**
   * Lists batch Inference Endpoint keys.
   */
  @action("listkeys")
  listKeys is ArmResourceActionSync<
    BatchEndpointData,
    void,
    ArmResponse<EndpointAuthKeys>
  >;
}

@@doc(BatchEndpointData.name, "Name for the Batch Endpoint.");
@@doc(
  BatchEndpointData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  BatchEndpoints.createOrUpdate::parameters.resource,
  "Batch inference endpoint definition object."
);
@@doc(
  BatchEndpoints.update::parameters.properties,
  "Mutable batch inference endpoint definition object."
);
