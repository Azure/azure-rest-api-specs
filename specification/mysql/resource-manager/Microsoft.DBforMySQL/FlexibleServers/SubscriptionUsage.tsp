// SubscriptionUsage.tsp
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DBforMySQL;

@doc("Subscription Usage resource.")
@subscriptionResource
@parentResource(SubscriptionLocationResource)
@added(Versions.v2025_12_01_preview)
model SubscriptionUsage is ProxyResource<SubscriptionUsageProperties> {
  @doc("Subscription Usage resource.")
  @path
  @key("subscriptionUsageName")
  @segment("usages")
  @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
  name: string = "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LocationBasedUsageOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      {}
    > {}

@armResourceOperations
interface SubscriptionUsages {
  @added(Versions.v2025_12_01_preview)
  get is LocationBasedUsageOps.Read<SubscriptionUsage>;
}
