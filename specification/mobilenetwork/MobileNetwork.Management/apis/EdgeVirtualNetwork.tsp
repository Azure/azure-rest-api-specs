import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/EdgeVirtualNetworkModels.tsp";
import "./PacketCoreDataPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Edge Virtual Network resource.")
@resource("edgeVirtualNetworks")
@parentResource(PacketCoreDataPlane)
model EdgeVirtualNetwork
  is TrackedResource<EdgeVirtualNetworkPropertiesFormat> {
  @doc("The name of the Edge Virtual Network.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("edgeVirtualNetworkName")
  @segment("edgeVirtualNetworks")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface EdgeVirtualNetworks {
  @doc("Gets information about the specified Edge Virtual Network.")
  get is ArmResourceRead<EdgeVirtualNetwork>;

  @doc("Creates or updates an Edge Virtual Network .")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeVirtualNetwork>;

  @doc("Update Edge Virtual Network resource.")
  @parameterVisibility("read")
  update is ArmCustomPatchSync<EdgeVirtualNetwork, TagsObject>;

  @doc("Deletes the specified Edge Virtual Network.")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeVirtualNetwork>;

  @doc("Lists all the Edge Virtual Networks in a resource group.")
  listByPacketCoreDataPlane is ArmResourceListByParent<EdgeVirtualNetwork>;
}

@@doc(EdgeVirtualNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Edge Virtual Network operation."
);
@@doc(EdgeVirtualNetworks.update::parameters.properties,
  "Parameters supplied to patch Edge Virtual Network tags."
);
