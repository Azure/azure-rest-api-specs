import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PrivateLinkService,
  PrivateLinkServicesListOptionalParams,
  PrivateLinkServicesListBySubscriptionOptionalParams,
  PrivateEndpointConnection,
  PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams,
  AutoApprovedPrivateLinkService,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams,
  PrivateLinkServicesDeleteOptionalParams,
  PrivateLinkServicesGetOptionalParams,
  PrivateLinkServicesGetResponse,
  PrivateLinkServicesCreateOrUpdateOptionalParams,
  PrivateLinkServicesCreateOrUpdateResponse,
  PrivateLinkServicesGetPrivateEndpointConnectionOptionalParams,
  PrivateLinkServicesGetPrivateEndpointConnectionResponse,
  PrivateLinkServicesUpdatePrivateEndpointConnectionOptionalParams,
  PrivateLinkServicesUpdatePrivateEndpointConnectionResponse,
  PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams,
  CheckPrivateLinkServiceVisibilityRequest,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PrivateLinkServices. */
export interface PrivateLinkServices {
  /**
   * Gets all private link services in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: PrivateLinkServicesListOptionalParams
  ): PagedAsyncIterableIterator<PrivateLinkService>;
  /**
   * Gets all private link service in a subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: PrivateLinkServicesListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<PrivateLinkService>;
  /**
   * Gets all private end point connections for a specific private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  listPrivateEndpointConnections(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  ): PagedAsyncIterableIterator<PrivateEndpointConnection>;
  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  listAutoApprovedPrivateLinkServices(
    location: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  ): PagedAsyncIterableIterator<AutoApprovedPrivateLinkService>;
  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listAutoApprovedPrivateLinkServicesByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AutoApprovedPrivateLinkService>;
  /**
   * Deletes the specified private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified private link service by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesGetOptionalParams
  ): Promise<PrivateLinkServicesGetResponse>;
  /**
   * Creates or updates an private link service in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param parameters Parameters supplied to the create or update private link service operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    serviceName: string,
    parameters: PrivateLinkService,
    options?: PrivateLinkServicesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PrivateLinkServicesCreateOrUpdateResponse>,
      PrivateLinkServicesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an private link service in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param parameters Parameters supplied to the create or update private link service operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    serviceName: string,
    parameters: PrivateLinkService,
    options?: PrivateLinkServicesCreateOrUpdateOptionalParams
  ): Promise<PrivateLinkServicesCreateOrUpdateResponse>;
  /**
   * Get the specific private end point connection by specific private link service in the resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  getPrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesGetPrivateEndpointConnectionOptionalParams
  ): Promise<PrivateLinkServicesGetPrivateEndpointConnectionResponse>;
  /**
   * Approve or reject private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param parameters Parameters supplied to approve or reject the private end point connection.
   * @param options The options parameters.
   */
  updatePrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    parameters: PrivateEndpointConnection,
    options?: PrivateLinkServicesUpdatePrivateEndpointConnectionOptionalParams
  ): Promise<PrivateLinkServicesUpdatePrivateEndpointConnectionResponse>;
  /**
   * Delete private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  beginDeletePrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Delete private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  beginDeletePrivateEndpointConnectionAndWait(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams
  ): Promise<void>;
  /**
   * Checks whether the subscription is visible to private link service.
   * @param location The location of the domain name.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  beginCheckPrivateLinkServiceVisibility(
    location: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse
      >,
      PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse
    >
  >;
  /**
   * Checks whether the subscription is visible to private link service.
   * @param location The location of the domain name.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  beginCheckPrivateLinkServiceVisibilityAndWait(
    location: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams
  ): Promise<PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse>;
  /**
   * Checks whether the subscription is visible to private link service in the specified resource group.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  beginCheckPrivateLinkServiceVisibilityByResourceGroup(
    location: string,
    resourceGroupName: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
      >,
      PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
    >
  >;
  /**
   * Checks whether the subscription is visible to private link service in the specified resource group.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  beginCheckPrivateLinkServiceVisibilityByResourceGroupAndWait(
    location: string,
    resourceGroupName: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams
  ): Promise<
    PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
  >;
}
