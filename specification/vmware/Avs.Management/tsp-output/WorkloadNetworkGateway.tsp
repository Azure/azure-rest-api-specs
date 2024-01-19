import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a gateway by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetGateway")
  getGateway is ArmResourceRead<WorkloadNetworkGateway>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of gateways in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListGateways")
  listGateways is ArmResourceListByParent<WorkloadNetworkGateway>;
}
