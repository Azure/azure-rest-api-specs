import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ConnectionMonitors } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
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
  ConnectionMonitorsQueryResponse,
  ConnectionMonitorsListResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ConnectionMonitors operations. */
export class ConnectionMonitorsImpl implements ConnectionMonitors {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ConnectionMonitors class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all connection monitors for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: ConnectionMonitorsListOptionalParams
  ): PagedAsyncIterableIterator<ConnectionMonitorResult> {
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
    options?: ConnectionMonitorsListOptionalParams
  ): AsyncIterableIterator<ConnectionMonitorResult[]> {
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
    options?: ConnectionMonitorsListOptionalParams
  ): AsyncIterableIterator<ConnectionMonitorResult> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkWatcherName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Create or update a connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param parameters Parameters that define the operation to create a connection monitor.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
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
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ConnectionMonitorsCreateOrUpdateResponse> => {
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
        connectionMonitorName,
        parameters,
        options
      },
      createOrUpdateOperationSpec
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
   * Create or update a connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param parameters Parameters that define the operation to create a connection monitor.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    parameters: ConnectionMonitor,
    options?: ConnectionMonitorsCreateOrUpdateOptionalParams
  ): Promise<ConnectionMonitorsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkWatcherName,
      connectionMonitorName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<ConnectionMonitorsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, connectionMonitorName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsDeleteOptionalParams
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
      { resourceGroupName, networkWatcherName, connectionMonitorName, options },
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
   * Deletes the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkWatcherName,
      connectionMonitorName,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<ConnectionMonitorsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkWatcherName,
        connectionMonitorName,
        parameters,
        options
      },
      updateTagsOperationSpec
    );
  }

  /**
   * Stops the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginStop(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStopOptionalParams
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
      { resourceGroupName, networkWatcherName, connectionMonitorName, options },
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
   * Stops the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginStopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStopOptionalParams
  ): Promise<void> {
    const poller = await this.beginStop(
      resourceGroupName,
      networkWatcherName,
      connectionMonitorName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Starts the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginStart(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStartOptionalParams
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
      { resourceGroupName, networkWatcherName, connectionMonitorName, options },
      startOperationSpec
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
   * Starts the specified connection monitor.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name of the connection monitor.
   * @param options The options parameters.
   */
  async beginStartAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsStartOptionalParams
  ): Promise<void> {
    const poller = await this.beginStart(
      resourceGroupName,
      networkWatcherName,
      connectionMonitorName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Query a snapshot of the most recent connection states.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name given to the connection monitor.
   * @param options The options parameters.
   */
  async beginQuery(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsQueryOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ConnectionMonitorsQueryResponse>,
      ConnectionMonitorsQueryResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ConnectionMonitorsQueryResponse> => {
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
      { resourceGroupName, networkWatcherName, connectionMonitorName, options },
      queryOperationSpec
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
   * Query a snapshot of the most recent connection states.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param connectionMonitorName The name given to the connection monitor.
   * @param options The options parameters.
   */
  async beginQueryAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    connectionMonitorName: string,
    options?: ConnectionMonitorsQueryOptionalParams
  ): Promise<ConnectionMonitorsQueryResponse> {
    const poller = await this.beginQuery(
      resourceGroupName,
      networkWatcherName,
      connectionMonitorName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all connection monitors for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: ConnectionMonitorsListOptionalParams
  ): Promise<ConnectionMonitorsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionMonitorResult
    },
    201: {
      bodyMapper: Mappers.ConnectionMonitorResult
    },
    202: {
      bodyMapper: Mappers.ConnectionMonitorResult
    },
    204: {
      bodyMapper: Mappers.ConnectionMonitorResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters56,
  queryParameters: [Parameters.apiVersion, Parameters.migrate],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionMonitorResult
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
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}",
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
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionMonitorResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const stopOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/stop",
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
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const startOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/start",
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
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const queryOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors/{connectionMonitorName}/query",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionMonitorQueryResult
    },
    201: {
      bodyMapper: Mappers.ConnectionMonitorQueryResult
    },
    202: {
      bodyMapper: Mappers.ConnectionMonitorQueryResult
    },
    204: {
      bodyMapper: Mappers.ConnectionMonitorQueryResult
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
    Parameters.connectionMonitorName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectionMonitors",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionMonitorListResult
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
