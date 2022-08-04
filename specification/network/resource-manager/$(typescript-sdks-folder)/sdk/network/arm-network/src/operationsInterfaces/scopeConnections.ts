import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  ScopeConnection,
  ScopeConnectionsListOptionalParams,
  ScopeConnectionsCreateOrUpdateOptionalParams,
  ScopeConnectionsCreateOrUpdateResponse,
  ScopeConnectionsGetOptionalParams,
  ScopeConnectionsGetResponse,
  ScopeConnectionsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ScopeConnections. */
export interface ScopeConnections {
  /**
   * List all scope connections created by this network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ScopeConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ScopeConnection>;
  /**
   * Creates or updates scope connection from Network Manager
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param parameters Scope connection to be created/updated.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    parameters: ScopeConnection,
    options?: ScopeConnectionsCreateOrUpdateOptionalParams
  ): Promise<ScopeConnectionsCreateOrUpdateResponse>;
  /**
   * Get specified scope connection created by this Network Manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    options?: ScopeConnectionsGetOptionalParams
  ): Promise<ScopeConnectionsGetResponse>;
  /**
   * Delete the pending scope connection created by this network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param options The options parameters.
   */
  delete(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    options?: ScopeConnectionsDeleteOptionalParams
  ): Promise<void>;
}
