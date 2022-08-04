import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualHub,
  VirtualHubsListByResourceGroupOptionalParams,
  VirtualHubsListOptionalParams,
  VirtualHubsGetOptionalParams,
  VirtualHubsGetResponse,
  VirtualHubsCreateOrUpdateOptionalParams,
  VirtualHubsCreateOrUpdateResponse,
  TagsObject,
  VirtualHubsUpdateTagsOptionalParams,
  VirtualHubsUpdateTagsResponse,
  VirtualHubsDeleteOptionalParams,
  VirtualHubsGetEffectiveVirtualHubRoutesOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualHubs. */
export interface VirtualHubs {
  /**
   * Lists all the VirtualHubs in a resource group.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualHubsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VirtualHub>;
  /**
   * Lists all the VirtualHubs in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: VirtualHubsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualHub>;
  /**
   * Retrieves the details of a VirtualHub.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubsGetOptionalParams
  ): Promise<VirtualHubsGetResponse>;
  /**
   * Creates a VirtualHub resource if it doesn't exist else updates the existing VirtualHub.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param virtualHubParameters Parameters supplied to create or update VirtualHub.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    virtualHubParameters: VirtualHub,
    options?: VirtualHubsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubsCreateOrUpdateResponse>,
      VirtualHubsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VirtualHub resource if it doesn't exist else updates the existing VirtualHub.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param virtualHubParameters Parameters supplied to create or update VirtualHub.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    virtualHubParameters: VirtualHub,
    options?: VirtualHubsCreateOrUpdateOptionalParams
  ): Promise<VirtualHubsCreateOrUpdateResponse>;
  /**
   * Updates VirtualHub tags.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param virtualHubParameters Parameters supplied to update VirtualHub tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    virtualHubName: string,
    virtualHubParameters: TagsObject,
    options?: VirtualHubsUpdateTagsOptionalParams
  ): Promise<VirtualHubsUpdateTagsResponse>;
  /**
   * Deletes a VirtualHub.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VirtualHub.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the effective routes configured for the Virtual Hub resource or the specified resource .
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  beginGetEffectiveVirtualHubRoutes(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubsGetEffectiveVirtualHubRoutesOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Gets the effective routes configured for the Virtual Hub resource or the specified resource .
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  beginGetEffectiveVirtualHubRoutesAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubsGetEffectiveVirtualHubRoutesOptionalParams
  ): Promise<void>;
}
