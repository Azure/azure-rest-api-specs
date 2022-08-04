import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  DdosProtectionPlan,
  DdosProtectionPlansListOptionalParams,
  DdosProtectionPlansListByResourceGroupOptionalParams,
  DdosProtectionPlansDeleteOptionalParams,
  DdosProtectionPlansGetOptionalParams,
  DdosProtectionPlansGetResponse,
  DdosProtectionPlansCreateOrUpdateOptionalParams,
  DdosProtectionPlansCreateOrUpdateResponse,
  TagsObject,
  DdosProtectionPlansUpdateTagsOptionalParams,
  DdosProtectionPlansUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a DdosProtectionPlans. */
export interface DdosProtectionPlans {
  /**
   * Gets all DDoS protection plans in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: DdosProtectionPlansListOptionalParams
  ): PagedAsyncIterableIterator<DdosProtectionPlan>;
  /**
   * Gets all the DDoS protection plans in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: DdosProtectionPlansListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<DdosProtectionPlan>;
  /**
   * Deletes the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets information about the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansGetOptionalParams
  ): Promise<DdosProtectionPlansGetResponse>;
  /**
   * Creates or updates a DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: DdosProtectionPlan,
    options?: DdosProtectionPlansCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<DdosProtectionPlansCreateOrUpdateResponse>,
      DdosProtectionPlansCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: DdosProtectionPlan,
    options?: DdosProtectionPlansCreateOrUpdateOptionalParams
  ): Promise<DdosProtectionPlansCreateOrUpdateResponse>;
  /**
   * Update a DDoS protection plan tags.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the update DDoS protection plan resource tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: TagsObject,
    options?: DdosProtectionPlansUpdateTagsOptionalParams
  ): Promise<DdosProtectionPlansUpdateTagsResponse>;
}
