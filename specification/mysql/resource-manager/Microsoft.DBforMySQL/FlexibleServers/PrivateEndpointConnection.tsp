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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("PrivateEndpointConnections")
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/privateEndpointConnections")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the server.
     */
    @path
    @segment("flexibleServers")
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
  ): ArmResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnection> | ErrorResponse;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/privateEndpointConnections")
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the server.
     */
    @path
    @segment("flexibleServers")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/privateEndpointConnections")
  @delete
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the server.
     */
    @path
    @segment("flexibleServers")
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
  ):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  /**
   * Gets all private endpoint connections on a server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DBforMySQL/flexibleServers/{serverName}/privateEndpointConnections")
  listByServer(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the server.
     */
    @path
    @segment("flexibleServers")
    @pattern("^[a-z0-9][-a-z0-9]*(?<!-)$")
    @minLength(1)
    @maxLength(63)
    serverName: string,
  ): ArmResponse<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResultV5> | ErrorResponse;
}
