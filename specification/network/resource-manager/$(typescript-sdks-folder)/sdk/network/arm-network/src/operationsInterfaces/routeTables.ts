import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  RouteTable,
  RouteTablesListOptionalParams,
  RouteTablesListAllOptionalParams,
  RouteTablesDeleteOptionalParams,
  RouteTablesGetOptionalParams,
  RouteTablesGetResponse,
  RouteTablesCreateOrUpdateOptionalParams,
  RouteTablesCreateOrUpdateResponse,
  TagsObject,
  RouteTablesUpdateTagsOptionalParams,
  RouteTablesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a RouteTables. */
export interface RouteTables {
  /**
   * Gets all route tables in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: RouteTablesListOptionalParams
  ): PagedAsyncIterableIterator<RouteTable>;
  /**
   * Gets all route tables in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: RouteTablesListAllOptionalParams
  ): PagedAsyncIterableIterator<RouteTable>;
  /**
   * Deletes the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesGetOptionalParams
  ): Promise<RouteTablesGetResponse>;
  /**
   * Create or updates a route table in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to the create or update route table operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    routeTableName: string,
    parameters: RouteTable,
    options?: RouteTablesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RouteTablesCreateOrUpdateResponse>,
      RouteTablesCreateOrUpdateResponse
    >
  >;
  /**
   * Create or updates a route table in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to the create or update route table operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeTableName: string,
    parameters: RouteTable,
    options?: RouteTablesCreateOrUpdateOptionalParams
  ): Promise<RouteTablesCreateOrUpdateResponse>;
  /**
   * Updates a route table tags.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to update route table tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    routeTableName: string,
    parameters: TagsObject,
    options?: RouteTablesUpdateTagsOptionalParams
  ): Promise<RouteTablesUpdateTagsResponse>;
}
