import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedVirtualNetworkResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
@doc("Managed private endpoint resource type.")
@parentResource(ManagedVirtualNetworkResource)
model ManagedPrivateEndpointResource is ProxyResource<ManagedPrivateEndpoint> {
  @doc("Managed private endpoint name")
  @maxLength(127)
  @minLength(1)
  @pattern("^([_A-Za-z0-9]|([_A-Za-z0-9][-_A-Za-z0-9]{0,125}[_A-Za-z0-9]))$")
  @path
  @key("managedPrivateEndpointName")
  @segment("managedPrivateEndpoints")
  name: string;
}

@armResourceOperations
interface ManagedPrivateEndpointResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a managed private endpoint.")
  @operationId("ManagedPrivateEndpoints_Get")
  get is ArmResourceRead<
    ManagedPrivateEndpointResource,
    {
      ...BaseParameters<ManagedPrivateEndpointResource>;

      @doc("ETag of the managed private endpoint entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a managed private endpoint.")
  @operationId("ManagedPrivateEndpoints_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ManagedPrivateEndpointResource,
    {
      ...BaseParameters<ManagedPrivateEndpointResource>;

      @doc("ETag of the managed private endpoint entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a managed private endpoint.")
  @operationId("ManagedPrivateEndpoints_Delete")
  delete is ArmResourceDeleteSync<ManagedPrivateEndpointResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists managed private endpoints.")
  @operationId("ManagedPrivateEndpoints_ListByFactory")
  listByFactory is ArmResourceListByParent<ManagedPrivateEndpointResource>;
}

@@projectedName(ManagedPrivateEndpointResources.createOrUpdate::parameters.resource,
  "json",
  "managedPrivateEndpoint"
);
@@extension(ManagedPrivateEndpointResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedPrivateEndpoint"
);
@@doc(ManagedPrivateEndpointResources.createOrUpdate::parameters.resource,
  "Managed private endpoint resource definition."
);
