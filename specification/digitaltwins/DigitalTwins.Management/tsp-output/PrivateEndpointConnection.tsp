import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * The private endpoint connection of a Digital Twin.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DigitalTwinsDescription)
@includeInapplicableMetadataInPayload(false)
model PrivateEndpointConnection {
  /**
   * The name of the private endpoint connection.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
  name: string;

  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the private endpoint connection.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * The connection properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connection properties for the given private endpoint.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the status of a private endpoint connection with the given name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Delete private endpoint connection with the specified name.
   */
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * List private endpoint connection properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection with updated properties."
);
