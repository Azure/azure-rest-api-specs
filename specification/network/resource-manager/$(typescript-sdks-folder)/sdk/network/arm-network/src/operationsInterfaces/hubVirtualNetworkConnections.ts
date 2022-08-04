import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  HubVirtualNetworkConnection,
  HubVirtualNetworkConnectionsListOptionalParams,
  HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams,
  HubVirtualNetworkConnectionsCreateOrUpdateResponse,
  HubVirtualNetworkConnectionsDeleteOptionalParams,
  HubVirtualNetworkConnectionsGetOptionalParams,
  HubVirtualNetworkConnectionsGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a HubVirtualNetworkConnections. */
export interface HubVirtualNetworkConnections {
  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubVirtualNetworkConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<HubVirtualNetworkConnection>;
  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the HubVirtualNetworkConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param hubVirtualNetworkConnectionParameters Parameters supplied to create or update a hub virtual
   *                                              network connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    hubVirtualNetworkConnectionParameters: HubVirtualNetworkConnection,
    options?: HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<HubVirtualNetworkConnectionsCreateOrUpdateResponse>,
      HubVirtualNetworkConnectionsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the HubVirtualNetworkConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param hubVirtualNetworkConnectionParameters Parameters supplied to create or update a hub virtual
   *                                              network connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    hubVirtualNetworkConnectionParameters: HubVirtualNetworkConnection,
    options?: HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams
  ): Promise<HubVirtualNetworkConnectionsCreateOrUpdateResponse>;
  /**
   * Deletes a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Retrieves the details of a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsGetOptionalParams
  ): Promise<HubVirtualNetworkConnectionsGetResponse>;
}
