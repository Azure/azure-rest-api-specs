namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface WorkloadNetworkGateways {
  list is ArmResourceListByParent<
    WorkloadNetworkGateway,
    Response = ArmResponse<ResourceList<WorkloadNetworkGateway>>
  >;

  get is ArmResourceRead<WorkloadNetworkGateway>;
}

@doc("NSX Gateway.")
@parentResource(WorkloadNetwork)
model WorkloadNetworkGateway
  is ProxyResource<WorkloadNetworkGatewayProperties> {
  @doc("The ID of the NSX Gateway")
  @pattern("^[-\\w\\._]+$")
  @key("gatewayId")
  @path
  @segment("gateways")
  name: string;
}

@doc("Properties of a NSX Gateway.")
model WorkloadNetworkGatewayProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Gateway Path.")
  @visibility(Lifecycle.Read)
  path?: string;
}
