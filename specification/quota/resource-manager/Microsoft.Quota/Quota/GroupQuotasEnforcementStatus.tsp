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

alias GroupQuotasEnforcementStatusesOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Management";

    /**
     * The management group ID.
     */
    @path
    @segment("managementGroups")
    @key
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;
  },
  {
    ...Extension.ExtensionProviderNamespace<QuotaAllocationRequestStatus>;

    /**
     * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
     */
    @path
    @segment("groupQuotas")
    @minLength(3)
    @maxLength(63)
    @key
    @pattern("^[a-z][a-z0-9]*$")
    groupQuotaName: string;

    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @key
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;

    /**
     * The name of the Azure region.
     */
    @path
    @minLength(1)
    @segment("locationSettings")
    location: Azure.Core.azureLocation;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GroupQuotasEnforcementStatuses {
  /**
   * Gets the GroupQuotas enforcement settings for the ResourceProvider/location. The locations, where GroupQuota enforcement is not enabled will return Not Found.
   */
  get is GroupQuotasEnforcementStatusesOps.Read<GroupQuotasEnforcementStatus>;

  /**
   * Enables the GroupQuotas enforcement for the resource provider and the location specified. The resource provider will start using the group quotas as the overall quota for the subscriptions included in the GroupQuota. The subscriptions cannot request quota at subscription level since it is now part of an enforced group.
   * The subscriptions share the GroupQuotaLimits assigned to the GroupQuota. If the GroupQuotaLimits is used, then submit a groupQuotaLimit request for the specific resource - provider/location/resource.
   * Once the GroupQuota Enforcement is enabled then, it cannot be deleted or reverted back. To disable GroupQuota Enforcement -
   *  1. Remove all the subscriptions from the groupQuota using the delete API for Subscriptions (Check the example - GroupQuotaSubscriptions_Delete).
   *  2. Then delete the GroupQuota (Check the example - GroupQuotas_Delete).
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is GroupQuotasEnforcementStatusesOps.CreateOrUpdateAsync<
    GroupQuotasEnforcementStatus,
    Response = ArmResourceUpdatedResponse<GroupQuotasEnforcementStatus> | ArmResourceCreatedResponse<
      GroupQuotasEnforcementStatus,
      ArmCombinedLroHeaders<FinalResult = GroupQuotasEnforcementStatus> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OptionalRequestBody = true
  >;

  /**
   * Enables the GroupQuotas enforcement for the resource provider and the location specified. The resource provider will start using the group quotas as the overall quota for the subscriptions included in the GroupQuota.  The subscriptions cannot request quota at subscription level since it is now part of an enforced group.
   * The subscriptions share the GroupQuotaLimits assigned to the GroupQuota. If the GroupQuotaLimits is used, then submit a groupQuotaLimit request for the specific resource - provider/location/resource.
   * Once the GroupQuota Enforcement is enabled then, it cannot be deleted or reverted back. To disable GroupQuota Enforcement -
   *  1. Remove all the subscriptions from the groupQuota using the delete API for Subscriptions (Check the example - GroupQuotaSubscriptions_Delete).
   *  2. Ten delete the GroupQuota (Check the example - GroupQuotas_Delete).
   */
  @patch(#{ implicitOptionality: false })
  update is GroupQuotasEnforcementStatusesOps.CustomPatchAsync<
    GroupQuotasEnforcementStatus,
    PatchModel = GroupQuotasEnforcementStatus,
    Response = ArmResponse<GroupQuotasEnforcementStatus> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GroupQuotasEnforcementStatus> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OptionalRequestBody = true
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
