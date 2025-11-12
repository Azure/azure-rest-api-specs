import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./PrivateEndpointConnection.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a private endpoint connection for a container registry.
 */
@parentResource(Registry)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get the specified private endpoint connection associated with the container registry.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of specified private endpoint connection associated with the container registry.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Deletes the specified private endpoint connection associated with the container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all private endpoint connections in a container registry.
   */
  @list
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection."
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The parameters for creating a private endpoint connection."
);
