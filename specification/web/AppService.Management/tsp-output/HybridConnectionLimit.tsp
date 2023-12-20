import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Hybrid Connection limits contract. This is used to return the plan limits of Hybrid Connections.")
@parentResource(AppServicePlan)
@singleton("limit")
model HybridConnectionLimit is ProxyResource<HybridConnectionLimitsProperties> {
  @key("limit")
  @segment("hybridConnectionPlanLimits")
  name: string;
}

@armResourceOperations
interface HybridConnectionLimits {
  @doc("Description for Get the maximum number of Hybrid Connections allowed in an App Service plan.")
  getHybridConnectionPlanLimit is ArmResourceRead<HybridConnectionLimit>;
}
