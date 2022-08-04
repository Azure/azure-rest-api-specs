import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  SecurityRule,
  SecurityRulesListOptionalParams,
  SecurityRulesDeleteOptionalParams,
  SecurityRulesGetOptionalParams,
  SecurityRulesGetResponse,
  SecurityRulesCreateOrUpdateOptionalParams,
  SecurityRulesCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a SecurityRules. */
export interface SecurityRules {
  /**
   * Gets all security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: SecurityRulesListOptionalParams
  ): PagedAsyncIterableIterator<SecurityRule>;
  /**
   * Deletes the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Get the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesGetOptionalParams
  ): Promise<SecurityRulesGetResponse>;
  /**
   * Creates or updates a security rule in the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param securityRuleParameters Parameters supplied to the create or update network security rule
   *                               operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    securityRuleParameters: SecurityRule,
    options?: SecurityRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<SecurityRulesCreateOrUpdateResponse>,
      SecurityRulesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a security rule in the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param securityRuleParameters Parameters supplied to the create or update network security rule
   *                               operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    securityRuleParameters: SecurityRule,
    options?: SecurityRulesCreateOrUpdateOptionalParams
  ): Promise<SecurityRulesCreateOrUpdateResponse>;
}
