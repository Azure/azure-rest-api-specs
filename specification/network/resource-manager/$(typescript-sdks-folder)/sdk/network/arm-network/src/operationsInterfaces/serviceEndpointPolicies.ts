import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ServiceEndpointPolicy,
  ServiceEndpointPoliciesListOptionalParams,
  ServiceEndpointPoliciesListByResourceGroupOptionalParams,
  ServiceEndpointPoliciesDeleteOptionalParams,
  ServiceEndpointPoliciesGetOptionalParams,
  ServiceEndpointPoliciesGetResponse,
  ServiceEndpointPoliciesCreateOrUpdateOptionalParams,
  ServiceEndpointPoliciesCreateOrUpdateResponse,
  TagsObject,
  ServiceEndpointPoliciesUpdateTagsOptionalParams,
  ServiceEndpointPoliciesUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ServiceEndpointPolicies. */
export interface ServiceEndpointPolicies {
  /**
   * Gets all the service endpoint policies in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: ServiceEndpointPoliciesListOptionalParams
  ): PagedAsyncIterableIterator<ServiceEndpointPolicy>;
  /**
   * Gets all service endpoint Policies in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: ServiceEndpointPoliciesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<ServiceEndpointPolicy>;
  /**
   * Deletes the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPoliciesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPoliciesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified service Endpoint Policies in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPoliciesGetOptionalParams
  ): Promise<ServiceEndpointPoliciesGetResponse>;
  /**
   * Creates or updates a service Endpoint Policies.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param parameters Parameters supplied to the create or update service endpoint policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    parameters: ServiceEndpointPolicy,
    options?: ServiceEndpointPoliciesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ServiceEndpointPoliciesCreateOrUpdateResponse>,
      ServiceEndpointPoliciesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a service Endpoint Policies.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param parameters Parameters supplied to the create or update service endpoint policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    parameters: ServiceEndpointPolicy,
    options?: ServiceEndpointPoliciesCreateOrUpdateOptionalParams
  ): Promise<ServiceEndpointPoliciesCreateOrUpdateResponse>;
  /**
   * Updates tags of a service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param parameters Parameters supplied to update service endpoint policy tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    parameters: TagsObject,
    options?: ServiceEndpointPoliciesUpdateTagsOptionalParams
  ): Promise<ServiceEndpointPoliciesUpdateTagsResponse>;
}
