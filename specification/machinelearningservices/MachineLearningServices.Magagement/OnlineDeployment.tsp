import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OnlineEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(OnlineEndpoint)
model OnlineDeployment
  is Azure.ResourceManager.TrackedResource<OnlineDeploymentProperties, false> {
  ...ResourceNameParameter<
    Resource = OnlineDeployment,
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
interface OnlineDeployments {
  /**
   * Get Inference Deployment Deployment.
   */
  @summary("Get Inference Deployment Deployment.")
  get is ArmResourceRead<OnlineDeployment>;

  /**
   * Create or update Inference Endpoint Deployment (asynchronous).
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update Inference Endpoint Deployment (asynchronous).")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OnlineDeployment,
    Response = ArmResourceUpdatedResponse<OnlineDeployment> | (ArmResourceCreatedResponse<
      OnlineDeployment,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = OnlineDeployment>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Update Online Deployment (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update Online Deployment (asynchronous).")
  update is ArmCustomPatchAsync<
    OnlineDeployment,
    PatchModel = PartialMinimalTrackedResourceWithSku,
    Response = OnlineDeployment | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OnlineDeployment>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        @header("x-ms-async-operation-timeout")
        timeout: duration;
      })
  >;

  /**
   * Delete Inference Endpoint Deployment (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete Inference Endpoint Deployment (asynchronous).")
  delete is ArmResourceDeleteWithoutOkAsync<
    OnlineDeployment,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Endpoint Deployments.
   */
  @summary("List Inference Endpoint Deployments.")
  list is ArmResourceListByParent<
    OnlineDeployment,
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
    Response = ArmResponse<OnlineDeploymentTrackedResourceArmPaginatedResult>
  >;

  /**
   * Polls an Endpoint operation.
   */
  @summary("Polls an Endpoint operation.")
  getLogs is ArmResourceActionSync<
    OnlineDeployment,
    DeploymentLogsRequest,
    ArmResponse<DeploymentLogs>
  >;

  /**
   * List Inference Endpoint Deployment Skus.
   */
  @list
  @get
  @action("skus")
  @summary("List Inference Endpoint Deployment Skus.")
  listSkus is ArmResourceActionSync<
    OnlineDeployment,
    void,
    ArmResponse<SkuResourceArmPaginatedResult>,
    Parameters = {
      /**
       * Number of Skus to be retrieved in a page of results.
       */
      @query("count")
      count?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;
}

@@doc(OnlineDeployment.name, "Inference Endpoint Deployment name.");
@@doc(OnlineDeployment.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(OnlineDeployments.createOrUpdate::parameters.resource,
  "Inference Endpoint entity to apply during operation."
);
@@doc(OnlineDeployments.update::parameters.properties,
  "Online Endpoint entity to apply during operation."
);
@@doc(OnlineDeployments.getLogs::parameters.body,
  "The request containing parameters for retrieving logs."
);
@@doc(OnlineDeployment.identity,
  "Managed service identity (system assigned and/or user assigned identities)"
);
@@doc(OnlineDeployment.sku,
  "Sku details required for ARM contract for Autoscaling."
);
