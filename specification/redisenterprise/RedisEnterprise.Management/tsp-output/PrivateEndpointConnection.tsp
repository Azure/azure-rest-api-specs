import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RedisEnterprise;
@doc("The Private Endpoint Connection resource.")
@parentResource(Cluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the RedisEnterprise cluster.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Updates the state of the specified private endpoint connection associated with the RedisEnterprise cluster.")
  put is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Deletes the specified private endpoint connection associated with the RedisEnterprise cluster.")
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;
  @doc("Lists all the private endpoint connections associated with the RedisEnterprise cluster.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
