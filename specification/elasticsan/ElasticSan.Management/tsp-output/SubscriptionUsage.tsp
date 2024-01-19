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
@doc("Usage Metric of a Subscription in a Location.")
@locationResource
model SubscriptionUsage is ProxyResource<SubscriptionUsageProperties> {
  @doc("Name of usage metric to return.")
  @path
  @key("usageName")
  @segment("usages")
  name: string;
}

@armResourceOperations
interface SubscriptionUsages {
  @doc("Gets a subscription usage metric.")
  get is ArmResourceRead<SubscriptionUsage>;

  @doc("Gets all subscription usage metrics in a given location.")
  listByLocation is ArmResourceListByParent<SubscriptionUsage>;
}
