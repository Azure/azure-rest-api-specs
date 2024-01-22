import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ManagedGrafana)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  /**
   * The private endpoint connection name of Azure Managed Grafana.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connections.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Manual approve private endpoint connection
   */
  approve is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete private endpoint connection
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    BaseParameters<PrivateEndpointConnection>,
    ArmAsyncOperationHeader
  >;

  /**
   * Get private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.approve::parameters.resource,
  "json",
  "body"
);
@@extension(PrivateEndpointConnections.approve::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(PrivateEndpointConnections.approve::parameters.resource, "");
