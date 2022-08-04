import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkGroup,
  NetworkGroupsListOptionalParams,
  NetworkGroupsGetOptionalParams,
  NetworkGroupsGetResponse,
  NetworkGroupsCreateOrUpdateOptionalParams,
  NetworkGroupsCreateOrUpdateResponse,
  NetworkGroupsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkGroups. */
export interface NetworkGroups {
  /**
   * Lists the specified network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkGroupsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkGroup>;
  /**
   * Gets the specified network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsGetOptionalParams
  ): Promise<NetworkGroupsGetResponse>;
  /**
   * Creates or updates a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param parameters Parameters supplied to the specify which network group need to create
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    parameters: NetworkGroup,
    options?: NetworkGroupsCreateOrUpdateOptionalParams
  ): Promise<NetworkGroupsCreateOrUpdateResponse>;
  /**
   * Deletes a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsDeleteOptionalParams
  ): Promise<void>;
}
