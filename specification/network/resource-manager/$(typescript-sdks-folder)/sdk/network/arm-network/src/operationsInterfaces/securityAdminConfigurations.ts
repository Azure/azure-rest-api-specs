import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  SecurityAdminConfiguration,
  SecurityAdminConfigurationsListOptionalParams,
  SecurityAdminConfigurationsGetOptionalParams,
  SecurityAdminConfigurationsGetResponse,
  SecurityAdminConfigurationsCreateOrUpdateOptionalParams,
  SecurityAdminConfigurationsCreateOrUpdateResponse,
  SecurityAdminConfigurationsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a SecurityAdminConfigurations. */
export interface SecurityAdminConfigurations {
  /**
   * Lists all the network manager security admin configurations in a network manager, in a paginated
   * format.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: SecurityAdminConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<SecurityAdminConfiguration>;
  /**
   * Retrieves a network manager security admin configuration.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: SecurityAdminConfigurationsGetOptionalParams
  ): Promise<SecurityAdminConfigurationsGetResponse>;
  /**
   * Creates or updates a network manager security admin configuration.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param securityAdminConfiguration The security admin configuration to create or update
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    securityAdminConfiguration: SecurityAdminConfiguration,
    options?: SecurityAdminConfigurationsCreateOrUpdateOptionalParams
  ): Promise<SecurityAdminConfigurationsCreateOrUpdateResponse>;
  /**
   * Deletes a network manager security admin configuration.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: SecurityAdminConfigurationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a network manager security admin configuration.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: SecurityAdminConfigurationsDeleteOptionalParams
  ): Promise<void>;
}
