import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PacketCaptures } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
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
  PacketCapturesGetStatusResponse,
  PacketCapturesListResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing PacketCaptures operations. */
export class PacketCapturesImpl implements PacketCaptures {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class PacketCaptures class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all packet capture sessions within the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: PacketCapturesListOptionalParams
  ): PagedAsyncIterableIterator<PacketCaptureResult> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkWatcherName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(
          resourceGroupName,
          networkWatcherName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: PacketCapturesListOptionalParams
  ): AsyncIterableIterator<PacketCaptureResult[]> {
    let result = await this._list(
      resourceGroupName,
      networkWatcherName,
      options
    );
    yield result.value || [];
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: PacketCapturesListOptionalParams
  ): AsyncIterableIterator<PacketCaptureResult> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkWatcherName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Create and start a packet capture on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param parameters Parameters that define the create packet capture operation.
   * @param options The options parameters.
   */
  async beginCreate(
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
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PacketCapturesCreateResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      {
        resourceGroupName,
        networkWatcherName,
        packetCaptureName,
        parameters,
        options
      },
      createOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "azure-async-operation"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Create and start a packet capture on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param parameters Parameters that define the create packet capture operation.
   * @param options The options parameters.
   */
  async beginCreateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    parameters: PacketCapture,
    options?: PacketCapturesCreateOptionalParams
  ): Promise<PacketCapturesCreateResponse> {
    const poller = await this.beginCreate(
      resourceGroupName,
      networkWatcherName,
      packetCaptureName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<PacketCapturesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, packetCaptureName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>> {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<void> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkWatcherName, packetCaptureName, options },
      deleteOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Deletes the specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkWatcherName,
      packetCaptureName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Stops a specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  async beginStop(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesStopOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>> {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<void> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkWatcherName, packetCaptureName, options },
      stopOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Stops a specified packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param packetCaptureName The name of the packet capture session.
   * @param options The options parameters.
   */
  async beginStopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesStopOptionalParams
  ): Promise<void> {
    const poller = await this.beginStop(
      resourceGroupName,
      networkWatcherName,
      packetCaptureName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Query the status of a running packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param packetCaptureName The name given to the packet capture session.
   * @param options The options parameters.
   */
  async beginGetStatus(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesGetStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PacketCapturesGetStatusResponse>,
      PacketCapturesGetStatusResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PacketCapturesGetStatusResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkWatcherName, packetCaptureName, options },
      getStatusOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Query the status of a running packet capture session.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param packetCaptureName The name given to the packet capture session.
   * @param options The options parameters.
   */
  async beginGetStatusAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    packetCaptureName: string,
    options?: PacketCapturesGetStatusOptionalParams
  ): Promise<PacketCapturesGetStatusResponse> {
    const poller = await this.beginGetStatus(
      resourceGroupName,
      networkWatcherName,
      packetCaptureName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all packet capture sessions within the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: PacketCapturesListOptionalParams
  ): Promise<PacketCapturesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.PacketCaptureResult
    },
    201: {
      bodyMapper: Mappers.PacketCaptureResult
    },
    202: {
      bodyMapper: Mappers.PacketCaptureResult
    },
    204: {
      bodyMapper: Mappers.PacketCaptureResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters55,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.packetCaptureName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PacketCaptureResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.packetCaptureName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.packetCaptureName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const stopOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.packetCaptureName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getStatusOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PacketCaptureQueryStatusResult
    },
    201: {
      bodyMapper: Mappers.PacketCaptureQueryStatusResult
    },
    202: {
      bodyMapper: Mappers.PacketCaptureQueryStatusResult
    },
    204: {
      bodyMapper: Mappers.PacketCaptureQueryStatusResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.packetCaptureName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PacketCaptureListResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
