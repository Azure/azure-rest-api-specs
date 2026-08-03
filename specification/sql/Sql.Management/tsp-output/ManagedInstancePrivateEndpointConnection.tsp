import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private endpoint connection
 */
@parentResource(ManagedInstance)
model ManagedInstancePrivateEndpointConnection
  is ProxyResource<ManagedInstancePrivateEndpointConnectionProperties> {
  /**
   * The name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ManagedInstancePrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<ManagedInstancePrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstancePrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  delete is ArmResourceDeleteAsync<ManagedInstancePrivateEndpointConnection>;

  /**
   * Gets all private endpoint connections on a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstancePrivateEndpointConnections_ListByManagedInstance")
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateEndpointConnection>;
}

@@projectedName(ManagedInstancePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstancePrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstancePrivateEndpointConnections.createOrUpdate::parameters.resource,
  ""
);
