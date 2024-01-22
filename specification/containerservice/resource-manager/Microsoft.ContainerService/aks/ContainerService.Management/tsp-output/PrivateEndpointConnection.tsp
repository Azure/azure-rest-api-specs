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
/**
 * A private endpoint connection
 */
@parentResource(ManagedCluster)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  /**
   * The name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Updates a private endpoint connection.
   */
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection.
   */
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * To learn more about private clusters, see: https://docs.microsoft.com/azure/aks/private-clusters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
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
