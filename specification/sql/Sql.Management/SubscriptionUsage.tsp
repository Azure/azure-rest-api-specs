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
@subscriptionResource
model SubscriptionUsage
  is Azure.ResourceManager.ProxyResource<SubscriptionUsageProperties> {
  ...ResourceNameParameter<
    Resource = SubscriptionUsage,
    KeyName = "usageName",
    SegmentName = "usages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SubscriptionUsages {
  /**
   * Gets a subscription usage metric.
   */
  get is ArmResourceRead<
    SubscriptionUsage,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets all subscription usage metrics in a given location.
   */
  listByLocation is ArmResourceListByParent<
    SubscriptionUsage,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(SubscriptionUsage.name, "Name of usage metric to return.");
@@doc(SubscriptionUsage.properties, "Resource properties.");
