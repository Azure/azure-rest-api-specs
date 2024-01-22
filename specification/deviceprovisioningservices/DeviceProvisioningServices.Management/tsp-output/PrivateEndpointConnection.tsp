import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The private endpoint connection of a provisioning service
 */
@parentResource(ProvisioningServiceDescription)
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Create or update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_CreateOrUpdatePrivateEndpointConnection")
  createOrUpdatePrivateEndpointConnection is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connection properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IotDpsResource_ListPrivateEndpointConnections")
  listPrivateEndpointConnections is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "The private endpoint connection with updated properties"
);
