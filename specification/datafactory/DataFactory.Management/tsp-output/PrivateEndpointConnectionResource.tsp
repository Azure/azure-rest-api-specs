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
@doc("Private Endpoint Connection ARM resource.")
@parentResource(Factory)
model PrivateEndpointConnectionResource
  is ProxyResource<RemotePrivateEndpointConnection> {
  @doc("The private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnectionResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a private endpoint connection")
  @operationId("PrivateEndpointConnection_Get")
  get is ArmResourceRead<
    PrivateEndpointConnectionResource,
    {
      ...BaseParameters<PrivateEndpointConnectionResource>;

      @doc("ETag of the private endpoint connection entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Approves or rejects a private endpoint connection")
  @operationId("PrivateEndpointConnection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateEndpointConnectionResource,
    {
      ...BaseParameters<PrivateEndpointConnectionResource>;

      @doc("ETag of the private endpoint connection entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a private endpoint connection")
  @operationId("PrivateEndpointConnection_Delete")
  delete is ArmResourceDeleteSync<PrivateEndpointConnectionResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists Private endpoint connections")
  @operationId("privateEndPointConnections_ListByFactory")
  listByFactory is ArmResourceListByParent<PrivateEndpointConnectionResource>;
}

@@projectedName(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointWrapper"
);
@@extension(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointWrapper"
);
@@doc(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  ""
);
