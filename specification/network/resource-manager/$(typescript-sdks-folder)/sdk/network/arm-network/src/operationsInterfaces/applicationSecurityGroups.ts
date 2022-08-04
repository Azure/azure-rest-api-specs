import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ApplicationSecurityGroup,
  ApplicationSecurityGroupsListAllOptionalParams,
  ApplicationSecurityGroupsListOptionalParams,
  ApplicationSecurityGroupsDeleteOptionalParams,
  ApplicationSecurityGroupsGetOptionalParams,
  ApplicationSecurityGroupsGetResponse,
  ApplicationSecurityGroupsCreateOrUpdateOptionalParams,
  ApplicationSecurityGroupsCreateOrUpdateResponse,
  TagsObject,
  ApplicationSecurityGroupsUpdateTagsOptionalParams,
  ApplicationSecurityGroupsUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ApplicationSecurityGroups. */
export interface ApplicationSecurityGroups {
  /**
   * Gets all application security groups in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: ApplicationSecurityGroupsListAllOptionalParams
  ): PagedAsyncIterableIterator<ApplicationSecurityGroup>;
  /**
   * Gets all the application security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: ApplicationSecurityGroupsListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationSecurityGroup>;
  /**
   * Deletes the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets information about the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsGetOptionalParams
  ): Promise<ApplicationSecurityGroupsGetResponse>;
  /**
   * Creates or updates an application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to the create or update ApplicationSecurityGroup operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: ApplicationSecurityGroup,
    options?: ApplicationSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationSecurityGroupsCreateOrUpdateResponse>,
      ApplicationSecurityGroupsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to the create or update ApplicationSecurityGroup operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: ApplicationSecurityGroup,
    options?: ApplicationSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<ApplicationSecurityGroupsCreateOrUpdateResponse>;
  /**
   * Updates an application security group's tags.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to update application security group tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: TagsObject,
    options?: ApplicationSecurityGroupsUpdateTagsOptionalParams
  ): Promise<ApplicationSecurityGroupsUpdateTagsResponse>;
}
