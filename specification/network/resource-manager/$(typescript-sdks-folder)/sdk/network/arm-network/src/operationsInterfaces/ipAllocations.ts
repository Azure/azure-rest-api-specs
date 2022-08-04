import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  IpAllocation,
  IpAllocationsListOptionalParams,
  IpAllocationsListByResourceGroupOptionalParams,
  IpAllocationsDeleteOptionalParams,
  IpAllocationsGetOptionalParams,
  IpAllocationsGetResponse,
  IpAllocationsCreateOrUpdateOptionalParams,
  IpAllocationsCreateOrUpdateResponse,
  TagsObject,
  IpAllocationsUpdateTagsOptionalParams,
  IpAllocationsUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a IpAllocations. */
export interface IpAllocations {
  /**
   * Gets all IpAllocations in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: IpAllocationsListOptionalParams
  ): PagedAsyncIterableIterator<IpAllocation>;
  /**
   * Gets all IpAllocations in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: IpAllocationsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<IpAllocation>;
  /**
   * Deletes the specified IpAllocation.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified IpAllocation.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified IpAllocation by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsGetOptionalParams
  ): Promise<IpAllocationsGetResponse>;
  /**
   * Creates or updates an IpAllocation in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: IpAllocation,
    options?: IpAllocationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<IpAllocationsCreateOrUpdateResponse>,
      IpAllocationsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an IpAllocation in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: IpAllocation,
    options?: IpAllocationsCreateOrUpdateOptionalParams
  ): Promise<IpAllocationsCreateOrUpdateResponse>;
  /**
   * Updates a IpAllocation tags.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to update IpAllocation tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: TagsObject,
    options?: IpAllocationsUpdateTagsOptionalParams
  ): Promise<IpAllocationsUpdateTagsResponse>;
}
