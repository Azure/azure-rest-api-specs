import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Purview;
@doc("A private endpoint connection class.")
@parentResource(Account)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get a private endpoint connection")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Create or update a private endpoint connection")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Delete a private endpoint connection")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("Get private endpoint connections for account")
  listByAccount is ArmResourceListByParent<
    PrivateEndpointConnection,
    {
      ...BaseParameters<PrivateEndpointConnection>;

      @doc("The skip token.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
