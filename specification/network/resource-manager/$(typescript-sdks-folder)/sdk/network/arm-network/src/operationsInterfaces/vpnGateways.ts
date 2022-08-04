import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnGateway,
  VpnGatewaysListByResourceGroupOptionalParams,
  VpnGatewaysListOptionalParams,
  VpnGatewaysGetOptionalParams,
  VpnGatewaysGetResponse,
  VpnGatewaysCreateOrUpdateOptionalParams,
  VpnGatewaysCreateOrUpdateResponse,
  TagsObject,
  VpnGatewaysUpdateTagsOptionalParams,
  VpnGatewaysUpdateTagsResponse,
  VpnGatewaysDeleteOptionalParams,
  VpnGatewaysResetOptionalParams,
  VpnGatewaysResetResponse,
  VpnGatewaysStartPacketCaptureOptionalParams,
  VpnGatewaysStartPacketCaptureResponse,
  VpnGatewaysStopPacketCaptureOptionalParams,
  VpnGatewaysStopPacketCaptureResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnGateways. */
export interface VpnGateways {
  /**
   * Lists all the VpnGateways in a resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: VpnGatewaysListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VpnGateway>;
  /**
   * Lists all the VpnGateways in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: VpnGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<VpnGateway>;
  /**
   * Retrieves the details of a virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysGetOptionalParams
  ): Promise<VpnGatewaysGetResponse>;
  /**
   * Creates a virtual wan vpn gateway if it doesn't exist else updates the existing gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param vpnGatewayParameters Parameters supplied to create or Update a virtual wan vpn gateway.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    vpnGatewayParameters: VpnGateway,
    options?: VpnGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnGatewaysCreateOrUpdateResponse>,
      VpnGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a virtual wan vpn gateway if it doesn't exist else updates the existing gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param vpnGatewayParameters Parameters supplied to create or Update a virtual wan vpn gateway.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnGatewayParameters: VpnGateway,
    options?: VpnGatewaysCreateOrUpdateOptionalParams
  ): Promise<VpnGatewaysCreateOrUpdateResponse>;
  /**
   * Updates virtual wan vpn gateway tags.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param vpnGatewayParameters Parameters supplied to update a virtual wan vpn gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    gatewayName: string,
    vpnGatewayParameters: TagsObject,
    options?: VpnGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnGatewaysUpdateTagsResponse>,
      VpnGatewaysUpdateTagsResponse
    >
  >;
  /**
   * Updates virtual wan vpn gateway tags.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param vpnGatewayParameters Parameters supplied to update a virtual wan vpn gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnGatewayParameters: TagsObject,
    options?: VpnGatewaysUpdateTagsOptionalParams
  ): Promise<VpnGatewaysUpdateTagsResponse>;
  /**
   * Deletes a virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysDeleteOptionalParams
  ): Promise<void>;
  /**
   * Resets the primary of the vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginReset(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysResetOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnGatewaysResetResponse>,
      VpnGatewaysResetResponse
    >
  >;
  /**
   * Resets the primary of the vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginResetAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysResetOptionalParams
  ): Promise<VpnGatewaysResetResponse>;
  /**
   * Starts packet capture on vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginStartPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnGatewaysStartPacketCaptureResponse>,
      VpnGatewaysStartPacketCaptureResponse
    >
  >;
  /**
   * Starts packet capture on vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysStartPacketCaptureOptionalParams
  ): Promise<VpnGatewaysStartPacketCaptureResponse>;
  /**
   * Stops packet capture on vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginStopPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnGatewaysStopPacketCaptureResponse>,
      VpnGatewaysStopPacketCaptureResponse
    >
  >;
  /**
   * Stops packet capture on vpn gateway in the specified resource group.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnGatewaysStopPacketCaptureOptionalParams
  ): Promise<VpnGatewaysStopPacketCaptureResponse>;
}
