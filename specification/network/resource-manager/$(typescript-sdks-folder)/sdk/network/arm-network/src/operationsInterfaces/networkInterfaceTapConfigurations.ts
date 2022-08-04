import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkInterfaceTapConfiguration,
  NetworkInterfaceTapConfigurationsListOptionalParams,
  NetworkInterfaceTapConfigurationsDeleteOptionalParams,
  NetworkInterfaceTapConfigurationsGetOptionalParams,
  NetworkInterfaceTapConfigurationsGetResponse,
  NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams,
  NetworkInterfaceTapConfigurationsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkInterfaceTapConfigurations. */
export interface NetworkInterfaceTapConfigurations {
  /**
   * Get all Tap configurations in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceTapConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterfaceTapConfiguration>;
  /**
   * Deletes the specified tap configuration from the NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified tap configuration from the NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Get the specified tap configuration on a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsGetOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsGetResponse>;
  /**
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param tapConfigurationParameters Parameters supplied to the create or update tap configuration
   *                                   operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    tapConfigurationParameters: NetworkInterfaceTapConfiguration,
    options?: NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        NetworkInterfaceTapConfigurationsCreateOrUpdateResponse
      >,
      NetworkInterfaceTapConfigurationsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param tapConfigurationParameters Parameters supplied to the create or update tap configuration
   *                                   operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    tapConfigurationParameters: NetworkInterfaceTapConfiguration,
    options?: NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsCreateOrUpdateResponse>;
}
