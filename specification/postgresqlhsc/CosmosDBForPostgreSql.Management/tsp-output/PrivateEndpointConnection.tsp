import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("The private endpoint connection resource.")
@parentResource(Cluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the cluster.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Approves or Rejects a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;
  @doc("Gets list of private endpoint connections on a cluster.")
  listByCluster is ArmResourceListByParent<PrivateEndpointConnection>;
}
