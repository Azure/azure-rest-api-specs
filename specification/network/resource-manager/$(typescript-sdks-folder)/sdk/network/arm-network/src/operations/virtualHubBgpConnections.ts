import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualHubBgpConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  BgpConnection,
  VirtualHubBgpConnectionsListNextOptionalParams,
  VirtualHubBgpConnectionsListOptionalParams,
  VirtualHubBgpConnectionsListResponse,
  VirtualHubBgpConnectionsListLearnedRoutesOptionalParams,
  VirtualHubBgpConnectionsListLearnedRoutesResponse,
  VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams,
  VirtualHubBgpConnectionsListAdvertisedRoutesResponse,
  VirtualHubBgpConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualHubBgpConnections operations. */
export class VirtualHubBgpConnectionsImpl implements VirtualHubBgpConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualHubBgpConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of all VirtualHubBgpConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubBgpConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<BgpConnection> {
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
    options?: VirtualHubBgpConnectionsListOptionalParams
  ): AsyncIterableIterator<BgpConnection[]> {
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
    options?: VirtualHubBgpConnectionsListOptionalParams
  ): AsyncIterableIterator<BgpConnection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualHubName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of all VirtualHubBgpConnections.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubBgpConnectionsListOptionalParams
  ): Promise<VirtualHubBgpConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, options },
      listOperationSpec
    );
  }

  /**
   * Retrieves a list of routes the virtual hub bgp connection has learned.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  async beginListLearnedRoutes(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListLearnedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubBgpConnectionsListLearnedRoutesResponse>,
      VirtualHubBgpConnectionsListLearnedRoutesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualHubBgpConnectionsListLearnedRoutesResponse> => {
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
      { resourceGroupName, hubName, connectionName, options },
      listLearnedRoutesOperationSpec
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
   * Retrieves a list of routes the virtual hub bgp connection has learned.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  async beginListLearnedRoutesAndWait(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListLearnedRoutesOptionalParams
  ): Promise<VirtualHubBgpConnectionsListLearnedRoutesResponse> {
    const poller = await this.beginListLearnedRoutes(
      resourceGroupName,
      hubName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves a list of routes the virtual hub bgp connection is advertising to the specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  async beginListAdvertisedRoutes(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubBgpConnectionsListAdvertisedRoutesResponse>,
      VirtualHubBgpConnectionsListAdvertisedRoutesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualHubBgpConnectionsListAdvertisedRoutesResponse> => {
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
      { resourceGroupName, hubName, connectionName, options },
      listAdvertisedRoutesOperationSpec
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
   * Retrieves a list of routes the virtual hub bgp connection is advertising to the specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param hubName The name of the virtual hub.
   * @param connectionName The name of the virtual hub bgp connection.
   * @param options The options parameters.
   */
  async beginListAdvertisedRoutesAndWait(
    resourceGroupName: string,
    hubName: string,
    connectionName: string,
    options?: VirtualHubBgpConnectionsListAdvertisedRoutesOptionalParams
  ): Promise<VirtualHubBgpConnectionsListAdvertisedRoutesResponse> {
    const poller = await this.beginListAdvertisedRoutes(
      resourceGroupName,
      hubName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
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
    options?: VirtualHubBgpConnectionsListNextOptionalParams
  ): Promise<VirtualHubBgpConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/bgpConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualHubBgpConnectionResults
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
const listLearnedRoutesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/learnedRoutes",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PeerRouteList
    },
    201: {
      bodyMapper: Mappers.PeerRouteList
    },
    202: {
      bodyMapper: Mappers.PeerRouteList
    },
    204: {
      bodyMapper: Mappers.PeerRouteList
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
    Parameters.hubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAdvertisedRoutesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{hubName}/bgpConnections/{connectionName}/advertisedRoutes",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PeerRouteList
    },
    201: {
      bodyMapper: Mappers.PeerRouteList
    },
    202: {
      bodyMapper: Mappers.PeerRouteList
    },
    204: {
      bodyMapper: Mappers.PeerRouteList
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
    Parameters.hubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualHubBgpConnectionResults
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
