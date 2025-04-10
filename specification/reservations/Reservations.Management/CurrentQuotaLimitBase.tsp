import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Capacity;
/**
 * Quota properties.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model CurrentQuotaLimitBase
  is Azure.ResourceManager.ProxyResource<QuotaProperties> {
  ...ResourceNameParameter<
    Resource = CurrentQuotaLimitBase,
    KeyName = "resourceName",
    SegmentName = "serviceLimits",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CurrentQuotaLimitBases {
  /**
   * Get the current quota (service limit) and usage of a resource. You can use the response from the GET operation to submit quota update request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_Get")
  get is ArmResourceRead<
    CurrentQuotaLimitBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or update the quota (service limits) of a resource to the requested value.
   *  Steps:
   *   1. Make the Get request to get the quota information for specific resource.
   *   2. To increase the quota, update the limit field in the response from Get request to new value.
   *   3. Submit the JSON to the quota request API to update the quota.
   *   The Create quota request may be constructed as follows. The PUT operation can be used to update the quota.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CurrentQuotaLimitBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<CurrentQuotaLimitBase> | ArmResourceCreatedResponse<QuotaRequestSubmitResponse201>
  >;

  /**
   * Update the quota (service limits) of this resource to the requested value.
   *   • To get the quota information for specific resource, send a GET request.
   *   • To increase the quota, update the limit field from the GET response to a new value.
   *   • To update the quota value, submit the JSON response to the quota request API to update the quota.
   *   • To update the quota. use the PATCH operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Quota_Update")
  update is ArmCustomPatchAsync<
    CurrentQuotaLimitBase,
    PatchModel = CurrentQuotaLimitBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<CurrentQuotaLimitBase> | ArmResourceCreatedResponse<QuotaRequestSubmitResponse201>
  >;

  /**
   * Gets a list of current quotas (service limits) and usage for all resources. The response from the list quota operation can be leveraged to request quota updates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quota_List")
  list is ArmResourceListByParent<
    CurrentQuotaLimitBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<QuotaLimits>
  >;
}

@@doc(CurrentQuotaLimitBase.name,
  "The resource name for a resource provider, such as SKU name for Microsoft.Compute, Sku or TotalLowPriorityCores for Microsoft.MachineLearningServices"
);
@@doc(CurrentQuotaLimitBase.properties, "Quota properties for the resource.");
@@doc(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "Quota requests payload."
);
@@doc(CurrentQuotaLimitBases.update::parameters.properties,
  "Payload for the quota request."
);
