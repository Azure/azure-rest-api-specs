import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkManager,
  NetworkManagersListBySubscriptionOptionalParams,
  NetworkManagersListOptionalParams,
  NetworkManagersGetOptionalParams,
  NetworkManagersGetResponse,
  NetworkManagersCreateOrUpdateOptionalParams,
  NetworkManagersCreateOrUpdateResponse,
  NetworkManagersDeleteOptionalParams,
  PatchObject,
  NetworkManagersPatchOptionalParams,
  NetworkManagersPatchResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkManagers. */
export interface NetworkManagers {
  /**
   * List all network managers in a subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: NetworkManagersListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<NetworkManager>;
  /**
   * List network managers in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: NetworkManagersListOptionalParams
  ): PagedAsyncIterableIterator<NetworkManager>;
  /**
   * Gets the specified Network Manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkManagersGetOptionalParams
  ): Promise<NetworkManagersGetResponse>;
  /**
   * Creates or updates a Network Manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which network manager is.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManager,
    options?: NetworkManagersCreateOrUpdateOptionalParams
  ): Promise<NetworkManagersCreateOrUpdateResponse>;
  /**
   * Deletes a network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkManagersDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkManagersDeleteOptionalParams
  ): Promise<void>;
  /**
   * Patch NetworkManager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which network manager is.
   * @param options The options parameters.
   */
  patch(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: PatchObject,
    options?: NetworkManagersPatchOptionalParams
  ): Promise<NetworkManagersPatchResponse>;
}
