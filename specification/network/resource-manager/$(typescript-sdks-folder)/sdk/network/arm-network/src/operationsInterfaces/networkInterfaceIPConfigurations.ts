import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  NetworkInterfaceIPConfiguration,
  NetworkInterfaceIPConfigurationsListOptionalParams,
  NetworkInterfaceIPConfigurationsGetOptionalParams,
  NetworkInterfaceIPConfigurationsGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkInterfaceIPConfigurations. */
export interface NetworkInterfaceIPConfigurations {
  /**
   * Get all ip configurations in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceIPConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterfaceIPConfiguration>;
  /**
   * Gets the specified network interface ip configuration.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param ipConfigurationName The name of the ip configuration name.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    options?: NetworkInterfaceIPConfigurationsGetOptionalParams
  ): Promise<NetworkInterfaceIPConfigurationsGetResponse>;
}
