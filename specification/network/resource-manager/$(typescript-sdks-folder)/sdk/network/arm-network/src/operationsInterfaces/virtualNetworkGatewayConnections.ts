import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualNetworkGatewayConnection,
  VirtualNetworkGatewayConnectionsListOptionalParams,
  VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams,
  VirtualNetworkGatewayConnectionsCreateOrUpdateResponse,
  VirtualNetworkGatewayConnectionsGetOptionalParams,
  VirtualNetworkGatewayConnectionsGetResponse,
  VirtualNetworkGatewayConnectionsDeleteOptionalParams,
  TagsObject,
  VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams,
  VirtualNetworkGatewayConnectionsUpdateTagsResponse,
  ConnectionSharedKey,
  VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsSetSharedKeyResponse,
  VirtualNetworkGatewayConnectionsGetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsGetSharedKeyResponse,
  ConnectionResetSharedKey,
  VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsResetSharedKeyResponse,
  VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams,
  VirtualNetworkGatewayConnectionsStartPacketCaptureResponse,
  VpnPacketCaptureStopParameters,
  VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams,
  VirtualNetworkGatewayConnectionsStopPacketCaptureResponse,
  VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams,
  VirtualNetworkGatewayConnectionsGetIkeSasResponse,
  VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualNetworkGatewayConnections. */
export interface VirtualNetworkGatewayConnections {
  /**
   * The List VirtualNetworkGatewayConnections operation retrieves all the virtual network gateways
   * connections created.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewayConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayConnection>;
  /**
   * Creates or updates a virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to the create or update virtual network gateway connection
   *                   operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VirtualNetworkGatewayConnection,
    options?: VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsCreateOrUpdateResponse
      >,
      VirtualNetworkGatewayConnectionsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to the create or update virtual network gateway connection
   *                   operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VirtualNetworkGatewayConnection,
    options?: VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsCreateOrUpdateResponse>;
  /**
   * Gets the specified virtual network gateway connection by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetResponse>;
  /**
   * Deletes the specified virtual network Gateway connection.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified virtual network Gateway connection.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Updates a virtual network gateway connection tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to update virtual network gateway connection tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsUpdateTagsResponse>,
      VirtualNetworkGatewayConnectionsUpdateTagsResponse
    >
  >;
  /**
   * Updates a virtual network gateway connection tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to update virtual network gateway connection tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsUpdateTagsResponse>;
  /**
   * The Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection name.
   * @param parameters Parameters supplied to the Begin Set Virtual Network Gateway connection Shared key
   *                   operation throughNetwork resource provider.
   * @param options The options parameters.
   */
  beginSetSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionSharedKey,
    options?: VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsSetSharedKeyResponse>,
      VirtualNetworkGatewayConnectionsSetSharedKeyResponse
    >
  >;
  /**
   * The Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection name.
   * @param parameters Parameters supplied to the Begin Set Virtual Network Gateway connection Shared key
   *                   operation throughNetwork resource provider.
   * @param options The options parameters.
   */
  beginSetSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionSharedKey,
    options?: VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsSetSharedKeyResponse>;
  /**
   * The Get VirtualNetworkGatewayConnectionSharedKey operation retrieves information about the specified
   * virtual network gateway connection shared key through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection shared key name.
   * @param options The options parameters.
   */
  getSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetSharedKeyResponse>;
  /**
   * The VirtualNetworkGatewayConnectionResetSharedKey operation resets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection reset shared key
   *                                            Name.
   * @param parameters Parameters supplied to the begin reset virtual network gateway connection shared
   *                   key operation through network resource provider.
   * @param options The options parameters.
   */
  beginResetSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionResetSharedKey,
    options?: VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsResetSharedKeyResponse
      >,
      VirtualNetworkGatewayConnectionsResetSharedKeyResponse
    >
  >;
  /**
   * The VirtualNetworkGatewayConnectionResetSharedKey operation resets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection reset shared key
   *                                            Name.
   * @param parameters Parameters supplied to the begin reset virtual network gateway connection shared
   *                   key operation through network resource provider.
   * @param options The options parameters.
   */
  beginResetSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionResetSharedKey,
    options?: VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsResetSharedKeyResponse>;
  /**
   * Starts packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  beginStartPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsStartPacketCaptureResponse
      >,
      VirtualNetworkGatewayConnectionsStartPacketCaptureResponse
    >
  >;
  /**
   * Starts packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsStartPacketCaptureResponse>;
  /**
   * Stops packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway connection.
   * @param options The options parameters.
   */
  beginStopPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsStopPacketCaptureResponse
      >,
      VirtualNetworkGatewayConnectionsStopPacketCaptureResponse
    >
  >;
  /**
   * Stops packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway connection.
   * @param options The options parameters.
   */
  beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsStopPacketCaptureResponse>;
  /**
   * Lists IKE Security Associations for the virtual network gateway connection in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  beginGetIkeSas(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsGetIkeSasResponse>,
      VirtualNetworkGatewayConnectionsGetIkeSasResponse
    >
  >;
  /**
   * Lists IKE Security Associations for the virtual network gateway connection in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  beginGetIkeSasAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetIkeSasResponse>;
  /**
   * Resets the virtual network gateway connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  beginResetConnection(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Resets the virtual network gateway connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  beginResetConnectionAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
  ): Promise<void>;
}
