import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  Subnet,
  SubnetsListOptionalParams,
  SubnetsDeleteOptionalParams,
  SubnetsGetOptionalParams,
  SubnetsGetResponse,
  SubnetsCreateOrUpdateOptionalParams,
  SubnetsCreateOrUpdateResponse,
  PrepareNetworkPoliciesRequest,
  SubnetsPrepareNetworkPoliciesOptionalParams,
  UnprepareNetworkPoliciesRequest,
  SubnetsUnprepareNetworkPoliciesOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a Subnets. */
export interface Subnets {
  /**
   * Gets all subnets in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: SubnetsListOptionalParams
  ): PagedAsyncIterableIterator<Subnet>;
  /**
   * Deletes the specified subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified subnet by virtual network and resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsGetOptionalParams
  ): Promise<SubnetsGetResponse>;
  /**
   * Creates or updates a subnet in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param subnetParameters Parameters supplied to the create or update subnet operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    subnetParameters: Subnet,
    options?: SubnetsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<SubnetsCreateOrUpdateResponse>,
      SubnetsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a subnet in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param subnetParameters Parameters supplied to the create or update subnet operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    subnetParameters: Subnet,
    options?: SubnetsCreateOrUpdateOptionalParams
  ): Promise<SubnetsCreateOrUpdateResponse>;
  /**
   * Prepares a subnet by applying network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param prepareNetworkPoliciesRequestParameters Parameters supplied to prepare subnet by applying
   *                                                network intent policies.
   * @param options The options parameters.
   */
  beginPrepareNetworkPolicies(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    prepareNetworkPoliciesRequestParameters: PrepareNetworkPoliciesRequest,
    options?: SubnetsPrepareNetworkPoliciesOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Prepares a subnet by applying network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param prepareNetworkPoliciesRequestParameters Parameters supplied to prepare subnet by applying
   *                                                network intent policies.
   * @param options The options parameters.
   */
  beginPrepareNetworkPoliciesAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    prepareNetworkPoliciesRequestParameters: PrepareNetworkPoliciesRequest,
    options?: SubnetsPrepareNetworkPoliciesOptionalParams
  ): Promise<void>;
  /**
   * Unprepares a subnet by removing network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param unprepareNetworkPoliciesRequestParameters Parameters supplied to unprepare subnet to remove
   *                                                  network intent policies.
   * @param options The options parameters.
   */
  beginUnprepareNetworkPolicies(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    unprepareNetworkPoliciesRequestParameters: UnprepareNetworkPoliciesRequest,
    options?: SubnetsUnprepareNetworkPoliciesOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Unprepares a subnet by removing network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param unprepareNetworkPoliciesRequestParameters Parameters supplied to unprepare subnet to remove
   *                                                  network intent policies.
   * @param options The options parameters.
   */
  beginUnprepareNetworkPoliciesAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    unprepareNetworkPoliciesRequestParameters: UnprepareNetworkPoliciesRequest,
    options?: SubnetsUnprepareNetworkPoliciesOptionalParams
  ): Promise<void>;
}
