import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerService;
@doc("A private endpoint connection")
@parentResource(ManagedCluster)
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
  @doc("To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Updates a private endpoint connection.")
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
