import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  Probe,
  LoadBalancerProbesListOptionalParams,
  LoadBalancerProbesGetOptionalParams,
  LoadBalancerProbesGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a LoadBalancerProbes. */
export interface LoadBalancerProbes {
  /**
   * Gets all the load balancer probes.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancerProbesListOptionalParams
  ): PagedAsyncIterableIterator<Probe>;
  /**
   * Gets load balancer probe.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param probeName The name of the probe.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    probeName: string,
    options?: LoadBalancerProbesGetOptionalParams
  ): Promise<LoadBalancerProbesGetResponse>;
}
