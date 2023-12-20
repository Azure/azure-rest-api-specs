import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PurviewAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Purview;
@doc("A private endpoint connection class.")
@parentResource(PurviewAccount)
model PurviewPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PurviewPrivateEndpointConnections {
  @doc("Get a private endpoint connection")
  get is ArmResourceRead<PurviewPrivateEndpointConnection>;
  @doc("Create or update a private endpoint connection")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PurviewPrivateEndpointConnection>;
  @doc("Delete a private endpoint connection")
  delete is ArmResourceDeleteAsync<PurviewPrivateEndpointConnection>;
  @doc("Get private endpoint connections for account")
  listByAccount is ArmResourceListByParent<
    PurviewPrivateEndpointConnection,
    {
      ...BaseParameters<PurviewPrivateEndpointConnection>;

      @doc("The skip token.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
