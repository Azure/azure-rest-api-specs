import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PublicIPPrefix,
  PublicIPPrefixesListAllOptionalParams,
  PublicIPPrefixesListOptionalParams,
  PublicIPPrefixesDeleteOptionalParams,
  PublicIPPrefixesGetOptionalParams,
  PublicIPPrefixesGetResponse,
  PublicIPPrefixesCreateOrUpdateOptionalParams,
  PublicIPPrefixesCreateOrUpdateResponse,
  TagsObject,
  PublicIPPrefixesUpdateTagsOptionalParams,
  PublicIPPrefixesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PublicIPPrefixes. */
export interface PublicIPPrefixes {
  /**
   * Gets all the public IP prefixes in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: PublicIPPrefixesListAllOptionalParams
  ): PagedAsyncIterableIterator<PublicIPPrefix>;
  /**
   * Gets all public IP prefixes in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: PublicIPPrefixesListOptionalParams
  ): PagedAsyncIterableIterator<PublicIPPrefix>;
  /**
   * Deletes the specified public IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the PublicIpPrefix.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    publicIpPrefixName: string,
    options?: PublicIPPrefixesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified public IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the PublicIpPrefix.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    publicIpPrefixName: string,
    options?: PublicIPPrefixesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified public IP prefix in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the public IP prefix.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    publicIpPrefixName: string,
    options?: PublicIPPrefixesGetOptionalParams
  ): Promise<PublicIPPrefixesGetResponse>;
  /**
   * Creates or updates a static or dynamic public IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the public IP prefix.
   * @param parameters Parameters supplied to the create or update public IP prefix operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    publicIpPrefixName: string,
    parameters: PublicIPPrefix,
    options?: PublicIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PublicIPPrefixesCreateOrUpdateResponse>,
      PublicIPPrefixesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a static or dynamic public IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the public IP prefix.
   * @param parameters Parameters supplied to the create or update public IP prefix operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    publicIpPrefixName: string,
    parameters: PublicIPPrefix,
    options?: PublicIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<PublicIPPrefixesCreateOrUpdateResponse>;
  /**
   * Updates public IP prefix tags.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpPrefixName The name of the public IP prefix.
   * @param parameters Parameters supplied to update public IP prefix tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    publicIpPrefixName: string,
    parameters: TagsObject,
    options?: PublicIPPrefixesUpdateTagsOptionalParams
  ): Promise<PublicIPPrefixesUpdateTagsResponse>;
}
