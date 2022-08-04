import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  BastionHost,
  BastionHostsListOptionalParams,
  BastionHostsListByResourceGroupOptionalParams,
  BastionHostsDeleteOptionalParams,
  BastionHostsGetOptionalParams,
  BastionHostsGetResponse,
  BastionHostsCreateOrUpdateOptionalParams,
  BastionHostsCreateOrUpdateResponse,
  TagsObject,
  BastionHostsUpdateTagsOptionalParams,
  BastionHostsUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a BastionHosts. */
export interface BastionHosts {
  /**
   * Lists all Bastion Hosts in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: BastionHostsListOptionalParams
  ): PagedAsyncIterableIterator<BastionHost>;
  /**
   * Lists all Bastion Hosts in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: BastionHostsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<BastionHost>;
  /**
   * Deletes the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsGetOptionalParams
  ): Promise<BastionHostsGetResponse>;
  /**
   * Creates or updates the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to the create or update Bastion Host operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: BastionHost,
    options?: BastionHostsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<BastionHostsCreateOrUpdateResponse>,
      BastionHostsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to the create or update Bastion Host operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: BastionHost,
    options?: BastionHostsCreateOrUpdateOptionalParams
  ): Promise<BastionHostsCreateOrUpdateResponse>;
  /**
   * Updates Tags for BastionHost resource
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to update BastionHost tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: TagsObject,
    options?: BastionHostsUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<BastionHostsUpdateTagsResponse>,
      BastionHostsUpdateTagsResponse
    >
  >;
  /**
   * Updates Tags for BastionHost resource
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to update BastionHost tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: TagsObject,
    options?: BastionHostsUpdateTagsOptionalParams
  ): Promise<BastionHostsUpdateTagsResponse>;
}
