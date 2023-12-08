import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./CosmosDBForPostgreSqlCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CosmosDBForPostgreSql;
@doc("The private endpoint connection resource.")
@parentResource(CosmosDBForPostgreSqlCluster)
model CosmosDBForPostgreSqlPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection associated with the cluster.")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface CosmosDBForPostgreSqlPrivateEndpointConnections {
  @doc("Gets private endpoint connection.")
  get is ArmResourceRead<CosmosDBForPostgreSqlPrivateEndpointConnection>;
  @doc("Approves or Rejects a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CosmosDBForPostgreSqlPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteWithoutOkAsync<CosmosDBForPostgreSqlPrivateEndpointConnection>;
  @doc("Gets list of private endpoint connections on a cluster.")
  listByCluster is ArmResourceListByParent<CosmosDBForPostgreSqlPrivateEndpointConnection>;
}
