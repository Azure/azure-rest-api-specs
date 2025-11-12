import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Rest;
using Azure.ResourceManager;
using Http;
using Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;
/**
 * Information regarding Quota Item.
 */
@renamedFrom(Versions.v2025_07_01_preview, "SubscriptionQuotaItem")
@clientName("NetAppSubscriptionQuotaItem", "csharp")
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

  /**
   * The usage quota value.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @added(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read)
  usage?: int32 | null;
}

@armResourceOperations
interface SubscriptionQuotaItems {
  /**
   * Get the default and current quota limit
   */
  get is ArmResourceRead<
    QuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get the default and current limits for quotas
   */
  list is ArmResourceListByParent<
    QuotaItem,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<QuotaItemList>
  >;
}

alias NetAppResourceQuotaLimitsAccountOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the NetApp account */
    @path
    @segment("netAppAccounts")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
    accountName: string;
  },
  {
    /** The name of the Quota Limit */
    @path
    @segment("quotaLimits")
    @key
    @pattern("^[a-zA-Z][a-zA-Z0-9\\-]{0,62}$")
    quotaLimitName: string;
  }
>;

@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface NetAppResourceQuotaLimitsAccount {
  /**
   * Get the default, current and usages account quota limit
   */
  get is NetAppResourceQuotaLimitsAccountOps.Read<QuotaItem>;

  /**
   * Gets a list of quota limits for all quotas that are under account. Currently PoolsPerAccount is the only one.
   */
  list is NetAppResourceQuotaLimitsAccountOps.List<
    QuotaItem,
    Response = ArmResponse<QuotaItemList>
  >;
}

@@doc(QuotaItem.name, "The name of the Quota Limit");
@@doc(QuotaItem.properties, "QuotaItem properties");
