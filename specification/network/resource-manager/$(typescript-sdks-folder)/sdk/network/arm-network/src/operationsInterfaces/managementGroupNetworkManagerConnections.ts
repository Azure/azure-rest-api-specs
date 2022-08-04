import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  NetworkManagerConnection,
  ManagementGroupNetworkManagerConnectionsListOptionalParams,
  ManagementGroupNetworkManagerConnectionsCreateOrUpdateOptionalParams,
  ManagementGroupNetworkManagerConnectionsCreateOrUpdateResponse,
  ManagementGroupNetworkManagerConnectionsGetOptionalParams,
  ManagementGroupNetworkManagerConnectionsGetResponse,
  ManagementGroupNetworkManagerConnectionsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ManagementGroupNetworkManagerConnections. */
export interface ManagementGroupNetworkManagerConnections {
  /**
   * List all network manager connections created by this management group.
   * @param managementGroupId The management group Id which uniquely identify the Microsoft Azure
   *                          management group.
   * @param options The options parameters.
   */
  list(
    managementGroupId: string,
    options?: ManagementGroupNetworkManagerConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkManagerConnection>;
  /**
   * Create a network manager connection on this management group.
   * @param managementGroupId The management group Id which uniquely identify the Microsoft Azure
   *                          management group.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param parameters Network manager connection to be created/updated.
   * @param options The options parameters.
   */
  createOrUpdate(
    managementGroupId: string,
    networkManagerConnectionName: string,
    parameters: NetworkManagerConnection,
    options?: ManagementGroupNetworkManagerConnectionsCreateOrUpdateOptionalParams
  ): Promise<ManagementGroupNetworkManagerConnectionsCreateOrUpdateResponse>;
  /**
   * Get a specified connection created by this management group.
   * @param managementGroupId The management group Id which uniquely identify the Microsoft Azure
   *                          management group.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  get(
    managementGroupId: string,
    networkManagerConnectionName: string,
    options?: ManagementGroupNetworkManagerConnectionsGetOptionalParams
  ): Promise<ManagementGroupNetworkManagerConnectionsGetResponse>;
  /**
   * Delete specified pending connection created by this management group.
   * @param managementGroupId The management group Id which uniquely identify the Microsoft Azure
   *                          management group.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  delete(
    managementGroupId: string,
    networkManagerConnectionName: string,
    options?: ManagementGroupNetworkManagerConnectionsDeleteOptionalParams
  ): Promise<void>;
}
