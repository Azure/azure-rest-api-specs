import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  LoadBalancer,
  LoadBalancersListAllOptionalParams,
  LoadBalancersListOptionalParams,
  LoadBalancersDeleteOptionalParams,
  LoadBalancersGetOptionalParams,
  LoadBalancersGetResponse,
  LoadBalancersCreateOrUpdateOptionalParams,
  LoadBalancersCreateOrUpdateResponse,
  TagsObject,
  LoadBalancersUpdateTagsOptionalParams,
  LoadBalancersUpdateTagsResponse,
  LoadBalancerVipSwapRequest,
  LoadBalancersSwapPublicIpAddressesOptionalParams,
  QueryInboundNatRulePortMappingRequest,
  LoadBalancersListInboundNatRulePortMappingsOptionalParams,
  LoadBalancersListInboundNatRulePortMappingsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a LoadBalancers. */
export interface LoadBalancers {
  /**
   * Gets all the load balancers in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: LoadBalancersListAllOptionalParams
  ): PagedAsyncIterableIterator<LoadBalancer>;
  /**
   * Gets all the load balancers in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: LoadBalancersListOptionalParams
  ): PagedAsyncIterableIterator<LoadBalancer>;
  /**
   * Deletes the specified load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancersDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancersDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancersGetOptionalParams
  ): Promise<LoadBalancersGetResponse>;
  /**
   * Creates or updates a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param parameters Parameters supplied to the create or update load balancer operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    loadBalancerName: string,
    parameters: LoadBalancer,
    options?: LoadBalancersCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<LoadBalancersCreateOrUpdateResponse>,
      LoadBalancersCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param parameters Parameters supplied to the create or update load balancer operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    parameters: LoadBalancer,
    options?: LoadBalancersCreateOrUpdateOptionalParams
  ): Promise<LoadBalancersCreateOrUpdateResponse>;
  /**
   * Updates a load balancer tags.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param parameters Parameters supplied to update load balancer tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    loadBalancerName: string,
    parameters: TagsObject,
    options?: LoadBalancersUpdateTagsOptionalParams
  ): Promise<LoadBalancersUpdateTagsResponse>;
  /**
   * Swaps VIPs between two load balancers.
   * @param location The region where load balancers are located at.
   * @param parameters Parameters that define which VIPs should be swapped.
   * @param options The options parameters.
   */
  beginSwapPublicIpAddresses(
    location: string,
    parameters: LoadBalancerVipSwapRequest,
    options?: LoadBalancersSwapPublicIpAddressesOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Swaps VIPs between two load balancers.
   * @param location The region where load balancers are located at.
   * @param parameters Parameters that define which VIPs should be swapped.
   * @param options The options parameters.
   */
  beginSwapPublicIpAddressesAndWait(
    location: string,
    parameters: LoadBalancerVipSwapRequest,
    options?: LoadBalancersSwapPublicIpAddressesOptionalParams
  ): Promise<void>;
  /**
   * List of inbound NAT rule port mappings.
   * @param groupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param backendPoolName The name of the load balancer backend address pool.
   * @param parameters Query inbound NAT rule port mapping request.
   * @param options The options parameters.
   */
  beginListInboundNatRulePortMappings(
    groupName: string,
    loadBalancerName: string,
    backendPoolName: string,
    parameters: QueryInboundNatRulePortMappingRequest,
    options?: LoadBalancersListInboundNatRulePortMappingsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<LoadBalancersListInboundNatRulePortMappingsResponse>,
      LoadBalancersListInboundNatRulePortMappingsResponse
    >
  >;
  /**
   * List of inbound NAT rule port mappings.
   * @param groupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param backendPoolName The name of the load balancer backend address pool.
   * @param parameters Query inbound NAT rule port mapping request.
   * @param options The options parameters.
   */
  beginListInboundNatRulePortMappingsAndWait(
    groupName: string,
    loadBalancerName: string,
    backendPoolName: string,
    parameters: QueryInboundNatRulePortMappingRequest,
    options?: LoadBalancersListInboundNatRulePortMappingsOptionalParams
  ): Promise<LoadBalancersListInboundNatRulePortMappingsResponse>;
}
