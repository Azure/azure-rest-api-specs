import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Usage Metric of a Subscription in a Location.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@Azure.ResourceManager.Private.armResourceInternal(SubscriptionUsageProperties)
@includeInapplicableMetadataInPayload(false)
model SubscriptionUsage extends ProxyResource {
  /**
   * Name of usage metric to return.
   */
  @path
  @key("usageName")
  @segment("usages")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SubscriptionUsageProperties;
}

@armResourceOperations
interface SubscriptionUsages {
  /**
   * Gets a subscription usage metric.
   */
  get is ArmResourceRead<SubscriptionUsage>;

  /**
   * Gets all subscription usage metrics in a given location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SubscriptionUsages_ListByLocation")
  listByLocation is ArmResourceListByParent<SubscriptionUsage>;
}
