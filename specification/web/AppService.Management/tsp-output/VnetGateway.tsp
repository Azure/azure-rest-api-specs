import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VnetInfoResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("The Virtual Network gateway contract. This is used to give the Virtual Network gateway access to the VPN package.")
@parentResource(VnetInfoResource)
model VnetGateway is ProxyResource<VnetGatewayProperties> {
  @doc("Name of the gateway. Only the 'primary' gateway is supported.")
  @key("gatewayName")
  @segment("gateways")
  name: string;
}

@armResourceOperations
@projectedName("client", "AppServicePlans")
interface VnetGateways_AppServicePlans {
  @doc("Description for Get a Virtual Network gateway.")
  getVnetGateway is ArmResourceRead<VnetGateway>;

  @doc("Description for Update a Virtual Network gateway.")
  updateVnetGateway is ArmResourceCreateOrReplaceSync<VnetGateway>;
}
