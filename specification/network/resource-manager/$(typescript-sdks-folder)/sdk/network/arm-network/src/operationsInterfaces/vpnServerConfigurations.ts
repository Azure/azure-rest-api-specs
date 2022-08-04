import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnServerConfiguration,
  VpnServerConfigurationsListByResourceGroupOptionalParams,
  VpnServerConfigurationsListOptionalParams,
  VpnServerConfigurationsGetOptionalParams,
  VpnServerConfigurationsGetResponse,
  VpnServerConfigurationsCreateOrUpdateOptionalParams,
  VpnServerConfigurationsCreateOrUpdateResponse,
  TagsObject,
  VpnServerConfigurationsUpdateTagsOptionalParams,
  VpnServerConfigurationsUpdateTagsResponse,
  VpnServerConfigurationsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnServerConfigurations. */
export interface VpnServerConfigurations {
  /**
   * Lists all the vpnServerConfigurations in a resource group.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: VpnServerConfigurationsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VpnServerConfiguration>;
  /**
   * Lists all the VpnServerConfigurations in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: VpnServerConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<VpnServerConfiguration>;
  /**
   * Retrieves the details of a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsGetOptionalParams
  ): Promise<VpnServerConfigurationsGetResponse>;
  /**
   * Creates a VpnServerConfiguration resource if it doesn't exist else updates the existing
   * VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being created or updated.
   * @param vpnServerConfigurationParameters Parameters supplied to create or update
   *                                         VpnServerConfiguration.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: VpnServerConfiguration,
    options?: VpnServerConfigurationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnServerConfigurationsCreateOrUpdateResponse>,
      VpnServerConfigurationsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VpnServerConfiguration resource if it doesn't exist else updates the existing
   * VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being created or updated.
   * @param vpnServerConfigurationParameters Parameters supplied to create or update
   *                                         VpnServerConfiguration.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: VpnServerConfiguration,
    options?: VpnServerConfigurationsCreateOrUpdateOptionalParams
  ): Promise<VpnServerConfigurationsCreateOrUpdateResponse>;
  /**
   * Updates VpnServerConfiguration tags.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being updated.
   * @param vpnServerConfigurationParameters Parameters supplied to update VpnServerConfiguration tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: TagsObject,
    options?: VpnServerConfigurationsUpdateTagsOptionalParams
  ): Promise<VpnServerConfigurationsUpdateTagsResponse>;
  /**
   * Deletes a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being deleted.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being deleted.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsDeleteOptionalParams
  ): Promise<void>;
}
