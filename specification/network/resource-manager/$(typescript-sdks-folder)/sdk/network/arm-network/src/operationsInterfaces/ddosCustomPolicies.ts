import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  DdosCustomPoliciesDeleteOptionalParams,
  DdosCustomPoliciesGetOptionalParams,
  DdosCustomPoliciesGetResponse,
  DdosCustomPolicy,
  DdosCustomPoliciesCreateOrUpdateOptionalParams,
  DdosCustomPoliciesCreateOrUpdateResponse,
  TagsObject,
  DdosCustomPoliciesUpdateTagsOptionalParams,
  DdosCustomPoliciesUpdateTagsResponse
} from "../models";

/** Interface representing a DdosCustomPolicies. */
export interface DdosCustomPolicies {
  /**
   * Deletes the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets information about the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesGetOptionalParams
  ): Promise<DdosCustomPoliciesGetResponse>;
  /**
   * Creates or updates a DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: DdosCustomPolicy,
    options?: DdosCustomPoliciesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<DdosCustomPoliciesCreateOrUpdateResponse>,
      DdosCustomPoliciesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: DdosCustomPolicy,
    options?: DdosCustomPoliciesCreateOrUpdateOptionalParams
  ): Promise<DdosCustomPoliciesCreateOrUpdateResponse>;
  /**
   * Update a DDoS custom policy tags.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to update DDoS custom policy resource tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: TagsObject,
    options?: DdosCustomPoliciesUpdateTagsOptionalParams
  ): Promise<DdosCustomPoliciesUpdateTagsResponse>;
}
