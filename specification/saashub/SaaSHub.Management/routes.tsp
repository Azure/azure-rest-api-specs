import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./SaasResourceModels.tsp";
import "./CloudServiceModels.tsp";
import "@typespec/versioning";
import "./SharedModels.tsp";
import "./SaasResource.tsp";
import "./CloudService.tsp";
import "./versions.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.SaaSHub;

@armResourceOperations
interface ProviderLevelActions {
  /**
   * Evaluates whether the request payload can create a new SaaS resource.
   * Not available in API versions 2023-01-01-preview.
   */
  @route("/providers/Microsoft.SaaSHub")
  @post
  @armResourceAction(Microsoft.SaaSHub.SaasResource)
  tenantLevelCanCreate(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the create SaaSHub SaaS resource operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CanCreateSaasResourceRequest,
  ): ArmResponse<Microsoft.SaaSHub.CanCreateResult> | ErrorResponse;

  /**
   * Gets coterm end dates for multiple resources at tenant level.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/providers/Microsoft.SaaSHub/tenantLevelCoterminousDates")
  @post
  @tag("ProviderLevelActions")
  tenantLevelGetCotermEndDates(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the GetCotermEndDates operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CotermEndDatesRequest,
  ): ArmResponse<Microsoft.SaaSHub.CotermResponseItem[]> | ErrorResponse;

  /**
   * Evaluates whether multiple transaction requests can be processed at tenant level.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/providers/Microsoft.SaaSHub/tenantLevelCanTransact")
  @post
  @tag("ProviderLevelActions")
  tenantLevelCanTransact(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the tenant level canTransact operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.TenantLevelCanTransactBulkRequest,
  ): ArmResponse<Microsoft.SaaSHub.TenantLevelCanTransactBulkResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Resource group level provider actions don't follow standard ARM resource patterns"
interface ResourceGroupLevelProviderActions {
  /**
   * Evaluates whether the request payload can create a new cloud service resource.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaSHub/canCreate")
  @tag("ResourceGroupLevelProviderActions")
  @post
  canCreate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Request parameters that are provided to the create SaaSHub cloud service operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CanCreateCloudServiceRequest,
  ): ArmResponse<Microsoft.SaaSHub.CanCreateResult> | ErrorResponse;

  /**
   * Gets coterm end dates for multiple resources at resource group level.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaSHub/coterminousDates")
  @tag("ResourceGroupLevelProviderActions")
  @post
  getCotermEndDates(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Request parameters that are provided to the GetCotermEndDates operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CotermEndDatesRequest,
  ): ArmResponse<Microsoft.SaaSHub.CotermResponseItem[]> | ErrorResponse;

  /**
   * Evaluates whether multiple transaction requests can be processed at resource group level.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaSHub/canTransact")
  @tag("ResourceGroupLevelProviderActions")
  @post
  canTransact(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Request parameters that are provided to the resource group level canTransact operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.ResourceGroupLevelCanTransactBulkRequest,
  ): ArmResponse<Microsoft.SaaSHub.ResourceGroupLevelCanTransactBulkResponse> | ErrorResponse;
}
