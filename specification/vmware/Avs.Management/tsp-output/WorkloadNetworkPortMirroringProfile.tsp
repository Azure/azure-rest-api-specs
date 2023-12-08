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
@doc("NSX Port Mirroring")
@parentResource(AvsPrivateCloud)
model WorkloadNetworkPortMirroringProfile
  is ProxyResource<WorkloadNetworkPortMirroringProperties> {
  @doc("NSX Port Mirroring identifier. Generally the same as the Port Mirroring display name")
  @path
  @key("portMirroringId")
  @segment("portMirroringProfiles")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkPortMirroringProfiles {
  @doc("Get a port mirroring profile by id in a private cloud workload network.")
  getPortMirroring is ArmResourceRead<WorkloadNetworkPortMirroringProfile>;
  @doc("Create a port mirroring profile by id in a private cloud workload network.")
  createPortMirroring is ArmResourceCreateOrUpdateAsync<WorkloadNetworkPortMirroringProfile>;
  @doc("Create or update a port mirroring profile by id in a private cloud workload network.")
  updatePortMirroring is ArmResourcePatchAsync<
    WorkloadNetworkPortMirroringProfile,
    WorkloadNetworkPortMirroringProperties
  >;
  @doc("Delete a port mirroring profile by id in a private cloud workload network.")
  deletePortMirroring is ArmResourceDeleteAsync<WorkloadNetworkPortMirroringProfile>;
  @doc("List of port mirroring profiles in a private cloud workload network.")
  listPortMirroring is ArmResourceListByParent<WorkloadNetworkPortMirroringProfile>;
}
