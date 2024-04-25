import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/PacketCoreDataPlaneModels.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Packet core data plane resource. Must be created in the same location as its parent packet core control plane.")
@resource("packetCoreDataPlanes")
@parentResource(PacketCoreControlPlane)
model PacketCoreDataPlane
  is TrackedResource<PacketCoreDataPlanePropertiesFormat> {
  @doc("The name of the packet core data plane.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("packetCoreDataPlaneName")
  @segment("packetCoreDataPlanes")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PacketCoreDataPlanes {
  @doc("Gets information about the specified packet core data plane.")
  get is ArmResourceRead<PacketCoreDataPlane>;

  @doc("Creates or updates a packet core data plane. Must be created in the same location as its parent packet core control plane.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PacketCoreDataPlane>;

  @doc("Updates packet core data planes tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<PacketCoreDataPlane, TagsObject>;

  @doc("Deletes the specified packet core data plane.")
  delete is ArmResourceDeleteWithoutOkAsync<PacketCoreDataPlane>;

  @doc("Lists all the packet core data planes associated with a packet core control plane.")
  listByPacketCoreControlPlane is ArmResourceListByParent<PacketCoreDataPlane>;
}

@@doc(PacketCoreDataPlanes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update packet core data plane operation."
);
@@doc(PacketCoreDataPlanes.updateTags::parameters.properties,
  "Parameters supplied to update packet core data plane tags."
);
