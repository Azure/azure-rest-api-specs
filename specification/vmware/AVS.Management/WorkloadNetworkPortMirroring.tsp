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
@doc("NSX Port Mirroring")
@parentResource(PrivateCloud)
model WorkloadNetworkPortMirroring
  is ProxyResource<WorkloadNetworkPortMirroringProperties> {
  @doc("NSX Port Mirroring identifier. Generally the same as the Port Mirroring display name")
  @path
  @key("portMirroringId")
  @segment("portMirroringProfiles")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkPortMirrorings {
  @doc("Get a port mirroring profile by id in a private cloud workload network.")
  getPortMirroring is ArmResourceRead<WorkloadNetworkPortMirroring>;
  @doc("Create a port mirroring profile by id in a private cloud workload network.")
  createPortMirroring is ArmResourceCreateOrUpdateAsync<WorkloadNetworkPortMirroring>;
  @doc("Create or update a port mirroring profile by id in a private cloud workload network.")
  updatePortMirroring is ArmResourcePatchAsync<
    WorkloadNetworkPortMirroring,
    WorkloadNetworkPortMirroringProperties
  >;
  @doc("Delete a port mirroring profile by id in a private cloud workload network.")
  deletePortMirroring is ArmResourceDeleteAsync<WorkloadNetworkPortMirroring>;
  @doc("List of port mirroring profiles in a private cloud workload network.")
  listPortMirroring is ArmResourceListByParent<WorkloadNetworkPortMirroring>;
}
