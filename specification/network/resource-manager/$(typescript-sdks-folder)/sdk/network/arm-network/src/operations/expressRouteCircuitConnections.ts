import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCircuitConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCircuitConnection,
  ExpressRouteCircuitConnectionsListNextOptionalParams,
  ExpressRouteCircuitConnectionsListOptionalParams,
  ExpressRouteCircuitConnectionsDeleteOptionalParams,
  ExpressRouteCircuitConnectionsGetOptionalParams,
  ExpressRouteCircuitConnectionsGetResponse,
  ExpressRouteCircuitConnectionsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitConnectionsCreateOrUpdateResponse,
  ExpressRouteCircuitConnectionsListResponse,
  ExpressRouteCircuitConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCircuitConnections operations. */
export class ExpressRouteCircuitConnectionsImpl
  implements ExpressRouteCircuitConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCircuitConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all global reach connections associated with a private peering in an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuitConnection> {
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
    options?: ExpressRouteCircuitConnectionsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitConnection[]> {
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
    options?: ExpressRouteCircuitConnectionsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitConnection> {
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
   * Deletes the specified Express Route Circuit Connection from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the express route circuit connection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    options?: ExpressRouteCircuitConnectionsDeleteOptionalParams
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
      { resourceGroupName, circuitName, peeringName, connectionName, options },
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
   * Deletes the specified Express Route Circuit Connection from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the express route circuit connection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    options?: ExpressRouteCircuitConnectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      circuitName,
      peeringName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Express Route Circuit Connection from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the express route circuit connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    options?: ExpressRouteCircuitConnectionsGetOptionalParams
  ): Promise<ExpressRouteCircuitConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, connectionName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a Express Route Circuit Connection in the specified express route circuits.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the express route circuit connection.
   * @param expressRouteCircuitConnectionParameters Parameters supplied to the create or update express
   *                                                route circuit connection operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    expressRouteCircuitConnectionParameters: ExpressRouteCircuitConnection,
    options?: ExpressRouteCircuitConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitConnectionsCreateOrUpdateResponse>,
      ExpressRouteCircuitConnectionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitConnectionsCreateOrUpdateResponse> => {
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
        circuitName,
        peeringName,
        connectionName,
        expressRouteCircuitConnectionParameters,
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
   * Creates or updates a Express Route Circuit Connection in the specified express route circuits.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param connectionName The name of the express route circuit connection.
   * @param expressRouteCircuitConnectionParameters Parameters supplied to the create or update express
   *                                                route circuit connection operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    connectionName: string,
    expressRouteCircuitConnectionParameters: ExpressRouteCircuitConnection,
    options?: ExpressRouteCircuitConnectionsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitConnectionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      circuitName,
      peeringName,
      connectionName,
      expressRouteCircuitConnectionParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all global reach connections associated with a private peering in an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitConnectionsListOptionalParams
  ): Promise<ExpressRouteCircuitConnectionsListResponse> {
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
    options?: ExpressRouteCircuitConnectionsListNextOptionalParams
  ): Promise<ExpressRouteCircuitConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}",
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitConnection
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
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections/{connectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitConnection
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitConnection
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitConnection
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.expressRouteCircuitConnectionParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.connectionName,
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/connections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitConnectionListResult
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
      bodyMapper: Mappers.ExpressRouteCircuitConnectionListResult
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
