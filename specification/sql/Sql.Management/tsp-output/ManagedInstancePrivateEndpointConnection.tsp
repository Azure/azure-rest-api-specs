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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model ManagedInstancePrivateEndpointConnection extends ProxyResource {
  /**
   * The name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstancePrivateEndpointConnectionProperties;
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
