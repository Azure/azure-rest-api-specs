import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  RouteFilterRule,
  RouteFilterRulesListByRouteFilterOptionalParams,
  RouteFilterRulesDeleteOptionalParams,
  RouteFilterRulesGetOptionalParams,
  RouteFilterRulesGetResponse,
  RouteFilterRulesCreateOrUpdateOptionalParams,
  RouteFilterRulesCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a RouteFilterRules. */
export interface RouteFilterRules {
  /**
   * Gets all RouteFilterRules in a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  listByRouteFilter(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFilterRulesListByRouteFilterOptionalParams
  ): PagedAsyncIterableIterator<RouteFilterRule>;
  /**
   * Deletes the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesGetOptionalParams
  ): Promise<RouteFilterRulesGetResponse>;
  /**
   * Creates or updates a route in the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the route filter rule.
   * @param routeFilterRuleParameters Parameters supplied to the create or update route filter rule
   *                                  operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    routeFilterRuleParameters: RouteFilterRule,
    options?: RouteFilterRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RouteFilterRulesCreateOrUpdateResponse>,
      RouteFilterRulesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a route in the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the route filter rule.
   * @param routeFilterRuleParameters Parameters supplied to the create or update route filter rule
   *                                  operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    routeFilterRuleParameters: RouteFilterRule,
    options?: RouteFilterRulesCreateOrUpdateOptionalParams
  ): Promise<RouteFilterRulesCreateOrUpdateResponse>;
}
