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
@parentResource(VirtualNetwork)
@added(Versions.v2025_09_01_preview)
model VirtualNetworkSubnet is ProxyResource<VirtualNetworkSubnetProperties> {
  @doc("Name of the virtual network subnet")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("subnetName")
  @segment("subnets")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_09_01_preview)
interface VirtualNetworkSubnets {
  @doc("The operation to get a virtual network subnet.")
  get is ArmResourceRead<VirtualNetworkSubnet>;

  @doc("The operation to create or update a virtual network subnet.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetworkSubnet>;

  @doc("The operation to update a virtual network subnet.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VirtualNetworkSubnet,
    VirtualNetworkSubnetUpdateRequest
  >;

  @doc("The operation to delete a virtual network.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualNetworkSubnet>;

  @doc("Lists all of the virtual network subnets in a  virtual network.")
  listByVirtualNetwork is ArmResourceListByParent<VirtualNetworkSubnet>;
}
