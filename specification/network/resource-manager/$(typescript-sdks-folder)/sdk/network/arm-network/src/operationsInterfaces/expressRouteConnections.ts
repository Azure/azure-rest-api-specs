import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ExpressRouteConnection,
  ExpressRouteConnectionsCreateOrUpdateOptionalParams,
  ExpressRouteConnectionsCreateOrUpdateResponse,
  ExpressRouteConnectionsGetOptionalParams,
  ExpressRouteConnectionsGetResponse,
  ExpressRouteConnectionsDeleteOptionalParams,
  ExpressRouteConnectionsListOptionalParams,
  ExpressRouteConnectionsListResponse
} from "../models";

/** Interface representing a ExpressRouteConnections. */
export interface ExpressRouteConnections {
  /**
   * Creates a connection between an ExpressRoute gateway and an ExpressRoute circuit.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param connectionName The name of the connection subresource.
   * @param putExpressRouteConnectionParameters Parameters required in an ExpressRouteConnection PUT
   *                                            operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    connectionName: string,
    putExpressRouteConnectionParameters: ExpressRouteConnection,
    options?: ExpressRouteConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteConnectionsCreateOrUpdateResponse>,
      ExpressRouteConnectionsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a connection between an ExpressRoute gateway and an ExpressRoute circuit.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param connectionName The name of the connection subresource.
   * @param putExpressRouteConnectionParameters Parameters required in an ExpressRouteConnection PUT
   *                                            operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    connectionName: string,
    putExpressRouteConnectionParameters: ExpressRouteConnection,
    options?: ExpressRouteConnectionsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteConnectionsCreateOrUpdateResponse>;
  /**
   * Gets the specified ExpressRouteConnection.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param connectionName The name of the ExpressRoute connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    connectionName: string,
    options?: ExpressRouteConnectionsGetOptionalParams
  ): Promise<ExpressRouteConnectionsGetResponse>;
  /**
   * Deletes a connection to a ExpressRoute circuit.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param connectionName The name of the connection subresource.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    connectionName: string,
    options?: ExpressRouteConnectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a connection to a ExpressRoute circuit.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param connectionName The name of the connection subresource.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    connectionName: string,
    options?: ExpressRouteConnectionsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Lists ExpressRouteConnections.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteConnectionsListOptionalParams
  ): Promise<ExpressRouteConnectionsListResponse>;
}
