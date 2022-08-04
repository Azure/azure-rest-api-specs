import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { HubVirtualNetworkConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  HubVirtualNetworkConnection,
  HubVirtualNetworkConnectionsListNextOptionalParams,
  HubVirtualNetworkConnectionsListOptionalParams,
  HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams,
  HubVirtualNetworkConnectionsCreateOrUpdateResponse,
  HubVirtualNetworkConnectionsDeleteOptionalParams,
  HubVirtualNetworkConnectionsGetOptionalParams,
  HubVirtualNetworkConnectionsGetResponse,
  HubVirtualNetworkConnectionsListResponse,
  HubVirtualNetworkConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing HubVirtualNetworkConnections operations. */
export class HubVirtualNetworkConnectionsImpl
  implements HubVirtualNetworkConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class HubVirtualNetworkConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubVirtualNetworkConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<HubVirtualNetworkConnection> {
    const iter = this.listPagingAll(resourceGroupName, virtualHubName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, virtualHubName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubVirtualNetworkConnectionsListOptionalParams
  ): AsyncIterableIterator<HubVirtualNetworkConnection[]> {
    let result = await this._list(resourceGroupName, virtualHubName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        virtualHubName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubVirtualNetworkConnectionsListOptionalParams
  ): AsyncIterableIterator<HubVirtualNetworkConnection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualHubName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the HubVirtualNetworkConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param hubVirtualNetworkConnectionParameters Parameters supplied to create or update a hub virtual
   *                                              network connection.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    hubVirtualNetworkConnectionParameters: HubVirtualNetworkConnection,
    options?: HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<HubVirtualNetworkConnectionsCreateOrUpdateResponse>,
      HubVirtualNetworkConnectionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<HubVirtualNetworkConnectionsCreateOrUpdateResponse> => {
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
        virtualHubName,
        connectionName,
        hubVirtualNetworkConnectionParameters,
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
   * Creates a hub virtual network connection if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the HubVirtualNetworkConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param hubVirtualNetworkConnectionParameters Parameters supplied to create or update a hub virtual
   *                                              network connection.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    hubVirtualNetworkConnectionParameters: HubVirtualNetworkConnection,
    options?: HubVirtualNetworkConnectionsCreateOrUpdateOptionalParams
  ): Promise<HubVirtualNetworkConnectionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualHubName,
      connectionName,
      hubVirtualNetworkConnectionParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsDeleteOptionalParams
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
      { resourceGroupName, virtualHubName, connectionName, options },
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
   * Deletes a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the HubVirtualNetworkConnection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualHubName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves the details of a HubVirtualNetworkConnection.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param connectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    connectionName: string,
    options?: HubVirtualNetworkConnectionsGetOptionalParams
  ): Promise<HubVirtualNetworkConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, connectionName, options },
      getOperationSpec
    );
  }

  /**
   * Retrieves the details of all HubVirtualNetworkConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubVirtualNetworkConnectionsListOptionalParams
  ): Promise<HubVirtualNetworkConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    virtualHubName: string,
    nextLink: string,
    options?: HubVirtualNetworkConnectionsListNextOptionalParams
  ): Promise<HubVirtualNetworkConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.HubVirtualNetworkConnection
    },
    201: {
      bodyMapper: Mappers.HubVirtualNetworkConnection
    },
    202: {
      bodyMapper: Mappers.HubVirtualNetworkConnection
    },
    204: {
      bodyMapper: Mappers.HubVirtualNetworkConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.hubVirtualNetworkConnectionParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.connectionName,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.connectionName,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections/{connectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.HubVirtualNetworkConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.connectionName,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubVirtualNetworkConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListHubVirtualNetworkConnectionsResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListHubVirtualNetworkConnectionsResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
