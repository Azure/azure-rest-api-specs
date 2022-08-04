import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VirtualNetworkGatewayNatRule,
  VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams,
  VirtualNetworkGatewayNatRulesGetOptionalParams,
  VirtualNetworkGatewayNatRulesGetResponse,
  VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams,
  VirtualNetworkGatewayNatRulesCreateOrUpdateResponse,
  VirtualNetworkGatewayNatRulesDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualNetworkGatewayNatRules. */
export interface VirtualNetworkGatewayNatRules {
  /**
   * Retrieves all nat rules for a particular virtual network gateway.
   * @param resourceGroupName The resource group name of the virtual network gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param options The options parameters.
   */
  listByVirtualNetworkGateway(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayNatRule>;
  /**
   * Retrieves the details of a nat rule.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesGetOptionalParams
  ): Promise<VirtualNetworkGatewayNatRulesGetResponse>;
  /**
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the
   * existing nat rules.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    natRuleParameters: VirtualNetworkGatewayNatRule,
    options?: VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayNatRulesCreateOrUpdateResponse>,
      VirtualNetworkGatewayNatRulesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the
   * existing nat rules.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    natRuleParameters: VirtualNetworkGatewayNatRule,
    options?: VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewayNatRulesCreateOrUpdateResponse>;
  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesDeleteOptionalParams
  ): Promise<void>;
}
