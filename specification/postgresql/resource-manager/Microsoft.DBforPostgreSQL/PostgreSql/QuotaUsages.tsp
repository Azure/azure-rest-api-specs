import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Capability for the PostgreSQL server
 */
model QuotaUsageList is Azure.Core.Page<QuotaUsage>;

/**
 * Quota usage for servers
 */
model QuotaUsage {
  /**
   * Name of quota usage for servers
   */
  name?: NameProperty;

  /**
   * Quota limit
   */
  limit?: int64;

  /**
   * Quota unit
   */
  unit?: string = "Count";

  /**
   * Current Quota usage value
   */
  currentValue?: int64;

  /**
   * Fully qualified ARM resource Id
   */
  id?: string;
}

/**
 * Name property for quota usage
 */
model NameProperty {
  /**
   * Name value
   */
  value?: string;

  /**
   * Localized name
   */
  localizedValue?: string;
}

@@visibility(QuotaUsageList.value, Lifecycle.Read);

@@identifiers(QuotaUsageList.value, #["name"]);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface QuotaUsagesOperationGroup {
  /**
   * Get quota usages at specified location in a given subscription.
   */
  @autoRoute
  @get
  @list
  @action("resourceType/flexibleServers/usages")
  list is ArmProviderActionSync<
    Response = QuotaUsageList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
