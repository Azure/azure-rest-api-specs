import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnGatewayNatRule,
  NatRulesListByVpnGatewayOptionalParams,
  NatRulesGetOptionalParams,
  NatRulesGetResponse,
  NatRulesCreateOrUpdateOptionalParams,
  NatRulesCreateOrUpdateResponse,
  NatRulesDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NatRules. */
export interface NatRules {
  /**
   * Retrieves all nat rules for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: NatRulesListByVpnGatewayOptionalParams
  ): PagedAsyncIterableIterator<VpnGatewayNatRule>;
  /**
   * Retrieves the details of a nat ruleGet.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesGetOptionalParams
  ): Promise<NatRulesGetResponse>;
  /**
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat
   * rules.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    natRuleParameters: VpnGatewayNatRule,
    options?: NatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NatRulesCreateOrUpdateResponse>,
      NatRulesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat
   * rules.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    natRuleParameters: VpnGatewayNatRule,
    options?: NatRulesCreateOrUpdateOptionalParams
  ): Promise<NatRulesCreateOrUpdateResponse>;
  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesDeleteOptionalParams
  ): Promise<void>;
}
