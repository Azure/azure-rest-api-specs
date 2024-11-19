// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;

interface PrivateEndpointConnectionsOperations {
  /**
   * List private endpoint connections.
   */
  @operationId("PrivateEndpointConnections_ListByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections")
  @get
  listByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[A-Za-z0-9@.\\-_ ]*$")
    @path
    workspaceName: string,
  ): ArmResponse<PrivateEndpointConnectionListResultWithSystemData> | ErrorResponse;

  /**
   * Get a private endpoint connection.
   */
  @operationId("PrivateEndpointConnections_GetByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  getByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[A-Za-z0-9@.\\-_ ]*$")
    @path
    workspaceName: string,

    /**
     * The name of the private endpoint connection associated with the Azure resource.
     */
    @path
    privateEndpointConnectionName: string,
  ): ArmResponse<PrivateEndpointConnectionWithSystemData> | ErrorResponse;

  /**
   * Approve or reject a private endpoint connection.
   */
  @operationId("PrivateEndpointConnections_UpdateByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  updateByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[A-Za-z0-9@.\\-_ ]*$")
    @path
    workspaceName: string,

    /**
     * The name of the private endpoint connection associated with the Azure resource.
     */
    @path
    privateEndpointConnectionName: string,

    /**
     * Object containing the updated connection.
     */
    @body
    connection: PrivateEndpointConnection,
  ): ArmResponse<PrivateEndpointConnectionWithSystemData> | ErrorResponse;

  /**
   * Remove a connection.
   */
  @operationId("PrivateEndpointConnections_DeleteByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  deleteByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace
     */
    @maxLength(64)
    @minLength(3)
    @pattern("^[A-Za-z0-9@.\\-_ ]*$")
    @path
    workspaceName: string,

    /**
     * The name of the private endpoint connection associated with the Azure resource.
     */
    @path
    privateEndpointConnectionName: string,
  ): OkResponse | ErrorResponse;
}
