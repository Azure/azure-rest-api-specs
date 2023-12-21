import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HDInsight;
@doc("The private endpoint connection.")
@parentResource(Cluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specific private endpoint connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection manually.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;
  @doc("Deletes the specific private endpoint connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("Lists the private endpoint connections for a HDInsight cluster.")
  listByCluster is ArmResourceListByParent<PrivateEndpointConnection>;
}
