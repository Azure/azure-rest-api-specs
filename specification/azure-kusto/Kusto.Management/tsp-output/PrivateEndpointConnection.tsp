import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
@doc("A private endpoint connection")
@parentResource(Cluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @pattern("^.*$")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;

  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("Returns the list of private endpoint connections.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
