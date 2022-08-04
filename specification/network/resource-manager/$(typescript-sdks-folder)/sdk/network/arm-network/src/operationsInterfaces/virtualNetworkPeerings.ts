import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualNetworkPeering,
  VirtualNetworkPeeringsListOptionalParams,
  VirtualNetworkPeeringsDeleteOptionalParams,
  VirtualNetworkPeeringsGetOptionalParams,
  VirtualNetworkPeeringsGetResponse,
  VirtualNetworkPeeringsCreateOrUpdateOptionalParams,
  VirtualNetworkPeeringsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualNetworkPeerings. */
export interface VirtualNetworkPeerings {
  /**
   * Gets all virtual network peerings in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworkPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkPeering>;
  /**
   * Deletes the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsGetOptionalParams
  ): Promise<VirtualNetworkPeeringsGetResponse>;
  /**
   * Creates or updates a peering in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the peering.
   * @param virtualNetworkPeeringParameters Parameters supplied to the create or update virtual network
   *                                        peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    virtualNetworkPeeringParameters: VirtualNetworkPeering,
    options?: VirtualNetworkPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkPeeringsCreateOrUpdateResponse>,
      VirtualNetworkPeeringsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a peering in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the peering.
   * @param virtualNetworkPeeringParameters Parameters supplied to the create or update virtual network
   *                                        peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    virtualNetworkPeeringParameters: VirtualNetworkPeering,
    options?: VirtualNetworkPeeringsCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkPeeringsCreateOrUpdateResponse>;
}
