import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Properties of the PrivateEndpointConnection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ServiceBusNamespace)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProperties
)
@includeInapplicableMetadataInPayload(false)
model PrivateEndpointConnection extends ProxyResource {
  /**
   * The PrivateEndpointConnection name
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  /**
   * Properties of the PrivateEndpointConnection.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateEndpointConnectionProperties;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a description for the specified Private Endpoint Connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Creates or updates PrivateEndpointConnections of service namespace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes an existing Private Endpoint Connection.
   */
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * Gets the available PrivateEndpointConnections within a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_List")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "Parameters supplied to update Status of PrivateEndpoint Connection to namespace resource."
);
