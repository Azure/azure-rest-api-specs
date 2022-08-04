import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PeerExpressRouteCircuitConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  PeerExpressRouteCircuitConnection,
  PeerExpressRouteCircuitConnectionsListNextOptionalParams,
  PeerExpressRouteCircuitConnectionsListOptionalParams,
  PeerExpressRouteCircuitConnectionsGetOptionalParams,
  PeerExpressRouteCircuitConnectionsGetResponse,
  PeerExpressRouteCircuitConnectionsListResponse,
  PeerExpressRouteCircuitConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing PeerExpressRouteCircuitConnections operations. */
export class PeerExpressRouteCircuitConnectionsImpl
  implements PeerExpressRouteCircuitConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class PeerExpressRouteCircuitConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all global reach peer connections associated with a private peering in an express route
   * circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: PeerExpressRouteCircuitConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<PeerExpressRouteCircuitConnection> {
    const iter = this.listPagingAll(
      resourceGroupName,
      circuitName,
      peeringName,
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
          circuitName,
          peeringName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: PeerExpressRouteCircuitConnectionsListOptionalParams
  ): AsyncIterableIterator<PeerExpressRouteCircuitConnection[]> {
    let result = await this._list(
      resourceGroupName,
      circuitName,
      peeringName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        circuitName,
        peeringName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: PeerExpressRouteCircuitConnectionsListOptionalParams
  ): AsyncIterableIterator<PeerExpressRouteCircuitConnection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      circuitName,
      peeringName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets the specified Peer Express Route Circuit Connection from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the peer express route circuit connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    options?: PeerExpressRouteCircuitConnectionsGetOptionalParams
  ): Promise<PeerExpressRouteCircuitConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, connectionName, options },
      getOperationSpec
    );
  }

  /**
   * Gets all global reach peer connections associated with a private peering in an express route
   * circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: PeerExpressRouteCircuitConnectionsListOptionalParams
  ): Promise<PeerExpressRouteCircuitConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    nextLink: string,
    options?: PeerExpressRouteCircuitConnectionsListNextOptionalParams
  ): Promise<PeerExpressRouteCircuitConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections/{connectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PeerExpressRouteCircuitConnection
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/peerConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PeerExpressRouteCircuitConnectionListResult
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PeerExpressRouteCircuitConnectionListResult
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
