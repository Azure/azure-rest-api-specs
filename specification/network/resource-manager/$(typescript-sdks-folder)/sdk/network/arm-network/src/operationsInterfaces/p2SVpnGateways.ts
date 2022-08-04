import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  P2SVpnGateway,
  P2SVpnGatewaysListByResourceGroupOptionalParams,
  P2SVpnGatewaysListOptionalParams,
  P2SVpnGatewaysGetOptionalParams,
  P2SVpnGatewaysGetResponse,
  P2SVpnGatewaysCreateOrUpdateOptionalParams,
  P2SVpnGatewaysCreateOrUpdateResponse,
  TagsObject,
  P2SVpnGatewaysUpdateTagsOptionalParams,
  P2SVpnGatewaysUpdateTagsResponse,
  P2SVpnGatewaysDeleteOptionalParams,
  P2SVpnGatewaysResetOptionalParams,
  P2SVpnGatewaysResetResponse,
  P2SVpnProfileParameters,
  P2SVpnGatewaysGenerateVpnProfileOptionalParams,
  P2SVpnGatewaysGenerateVpnProfileResponse,
  P2SVpnGatewaysGetP2SVpnConnectionHealthOptionalParams,
  P2SVpnGatewaysGetP2SVpnConnectionHealthResponse,
  P2SVpnConnectionHealthRequest,
  P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedOptionalParams,
  P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedResponse,
  P2SVpnConnectionRequest,
  P2SVpnGatewaysDisconnectP2SVpnConnectionsOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a P2SVpnGateways. */
export interface P2SVpnGateways {
  /**
   * Lists all the P2SVpnGateways in a resource group.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: P2SVpnGatewaysListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<P2SVpnGateway>;
  /**
   * Lists all the P2SVpnGateways in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: P2SVpnGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<P2SVpnGateway>;
  /**
   * Retrieves the details of a virtual wan p2s vpn gateway.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysGetOptionalParams
  ): Promise<P2SVpnGatewaysGetResponse>;
  /**
   * Creates a virtual wan p2s vpn gateway if it doesn't exist else updates the existing gateway.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param p2SVpnGatewayParameters Parameters supplied to create or Update a virtual wan p2s vpn
   *                                gateway.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    p2SVpnGatewayParameters: P2SVpnGateway,
    options?: P2SVpnGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<P2SVpnGatewaysCreateOrUpdateResponse>,
      P2SVpnGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a virtual wan p2s vpn gateway if it doesn't exist else updates the existing gateway.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param p2SVpnGatewayParameters Parameters supplied to create or Update a virtual wan p2s vpn
   *                                gateway.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    p2SVpnGatewayParameters: P2SVpnGateway,
    options?: P2SVpnGatewaysCreateOrUpdateOptionalParams
  ): Promise<P2SVpnGatewaysCreateOrUpdateResponse>;
  /**
   * Updates virtual wan p2s vpn gateway tags.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param p2SVpnGatewayParameters Parameters supplied to update a virtual wan p2s vpn gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    gatewayName: string,
    p2SVpnGatewayParameters: TagsObject,
    options?: P2SVpnGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<P2SVpnGatewaysUpdateTagsResponse>,
      P2SVpnGatewaysUpdateTagsResponse
    >
  >;
  /**
   * Updates virtual wan p2s vpn gateway tags.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param p2SVpnGatewayParameters Parameters supplied to update a virtual wan p2s vpn gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    gatewayName: string,
    p2SVpnGatewayParameters: TagsObject,
    options?: P2SVpnGatewaysUpdateTagsOptionalParams
  ): Promise<P2SVpnGatewaysUpdateTagsResponse>;
  /**
   * Deletes a virtual wan p2s vpn gateway.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a virtual wan p2s vpn gateway.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysDeleteOptionalParams
  ): Promise<void>;
  /**
   * Resets the primary of the p2s vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginReset(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysResetOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<P2SVpnGatewaysResetResponse>,
      P2SVpnGatewaysResetResponse
    >
  >;
  /**
   * Resets the primary of the p2s vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the P2SVpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginResetAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysResetOptionalParams
  ): Promise<P2SVpnGatewaysResetResponse>;
  /**
   * Generates VPN profile for P2S client of the P2SVpnGateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param parameters Parameters supplied to the generate P2SVpnGateway VPN client package operation.
   * @param options The options parameters.
   */
  beginGenerateVpnProfile(
    resourceGroupName: string,
    gatewayName: string,
    parameters: P2SVpnProfileParameters,
    options?: P2SVpnGatewaysGenerateVpnProfileOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<P2SVpnGatewaysGenerateVpnProfileResponse>,
      P2SVpnGatewaysGenerateVpnProfileResponse
    >
  >;
  /**
   * Generates VPN profile for P2S client of the P2SVpnGateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param parameters Parameters supplied to the generate P2SVpnGateway VPN client package operation.
   * @param options The options parameters.
   */
  beginGenerateVpnProfileAndWait(
    resourceGroupName: string,
    gatewayName: string,
    parameters: P2SVpnProfileParameters,
    options?: P2SVpnGatewaysGenerateVpnProfileOptionalParams
  ): Promise<P2SVpnGatewaysGenerateVpnProfileResponse>;
  /**
   * Gets the connection health of P2S clients of the virtual wan P2SVpnGateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param options The options parameters.
   */
  beginGetP2SVpnConnectionHealth(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysGetP2SVpnConnectionHealthOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<P2SVpnGatewaysGetP2SVpnConnectionHealthResponse>,
      P2SVpnGatewaysGetP2SVpnConnectionHealthResponse
    >
  >;
  /**
   * Gets the connection health of P2S clients of the virtual wan P2SVpnGateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param options The options parameters.
   */
  beginGetP2SVpnConnectionHealthAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: P2SVpnGatewaysGetP2SVpnConnectionHealthOptionalParams
  ): Promise<P2SVpnGatewaysGetP2SVpnConnectionHealthResponse>;
  /**
   * Gets the sas url to get the connection health detail of P2S clients of the virtual wan P2SVpnGateway
   * in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param request Request parameters supplied to get p2s vpn connections detailed health.
   * @param options The options parameters.
   */
  beginGetP2SVpnConnectionHealthDetailed(
    resourceGroupName: string,
    gatewayName: string,
    request: P2SVpnConnectionHealthRequest,
    options?: P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedResponse
      >,
      P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedResponse
    >
  >;
  /**
   * Gets the sas url to get the connection health detail of P2S clients of the virtual wan P2SVpnGateway
   * in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the P2SVpnGateway.
   * @param request Request parameters supplied to get p2s vpn connections detailed health.
   * @param options The options parameters.
   */
  beginGetP2SVpnConnectionHealthDetailedAndWait(
    resourceGroupName: string,
    gatewayName: string,
    request: P2SVpnConnectionHealthRequest,
    options?: P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedOptionalParams
  ): Promise<P2SVpnGatewaysGetP2SVpnConnectionHealthDetailedResponse>;
  /**
   * Disconnect P2S vpn connections of the virtual wan P2SVpnGateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param p2SVpnGatewayName The name of the P2S Vpn Gateway.
   * @param request The parameters are supplied to disconnect p2s vpn connections.
   * @param options The options parameters.
   */
  beginDisconnectP2SVpnConnections(
    resourceGroupName: string,
    p2SVpnGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: P2SVpnGatewaysDisconnectP2SVpnConnectionsOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Disconnect P2S vpn connections of the virtual wan P2SVpnGateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param p2SVpnGatewayName The name of the P2S Vpn Gateway.
   * @param request The parameters are supplied to disconnect p2s vpn connections.
   * @param options The options parameters.
   */
  beginDisconnectP2SVpnConnectionsAndWait(
    resourceGroupName: string,
    p2SVpnGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: P2SVpnGatewaysDisconnectP2SVpnConnectionsOptionalParams
  ): Promise<void>;
}
