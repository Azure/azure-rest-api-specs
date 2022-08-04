import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  AdminRuleCollection,
  AdminRuleCollectionsListOptionalParams,
  AdminRuleCollectionsGetOptionalParams,
  AdminRuleCollectionsGetResponse,
  AdminRuleCollectionsCreateOrUpdateOptionalParams,
  AdminRuleCollectionsCreateOrUpdateResponse,
  AdminRuleCollectionsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a AdminRuleCollections. */
export interface AdminRuleCollections {
  /**
   * Lists all the rule collections in a security admin configuration, in a paginated format.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: AdminRuleCollectionsListOptionalParams
  ): PagedAsyncIterableIterator<AdminRuleCollection>;
  /**
   * Gets a network manager security admin configuration rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsGetOptionalParams
  ): Promise<AdminRuleCollectionsGetResponse>;
  /**
   * Creates or updates an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleCollection The Rule Collection to create or update
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleCollection: AdminRuleCollection,
    options?: AdminRuleCollectionsCreateOrUpdateOptionalParams
  ): Promise<AdminRuleCollectionsCreateOrUpdateResponse>;
  /**
   * Deletes an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsDeleteOptionalParams
  ): Promise<void>;
}
