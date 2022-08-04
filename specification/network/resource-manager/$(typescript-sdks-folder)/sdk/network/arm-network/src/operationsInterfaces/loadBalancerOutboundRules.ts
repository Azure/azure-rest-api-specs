import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  OutboundRule,
  LoadBalancerOutboundRulesListOptionalParams,
  LoadBalancerOutboundRulesGetOptionalParams,
  LoadBalancerOutboundRulesGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a LoadBalancerOutboundRules. */
export interface LoadBalancerOutboundRules {
  /**
   * Gets all the outbound rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancerOutboundRulesListOptionalParams
  ): PagedAsyncIterableIterator<OutboundRule>;
  /**
   * Gets the specified load balancer outbound rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param outboundRuleName The name of the outbound rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    outboundRuleName: string,
    options?: LoadBalancerOutboundRulesGetOptionalParams
  ): Promise<LoadBalancerOutboundRulesGetResponse>;
}
