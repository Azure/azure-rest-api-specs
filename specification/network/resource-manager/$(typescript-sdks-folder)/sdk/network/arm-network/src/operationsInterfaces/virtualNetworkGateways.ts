import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualNetworkGateway,
  VirtualNetworkGatewaysListOptionalParams,
  VirtualNetworkGatewayConnectionListEntity,
  VirtualNetworkGatewaysListConnectionsOptionalParams,
  VirtualNetworkGatewaysCreateOrUpdateOptionalParams,
  VirtualNetworkGatewaysCreateOrUpdateResponse,
  VirtualNetworkGatewaysGetOptionalParams,
  VirtualNetworkGatewaysGetResponse,
  VirtualNetworkGatewaysDeleteOptionalParams,
  TagsObject,
  VirtualNetworkGatewaysUpdateTagsOptionalParams,
  VirtualNetworkGatewaysUpdateTagsResponse,
  VirtualNetworkGatewaysResetOptionalParams,
  VirtualNetworkGatewaysResetResponse,
  VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams,
  VpnClientParameters,
  VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams,
  VirtualNetworkGatewaysGeneratevpnclientpackageResponse,
  VirtualNetworkGatewaysGenerateVpnProfileOptionalParams,
  VirtualNetworkGatewaysGenerateVpnProfileResponse,
  VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams,
  VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse,
  VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams,
  VirtualNetworkGatewaysGetBgpPeerStatusResponse,
  VirtualNetworkGatewaysSupportedVpnDevicesOptionalParams,
  VirtualNetworkGatewaysSupportedVpnDevicesResponse,
  VirtualNetworkGatewaysGetLearnedRoutesOptionalParams,
  VirtualNetworkGatewaysGetLearnedRoutesResponse,
  VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams,
  VirtualNetworkGatewaysGetAdvertisedRoutesResponse,
  VpnClientIPsecParameters,
  VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams,
  VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse,
  VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams,
  VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse,
  VpnDeviceScriptParameters,
  VirtualNetworkGatewaysVpnDeviceConfigurationScriptOptionalParams,
  VirtualNetworkGatewaysVpnDeviceConfigurationScriptResponse,
  VirtualNetworkGatewaysStartPacketCaptureOptionalParams,
  VirtualNetworkGatewaysStartPacketCaptureResponse,
  VpnPacketCaptureStopParameters,
  VirtualNetworkGatewaysStopPacketCaptureOptionalParams,
  VirtualNetworkGatewaysStopPacketCaptureResponse,
  VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams,
  VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse,
  P2SVpnConnectionRequest,
  VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualNetworkGateways. */
export interface VirtualNetworkGateways {
  /**
   * Gets all virtual network gateways by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGateway>;
  /**
   * Gets all the connections in a virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  listConnections(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysListConnectionsOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayConnectionListEntity>;
  /**
   * Creates or updates a virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to create or update virtual network gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VirtualNetworkGateway,
    options?: VirtualNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysCreateOrUpdateResponse>,
      VirtualNetworkGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to create or update virtual network gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VirtualNetworkGateway,
    options?: VirtualNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewaysCreateOrUpdateResponse>;
  /**
   * Gets the specified virtual network gateway by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetOptionalParams
  ): Promise<VirtualNetworkGatewaysGetResponse>;
  /**
   * Deletes the specified virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysDeleteOptionalParams
  ): Promise<void>;
  /**
   * Updates a virtual network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to update virtual network gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysUpdateTagsResponse>,
      VirtualNetworkGatewaysUpdateTagsResponse
    >
  >;
  /**
   * Updates a virtual network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to update virtual network gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<VirtualNetworkGatewaysUpdateTagsResponse>;
  /**
   * Resets the primary of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginReset(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysResetResponse>,
      VirtualNetworkGatewaysResetResponse
    >
  >;
  /**
   * Resets the primary of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginResetAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetOptionalParams
  ): Promise<VirtualNetworkGatewaysResetResponse>;
  /**
   * Resets the VPN client shared key of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginResetVpnClientSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Resets the VPN client shared key of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginResetVpnClientSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams
  ): Promise<void>;
  /**
   * Generates VPN client package for P2S client of the virtual network gateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  beginGeneratevpnclientpackage(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGeneratevpnclientpackageResponse
      >,
      VirtualNetworkGatewaysGeneratevpnclientpackageResponse
    >
  >;
  /**
   * Generates VPN client package for P2S client of the virtual network gateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  beginGeneratevpnclientpackageAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams
  ): Promise<VirtualNetworkGatewaysGeneratevpnclientpackageResponse>;
  /**
   * Generates VPN profile for P2S client of the virtual network gateway in the specified resource group.
   * Used for IKEV2 and radius based authentication.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  beginGenerateVpnProfile(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGenerateVpnProfileOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGenerateVpnProfileResponse>,
      VirtualNetworkGatewaysGenerateVpnProfileResponse
    >
  >;
  /**
   * Generates VPN profile for P2S client of the virtual network gateway in the specified resource group.
   * Used for IKEV2 and radius based authentication.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  beginGenerateVpnProfileAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGenerateVpnProfileOptionalParams
  ): Promise<VirtualNetworkGatewaysGenerateVpnProfileResponse>;
  /**
   * Gets pre-generated VPN profile for P2S client of the virtual network gateway in the specified
   * resource group. The profile needs to be generated first using generateVpnProfile.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetVpnProfilePackageUrl(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse>,
      VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse
    >
  >;
  /**
   * Gets pre-generated VPN profile for P2S client of the virtual network gateway in the specified
   * resource group. The profile needs to be generated first using generateVpnProfile.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetVpnProfilePackageUrlAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse>;
  /**
   * The GetBgpPeerStatus operation retrieves the status of all BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetBgpPeerStatus(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetBgpPeerStatusResponse>,
      VirtualNetworkGatewaysGetBgpPeerStatusResponse
    >
  >;
  /**
   * The GetBgpPeerStatus operation retrieves the status of all BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetBgpPeerStatusAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams
  ): Promise<VirtualNetworkGatewaysGetBgpPeerStatusResponse>;
  /**
   * Gets a xml format representation for supported vpn devices.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  supportedVpnDevices(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysSupportedVpnDevicesOptionalParams
  ): Promise<VirtualNetworkGatewaysSupportedVpnDevicesResponse>;
  /**
   * This operation retrieves a list of routes the virtual network gateway has learned, including routes
   * learned from BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetLearnedRoutes(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetLearnedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetLearnedRoutesResponse>,
      VirtualNetworkGatewaysGetLearnedRoutesResponse
    >
  >;
  /**
   * This operation retrieves a list of routes the virtual network gateway has learned, including routes
   * learned from BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetLearnedRoutesAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetLearnedRoutesOptionalParams
  ): Promise<VirtualNetworkGatewaysGetLearnedRoutesResponse>;
  /**
   * This operation retrieves a list of routes the virtual network gateway is advertising to the
   * specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param peer The IP address of the peer.
   * @param options The options parameters.
   */
  beginGetAdvertisedRoutes(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    peer: string,
    options?: VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetAdvertisedRoutesResponse>,
      VirtualNetworkGatewaysGetAdvertisedRoutesResponse
    >
  >;
  /**
   * This operation retrieves a list of routes the virtual network gateway is advertising to the
   * specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param peer The IP address of the peer.
   * @param options The options parameters.
   */
  beginGetAdvertisedRoutesAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    peer: string,
    options?: VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams
  ): Promise<VirtualNetworkGatewaysGetAdvertisedRoutesResponse>;
  /**
   * The Set VpnclientIpsecParameters operation sets the vpnclient ipsec policy for P2S client of virtual
   * network gateway in the specified resource group through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param vpnclientIpsecParams Parameters supplied to the Begin Set vpnclient ipsec parameters of
   *                             Virtual Network Gateway P2S client operation through Network resource provider.
   * @param options The options parameters.
   */
  beginSetVpnclientIpsecParameters(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    vpnclientIpsecParams: VpnClientIPsecParameters,
    options?: VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse
      >,
      VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse
    >
  >;
  /**
   * The Set VpnclientIpsecParameters operation sets the vpnclient ipsec policy for P2S client of virtual
   * network gateway in the specified resource group through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param vpnclientIpsecParams Parameters supplied to the Begin Set vpnclient ipsec parameters of
   *                             Virtual Network Gateway P2S client operation through Network resource provider.
   * @param options The options parameters.
   */
  beginSetVpnclientIpsecParametersAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    vpnclientIpsecParams: VpnClientIPsecParameters,
    options?: VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams
  ): Promise<VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse>;
  /**
   * The Get VpnclientIpsecParameters operation retrieves information about the vpnclient ipsec policy
   * for P2S client of virtual network gateway in the specified resource group through Network resource
   * provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The virtual network gateway name.
   * @param options The options parameters.
   */
  beginGetVpnclientIpsecParameters(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse
      >,
      VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse
    >
  >;
  /**
   * The Get VpnclientIpsecParameters operation retrieves information about the vpnclient ipsec policy
   * for P2S client of virtual network gateway in the specified resource group through Network resource
   * provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The virtual network gateway name.
   * @param options The options parameters.
   */
  beginGetVpnclientIpsecParametersAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse>;
  /**
   * Gets a xml format representation for vpn device configuration script.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection for
   *                                            which the configuration script is generated.
   * @param parameters Parameters supplied to the generate vpn device script operation.
   * @param options The options parameters.
   */
  vpnDeviceConfigurationScript(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnDeviceScriptParameters,
    options?: VirtualNetworkGatewaysVpnDeviceConfigurationScriptOptionalParams
  ): Promise<VirtualNetworkGatewaysVpnDeviceConfigurationScriptResponse>;
  /**
   * Starts packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginStartPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysStartPacketCaptureResponse>,
      VirtualNetworkGatewaysStartPacketCaptureResponse
    >
  >;
  /**
   * Starts packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysStartPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewaysStartPacketCaptureResponse>;
  /**
   * Stops packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway.
   * @param options The options parameters.
   */
  beginStopPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewaysStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysStopPacketCaptureResponse>,
      VirtualNetworkGatewaysStopPacketCaptureResponse
    >
  >;
  /**
   * Stops packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway.
   * @param options The options parameters.
   */
  beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewaysStopPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewaysStopPacketCaptureResponse>;
  /**
   * Get VPN client connection health detail per P2S client connection of the virtual network gateway in
   * the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetVpnclientConnectionHealth(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse
      >,
      VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse
    >
  >;
  /**
   * Get VPN client connection health detail per P2S client connection of the virtual network gateway in
   * the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  beginGetVpnclientConnectionHealthAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse>;
  /**
   * Disconnect vpn connections of virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param request The parameters are supplied to disconnect vpn connections.
   * @param options The options parameters.
   */
  beginDisconnectVirtualNetworkGatewayVpnConnections(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Disconnect vpn connections of virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param request The parameters are supplied to disconnect vpn connections.
   * @param options The options parameters.
   */
  beginDisconnectVirtualNetworkGatewayVpnConnectionsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
  ): Promise<void>;
}
