import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualNetwork,
  VirtualNetworksListAllOptionalParams,
  VirtualNetworksListOptionalParams,
  VirtualNetworkUsage,
  VirtualNetworksListUsageOptionalParams,
  VirtualNetworksDeleteOptionalParams,
  VirtualNetworksGetOptionalParams,
  VirtualNetworksGetResponse,
  VirtualNetworksCreateOrUpdateOptionalParams,
  VirtualNetworksCreateOrUpdateResponse,
  TagsObject,
  VirtualNetworksUpdateTagsOptionalParams,
  VirtualNetworksUpdateTagsResponse,
  VirtualNetworksCheckIPAddressAvailabilityOptionalParams,
  VirtualNetworksCheckIPAddressAvailabilityResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualNetworks. */
export interface VirtualNetworks {
  /**
   * Gets all virtual networks in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: VirtualNetworksListAllOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetwork>;
  /**
   * Gets all virtual networks in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: VirtualNetworksListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetwork>;
  /**
   * Lists usage stats.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  listUsage(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksListUsageOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkUsage>;
  /**
   * Deletes the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified virtual network by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksGetOptionalParams
  ): Promise<VirtualNetworksGetResponse>;
  /**
   * Creates or updates a virtual network in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: VirtualNetwork,
    options?: VirtualNetworksCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworksCreateOrUpdateResponse>,
      VirtualNetworksCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a virtual network in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: VirtualNetwork,
    options?: VirtualNetworksCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworksCreateOrUpdateResponse>;
  /**
   * Updates a virtual network tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to update virtual network tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: TagsObject,
    options?: VirtualNetworksUpdateTagsOptionalParams
  ): Promise<VirtualNetworksUpdateTagsResponse>;
  /**
   * Checks whether a private IP address is available for use.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param ipAddress The private IP address to be verified.
   * @param options The options parameters.
   */
  checkIPAddressAvailability(
    resourceGroupName: string,
    virtualNetworkName: string,
    ipAddress: string,
    options?: VirtualNetworksCheckIPAddressAvailabilityOptionalParams
  ): Promise<VirtualNetworksCheckIPAddressAvailabilityResponse>;
}
