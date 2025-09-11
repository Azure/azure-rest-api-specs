import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO - x-ms-azure-resource is this needed?"
@doc("The virtual network resource definition.")
@extension("x-ms-azure-resource", true)
@added(Versions.v2025_09_01_preview)
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the virtual network")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface VirtualNetworks {
  @doc("The operation to get a virtual network.")
  get is ArmResourceRead<VirtualNetwork>;

  @doc("The operation to create or update a virtual network. Please note some properties can be set only during virtualNetwork network creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetwork>;

  @doc("Updates a virtual network tags.")
  updateTags is ArmTagsPatchAsync<VirtualNetwork, TagsObject>;

  @doc("The operation to delete a virtual network.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetwork>;

  @doc("Lists all of the virtual networks in the specified resource group. Use the nextLink property in the response to get the next page of virtualNetwork networks.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;

  @doc("Lists all of the virtual networks in the specified subscription. Use the nextLink property in the response to get the next page of virtualNetwork networks.")
  listAll is ArmListBySubscription<VirtualNetwork>;
}
