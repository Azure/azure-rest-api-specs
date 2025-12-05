import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Quota;
/**
 * Subscription quota list.
 */
model SubscriptionQuotaAllocationsList
  is Azure.ResourceManager.ExtensionResource<SubscriptionQuotaAllocationsListProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionQuotaAllocationsList,
    KeyName = "location",
    SegmentName = "quotaAllocations",
    NamePattern = ""
  >;
}

alias SubscriptionQuotaAllocationsListsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    @minLength(3)
    @maxLength(63)
    managementGroupId: string;

    ...SubscriptionIdParameter;
  },
  {
    ...Extension.ExtensionProviderNamespace<SubscriptionQuotaAllocationsList>;
  },
  {
    ...Extension.ExtensionProviderNamespace<SubscriptionQuotaAllocationsList>;

    /**
     * The GroupQuota name. The name should be unique for the provided context tenantId/MgId.
     */
    @path
    @segment("groupQuotas")
    @minLength(3)
    @maxLength(63)
    @pattern("^[a-z][a-z0-9]*$")
    groupQuotaName: string;

    /**
     * The resource provider name, such as - Microsoft.Compute. Currently only Microsoft.Compute resource provider supports this API.
     */
    @path
    @segment("resourceProviders")
    @pattern("^((?!-)[a-zA-Z0-9-]{1,63}(?<!-)\\.)+[a-zA-Z]{2,63}$")
    resourceProviderName: string;

    /**
     * The name of the Azure region.
     */
    @path
    @segment("quotaAllocations")
    @minLength(1)
    location: Azure.Core.azureLocation;
  }
>;

@armResourceOperations
interface SubscriptionQuotaAllocationsLists {
  /**
   * Gets all the quota allocated to a subscription for the specified resource provider and location for resource names passed in $filter=resourceName eq {SKU}. This will include the GroupQuota and total quota allocated to the subscription. Only the Group quota allocated to the subscription can be allocated back to the MG Group Quota.
   */
  list is SubscriptionQuotaAllocationsListsOps.Read<SubscriptionQuotaAllocationsList>;

  /**
   * Request to assign quota from group quota to a specific Subscription. The assign GroupQuota to subscriptions or reduce the quota allocated to subscription to give back the unused quota ( quota >= usages) to the groupQuota. So, this API can be used to assign Quota to subscriptions and assign back unused quota to group quota, which can be assigned to another subscriptions in the GroupQuota. User can collect unused quotas from multiple subscriptions within the groupQuota and assign the groupQuota to the subscription, where it's needed.
   */
  @patch(#{ implicitOptionality: false })
  update is SubscriptionQuotaAllocationsListsOps.CustomPatchAsync<
    SubscriptionQuotaAllocationsList,
    PatchModel = SubscriptionQuotaAllocationsList,
    Response = ArmResponse<SubscriptionQuotaAllocationsList> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SubscriptionQuotaAllocationsList> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@minLength(SubscriptionQuotaAllocationsList.name, 1);
@@doc(SubscriptionQuotaAllocationsList.name, "The name of the Azure region.");
@@doc(SubscriptionQuotaAllocationsList.properties, "");
@@doc(SubscriptionQuotaAllocationsLists.update::parameters.properties,
  "Quota requests payload."
);
