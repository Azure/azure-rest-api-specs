import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  RouteFilter,
  RouteFiltersListByResourceGroupOptionalParams,
  RouteFiltersListOptionalParams,
  RouteFiltersDeleteOptionalParams,
  RouteFiltersGetOptionalParams,
  RouteFiltersGetResponse,
  RouteFiltersCreateOrUpdateOptionalParams,
  RouteFiltersCreateOrUpdateResponse,
  TagsObject,
  RouteFiltersUpdateTagsOptionalParams,
  RouteFiltersUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a RouteFilters. */
export interface RouteFilters {
  /**
   * Gets all route filters in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: RouteFiltersListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<RouteFilter>;
  /**
   * Gets all route filters in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: RouteFiltersListOptionalParams
  ): PagedAsyncIterableIterator<RouteFilter>;
  /**
   * Deletes the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFiltersDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFiltersDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFiltersGetOptionalParams
  ): Promise<RouteFiltersGetResponse>;
  /**
   * Creates or updates a route filter in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param routeFilterParameters Parameters supplied to the create or update route filter operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    routeFilterName: string,
    routeFilterParameters: RouteFilter,
    options?: RouteFiltersCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RouteFiltersCreateOrUpdateResponse>,
      RouteFiltersCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a route filter in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param routeFilterParameters Parameters supplied to the create or update route filter operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    routeFilterParameters: RouteFilter,
    options?: RouteFiltersCreateOrUpdateOptionalParams
  ): Promise<RouteFiltersCreateOrUpdateResponse>;
  /**
   * Updates tags of a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param parameters Parameters supplied to update route filter tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    routeFilterName: string,
    parameters: TagsObject,
    options?: RouteFiltersUpdateTagsOptionalParams
  ): Promise<RouteFiltersUpdateTagsResponse>;
}
