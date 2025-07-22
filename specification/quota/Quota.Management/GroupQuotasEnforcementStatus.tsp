import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GroupQuotasEntity.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Quota;
/**
 * The GroupQuota Enforcement status for a Azure Location/Region.
 */
@parentResource(GroupQuotasEntity)
model GroupQuotasEnforcementStatus
  is Azure.ResourceManager.ProxyResource<GroupQuotasEnforcementStatusProperties> {
  ...ResourceNameParameter<
    Resource = GroupQuotasEnforcementStatus,
    KeyName = "location",
    SegmentName = "locationSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GroupQuotasEnforcementStatuses {
  /**
   * Gets the GroupQuotas enforcement settings for the ResourceProvider/location. The locations, where GroupQuota enforcement is not enabled will return Not Found.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupQuotaLocationSettings_Get")
  get is ArmResourceRead<GroupQuotasEnforcementStatus>;

  /**
   * Enables the GroupQuotas enforcement for the resource provider and the location specified. The resource provider will start using the group quotas as the overall quota for the subscriptions included in the GroupQuota. The subscriptions cannot request quota at subscription level since it is now part of an enforced group.
   * The subscriptions share the GroupQuotaLimits assigned to the GroupQuota. If the GroupQuotaLimits is used, then submit a groupQuotaLimit request for the specific resource - provider/location/resource.
   * Once the GroupQuota Enforcement is enabled then, it cannot be deleted or reverted back. To disable GroupQuota Enforcement -
   *  1. Remove all the subscriptions from the groupQuota using the delete API for Subscriptions (Check the example - GroupQuotaSubscriptions_Delete).
   *  2. Then delete the GroupQuota (Check the example - GroupQuotas_Delete).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupQuotaLocationSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    GroupQuotasEnforcementStatus,
    Response = ArmResourceUpdatedResponse<GroupQuotasEnforcementStatus> | ArmResourceCreatedResponse<
      LROResponse,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Enables the GroupQuotas enforcement for the resource provider and the location specified. The resource provider will start using the group quotas as the overall quota for the subscriptions included in the GroupQuota.  The subscriptions cannot request quota at subscription level since it is now part of an enforced group.
   * The subscriptions share the GroupQuotaLimits assigned to the GroupQuota. If the GroupQuotaLimits is used, then submit a groupQuotaLimit request for the specific resource - provider/location/resource.
   * Once the GroupQuota Enforcement is enabled then, it cannot be deleted or reverted back. To disable GroupQuota Enforcement -
   *  1. Remove all the subscriptions from the groupQuota using the delete API for Subscriptions (Check the example - GroupQuotaSubscriptions_Delete).
   *  2. Ten delete the GroupQuota (Check the example - GroupQuotas_Delete).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("GroupQuotaLocationSettings_Update")
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    GroupQuotasEnforcementStatus,
    PatchModel = GroupQuotasEnforcementStatus,
    OptionalRequestBody = true
  >;

  /**
   * Returns only the list of the Azure regions settings, where the GroupQuotas enforcement is enabled. The locations not included in GroupQuota Enforcement will not be listed, the regions in failed status with listed as status Failed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupQuotaLocationSettings_List")
  list is ArmResourceListByParent<
    GroupQuotasEnforcementStatus,
    Response = ArmResponse<GroupQuotasEnforcementListResponse>
  >;
}

@@minLength(GroupQuotasEnforcementStatus.name, 1);
@@doc(GroupQuotasEnforcementStatus.name, "The name of the Azure region.");
@@doc(GroupQuotasEnforcementStatus.properties, "");
@@doc(GroupQuotasEnforcementStatuses.createOrUpdate::parameters.resource,
  "The GroupQuota body details for creation or update of a GroupQuota entity."
);
@@doc(GroupQuotasEnforcementStatuses.update::parameters.properties,
  "The GroupQuota body details for creation or update of a GroupQuota entity."
);
