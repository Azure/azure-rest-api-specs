import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  SecurityRule,
  DefaultSecurityRulesListOptionalParams,
  DefaultSecurityRulesGetOptionalParams,
  DefaultSecurityRulesGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a DefaultSecurityRules. */
export interface DefaultSecurityRules {
  /**
   * Gets all default security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: DefaultSecurityRulesListOptionalParams
  ): PagedAsyncIterableIterator<SecurityRule>;
  /**
   * Get the specified default network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param defaultSecurityRuleName The name of the default security rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    defaultSecurityRuleName: string,
    options?: DefaultSecurityRulesGetOptionalParams
  ): Promise<DefaultSecurityRulesGetResponse>;
}
