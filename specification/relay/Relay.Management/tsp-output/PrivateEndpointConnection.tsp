import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Properties of the PrivateEndpointConnection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(RelayNamespace)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  PrivateEndpointConnectionProperties
)
model PrivateEndpointConnection extends ProxyResourceBase {
  /**
   * The PrivateEndpointConnection name
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  @visibility("read")
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
   * Gets a description for the specified Private Endpoint Connection name.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Creates or updates PrivateEndpointConnections of service namespace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
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
  "Parameters supplied to update Status of PrivateEndPoint Connection to namespace resource."
);
