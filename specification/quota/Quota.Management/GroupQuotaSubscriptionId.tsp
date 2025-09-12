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
 * This represents a Azure subscriptionId that is associated with a GroupQuotasEntity.
 */
@parentResource(GroupQuotasEntity)
model GroupQuotaSubscriptionId
  is Azure.ResourceManager.ProxyResource<GroupQuotaSubscriptionIdProperties> {
  ...ResourceNameParameter<
    Resource = GroupQuotaSubscriptionId,
    KeyName = "subscriptionId",
    SegmentName = "subscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GroupQuotaSubscriptionIdsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /**
         * The provider namespace for the resource.
         */
        @path
        @segment("providers")
        providerNameSpace: "Microsoft.Management",

        /**
         * Management Group Id.
         */
        @path
        @segment("managementGroups")
        @minLength(3)
        @maxLength(63)
        managementGroupId: string,

        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
         */
        @path
        @segment("groupQuotas")
        @minLength(3)
        @maxLength(63)
        @pattern("^[a-z][a-z0-9]*$")
        groupQuotaName: string,
      },
      {
        ...SubscriptionIdParameter,
      }
    > {}

@armResourceOperations
interface GroupQuotaSubscriptionIds {
  /**
   * Returns the subscriptionIds along with its provisioning state for being associated with the GroupQuota. If the subscription is not a member of GroupQuota, it will return 404, else 200.
   */
  get is Extension.Read<
    Extension.ManagementGroup<"managementGroupId">,
    GroupQuotaSubscriptionId
  >;

  /**
   * Adds a subscription to GroupQuotas. The subscriptions will be validated based on the additionalAttributes defined in the GroupQuota. The additionalAttributes works as filter for the subscriptions, which can be included in the GroupQuotas. The request's TenantId is validated against the subscription's TenantId.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is GroupQuotaSubscriptionIdsOps.CreateOrUpdateAsync<
    GroupQuotaSubscriptionId,
    Response = ArmResourceUpdatedResponse<GroupQuotaSubscriptionId> | ArmResourceCreatedResponse<
      GroupQuotaSubscriptionId,
      ArmCombinedLroHeaders<FinalResult = GroupQuotaSubscriptionId> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Request = void
  >;

  /**
   * Updates the GroupQuotas with the subscription to add to the subscriptions list. The subscriptions will be validated if additionalAttributes are defined in the GroupQuota. The request's TenantId is validated against the subscription's TenantId.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is GroupQuotaSubscriptionIdsOps.CustomPatchAsync<
    GroupQuotaSubscriptionId,
    PatchModel = void,
    Response = ArmResponse<GroupQuotaSubscriptionId> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = GroupQuotaSubscriptionId> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Removes the subscription from GroupQuotas. The request's TenantId is validated against the subscription's TenantId.
   */
  delete is Extension.DeleteWithoutOkAsync<
    Extension.ManagementGroup<"managementGroupId">,
    GroupQuotaSubscriptionId,
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of the subscriptionIds associated with the GroupQuotas.
   */
  list is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    GroupQuotaSubscriptionId,
    Response = ArmResponse<GroupQuotaSubscriptionIdList>
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(GroupQuotaSubscriptionId.name, "uuid");
@@doc(GroupQuotaSubscriptionId.name,
  "The ID of the target subscription. The value must be an UUID."
);
@@doc(GroupQuotaSubscriptionId.properties, "");
