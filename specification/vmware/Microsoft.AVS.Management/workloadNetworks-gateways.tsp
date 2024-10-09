namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkGateways {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListGateways")
  list is ArmResourceListByParent<
    WorkloadNetworkGateway,
    Response = ArmResponse<ResourceList<WorkloadNetworkGateway>>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetGateway")
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
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Gateway Path.")
  @visibility("read")
  path?: string;
}
