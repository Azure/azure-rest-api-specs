import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { SubscriptionNetworkManagerConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  NetworkManagerConnection,
  SubscriptionNetworkManagerConnectionsListNextOptionalParams,
  SubscriptionNetworkManagerConnectionsListOptionalParams,
  SubscriptionNetworkManagerConnectionsCreateOrUpdateOptionalParams,
  SubscriptionNetworkManagerConnectionsCreateOrUpdateResponse,
  SubscriptionNetworkManagerConnectionsGetOptionalParams,
  SubscriptionNetworkManagerConnectionsGetResponse,
  SubscriptionNetworkManagerConnectionsDeleteOptionalParams,
  SubscriptionNetworkManagerConnectionsListResponse,
  SubscriptionNetworkManagerConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing SubscriptionNetworkManagerConnections operations. */
export class SubscriptionNetworkManagerConnectionsImpl
  implements SubscriptionNetworkManagerConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class SubscriptionNetworkManagerConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List all network manager connections created by this subscription.
   * @param options The options parameters.
   */
  public list(
    options?: SubscriptionNetworkManagerConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkManagerConnection> {
    const iter = this.listPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(options);
      }
    };
  }

  private async *listPagingPage(
    options?: SubscriptionNetworkManagerConnectionsListOptionalParams
  ): AsyncIterableIterator<NetworkManagerConnection[]> {
    let result = await this._list(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    options?: SubscriptionNetworkManagerConnectionsListOptionalParams
  ): AsyncIterableIterator<NetworkManagerConnection> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Create a network manager connection on this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param parameters Network manager connection to be created/updated.
   * @param options The options parameters.
   */
  createOrUpdate(
    networkManagerConnectionName: string,
    parameters: NetworkManagerConnection,
    options?: SubscriptionNetworkManagerConnectionsCreateOrUpdateOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      { networkManagerConnectionName, parameters, options },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Get a specified connection created by this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  get(
    networkManagerConnectionName: string,
    options?: SubscriptionNetworkManagerConnectionsGetOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { networkManagerConnectionName, options },
      getOperationSpec
    );
  }

  /**
   * Delete specified connection created by this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  delete(
    networkManagerConnectionName: string,
    options?: SubscriptionNetworkManagerConnectionsDeleteOptionalParams
  ): Promise<void> {
    return this.client.sendOperationRequest(
      { networkManagerConnectionName, options },
      deleteOperationSpec
    );
  }

  /**
   * List all network manager connections created by this subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: SubscriptionNetworkManagerConnectionsListOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: SubscriptionNetworkManagerConnectionsListNextOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkManagerConnections/{networkManagerConnectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerConnection
    },
    201: {
      bodyMapper: Mappers.NetworkManagerConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters33,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.networkManagerConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkManagerConnections/{networkManagerConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.networkManagerConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkManagerConnections/{networkManagerConnectionName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.networkManagerConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkManagerConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
