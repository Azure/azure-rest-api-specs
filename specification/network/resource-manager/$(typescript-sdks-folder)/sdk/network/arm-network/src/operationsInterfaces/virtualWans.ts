import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualWAN,
  VirtualWansListByResourceGroupOptionalParams,
  VirtualWansListOptionalParams,
  VirtualWansGetOptionalParams,
  VirtualWansGetResponse,
  VirtualWansCreateOrUpdateOptionalParams,
  VirtualWansCreateOrUpdateResponse,
  TagsObject,
  VirtualWansUpdateTagsOptionalParams,
  VirtualWansUpdateTagsResponse,
  VirtualWansDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualWans. */
export interface VirtualWans {
  /**
   * Lists all the VirtualWANs in a resource group.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualWansListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VirtualWAN>;
  /**
   * Lists all the VirtualWANs in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: VirtualWansListOptionalParams
  ): PagedAsyncIterableIterator<VirtualWAN>;
  /**
   * Retrieves the details of a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansGetOptionalParams
  ): Promise<VirtualWansGetResponse>;
  /**
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being created or updated.
   * @param wANParameters Parameters supplied to create or update VirtualWAN.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: VirtualWAN,
    options?: VirtualWansCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualWansCreateOrUpdateResponse>,
      VirtualWansCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being created or updated.
   * @param wANParameters Parameters supplied to create or update VirtualWAN.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: VirtualWAN,
    options?: VirtualWansCreateOrUpdateOptionalParams
  ): Promise<VirtualWansCreateOrUpdateResponse>;
  /**
   * Updates a VirtualWAN tags.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being updated.
   * @param wANParameters Parameters supplied to Update VirtualWAN tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: TagsObject,
    options?: VirtualWansUpdateTagsOptionalParams
  ): Promise<VirtualWansUpdateTagsResponse>;
  /**
   * Deletes a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being deleted.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being deleted.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansDeleteOptionalParams
  ): Promise<void>;
}
