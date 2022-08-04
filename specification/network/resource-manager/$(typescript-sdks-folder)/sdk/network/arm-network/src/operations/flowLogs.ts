import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { FlowLogs } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  FlowLog,
  FlowLogsListNextOptionalParams,
  FlowLogsListOptionalParams,
  FlowLogsCreateOrUpdateOptionalParams,
  FlowLogsCreateOrUpdateResponse,
  TagsObject,
  FlowLogsUpdateTagsOptionalParams,
  FlowLogsUpdateTagsResponse,
  FlowLogsGetOptionalParams,
  FlowLogsGetResponse,
  FlowLogsDeleteOptionalParams,
  FlowLogsListResponse,
  FlowLogsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing FlowLogs operations. */
export class FlowLogsImpl implements FlowLogs {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class FlowLogs class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all flow log resources for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: FlowLogsListOptionalParams
  ): PagedAsyncIterableIterator<FlowLog> {
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
    options?: FlowLogsListOptionalParams
  ): AsyncIterableIterator<FlowLog[]> {
    let result = await this._list(
      resourceGroupName,
      networkWatcherName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkWatcherName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: FlowLogsListOptionalParams
  ): AsyncIterableIterator<FlowLog> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkWatcherName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Create or update a flow log for the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log.
   * @param parameters Parameters that define the create or update flow log resource.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
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
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<FlowLogsCreateOrUpdateResponse> => {
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
        flowLogName,
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
   * Create or update a flow log for the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log.
   * @param parameters Parameters that define the create or update flow log resource.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    parameters: FlowLog,
    options?: FlowLogsCreateOrUpdateOptionalParams
  ): Promise<FlowLogsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkWatcherName,
      flowLogName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<FlowLogsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkWatcherName,
        flowLogName,
        parameters,
        options
      },
      updateTagsOperationSpec
    );
  }

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
  ): Promise<FlowLogsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, flowLogName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified flow log resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log resource.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    options?: FlowLogsDeleteOptionalParams
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
      { resourceGroupName, networkWatcherName, flowLogName, options },
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
   * Deletes the specified flow log resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param flowLogName The name of the flow log resource.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    flowLogName: string,
    options?: FlowLogsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkWatcherName,
      flowLogName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all flow log resources for the specified Network Watcher.
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: FlowLogsListOptionalParams
  ): Promise<FlowLogsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group containing Network Watcher.
   * @param networkWatcherName The name of the Network Watcher resource.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkWatcherName: string,
    nextLink: string,
    options?: FlowLogsListNextOptionalParams
  ): Promise<FlowLogsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLog
    },
    201: {
      bodyMapper: Mappers.FlowLog
    },
    202: {
      bodyMapper: Mappers.FlowLog
    },
    204: {
      bodyMapper: Mappers.FlowLog
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters57,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName,
    Parameters.flowLogName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLog
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
    Parameters.flowLogName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLog
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
    Parameters.flowLogName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs/{flowLogName}",
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
    Parameters.flowLogName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/flowLogs",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLogListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLogListResult
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
    Parameters.nextLink,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
