import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ExpressRouteGatewaysListBySubscriptionOptionalParams,
  ExpressRouteGatewaysListBySubscriptionResponse,
  ExpressRouteGatewaysListByResourceGroupOptionalParams,
  ExpressRouteGatewaysListByResourceGroupResponse,
  ExpressRouteGateway,
  ExpressRouteGatewaysCreateOrUpdateOptionalParams,
  ExpressRouteGatewaysCreateOrUpdateResponse,
  TagsObject,
  ExpressRouteGatewaysUpdateTagsOptionalParams,
  ExpressRouteGatewaysUpdateTagsResponse,
  ExpressRouteGatewaysGetOptionalParams,
  ExpressRouteGatewaysGetResponse,
  ExpressRouteGatewaysDeleteOptionalParams
} from "../models";

/** Interface representing a ExpressRouteGateways. */
export interface ExpressRouteGateways {
  /**
   * Lists ExpressRoute gateways under a given subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: ExpressRouteGatewaysListBySubscriptionOptionalParams
  ): Promise<ExpressRouteGatewaysListBySubscriptionResponse>;
  /**
   * Lists ExpressRoute gateways in a given resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: ExpressRouteGatewaysListByResourceGroupOptionalParams
  ): Promise<ExpressRouteGatewaysListByResourceGroupResponse>;
  /**
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param putExpressRouteGatewayParameters Parameters required in an ExpressRoute gateway PUT
   *                                         operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    putExpressRouteGatewayParameters: ExpressRouteGateway,
    options?: ExpressRouteGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteGatewaysCreateOrUpdateResponse>,
      ExpressRouteGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param putExpressRouteGatewayParameters Parameters required in an ExpressRoute gateway PUT
   *                                         operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    putExpressRouteGatewayParameters: ExpressRouteGateway,
    options?: ExpressRouteGatewaysCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteGatewaysCreateOrUpdateResponse>;
  /**
   * Updates express route gateway tags.
   * @param resourceGroupName The resource group name of the ExpressRouteGateway.
   * @param expressRouteGatewayName The name of the gateway.
   * @param expressRouteGatewayParameters Parameters supplied to update a virtual wan express route
   *                                      gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTags(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    expressRouteGatewayParameters: TagsObject,
    options?: ExpressRouteGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteGatewaysUpdateTagsResponse>,
      ExpressRouteGatewaysUpdateTagsResponse
    >
  >;
  /**
   * Updates express route gateway tags.
   * @param resourceGroupName The resource group name of the ExpressRouteGateway.
   * @param expressRouteGatewayName The name of the gateway.
   * @param expressRouteGatewayParameters Parameters supplied to update a virtual wan express route
   *                                      gateway tags.
   * @param options The options parameters.
   */
  beginUpdateTagsAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    expressRouteGatewayParameters: TagsObject,
    options?: ExpressRouteGatewaysUpdateTagsOptionalParams
  ): Promise<ExpressRouteGatewaysUpdateTagsResponse>;
  /**
   * Fetches the details of a ExpressRoute gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysGetOptionalParams
  ): Promise<ExpressRouteGatewaysGetResponse>;
  /**
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can
   * only be deleted when there are no connection subresources.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can
   * only be deleted when there are no connection subresources.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysDeleteOptionalParams
  ): Promise<void>;
}
