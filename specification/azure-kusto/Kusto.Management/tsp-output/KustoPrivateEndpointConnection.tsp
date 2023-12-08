import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
@doc("A private endpoint connection")
@parentResource(KustoCluster)
model KustoPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @pattern("^.*$")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface KustoPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<KustoPrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<KustoPrivateEndpointConnection>;
  @doc("Returns the list of private endpoint connections.")
  list is ArmResourceListByParent<KustoPrivateEndpointConnection>;
}
