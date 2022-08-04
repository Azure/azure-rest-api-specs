import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  FlowLog,
  FlowLogsListOptionalParams,
  FlowLogsCreateOrUpdateOptionalParams,
  FlowLogsCreateOrUpdateResponse,
  TagsObject,
  FlowLogsUpdateTagsOptionalParams,
  FlowLogsUpdateTagsResponse,
  FlowLogsGetOptionalParams,
  FlowLogsGetResponse,
  FlowLogsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a FlowLogs. */
export interface FlowLogs {
  /**
   * Lists all flow log resources for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: FlowLogsListOptionalParams
  ): PagedAsyncIterableIterator<FlowLog>;
  /**
   * Create or update a flow log for the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log.
   * @param parameters Parameters that define the create or update flow log resource.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    parameters: FlowLog,
    options?: FlowLogsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<FlowLogsCreateOrUpdateResponse>,
      FlowLogsCreateOrUpdateResponse
    >
  >;
  /**
   * Create or update a flow log for the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log.
   * @param parameters Parameters that define the create or update flow log resource.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    parameters: FlowLog,
    options?: FlowLogsCreateOrUpdateOptionalParams
  ): Promise<FlowLogsCreateOrUpdateResponse>;
  /**
   * Update tags of the specified flow log.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log.
   * @param parameters Parameters supplied to update flow log tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    parameters: TagsObject,
    options?: FlowLogsUpdateTagsOptionalParams
  ): Promise<FlowLogsUpdateTagsResponse>;
  /**
   * Gets a flow log resource by name.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log resource.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    options?: FlowLogsGetOptionalParams
  ): Promise<FlowLogsGetResponse>;
  /**
   * Deletes the specified flow log resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log resource.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    options?: FlowLogsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified flow log resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log resource.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    options?: FlowLogsDeleteOptionalParams
  ): Promise<void>;
}
