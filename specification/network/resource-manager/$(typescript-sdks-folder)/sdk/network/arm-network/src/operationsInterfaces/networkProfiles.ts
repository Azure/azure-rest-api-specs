import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkProfile,
  NetworkProfilesListAllOptionalParams,
  NetworkProfilesListOptionalParams,
  NetworkProfilesDeleteOptionalParams,
  NetworkProfilesGetOptionalParams,
  NetworkProfilesGetResponse,
  NetworkProfilesCreateOrUpdateOptionalParams,
  NetworkProfilesCreateOrUpdateResponse,
  TagsObject,
  NetworkProfilesUpdateTagsOptionalParams,
  NetworkProfilesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkProfiles. */
export interface NetworkProfiles {
  /**
   * Gets all the network profiles in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: NetworkProfilesListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkProfile>;
  /**
   * Gets all network profiles in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: NetworkProfilesListOptionalParams
  ): PagedAsyncIterableIterator<NetworkProfile>;
  /**
   * Deletes the specified network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the NetworkProfile.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the NetworkProfile.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified network profile in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the public IP prefix.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesGetOptionalParams
  ): Promise<NetworkProfilesGetResponse>;
  /**
   * Creates or updates a network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the network profile.
   * @param parameters Parameters supplied to the create or update network profile operation.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkProfileName: string,
    parameters: NetworkProfile,
    options?: NetworkProfilesCreateOrUpdateOptionalParams
  ): Promise<NetworkProfilesCreateOrUpdateResponse>;
  /**
   * Updates network profile tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the network profile.
   * @param parameters Parameters supplied to update network profile tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkProfileName: string,
    parameters: TagsObject,
    options?: NetworkProfilesUpdateTagsOptionalParams
  ): Promise<NetworkProfilesUpdateTagsResponse>;
}
