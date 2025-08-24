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
@doc("NSX VM Group")
@parentResource(PrivateCloud)
model WorkloadNetworkVMGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
  @path
  @key("vmGroupId")
  @segment("vmGroups")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkVMGroups {
  @doc("Get a vm group by id in a private cloud workload network.")
  getVMGroup is ArmResourceRead<WorkloadNetworkVMGroup>;
  @doc("Create a vm group by id in a private cloud workload network.")
  createVMGroup is ArmResourceCreateOrUpdateAsync<WorkloadNetworkVMGroup>;
  @doc("Create or update a vm group by id in a private cloud workload network.")
  updateVMGroup is ArmResourcePatchAsync<
    WorkloadNetworkVMGroup,
    WorkloadNetworkVMGroupProperties
  >;
  @doc("Delete a vm group by id in a private cloud workload network.")
  deleteVMGroup is ArmResourceDeleteAsync<WorkloadNetworkVMGroup>;
  @doc("List of vm groups in a private cloud workload network.")
  listVMGroups is ArmResourceListByParent<WorkloadNetworkVMGroup>;
}
