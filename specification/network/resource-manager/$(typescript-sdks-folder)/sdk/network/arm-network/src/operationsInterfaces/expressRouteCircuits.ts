import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ExpressRouteCircuit,
  ExpressRouteCircuitsListOptionalParams,
  ExpressRouteCircuitsListAllOptionalParams,
  ExpressRouteCircuitsDeleteOptionalParams,
  ExpressRouteCircuitsGetOptionalParams,
  ExpressRouteCircuitsGetResponse,
  ExpressRouteCircuitsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitsCreateOrUpdateResponse,
  TagsObject,
  ExpressRouteCircuitsUpdateTagsOptionalParams,
  ExpressRouteCircuitsUpdateTagsResponse,
  ExpressRouteCircuitsListArpTableOptionalParams,
  ExpressRouteCircuitsListArpTableResponse,
  ExpressRouteCircuitsListRoutesTableOptionalParams,
  ExpressRouteCircuitsListRoutesTableResponse,
  ExpressRouteCircuitsListRoutesTableSummaryOptionalParams,
  ExpressRouteCircuitsListRoutesTableSummaryResponse,
  ExpressRouteCircuitsGetStatsOptionalParams,
  ExpressRouteCircuitsGetStatsResponse,
  ExpressRouteCircuitsGetPeeringStatsOptionalParams,
  ExpressRouteCircuitsGetPeeringStatsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ExpressRouteCircuits. */
export interface ExpressRouteCircuits {
  /**
   * Gets all the express route circuits in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: ExpressRouteCircuitsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuit>;
  /**
   * Gets all the express route circuits in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: ExpressRouteCircuitsListAllOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuit>;
  /**
   * Deletes the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets information about the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of express route circuit.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsGetOptionalParams
  ): Promise<ExpressRouteCircuitsGetResponse>;
  /**
   * Creates or updates an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to the create or update express route circuit operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    parameters: ExpressRouteCircuit,
    options?: ExpressRouteCircuitsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsCreateOrUpdateResponse>,
      ExpressRouteCircuitsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to the create or update express route circuit operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    parameters: ExpressRouteCircuit,
    options?: ExpressRouteCircuitsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitsCreateOrUpdateResponse>;
  /**
   * Updates an express route circuit tags.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to update express route circuit tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    circuitName: string,
    parameters: TagsObject,
    options?: ExpressRouteCircuitsUpdateTagsOptionalParams
  ): Promise<ExpressRouteCircuitsUpdateTagsResponse>;
  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListArpTable(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListArpTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListArpTableResponse>,
      ExpressRouteCircuitsListArpTableResponse
    >
  >;
  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListArpTableAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListArpTableOptionalParams
  ): Promise<ExpressRouteCircuitsListArpTableResponse>;
  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListRoutesTable(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListRoutesTableResponse>,
      ExpressRouteCircuitsListRoutesTableResponse
    >
  >;
  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListRoutesTableAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableOptionalParams
  ): Promise<ExpressRouteCircuitsListRoutesTableResponse>;
  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListRoutesTableSummary(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableSummaryOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListRoutesTableSummaryResponse>,
      ExpressRouteCircuitsListRoutesTableSummaryResponse
    >
  >;
  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  beginListRoutesTableSummaryAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableSummaryOptionalParams
  ): Promise<ExpressRouteCircuitsListRoutesTableSummaryResponse>;
  /**
   * Gets all the stats from an express route circuit in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  getStats(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsGetStatsOptionalParams
  ): Promise<ExpressRouteCircuitsGetStatsResponse>;
  /**
   * Gets all stats from an express route circuit in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  getPeeringStats(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitsGetPeeringStatsOptionalParams
  ): Promise<ExpressRouteCircuitsGetPeeringStatsResponse>;
}
