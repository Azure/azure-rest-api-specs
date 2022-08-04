import {
  VpnSiteLinkConnectionsGetOptionalParams,
  VpnSiteLinkConnectionsGetResponse
} from "../models";

/** Interface representing a VpnSiteLinkConnections. */
export interface VpnSiteLinkConnections {
  /**
   * Retrieves the details of a vpn site link connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnSiteLinkConnectionsGetOptionalParams
  ): Promise<VpnSiteLinkConnectionsGetResponse>;
}
