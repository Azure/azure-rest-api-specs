import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnSiteLinkConnection,
  VpnLinkConnectionsListByVpnConnectionOptionalParams,
  VpnLinkConnectionsResetConnectionOptionalParams,
  VpnLinkConnectionsGetIkeSasOptionalParams,
  VpnLinkConnectionsGetIkeSasResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnLinkConnections. */
export interface VpnLinkConnections {
  /**
   * Retrieves all vpn site link connections for a particular virtual wan vpn gateway vpn connection.
   * @param resourceGroupName The resource group name of the vpn gateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  listByVpnConnection(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnLinkConnectionsListByVpnConnectionOptionalParams
  ): PagedAsyncIterableIterator<VpnSiteLinkConnection>;
  /**
   * Resets the VpnLink connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn link connection.
   * @param options The options parameters.
   */
  beginResetConnection(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnLinkConnectionsResetConnectionOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Resets the VpnLink connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn link connection.
   * @param options The options parameters.
   */
  beginResetConnectionAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnLinkConnectionsResetConnectionOptionalParams
  ): Promise<void>;
  /**
   * Lists IKE Security Associations for Vpn Site Link Connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn link connection.
   * @param options The options parameters.
   */
  beginGetIkeSas(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnLinkConnectionsGetIkeSasOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnLinkConnectionsGetIkeSasResponse>,
      VpnLinkConnectionsGetIkeSasResponse
    >
  >;
  /**
   * Lists IKE Security Associations for Vpn Site Link Connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn link connection.
   * @param options The options parameters.
   */
  beginGetIkeSasAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnLinkConnectionsGetIkeSasOptionalParams
  ): Promise<VpnLinkConnectionsGetIkeSasResponse>;
}
