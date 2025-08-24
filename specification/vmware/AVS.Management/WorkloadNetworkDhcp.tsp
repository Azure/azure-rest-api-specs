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
@doc("NSX DHCP")
@parentResource(PrivateCloud)
model WorkloadNetworkDhcp is ProxyResource<WorkloadNetworkDhcpEntity> {
  @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
  @path
  @key("dhcpId")
  @segment("dhcpConfigurations")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkDhcps {
  @doc("Get dhcp by id in a private cloud workload network.")
  getDhcp is ArmResourceRead<WorkloadNetworkDhcp>;
  @doc("Create dhcp by id in a private cloud workload network.")
  createDhcp is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDhcp>;
  @doc("Create or update dhcp by id in a private cloud workload network.")
  updateDhcp is ArmResourcePatchAsync<
    WorkloadNetworkDhcp,
    WorkloadNetworkDhcpEntity
  >;
  @doc("Delete dhcp by id in a private cloud workload network.")
  deleteDhcp is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;
  @doc("List dhcp in a private cloud workload network.")
  listDhcp is ArmResourceListByParent<WorkloadNetworkDhcp>;
}
