import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ConnectionMonitorResult,
  ConnectionMonitorsListOptionalParams,
  ConnectionMonitor,
  ConnectionMonitorsCreateOrUpdateOptionalParams,
  ConnectionMonitorsCreateOrUpdateResponse,
  ConnectionMonitorsGetOptionalParams,
  ConnectionMonitorsGetResponse,
  ConnectionMonitorsDeleteOptionalParams,
  TagsObject,
  ConnectionMonitorsUpdateTagsOptionalParams,
  ConnectionMonitorsUpdateTagsResponse,
  ConnectionMonitorsStopOptionalParams,
  ConnectionMonitorsStartOptionalParams,
  ConnectionMonitorsQueryOptionalParams,
  ConnectionMonitorsQueryResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ConnectionMonitors. */
export interface ConnectionMonitors {
  /**
   * Lists all connection monitors for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: ConnectionMonitorsListOptionalParams
  ): PagedAsyncIterableIterator<ConnectionMonitorResult>;
  /**
   * Create or update a connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param parameters Parameters that define the operation to create a connection monitor.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    parameters: ConnectionMonitor,
    options?: ConnectionMonitorsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ConnectionMonitorsCreateOrUpdateResponse>,
      ConnectionMonitorsCreateOrUpdateResponse
    >
  >;
  /**
   * Create or update a connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param parameters Parameters that define the operation to create a connection monitor.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    parameters: ConnectionMonitor,
    options?: ConnectionMonitorsCreateOrUpdateOptionalParams
  ): Promise<ConnectionMonitorsCreateOrUpdateResponse>;
  /**
   * Gets a connection monitor by name.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsGetOptionalParams
  ): Promise<ConnectionMonitorsGetResponse>;
  /**
   * Deletes the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Update tags of the specified connection monitor.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param connectionMonitorName The name of the connection monitor.
   * @param parameters Parameters supplied to update connection monitor tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    parameters: TagsObject,
    options?: ConnectionMonitorsUpdateTagsOptionalParams
  ): Promise<ConnectionMonitorsUpdateTagsResponse>;
  /**
   * Stops the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginStop(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStopOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Stops the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginStopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStopOptionalParams
  ): Promise<void>;
  /**
   * Starts the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginStart(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStartOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Starts the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  beginStartAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStartOptionalParams
  ): Promise<void>;
  /**
   * Query a snapshot of the most recent connection states.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name given to the connection monitor.
   * @param options The options parameters.
   */
  beginQuery(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsQueryOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ConnectionMonitorsQueryResponse>,
      ConnectionMonitorsQueryResponse
    >
  >;
  /**
   * Query a snapshot of the most recent connection states.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name given to the connection monitor.
   * @param options The options parameters.
   */
  beginQueryAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsQueryOptionalParams
  ): Promise<ConnectionMonitorsQueryResponse>;
}
