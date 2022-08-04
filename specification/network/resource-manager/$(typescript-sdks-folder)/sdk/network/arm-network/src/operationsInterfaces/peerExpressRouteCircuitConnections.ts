import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  PeerExpressRouteCircuitConnection,
  PeerExpressRouteCircuitConnectionsListOptionalParams,
  PeerExpressRouteCircuitConnectionsGetOptionalParams,
  PeerExpressRouteCircuitConnectionsGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PeerExpressRouteCircuitConnections. */
export interface PeerExpressRouteCircuitConnections {
  /**
   * Gets all global reach peer connections associated with a private peering in an express route
   * circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: PeerExpressRouteCircuitConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<PeerExpressRouteCircuitConnection>;
  /**
   * Gets the specified Peer Express Route Circuit Connection from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the peer express route circuit connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    options?: PeerExpressRouteCircuitConnectionsGetOptionalParams
  ): Promise<PeerExpressRouteCircuitConnectionsGetResponse>;
}
