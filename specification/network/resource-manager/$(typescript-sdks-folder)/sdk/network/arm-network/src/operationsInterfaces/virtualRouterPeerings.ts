import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualRouterPeering,
  VirtualRouterPeeringsListOptionalParams,
  VirtualRouterPeeringsDeleteOptionalParams,
  VirtualRouterPeeringsGetOptionalParams,
  VirtualRouterPeeringsGetResponse,
  VirtualRouterPeeringsCreateOrUpdateOptionalParams,
  VirtualRouterPeeringsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualRouterPeerings. */
export interface VirtualRouterPeerings {
  /**
   * Lists all Virtual Router Peerings in a Virtual Router resource.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualRouterName: string,
    options?: VirtualRouterPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualRouterPeering>;
  /**
   * Deletes the specified peering from a Virtual Router.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified peering from a Virtual Router.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsGetOptionalParams
  ): Promise<VirtualRouterPeeringsGetResponse>;
  /**
   * Creates or updates the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param parameters Parameters supplied to the create or update Virtual Router Peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    parameters: VirtualRouterPeering,
    options?: VirtualRouterPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualRouterPeeringsCreateOrUpdateResponse>,
      VirtualRouterPeeringsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param parameters Parameters supplied to the create or update Virtual Router Peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    parameters: VirtualRouterPeering,
    options?: VirtualRouterPeeringsCreateOrUpdateOptionalParams
  ): Promise<VirtualRouterPeeringsCreateOrUpdateResponse>;
}
