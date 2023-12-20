import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataFactory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Private Endpoint Connection ARM resource.")
@parentResource(DataFactory)
model DataFactoryPrivateEndpointConnection
  is ProxyResource<RemotePrivateEndpointConnection> {
  @doc("The private endpoint connection name.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface DataFactoryPrivateEndpointConnections {
  @doc("Gets a private endpoint connection")
  get is ArmResourceRead<
    DataFactoryPrivateEndpointConnection,
    {
      ...BaseParameters<DataFactoryPrivateEndpointConnection>;

      @doc("ETag of the private endpoint connection entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Approves or rejects a private endpoint connection")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryPrivateEndpointConnection,
    {
      ...BaseParameters<DataFactoryPrivateEndpointConnection>;

      @doc("ETag of the private endpoint connection entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a private endpoint connection")
  delete is ArmResourceDeleteSync<DataFactoryPrivateEndpointConnection>;
  @doc("Lists Private endpoint connections")
  listByFactory is ArmResourceListByParent<DataFactoryPrivateEndpointConnection>;
}
