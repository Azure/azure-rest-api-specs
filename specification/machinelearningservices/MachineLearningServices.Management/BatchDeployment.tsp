import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(BatchEndpoint)
model BatchDeployment
  is Azure.ResourceManager.TrackedResource<BatchDeploymentProperties, false> {
  ...ResourceNameParameter<
    Resource = BatchDeployment,
    KeyName = "deploymentName",
    SegmentName = "deployments",
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
interface BatchDeployments {
  /**
   * Gets a batch inference deployment by id.
   */
  @summary("Get batch inference deployment by id.")
  get is ArmResourceRead<BatchDeployment>;

  /**
   * Creates/updates a batch inference deployment (asynchronous).
   */
  @summary("Creates/updates a batch inference deployment (asynchronous).")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BatchDeployment,
    Response = ArmResourceUpdatedResponse<BatchDeployment> | (ArmResourceCreatedResponse<
      BatchDeployment,
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
   * Update a batch inference deployment (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update a batch inference deployment (asynchronous).")
  update is ArmCustomPatchAsync<
    BatchDeployment,
    PatchModel = PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties,
    Response = BatchDeployment | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BatchDeployment>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete Batch Inference deployment (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete Batch Inference deployment (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchDeployment,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Lists Batch inference deployments in the workspace.
   */
  @summary("Lists Batch inference deployments in the workspace.")
  list is ArmResourceListByParent<
    BatchDeployment,
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

@@doc(BatchDeployment.name, "The identifier for the Batch deployments.");
@@doc(BatchDeployment.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(BatchDeployments.createOrUpdate::parameters.resource,
  "Batch inference deployment definition object."
);
@@doc(BatchDeployments.update::parameters.properties,
  "Batch inference deployment definition object."
);
@@doc(BatchDeployment.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(BatchDeployment.sku,
  "Sku details required for ARM contract for Autoscaling."
);
