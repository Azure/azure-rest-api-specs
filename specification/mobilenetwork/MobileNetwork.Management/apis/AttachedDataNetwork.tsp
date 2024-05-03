import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/AttachedDataNetworkModels.tsp";
import "./PacketCoreDataPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Attached data network resource. Must be created in the same location as its parent packet core data plane.")
@resource("attachedDataNetworks")
@parentResource(PacketCoreDataPlane)
model AttachedDataNetwork
  is TrackedResource<AttachedDataNetworkPropertiesFormat> {
  @doc("The name of the attached data network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*(\\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])*)*$")
  @path
  @key("attachedDataNetworkName")
  @segment("attachedDataNetworks")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface AttachedDataNetworks {
  @doc("Gets information about the specified attached data network.")
  get is ArmResourceRead<AttachedDataNetwork>;

  @doc("Creates or updates an attached data network. Must be created in the same location as its parent packet core data plane.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AttachedDataNetwork>;

  @doc("Updates an attached data network tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<AttachedDataNetwork, TagsObject>;

  @doc("Deletes the specified attached data network.")
  delete is ArmResourceDeleteWithoutOkAsync<AttachedDataNetwork>;

  @doc("Gets all the attached data networks associated with a packet core data plane.")
  listByPacketCoreDataPlane is ArmResourceListByParent<AttachedDataNetwork>;
}

@@doc(AttachedDataNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update attached data network operation."
);
@@doc(AttachedDataNetworks.updateTags::parameters.properties,
  "Parameters supplied to update attached data network tags."
);
