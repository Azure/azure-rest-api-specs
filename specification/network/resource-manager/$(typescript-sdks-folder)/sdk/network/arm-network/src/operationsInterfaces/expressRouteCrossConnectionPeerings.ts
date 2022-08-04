import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ExpressRouteCrossConnectionPeering,
  ExpressRouteCrossConnectionPeeringsListOptionalParams,
  ExpressRouteCrossConnectionPeeringsDeleteOptionalParams,
  ExpressRouteCrossConnectionPeeringsGetOptionalParams,
  ExpressRouteCrossConnectionPeeringsGetResponse,
  ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams,
  ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ExpressRouteCrossConnectionPeerings. */
export interface ExpressRouteCrossConnectionPeerings {
  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCrossConnectionPeering>;
  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsGetOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsGetResponse>;
  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update ExpressRouteCrossConnection
   *                          peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCrossConnectionPeering,
    options?: ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse
      >,
      ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update ExpressRouteCrossConnection
   *                          peering operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCrossConnectionPeering,
    options?: ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse>;
}
