import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  InboundNatRule,
  InboundNatRulesListOptionalParams,
  InboundNatRulesDeleteOptionalParams,
  InboundNatRulesGetOptionalParams,
  InboundNatRulesGetResponse,
  InboundNatRulesCreateOrUpdateOptionalParams,
  InboundNatRulesCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a InboundNatRules. */
export interface InboundNatRules {
  /**
   * Gets all the inbound NAT rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: InboundNatRulesListOptionalParams
  ): PagedAsyncIterableIterator<InboundNatRule>;
  /**
   * Deletes the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesGetOptionalParams
  ): Promise<InboundNatRulesGetResponse>;
  /**
   * Creates or updates a load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param inboundNatRuleParameters Parameters supplied to the create or update inbound NAT rule
   *                                 operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    inboundNatRuleParameters: InboundNatRule,
    options?: InboundNatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<InboundNatRulesCreateOrUpdateResponse>,
      InboundNatRulesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param inboundNatRuleParameters Parameters supplied to the create or update inbound NAT rule
   *                                 operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    inboundNatRuleParameters: InboundNatRule,
    options?: InboundNatRulesCreateOrUpdateOptionalParams
  ): Promise<InboundNatRulesCreateOrUpdateResponse>;
}
