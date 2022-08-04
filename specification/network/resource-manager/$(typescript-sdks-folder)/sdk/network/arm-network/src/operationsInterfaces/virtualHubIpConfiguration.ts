import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  HubIpConfiguration,
  VirtualHubIpConfigurationListOptionalParams,
  VirtualHubIpConfigurationGetOptionalParams,
  VirtualHubIpConfigurationGetResponse,
  VirtualHubIpConfigurationCreateOrUpdateOptionalParams,
  VirtualHubIpConfigurationCreateOrUpdateResponse,
  VirtualHubIpConfigurationDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualHubIpConfiguration. */
export interface VirtualHubIpConfiguration {
  /**
   * Retrieves the details of all VirtualHubIpConfigurations.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubIpConfigurationListOptionalParams
  ): PagedAsyncIterableIterator<HubIpConfiguration>;
  /**
   * Retrieves the details of a Virtual Hub Ip configuration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationGetOptionalParams
  ): Promise<VirtualHubIpConfigurationGetResponse>;
  /**
   * Creates a VirtualHubIpConfiguration resource if it doesn't exist else updates the existing
   * VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param parameters Hub Ip Configuration parameters.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    parameters: HubIpConfiguration,
    options?: VirtualHubIpConfigurationCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubIpConfigurationCreateOrUpdateResponse>,
      VirtualHubIpConfigurationCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VirtualHubIpConfiguration resource if it doesn't exist else updates the existing
   * VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param parameters Hub Ip Configuration parameters.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    parameters: HubIpConfiguration,
    options?: VirtualHubIpConfigurationCreateOrUpdateOptionalParams
  ): Promise<VirtualHubIpConfigurationCreateOrUpdateResponse>;
  /**
   * Deletes a VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationDeleteOptionalParams
  ): Promise<void>;
}
