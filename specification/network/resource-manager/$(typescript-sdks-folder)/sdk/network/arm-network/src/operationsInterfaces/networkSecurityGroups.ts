import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkSecurityGroup,
  NetworkSecurityGroupsListAllOptionalParams,
  NetworkSecurityGroupsListOptionalParams,
  NetworkSecurityGroupsDeleteOptionalParams,
  NetworkSecurityGroupsGetOptionalParams,
  NetworkSecurityGroupsGetResponse,
  NetworkSecurityGroupsCreateOrUpdateOptionalParams,
  NetworkSecurityGroupsCreateOrUpdateResponse,
  TagsObject,
  NetworkSecurityGroupsUpdateTagsOptionalParams,
  NetworkSecurityGroupsUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkSecurityGroups. */
export interface NetworkSecurityGroups {
  /**
   * Gets all network security groups in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: NetworkSecurityGroupsListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkSecurityGroup>;
  /**
   * Gets all network security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: NetworkSecurityGroupsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkSecurityGroup>;
  /**
   * Deletes the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsGetOptionalParams
  ): Promise<NetworkSecurityGroupsGetResponse>;
  /**
   * Creates or updates a network security group in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to the create or update network security group operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: NetworkSecurityGroup,
    options?: NetworkSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkSecurityGroupsCreateOrUpdateResponse>,
      NetworkSecurityGroupsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a network security group in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to the create or update network security group operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: NetworkSecurityGroup,
    options?: NetworkSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<NetworkSecurityGroupsCreateOrUpdateResponse>;
  /**
   * Updates a network security group tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to update network security group tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: TagsObject,
    options?: NetworkSecurityGroupsUpdateTagsOptionalParams
  ): Promise<NetworkSecurityGroupsUpdateTagsResponse>;
}
