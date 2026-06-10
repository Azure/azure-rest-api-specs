import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./OnlineEndpointData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

@parentResource(OnlineEndpointData)
model OnlineDeploymentData
  is Azure.ResourceManager.TrackedResource<OnlineDeploymentDetails, false> {
  ...ResourceNameParameter<
    Resource = OnlineDeploymentData,
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
interface OnlineDeployments {
  /**
   * Get Inference Deployment Deployment.
   */
  get is ArmResourceRead<OnlineDeploymentData>;

  /**
   * Create or update Inference Endpoint Deployment (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    OnlineDeploymentData,
    LroHeaders = ArmLroLocationHeader<FinalResult = OnlineDeploymentData> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update Online Deployment (asynchronous).
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OnlineDeploymentData,
    PatchModel = PartialOnlineDeploymentPartialTrackedResource
  >;

  /**
   * Delete Inference Endpoint Deployment (asynchronous).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    OnlineDeploymentData,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List Inference Endpoint Deployments.
   */
  list is ArmResourceListByParent<
    OnlineDeploymentData,
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
  getLogs is ArmResourceActionSync<
    OnlineDeploymentData,
    DeploymentLogsRequest,
    ArmResponse<DeploymentLogs>
  >;

  /**
   * List Inference Endpoint Deployment Skus.
   */
  @list
  @get
  @action("skus")
  listSkus is ArmResourceActionSync<
    OnlineDeploymentData,
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

@@doc(OnlineDeploymentData.name, "Inference Endpoint Deployment name.");
@@doc(
  OnlineDeploymentData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  OnlineDeployments.createOrUpdate::parameters.resource,
  "Inference Endpoint entity to apply during operation."
);
@@doc(
  OnlineDeployments.update::parameters.properties,
  "Online Endpoint entity to apply during operation."
);
@@doc(
  OnlineDeployments.getLogs::parameters.body,
  "The request containing parameters for retrieving logs."
);
