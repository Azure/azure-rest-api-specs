import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  BgpConnection,
  VirtualHubBgpConnectionsListOptionalParams,
  VirtualHubBgpConnectionsListLearnedRoutesOptionalParams,
  VirtualHubBgpConnectionsListLearnedRoutesResponse,
  VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams,
  VirtualHubBgpConnectionsListAdvertisedRoutesResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualHubBgpConnections. */
export interface VirtualHubBgpConnections {
  /**
   * Retrieves the details of all VirtualHubBgpConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubBgpConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<BgpConnection>;
  /**
   * Retrieves a list of routes the virtual hub bgp connection has learned.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  beginListLearnedRoutes(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListLearnedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubBgpConnectionsListLearnedRoutesResponse>,
      VirtualHubBgpConnectionsListLearnedRoutesResponse
    >
  >;
  /**
   * Retrieves a list of routes the virtual hub bgp connection has learned.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  beginListLearnedRoutesAndWait(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListLearnedRoutesOptionalParams
  ): Promise<VirtualHubBgpConnectionsListLearnedRoutesResponse>;
  /**
   * Retrieves a list of routes the virtual hub bgp connection is advertising to the specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  beginListAdvertisedRoutes(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubBgpConnectionsListAdvertisedRoutesResponse>,
      VirtualHubBgpConnectionsListAdvertisedRoutesResponse
    >
  >;
  /**
   * Retrieves a list of routes the virtual hub bgp connection is advertising to the specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  beginListAdvertisedRoutesAndWait(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams
  ): Promise<VirtualHubBgpConnectionsListAdvertisedRoutesResponse>;
}
