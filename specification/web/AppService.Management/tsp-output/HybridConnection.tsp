import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Hybrid Connection contract. This is used to configure a Hybrid Connection.")
@parentResource(AppServicePlan)
model HybridConnection is ProxyResource<HybridConnectionProperties> {
  @doc("Name of the Service Bus relay.")
  @key("relayName")
  @segment("relays")
  name: string;
}

@armResourceOperations
@projectedName("client", "AppServicePlans")
interface HybridConnections_AppServicePlans {
  @doc("Description for Retrieve a Hybrid Connection in use in an App Service plan.")
  getHybridConnection is ArmResourceRead<HybridConnection>;

  @doc("Description for Delete a Hybrid Connection in use in an App Service plan.")
  deleteHybridConnection is ArmResourceDeleteSync<HybridConnection>;

  @doc("Description for Get the send key name and value of a Hybrid Connection.")
  listHybridConnectionKeys is ArmResourceActionSync<
    HybridConnection,
    void,
    HybridConnectionKey
  >;

  @summary("Get all apps that use a Hybrid Connection in an App Service Plan.")
  @doc("Description for Get all apps that use a Hybrid Connection in an App Service Plan.")
  // FIXME: AppServicePlans_ListWebAppsByHybridConnection could not be converted to a resource operation
  ListWebAppsByHybridConnection is Azure.Core.ResourceList<string>;
}
