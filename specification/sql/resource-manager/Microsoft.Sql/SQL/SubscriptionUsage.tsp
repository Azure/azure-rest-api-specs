import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Usage Metric of a Subscription in a Location.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@subscriptionResource
@Azure.ResourceManager.Legacy.feature(Features.SubscriptionUsages)
model SubscriptionUsage
  is Azure.ResourceManager.ProxyResource<SubscriptionUsageProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionUsage,
    KeyName = "usageName",
    SegmentName = "usages",
    NamePattern = ""
  >;
}

alias SubscriptionUsagesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the region where the resource is located. */
    @path
    @segment("locations")
    @key
    locationName: string;
  },
  {
    /** Name of usage metric to return. */
    @path
    @segment("usages")
    @key
    usageName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.SubscriptionUsages)
interface SubscriptionUsages {
  /**
   * Gets a subscription usage metric.
   */
  get is SubscriptionUsagesOps.Read<SubscriptionUsage>;

  /**
   * Gets all subscription usage metrics in a given location.
   */
  listByLocation is SubscriptionUsagesOps.List<SubscriptionUsage>;
}

@@doc(SubscriptionUsage.name, "Name of usage metric to return.");
@@doc(SubscriptionUsage.properties, "Resource properties.");
