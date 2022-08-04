import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  Route,
  RoutesListOptionalParams,
  RoutesDeleteOptionalParams,
  RoutesGetOptionalParams,
  RoutesGetResponse,
  RoutesCreateOrUpdateOptionalParams,
  RoutesCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a Routes. */
export interface Routes {
  /**
   * Gets all routes in a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    routeTableName: string,
    options?: RoutesListOptionalParams
  ): PagedAsyncIterableIterator<Route>;
  /**
   * Deletes the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesGetOptionalParams
  ): Promise<RoutesGetResponse>;
  /**
   * Creates or updates a route in the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param routeParameters Parameters supplied to the create or update route operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    routeParameters: Route,
    options?: RoutesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RoutesCreateOrUpdateResponse>,
      RoutesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a route in the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param routeParameters Parameters supplied to the create or update route operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    routeParameters: Route,
    options?: RoutesCreateOrUpdateOptionalParams
  ): Promise<RoutesCreateOrUpdateResponse>;
}
