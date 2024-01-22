import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The private endpoint connection of an IotHub
 */
@parentResource(IotHubDescription)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  /**
   * The name of the private endpoint connection
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connection properties
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the status of a private endpoint connection with the specified name
   */
  update is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Delete private endpoint connection with the specified name
   */
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connection properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.update::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The private endpoint connection with updated properties"
);
