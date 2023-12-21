import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A virtual network.")
@parentResource(Lab)
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("The name of the virtual network.")
  @path
  @key("name")
  @segment("virtualnetworks")
  name: string;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Get virtual network.")
  get is ArmResourceRead<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Specify the $expand query. Example: 'properties($expand=externalSubnets)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing virtual network. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetwork>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of virtual networks. All other properties will be ignored.")
  update is ArmCustomPatchSync<VirtualNetwork, VirtualNetworkFragment>;
  @doc("Delete virtual network. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<VirtualNetwork>;
  @doc("List virtual networks in a given lab.")
  list is ArmResourceListByParent<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Specify the $expand query. Example: 'properties($expand=externalSubnets)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}
