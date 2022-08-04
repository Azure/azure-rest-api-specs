import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PrivateEndpoint,
  PrivateEndpointsListOptionalParams,
  PrivateEndpointsListBySubscriptionOptionalParams,
  PrivateEndpointsDeleteOptionalParams,
  PrivateEndpointsGetOptionalParams,
  PrivateEndpointsGetResponse,
  PrivateEndpointsCreateOrUpdateOptionalParams,
  PrivateEndpointsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PrivateEndpoints. */
export interface PrivateEndpoints {
  /**
   * Gets all private endpoints in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: PrivateEndpointsListOptionalParams
  ): PagedAsyncIterableIterator<PrivateEndpoint>;
  /**
   * Gets all private endpoints in a subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: PrivateEndpointsListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<PrivateEndpoint>;
  /**
   * Deletes the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    privateEndpointName: string,
    options?: PrivateEndpointsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    options?: PrivateEndpointsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified private endpoint by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    privateEndpointName: string,
    options?: PrivateEndpointsGetOptionalParams
  ): Promise<PrivateEndpointsGetResponse>;
  /**
   * Creates or updates an private endpoint in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param parameters Parameters supplied to the create or update private endpoint operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    privateEndpointName: string,
    parameters: PrivateEndpoint,
    options?: PrivateEndpointsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PrivateEndpointsCreateOrUpdateResponse>,
      PrivateEndpointsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an private endpoint in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param parameters Parameters supplied to the create or update private endpoint operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    parameters: PrivateEndpoint,
    options?: PrivateEndpointsCreateOrUpdateOptionalParams
  ): Promise<PrivateEndpointsCreateOrUpdateResponse>;
}
