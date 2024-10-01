import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { SimplePollerLike, OperationState } from "@azure/core-lro";
import {
  Fleet,
  FleetsListBySubscriptionOptionalParams,
  FleetsListByResourceGroupOptionalParams,
  VirtualMachineScaleSet,
  FleetsListVirtualMachineScaleSetsOptionalParams,
  FleetsGetOptionalParams,
  FleetsGetResponse,
  FleetsCreateOrUpdateOptionalParams,
  FleetsCreateOrUpdateResponse,
  FleetUpdate,
  FleetsUpdateOptionalParams,
  FleetsUpdateResponse,
  FleetsDeleteOptionalParams,
  FleetsDeleteResponse,
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a Fleets. */
export interface Fleets {
  /**
   * List Fleet resources by subscription ID
   * @param options The options parameters.
   */
  listBySubscription(
    options?: FleetsListBySubscriptionOptionalParams,
  ): PagedAsyncIterableIterator<Fleet>;
  /**
   * List Fleet resources by resource group
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: FleetsListByResourceGroupOptionalParams,
  ): PagedAsyncIterableIterator<Fleet>;
  /**
   * List VirtualMachineScaleSet resources by Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param name The name of the Fleet
   * @param options The options parameters.
   */
  listVirtualMachineScaleSets(
    resourceGroupName: string,
    name: string,
    options?: FleetsListVirtualMachineScaleSetsOptionalParams,
  ): PagedAsyncIterableIterator<VirtualMachineScaleSet>;
  /**
   * Get a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsGetOptionalParams,
  ): Promise<FleetsGetResponse>;
  /**
   * Create a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param resource Resource create parameters.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    fleetName: string,
    resource: Fleet,
    options?: FleetsCreateOrUpdateOptionalParams,
  ): Promise<
    SimplePollerLike<
      OperationState<FleetsCreateOrUpdateResponse>,
      FleetsCreateOrUpdateResponse
    >
  >;
  /**
   * Create a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param resource Resource create parameters.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    fleetName: string,
    resource: Fleet,
    options?: FleetsCreateOrUpdateOptionalParams,
  ): Promise<FleetsCreateOrUpdateResponse>;
  /**
   * Update a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param properties The resource properties to be updated.
   * @param options The options parameters.
   */
  beginUpdate(
    resourceGroupName: string,
    fleetName: string,
    properties: FleetUpdate,
    options?: FleetsUpdateOptionalParams,
  ): Promise<
    SimplePollerLike<OperationState<FleetsUpdateResponse>, FleetsUpdateResponse>
  >;
  /**
   * Update a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param properties The resource properties to be updated.
   * @param options The options parameters.
   */
  beginUpdateAndWait(
    resourceGroupName: string,
    fleetName: string,
    properties: FleetUpdate,
    options?: FleetsUpdateOptionalParams,
  ): Promise<FleetsUpdateResponse>;
  /**
   * Delete a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsDeleteOptionalParams,
  ): Promise<
    SimplePollerLike<OperationState<FleetsDeleteResponse>, FleetsDeleteResponse>
  >;
  /**
   * Delete a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsDeleteOptionalParams,
  ): Promise<FleetsDeleteResponse>;
}
