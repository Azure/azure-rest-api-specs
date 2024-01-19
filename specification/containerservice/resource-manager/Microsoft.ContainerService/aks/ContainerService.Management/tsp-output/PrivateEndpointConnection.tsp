import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
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

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The updated private endpoint connection."
);
