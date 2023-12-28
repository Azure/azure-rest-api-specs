import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Managed Virtual Network resource type.")
@parentResource(Factory)
model ManagedVirtualNetworkResource is ProxyResource<ManagedVirtualNetwork> {
  @doc("Managed virtual network name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @key("managedVirtualNetworkName")
  @segment("managedVirtualNetworks")
  name: string;
}

@armResourceOperations
interface ManagedVirtualNetworks {
  @doc("Gets a managed Virtual Network.")
  get is ArmResourceRead<
    ManagedVirtualNetworkResource,
    {
      ...BaseParameters<ManagedVirtualNetworkResource>;

      @doc("ETag of the managed Virtual Network entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a managed Virtual Network.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedVirtualNetworkResource,
    {
      ...BaseParameters<ManagedVirtualNetworkResource>;

      @doc("ETag of the managed Virtual Network entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Lists managed Virtual Networks.")
  listByFactory is ArmResourceListByParent<ManagedVirtualNetworkResource>;
}
