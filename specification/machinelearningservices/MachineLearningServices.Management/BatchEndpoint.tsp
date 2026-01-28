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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  ...Azure.ResourceManager.ResourceSkuProperty;
}

@armResourceOperations
interface BatchEndpoints {
  /**
   * Gets a batch inference endpoint by name.
   */
  @summary("Get batch inference endpoint by name.")
  get is ArmResourceRead<BatchEndpoint>;

  /**
   * Creates a batch inference endpoint (asynchronous).
   */
  @summary("Create a batch inference endpoint (asynchronous).")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BatchEndpoint,
    Response = ArmResourceUpdatedResponse<BatchEndpoint> | (ArmResourceCreatedResponse<
      BatchEndpoint,
      LroHeaders = ArmAsyncOperationHeader
    > &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Update a batch inference endpoint (asynchronous).
   */
  @summary("Update a batch inference endpoint (asynchronous).")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BatchEndpoint,
    PatchModel = PartialMinimalTrackedResourceWithIdentity,
    Response = BatchEndpoint | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BatchEndpoint>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete Batch Inference Endpoint (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete Batch Inference Endpoint (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchEndpoint,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Batch inference endpoint in the workspace.
   */
  @summary("Lists Batch inference endpoint in the workspace.")
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
  @summary("Lists batch Inference Endpoint keys.")
  listKeys is ArmResourceActionSync<BatchEndpoint, void, EndpointAuthKeys>;
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
@@doc(BatchEndpoint.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(BatchEndpoint.sku,
  "Sku details required for ARM contract for Autoscaling."
);
