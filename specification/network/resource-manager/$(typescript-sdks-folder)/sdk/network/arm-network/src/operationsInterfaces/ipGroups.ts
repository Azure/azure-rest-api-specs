import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  IpGroup,
  IpGroupsListByResourceGroupOptionalParams,
  IpGroupsListOptionalParams,
  IpGroupsGetOptionalParams,
  IpGroupsGetResponse,
  IpGroupsCreateOrUpdateOptionalParams,
  IpGroupsCreateOrUpdateResponse,
  TagsObject,
  IpGroupsUpdateGroupsOptionalParams,
  IpGroupsUpdateGroupsResponse,
  IpGroupsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a IpGroups. */
export interface IpGroups {
  /**
   * Gets all IpGroups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: IpGroupsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<IpGroup>;
  /**
   * Gets all IpGroups in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: IpGroupsListOptionalParams
  ): PagedAsyncIterableIterator<IpGroup>;
  /**
   * Gets the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsGetOptionalParams
  ): Promise<IpGroupsGetResponse>;
  /**
   * Creates or updates an ipGroups in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the create or update IpGroups operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: IpGroup,
    options?: IpGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<IpGroupsCreateOrUpdateResponse>,
      IpGroupsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an ipGroups in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the create or update IpGroups operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: IpGroup,
    options?: IpGroupsCreateOrUpdateOptionalParams
  ): Promise<IpGroupsCreateOrUpdateResponse>;
  /**
   * Updates tags of an IpGroups resource.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the update ipGroups operation.
   * @param options The options parameters.
   */
  updateGroups(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: TagsObject,
    options?: IpGroupsUpdateGroupsOptionalParams
  ): Promise<IpGroupsUpdateGroupsResponse>;
  /**
   * Deletes the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsDeleteOptionalParams
  ): Promise<void>;
}
