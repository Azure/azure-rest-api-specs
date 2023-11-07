import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
@doc("The VirtualNetworks resource definition.")
model VirtualNetwork is TrackedResource<VirtualNetworkProperties> {
  @doc("Name of the VirtualNetwork.")
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualNetworks {
  @doc("Implements VirtualNetwork GET method.")
  get is ArmResourceRead<VirtualNetwork>;
  @doc("Onboards the ScVmm virtual network as an Azure virtual network resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualNetwork>;
  @doc("Updates the VirtualNetworks resource.")
  update is ArmTagsPatchAsync<VirtualNetwork>;
  @doc("Deregisters the ScVmm virtual network from Azure.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    {
      ...BaseParameters<VirtualNetwork>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: Force;
    }
  >;
  @doc("List of VirtualNetworks in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualNetwork>;
  @doc("List of VirtualNetworks in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualNetwork>;
}
