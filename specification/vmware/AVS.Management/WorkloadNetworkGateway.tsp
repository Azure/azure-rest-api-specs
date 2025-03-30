import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("NSX Gateway.")
@parentResource(PrivateCloud)
model WorkloadNetworkGateway
  is ProxyResource<WorkloadNetworkGatewayProperties> {
  @doc("NSX Gateway identifier. Generally the same as the Gateway's display name")
  @path
  @key("gatewayId")
  @segment("gateways")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkGateways {
  @doc("Get a gateway by id in a private cloud workload network.")
  getGateway is ArmResourceRead<WorkloadNetworkGateway>;
  @doc("List of gateways in a private cloud workload network.")
  listGateways is ArmResourceListByParent<WorkloadNetworkGateway>;
}
