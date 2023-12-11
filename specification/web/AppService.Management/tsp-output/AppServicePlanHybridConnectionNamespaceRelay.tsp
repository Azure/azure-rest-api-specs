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
@doc("Hybrid Connection contract. This is used to configure a Hybrid Connection.")
@parentResource(AppServicePlan)
model AppServicePlanHybridConnectionNamespaceRelay
  is ProxyResource<HybridConnectionProperties> {
  @doc("Name of the Service Bus relay.")
  @path
  @key("relayName")
  @segment("relays")
  name: string;
}

@armResourceOperations
interface AppServicePlanHybridConnectionNamespaceRelays {
  @doc("Description for Retrieve a Hybrid Connection in use in an App Service plan.")
  getHybridConnection is ArmResourceRead<AppServicePlanHybridConnectionNamespaceRelay>;
  @doc("Description for Delete a Hybrid Connection in use in an App Service plan.")
  deleteHybridConnection is ArmResourceDeleteSync<AppServicePlanHybridConnectionNamespaceRelay>;
  @doc("Description for Get the send key name and value of a Hybrid Connection.")
  listHybridConnectionKeys is ArmResourceActionSync<
    AppServicePlanHybridConnectionNamespaceRelay,
    {},
    HybridConnectionKey
  >;
  @summary("Get all apps that use a Hybrid Connection in an App Service Plan.")
  @doc("Description for Get all apps that use a Hybrid Connection in an App Service Plan.")
  ListWebAppsByHybridConnection is Azure.Core.ResourceList<string>;
}
