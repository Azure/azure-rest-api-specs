import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A virtual network.")
@parentResource(DevTestLab)
model DevTestLabVirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("The name of the virtual network.")
  @path
  @key("name")
  @segment("virtualnetworks")
  name: string;
}

@armResourceOperations
interface DevTestLabVirtualNetworks {
  @doc("Get virtual network.")
  get is ArmResourceRead<
    DevTestLabVirtualNetwork,
    {
      ...BaseParameters<DevTestLabVirtualNetwork>;

      @doc("Specify the $expand query. Example: 'properties($expand=externalSubnets)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing virtual network. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLabVirtualNetwork>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of virtual networks. All other properties will be ignored.")
  update is ArmCustomPatchSync<
    DevTestLabVirtualNetwork,
    VirtualNetworkFragment
  >;
  @doc("Delete virtual network. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DevTestLabVirtualNetwork>;
  @doc("List virtual networks in a given lab.")
  list is ArmResourceListByParent<
    DevTestLabVirtualNetwork,
    {
      ...BaseParameters<DevTestLabVirtualNetwork>;

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
