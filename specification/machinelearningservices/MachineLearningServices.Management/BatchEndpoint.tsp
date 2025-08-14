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
model BatchEndpoint
  is Azure.ResourceManager.TrackedResource<BatchEndpointProperties, false> {
  ...ResourceNameParameter<
    Resource = BatchEndpoint,
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
  get is ArmResourceRead<BatchEndpoint>;

  /**
   * Creates a batch inference endpoint (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BatchEndpoint>;

  /**
   * Update a batch inference endpoint (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BatchEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithIdentity
  >;

  /**
   * Delete Batch Inference Endpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Batch inference endpoint in the workspace.
   */
  list is ArmResourceListByParent<
    BatchEndpoint,
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
    BatchEndpoint,
    void,
    ArmResponse<EndpointAuthKeys>
  >;
}

@@doc(BatchEndpoint.name, "Name for the Batch Endpoint.");
@@doc(BatchEndpoint.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(BatchEndpoints.createOrUpdate::parameters.resource,
  "Batch inference endpoint definition object."
);
@@doc(BatchEndpoints.update::parameters.properties,
  "Mutable batch inference endpoint definition object."
);
