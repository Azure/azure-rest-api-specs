import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ConnectivityConfiguration,
  ConnectivityConfigurationsListOptionalParams,
  ConnectivityConfigurationsGetOptionalParams,
  ConnectivityConfigurationsGetResponse,
  ConnectivityConfigurationsCreateOrUpdateOptionalParams,
  ConnectivityConfigurationsCreateOrUpdateResponse,
  ConnectivityConfigurationsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ConnectivityConfigurations. */
export interface ConnectivityConfigurations {
  /**
   * Lists all the network manager connectivity configuration in a specified network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ConnectivityConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<ConnectivityConfiguration>;
  /**
   * Gets a Network Connectivity Configuration, specified by the resource group, network manager name,
   * and connectivity Configuration name
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager connectivity configuration.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: ConnectivityConfigurationsGetOptionalParams
  ): Promise<ConnectivityConfigurationsGetResponse>;
  /**
   * Creates/Updates a new network manager connectivity configuration
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager connectivity configuration.
   * @param connectivityConfiguration Parameters supplied to create/update a network manager connectivity
   *                                  configuration
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    connectivityConfiguration: ConnectivityConfiguration,
    options?: ConnectivityConfigurationsCreateOrUpdateOptionalParams
  ): Promise<ConnectivityConfigurationsCreateOrUpdateResponse>;
  /**
   * Deletes a network manager connectivity configuration, specified by the resource group, network
   * manager name, and connectivity configuration name
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager connectivity configuration.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: ConnectivityConfigurationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a network manager connectivity configuration, specified by the resource group, network
   * manager name, and connectivity configuration name
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager connectivity configuration.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: ConnectivityConfigurationsDeleteOptionalParams
  ): Promise<void>;
}
