import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Information regarding Subscription Quota Item.
 */
@subscriptionResource
model SubscriptionQuotaItem
  is Azure.ResourceManager.ProxyResource<SubscriptionQuotaItemProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionQuotaItem,
    KeyName = "quotaLimitName",
    SegmentName = "quotaLimits",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-]{0,62}$"
  >;
}

@armResourceOperations
interface SubscriptionQuotaItems {
  /**
   * Get the default and current subscription quota limit
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceQuotaLimits_Get")
  get is ArmResourceRead<
    SubscriptionQuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the default and current limits for quotas
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceQuotaLimits_List")
  list is ArmResourceListByParent<
    SubscriptionQuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SubscriptionQuotaItemList>
  >;
}

@@doc(SubscriptionQuotaItem.name, "The name of the Quota Limit");
@@doc(SubscriptionQuotaItem.properties, "SubscriptionQuotaItem properties");
