import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./App.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTCentral;
/**
 * The private endpoint connection resource.
 */
@parentResource(App)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  /**
   * The private endpoint connection name.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get the metadata of a private endpoint connection for the IoT Central Application.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update a private endpoint connection.
   */
  create is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection from the IoT Central Application.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * Get all private endpoint connections of a IoT Central Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.create::parameters.resource,
  "json",
  "PrivateEndpointConnection"
);
@@extension(PrivateEndpointConnections.create::parameters.resource,
  "x-ms-client-name",
  "PrivateEndpointConnection"
);
@@doc(PrivateEndpointConnections.create::parameters.resource,
  "The private endpoint connection metadata."
);
