import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("Packet core data plane resource. Must be created in the same location as its parent packet core control plane.")
@parentResource(PacketCoreControlPlane)
model PacketCoreDataPlane
  is TrackedResource<PacketCoreDataPlanePropertiesFormat> {
  @doc("The name of the packet core data plane.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("packetCoreDataPlaneName")
  @segment("packetCoreDataPlanes")
  name: string;
}

@armResourceOperations
interface PacketCoreDataPlanes {
  @doc("Gets information about the specified packet core data plane.")
  get is ArmResourceRead<PacketCoreDataPlane>;
  @doc("Creates or updates a packet core data plane. Must be created in the same location as its parent packet core control plane.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PacketCoreDataPlane>;
  @doc("Updates packet core data planes tags.")
  updateTags is ArmCustomPatchSync<PacketCoreDataPlane, TagsObject>;
  @doc("Deletes the specified packet core data plane.")
  delete is ArmResourceDeleteAsync<PacketCoreDataPlane>;
  @doc("Lists all the packet core data planes associated with a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCoreDataPlane>;
}
