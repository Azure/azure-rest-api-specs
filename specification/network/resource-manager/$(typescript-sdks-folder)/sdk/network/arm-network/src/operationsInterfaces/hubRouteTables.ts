import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  HubRouteTable,
  HubRouteTablesListOptionalParams,
  HubRouteTablesCreateOrUpdateOptionalParams,
  HubRouteTablesCreateOrUpdateResponse,
  HubRouteTablesGetOptionalParams,
  HubRouteTablesGetResponse,
  HubRouteTablesDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a HubRouteTables. */
export interface HubRouteTables {
  /**
   * Retrieves the details of all RouteTables.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubRouteTablesListOptionalParams
  ): PagedAsyncIterableIterator<HubRouteTable>;
  /**
   * Creates a RouteTable resource if it doesn't exist else updates the existing RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param routeTableParameters Parameters supplied to create or update RouteTable.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    routeTableParameters: HubRouteTable,
    options?: HubRouteTablesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<HubRouteTablesCreateOrUpdateResponse>,
      HubRouteTablesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a RouteTable resource if it doesn't exist else updates the existing RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param routeTableParameters Parameters supplied to create or update RouteTable.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    routeTableParameters: HubRouteTable,
    options?: HubRouteTablesCreateOrUpdateOptionalParams
  ): Promise<HubRouteTablesCreateOrUpdateResponse>;
  /**
   * Retrieves the details of a RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesGetOptionalParams
  ): Promise<HubRouteTablesGetResponse>;
  /**
   * Deletes a RouteTable.
   * @param resourceGroupName The resource group name of the RouteTable.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a RouteTable.
   * @param resourceGroupName The resource group name of the RouteTable.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesDeleteOptionalParams
  ): Promise<void>;
}
