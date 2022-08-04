import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  FirewallPolicy,
  FirewallPoliciesListOptionalParams,
  FirewallPoliciesListAllOptionalParams,
  FirewallPoliciesDeleteOptionalParams,
  FirewallPoliciesGetOptionalParams,
  FirewallPoliciesGetResponse,
  FirewallPoliciesCreateOrUpdateOptionalParams,
  FirewallPoliciesCreateOrUpdateResponse,
  TagsObject,
  FirewallPoliciesUpdateTagsOptionalParams,
  FirewallPoliciesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a FirewallPolicies. */
export interface FirewallPolicies {
  /**
   * Lists all Firewall Policies in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: FirewallPoliciesListOptionalParams
  ): PagedAsyncIterableIterator<FirewallPolicy>;
  /**
   * Gets all the Firewall Policies in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: FirewallPoliciesListAllOptionalParams
  ): PagedAsyncIterableIterator<FirewallPolicy>;
  /**
   * Deletes the specified Firewall Policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPoliciesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified Firewall Policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPoliciesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified Firewall Policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPoliciesGetOptionalParams
  ): Promise<FirewallPoliciesGetResponse>;
  /**
   * Creates or updates the specified Firewall Policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Parameters supplied to the create or update Firewall Policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: FirewallPolicy,
    options?: FirewallPoliciesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<FirewallPoliciesCreateOrUpdateResponse>,
      FirewallPoliciesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates the specified Firewall Policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Parameters supplied to the create or update Firewall Policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: FirewallPolicy,
    options?: FirewallPoliciesCreateOrUpdateOptionalParams
  ): Promise<FirewallPoliciesCreateOrUpdateResponse>;
  /**
   * Updates tags of a Azure Firewall Policy resource.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Parameters supplied to update Azure Firewall Policy tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: TagsObject,
    options?: FirewallPoliciesUpdateTagsOptionalParams
  ): Promise<FirewallPoliciesUpdateTagsResponse>;
}
