import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A private endpoint connection
 */
@parentResource(Workspace)
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
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection.
   */
  create is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Delete a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response =
      | ArmDeletedResponse
      | (ArmDeleteAcceptedLroResponse & {
          @bodyRoot
          _: OperationResource;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists private endpoint connection in workspace.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionList>
  >;
}

@@doc(
  PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(
  PrivateEndpointConnection.properties,
  "Private endpoint connection properties."
);
@@doc(
  PrivateEndpointConnections.create::parameters.resource,
  "Request body of private endpoint connection to create."
);
