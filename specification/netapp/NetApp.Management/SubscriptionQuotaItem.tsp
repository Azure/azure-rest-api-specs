import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.NetApp;
/**
 * Information regarding Quota Item.
 */
@renamedFrom(Versions.v2025_07_01_preview, "SubscriptionQuotaItem")
@parentResource(SubscriptionLocationResource)
model QuotaItem is Azure.ResourceManager.ProxyResource<QuotaItemProperties> {
  ...ResourceNameParameter<
    Resource = QuotaItem,
    KeyName = "quotaLimitName",
    SegmentName = "quotaLimits",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9\\-]{0,62}$"
  >;
}

/**
 * List of Quota Items
 */
@renamedFrom(Versions.v2025_07_01_preview, "SubscriptionQuotaItemList")
model QuotaItemList is Azure.Core.Page<QuotaItem>;

/**
 * QuotaItem Properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@renamedFrom(Versions.v2025_07_01_preview, "SubscriptionQuotaItemProperties")
model QuotaItemProperties {
  /**
   * The current quota value.
   */
  @visibility(Lifecycle.Read)
  current?: int32;

  /**
   * The default quota value.
   */
  @visibility(Lifecycle.Read)
  default?: int32;
}

@armResourceOperations
interface SubscriptionQuotaItems {
  /**
   * Get the default and current quota limit
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceQuotaLimits_Get")
  get is ArmResourceRead<
    QuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the default and current limits for quotas
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceQuotaLimits_List")
  list is ArmResourceListByParent<
    QuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<QuotaItemList>
  >;
}

@@doc(QuotaItem.name, "The name of the Quota Limit");
@@doc(QuotaItem.properties, "QuotaItem properties");
