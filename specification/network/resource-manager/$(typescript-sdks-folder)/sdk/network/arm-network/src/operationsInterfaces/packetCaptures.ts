import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PacketCaptureResult,
  PacketCapturesListOptionalParams,
  PacketCapture,
  PacketCapturesCreateOptionalParams,
  PacketCapturesCreateResponse,
  PacketCapturesGetOptionalParams,
  PacketCapturesGetResponse,
  PacketCapturesDeleteOptionalParams,
  PacketCapturesStopOptionalParams,
  PacketCapturesGetStatusOptionalParams,
  PacketCapturesGetStatusResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PacketCaptures. */
export interface PacketCaptures {
  /**
   * Lists all packet capture sessions within the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: PacketCapturesListOptionalParams
  ): PagedAsyncIterableIterator<PacketCaptureResult>;
  /**
   * Create and start a packet capture on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param parameters Parameters that define the create packet capture operation.
   * @param options The options parameters.
   */
  beginCreate(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    parameters: PacketCapture,
    options?: PacketCapturesCreateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PacketCapturesCreateResponse>,
      PacketCapturesCreateResponse
    >
  >;
  /**
   * Create and start a packet capture on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param parameters Parameters that define the create packet capture operation.
   * @param options The options parameters.
   */
  beginCreateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    parameters: PacketCapture,
    options?: PacketCapturesCreateOptionalParams
  ): Promise<PacketCapturesCreateResponse>;
  /**
   * Gets a packet capture session by name.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesGetOptionalParams
  ): Promise<PacketCapturesGetResponse>;
  /**
   * Deletes the specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Stops a specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  beginStop(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesStopOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Stops a specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  beginStopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesStopOptionalParams
  ): Promise<void>;
  /**
   * Query the status of a running packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param packetCaptureName The name given to the packet capture session.
   * @param options The options parameters.
   */
  beginGetStatus(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesGetStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PacketCapturesGetStatusResponse>,
      PacketCapturesGetStatusResponse
    >
  >;
  /**
   * Query the status of a running packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param packetCaptureName The name given to the packet capture session.
   * @param options The options parameters.
   */
  beginGetStatusAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesGetStatusOptionalParams
  ): Promise<PacketCapturesGetStatusResponse>;
}
