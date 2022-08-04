import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  BaseAdminRuleUnion,
  AdminRulesListOptionalParams,
  AdminRulesGetOptionalParams,
  AdminRulesGetResponse,
  AdminRulesCreateOrUpdateOptionalParams,
  AdminRulesCreateOrUpdateResponse,
  AdminRulesDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a AdminRules. */
export interface AdminRules {
  /**
   * List all network manager security configuration admin rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRulesListOptionalParams
  ): PagedAsyncIterableIterator<BaseAdminRuleUnion>;
  /**
   * Gets a network manager security configuration admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesGetOptionalParams
  ): Promise<AdminRulesGetResponse>;
  /**
   * Creates or updates an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param adminRule The admin rule to create or update
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    adminRule: BaseAdminRuleUnion,
    options?: AdminRulesCreateOrUpdateOptionalParams
  ): Promise<AdminRulesCreateOrUpdateResponse>;
  /**
   * Deletes an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesDeleteOptionalParams
  ): Promise<void>;
}
