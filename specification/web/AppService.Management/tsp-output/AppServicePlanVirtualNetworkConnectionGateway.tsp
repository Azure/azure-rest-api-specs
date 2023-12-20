import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServicePlanVirtualNetworkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("The Virtual Network gateway contract. This is used to give the Virtual Network gateway access to the VPN package.")
@parentResource(AppServicePlanVirtualNetworkConnection)
model AppServicePlanVirtualNetworkConnectionGateway
  is ProxyResource<VnetGatewayProperties> {
  @doc("Name of the gateway. Only the 'primary' gateway is supported.")
  @path
  @key("gatewayName")
  @segment("gateways")
  name: string;
}

@armResourceOperations
interface AppServicePlanVirtualNetworkConnectionGateways {
  @doc("Description for Get a Virtual Network gateway.")
  getVnetGateway is ArmResourceRead<AppServicePlanVirtualNetworkConnectionGateway>;
  @doc("Description for Update a Virtual Network gateway.")
  updateVnetGateway is ArmResourceCreateOrReplaceSync<AppServicePlanVirtualNetworkConnectionGateway>;
}
