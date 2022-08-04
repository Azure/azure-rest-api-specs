import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkVirtualAppliance,
  NetworkVirtualAppliancesListByResourceGroupOptionalParams,
  NetworkVirtualAppliancesListOptionalParams,
  NetworkVirtualAppliancesDeleteOptionalParams,
  NetworkVirtualAppliancesGetOptionalParams,
  NetworkVirtualAppliancesGetResponse,
  TagsObject,
  NetworkVirtualAppliancesUpdateTagsOptionalParams,
  NetworkVirtualAppliancesUpdateTagsResponse,
  NetworkVirtualAppliancesCreateOrUpdateOptionalParams,
  NetworkVirtualAppliancesCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkVirtualAppliances. */
export interface NetworkVirtualAppliances {
  /**
   * Lists all Network Virtual Appliances in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: NetworkVirtualAppliancesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<NetworkVirtualAppliance>;
  /**
   * Gets all Network Virtual Appliances in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: NetworkVirtualAppliancesListOptionalParams
  ): PagedAsyncIterableIterator<NetworkVirtualAppliance>;
  /**
   * Deletes the specified Network Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: NetworkVirtualAppliancesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified Network Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: NetworkVirtualAppliancesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified Network Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: NetworkVirtualAppliancesGetOptionalParams
  ): Promise<NetworkVirtualAppliancesGetResponse>;
  /**
   * Updates a Network Virtual Appliance.
   * @param resourceGroupName The resource group name of Network Virtual Appliance.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance being updated.
   * @param parameters Parameters supplied to Update Network Virtual Appliance Tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    parameters: TagsObject,
    options?: NetworkVirtualAppliancesUpdateTagsOptionalParams
  ): Promise<NetworkVirtualAppliancesUpdateTagsResponse>;
  /**
   * Creates or updates the specified Network Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    parameters: NetworkVirtualAppliance,
    options?: NetworkVirtualAppliancesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkVirtualAppliancesCreateOrUpdateResponse>,
      NetworkVirtualAppliancesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates the specified Network Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of Network Virtual Appliance.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    parameters: NetworkVirtualAppliance,
    options?: NetworkVirtualAppliancesCreateOrUpdateOptionalParams
  ): Promise<NetworkVirtualAppliancesCreateOrUpdateResponse>;
}
