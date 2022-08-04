import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  CustomIpPrefix,
  CustomIPPrefixesListAllOptionalParams,
  CustomIPPrefixesListOptionalParams,
  CustomIPPrefixesDeleteOptionalParams,
  CustomIPPrefixesGetOptionalParams,
  CustomIPPrefixesGetResponse,
  CustomIPPrefixesCreateOrUpdateOptionalParams,
  CustomIPPrefixesCreateOrUpdateResponse,
  TagsObject,
  CustomIPPrefixesUpdateTagsOptionalParams,
  CustomIPPrefixesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a CustomIPPrefixes. */
export interface CustomIPPrefixes {
  /**
   * Gets all the custom IP prefixes in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: CustomIPPrefixesListAllOptionalParams
  ): PagedAsyncIterableIterator<CustomIpPrefix>;
  /**
   * Gets all custom IP prefixes in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: CustomIPPrefixesListOptionalParams
  ): PagedAsyncIterableIterator<CustomIpPrefix>;
  /**
   * Deletes the specified custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the CustomIpPrefix.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the CustomIpPrefix.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified custom IP prefix in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesGetOptionalParams
  ): Promise<CustomIPPrefixesGetResponse>;
  /**
   * Creates or updates a custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to the create or update custom IP prefix operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: CustomIpPrefix,
    options?: CustomIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<CustomIPPrefixesCreateOrUpdateResponse>,
      CustomIPPrefixesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to the create or update custom IP prefix operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: CustomIpPrefix,
    options?: CustomIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<CustomIPPrefixesCreateOrUpdateResponse>;
  /**
   * Updates custom IP prefix tags.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to update custom IP prefix tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: TagsObject,
    options?: CustomIPPrefixesUpdateTagsOptionalParams
  ): Promise<CustomIPPrefixesUpdateTagsResponse>;
}
