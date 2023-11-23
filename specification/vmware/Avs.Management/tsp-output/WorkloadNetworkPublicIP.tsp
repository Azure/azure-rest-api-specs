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
@doc("NSX Public IP Block")
@parentResource(PrivateCloud)
model WorkloadNetworkPublicIP
  is ProxyResource<WorkloadNetworkPublicIPProperties> {
  @doc("NSX Public IP Block identifier. Generally the same as the Public IP Block's display name")
  @path
  @key("publicIPId")
  @segment("publicIPs")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkPublicIPS {
  @doc("Get a Public IP Block by id in a private cloud workload network.")
  getPublicIP is ArmResourceRead<WorkloadNetworkPublicIP>;
  @doc("Create a Public IP Block by id in a private cloud workload network.")
  createPublicIP is ArmResourceCreateOrUpdateAsync<WorkloadNetworkPublicIP>;
  @doc("Delete a Public IP Block by id in a private cloud workload network.")
  deletePublicIP is ArmResourceDeleteAsync<WorkloadNetworkPublicIP>;
  @doc("List of Public IP Blocks in a private cloud workload network.")
  listPublicIPs is ArmResourceListByParent<WorkloadNetworkPublicIP>;
}
