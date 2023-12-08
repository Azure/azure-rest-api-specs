import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AvsPrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("NSX VM Group")
@parentResource(AvsPrivateCloud)
model WorkloadNetworkVmGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
  @path
  @key("vmGroupId")
  @segment("vmGroups")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkVmGroups {
  @doc("Get a vm group by id in a private cloud workload network.")
  getVMGroup is ArmResourceRead<WorkloadNetworkVmGroup>;
  @doc("Create a vm group by id in a private cloud workload network.")
  createVMGroup is ArmResourceCreateOrUpdateAsync<WorkloadNetworkVmGroup>;
  @doc("Create or update a vm group by id in a private cloud workload network.")
  updateVMGroup is ArmResourcePatchAsync<
    WorkloadNetworkVmGroup,
    WorkloadNetworkVMGroupProperties
  >;
  @doc("Delete a vm group by id in a private cloud workload network.")
  deleteVMGroup is ArmResourceDeleteAsync<WorkloadNetworkVmGroup>;
  @doc("List of vm groups in a private cloud workload network.")
  listVMGroups is ArmResourceListByParent<WorkloadNetworkVmGroup>;
}
