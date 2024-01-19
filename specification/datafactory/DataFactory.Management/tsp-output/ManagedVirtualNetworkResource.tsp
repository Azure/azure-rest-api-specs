import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
@doc("Managed Virtual Network resource type.")
@parentResource(Factory)
model ManagedVirtualNetworkResource is ProxyResource<ManagedVirtualNetwork> {
  @doc("Managed virtual network name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @path
  @key("managedVirtualNetworkName")
  @segment("managedVirtualNetworks")
  name: string;
}

@armResourceOperations
interface ManagedVirtualNetworkResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a managed Virtual Network.")
  @operationId("ManagedVirtualNetworks_Get")
  get is ArmResourceRead<
    ManagedVirtualNetworkResource,
    {
      ...BaseParameters<ManagedVirtualNetworkResource>;

      @doc("ETag of the managed Virtual Network entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a managed Virtual Network.")
  @operationId("ManagedVirtualNetworks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedVirtualNetworkResource,
    {
      ...BaseParameters<ManagedVirtualNetworkResource>;

      @doc("ETag of the managed Virtual Network entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists managed Virtual Networks.")
  @operationId("ManagedVirtualNetworks_ListByFactory")
  listByFactory is ArmResourceListByParent<ManagedVirtualNetworkResource>;
}

@@projectedName(ManagedVirtualNetworkResources.createOrUpdate::parameters.resource,
  "json",
  "managedVirtualNetwork"
);
@@extension(ManagedVirtualNetworkResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedVirtualNetwork"
);
@@doc(ManagedVirtualNetworkResources.createOrUpdate::parameters.resource,
  "Managed Virtual Network resource definition."
);
