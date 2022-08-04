import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ApplicationGatewayPrivateEndpointConnection,
  ApplicationGatewayPrivateEndpointConnectionsListOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsUpdateResponse,
  ApplicationGatewayPrivateEndpointConnectionsGetOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ApplicationGatewayPrivateEndpointConnections. */
export interface ApplicationGatewayPrivateEndpointConnections {
  /**
   * Lists all private endpoint connections on an application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGatewayPrivateEndpointConnection>;
  /**
   * Deletes the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Updates the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param parameters Parameters supplied to update application gateway private endpoint connection
   *                   operation.
   * @param options The options parameters.
   */
  beginUpdate(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    parameters: ApplicationGatewayPrivateEndpointConnection,
    options?: ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ApplicationGatewayPrivateEndpointConnectionsUpdateResponse
      >,
      ApplicationGatewayPrivateEndpointConnectionsUpdateResponse
    >
  >;
  /**
   * Updates the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param parameters Parameters supplied to update application gateway private endpoint connection
   *                   operation.
   * @param options The options parameters.
   */
  beginUpdateAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    parameters: ApplicationGatewayPrivateEndpointConnection,
    options?: ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsUpdateResponse>;
  /**
   * Gets the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsGetOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsGetResponse>;
}
