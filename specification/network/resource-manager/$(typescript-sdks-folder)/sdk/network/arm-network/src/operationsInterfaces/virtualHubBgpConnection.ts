import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualHubBgpConnectionGetOptionalParams,
  VirtualHubBgpConnectionGetResponse,
  BgpConnection,
  VirtualHubBgpConnectionCreateOrUpdateOptionalParams,
  VirtualHubBgpConnectionCreateOrUpdateResponse,
  VirtualHubBgpConnectionDeleteOptionalParams
} from "../models";

/** Interface representing a VirtualHubBgpConnection. */
export interface VirtualHubBgpConnection {
  /**
   * Retrieves the details of a Virtual Hub Bgp Connection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionGetOptionalParams
  ): Promise<VirtualHubBgpConnectionGetResponse>;
  /**
   * Creates a VirtualHubBgpConnection resource if it doesn't exist else updates the existing
   * VirtualHubBgpConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the connection.
   * @param parameters Parameters of Bgp connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    parameters: BgpConnection,
    options?: VirtualHubBgpConnectionCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubBgpConnectionCreateOrUpdateResponse>,
      VirtualHubBgpConnectionCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VirtualHubBgpConnection resource if it doesn't exist else updates the existing
   * VirtualHubBgpConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the connection.
   * @param parameters Parameters of Bgp connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    parameters: BgpConnection,
    options?: VirtualHubBgpConnectionCreateOrUpdateOptionalParams
  ): Promise<VirtualHubBgpConnectionCreateOrUpdateResponse>;
  /**
   * Deletes a VirtualHubBgpConnection.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VirtualHubBgpConnection.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionDeleteOptionalParams
  ): Promise<void>;
}
