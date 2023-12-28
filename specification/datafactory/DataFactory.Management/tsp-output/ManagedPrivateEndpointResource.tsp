import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedVirtualNetworkResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Managed private endpoint resource type.")
@parentResource(ManagedVirtualNetworkResource)
model ManagedPrivateEndpointResource is ProxyResource<ManagedPrivateEndpoint> {
  @doc("Managed private endpoint name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface ManagedPrivateEndpoints {
  @doc("Gets a managed private endpoint.")
  get is ArmResourceRead<
    ManagedPrivateEndpointResource,
    {
      ...BaseParameters<ManagedPrivateEndpointResource>;

      @doc("ETag of the managed private endpoint entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a managed private endpoint.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedPrivateEndpointResource,
    {
      ...BaseParameters<ManagedPrivateEndpointResource>;

      @doc("ETag of the managed private endpoint entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a managed private endpoint.")
  delete is ArmResourceDeleteSync<ManagedPrivateEndpointResource>;
  @doc("Lists managed private endpoints.")
  listByFactory is ArmResourceListByParent<ManagedPrivateEndpointResource>;
}
