import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  LocalNetworkGateway,
  LocalNetworkGatewaysListOptionalParams,
  LocalNetworkGatewaysCreateOrUpdateOptionalParams,
  LocalNetworkGatewaysCreateOrUpdateResponse,
  LocalNetworkGatewaysGetOptionalParams,
  LocalNetworkGatewaysGetResponse,
  LocalNetworkGatewaysDeleteOptionalParams,
  TagsObject,
  LocalNetworkGatewaysUpdateTagsOptionalParams,
  LocalNetworkGatewaysUpdateTagsResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a LocalNetworkGateways. */
export interface LocalNetworkGateways {
  /**
   * Gets all the local network gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: LocalNetworkGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<LocalNetworkGateway>;
  /**
   * Creates or updates a local network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to the create or update local network gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: LocalNetworkGateway,
    options?: LocalNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<LocalNetworkGatewaysCreateOrUpdateResponse>,
      LocalNetworkGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a local network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to the create or update local network gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: LocalNetworkGateway,
    options?: LocalNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<LocalNetworkGatewaysCreateOrUpdateResponse>;
  /**
   * Gets the specified local network gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysGetOptionalParams
  ): Promise<LocalNetworkGatewaysGetResponse>;
  /**
   * Deletes the specified local network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified local network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysDeleteOptionalParams
  ): Promise<void>;
  /**
   * Updates a local network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to update local network gateway tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: TagsObject,
    options?: LocalNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<LocalNetworkGatewaysUpdateTagsResponse>;
}
