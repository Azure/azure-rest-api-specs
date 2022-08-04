import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnConnection,
  VpnConnectionsListByVpnGatewayOptionalParams,
  VpnConnectionsGetOptionalParams,
  VpnConnectionsGetResponse,
  VpnConnectionsCreateOrUpdateOptionalParams,
  VpnConnectionsCreateOrUpdateResponse,
  VpnConnectionsDeleteOptionalParams,
  VpnConnectionsStartPacketCaptureOptionalParams,
  VpnConnectionsStartPacketCaptureResponse,
  VpnConnectionsStopPacketCaptureOptionalParams,
  VpnConnectionsStopPacketCaptureResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnConnections. */
export interface VpnConnections {
  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnConnectionsListByVpnGatewayOptionalParams
  ): PagedAsyncIterableIterator<VpnConnection>;
  /**
   * Retrieves the details of a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsGetOptionalParams
  ): Promise<VpnConnectionsGetResponse>;
  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing
   * connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param vpnConnectionParameters Parameters supplied to create or Update a VPN Connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    vpnConnectionParameters: VpnConnection,
    options?: VpnConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsCreateOrUpdateResponse>,
      VpnConnectionsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing
   * connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param vpnConnectionParameters Parameters supplied to create or Update a VPN Connection.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    vpnConnectionParameters: VpnConnection,
    options?: VpnConnectionsCreateOrUpdateOptionalParams
  ): Promise<VpnConnectionsCreateOrUpdateResponse>;
  /**
   * Deletes a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  beginStartPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsStartPacketCaptureResponse>,
      VpnConnectionsStartPacketCaptureResponse
    >
  >;
  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStartPacketCaptureOptionalParams
  ): Promise<VpnConnectionsStartPacketCaptureResponse>;
  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  beginStopPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsStopPacketCaptureResponse>,
      VpnConnectionsStopPacketCaptureResponse
    >
  >;
  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStopPacketCaptureOptionalParams
  ): Promise<VpnConnectionsStopPacketCaptureResponse>;
}
