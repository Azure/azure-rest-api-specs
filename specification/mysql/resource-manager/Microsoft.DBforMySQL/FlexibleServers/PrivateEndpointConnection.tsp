import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * The private endpoint connection resource.
 */
@parentResource(Server)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<
    PrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection>
  >;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the server.
     */
    @path
    @segment("providers/Microsoft.DBforMySQL/flexibleServers")
    @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
    @minLength(1)
    @maxLength(63)
    serverName: string,

    /**
     * The name of the privateEndpointConnection.
     */
    @path
    @segment("privateEndpointConnections")
    @pattern("^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*")
    privateEndpointConnectionName: string,

    /**
     * The private endpoint connection resource.
     */
    @body
    parameters: Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  ):
    | ArmResourceUpdatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection>
    | ArmResourceCreatedResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection>
    | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
        LocationHeader>
    | ErrorResponse;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoint connections on a server.
   */
  #suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByServer is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResultV5>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
