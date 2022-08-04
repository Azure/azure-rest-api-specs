import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCircuitPeerings } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCircuitPeering,
  ExpressRouteCircuitPeeringsListNextOptionalParams,
  ExpressRouteCircuitPeeringsListOptionalParams,
  ExpressRouteCircuitPeeringsDeleteOptionalParams,
  ExpressRouteCircuitPeeringsGetOptionalParams,
  ExpressRouteCircuitPeeringsGetResponse,
  ExpressRouteCircuitPeeringsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitPeeringsCreateOrUpdateResponse,
  ExpressRouteCircuitPeeringsListResponse,
  ExpressRouteCircuitPeeringsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCircuitPeerings operations. */
export class ExpressRouteCircuitPeeringsImpl
  implements ExpressRouteCircuitPeerings {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCircuitPeerings class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all peerings in a specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuitPeering> {
    const iter = this.listPagingAll(resourceGroupName, circuitName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, circuitName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitPeeringsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitPeering[]> {
    let result = await this._list(resourceGroupName, circuitName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        circuitName,
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
    options?: ExpressRouteCircuitPeeringsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitPeering> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      circuitName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified peering from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitPeeringsDeleteOptionalParams
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
      { resourceGroupName, circuitName, peeringName, options },
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
   * Deletes the specified peering from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitPeeringsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      circuitName,
      peeringName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified peering for the express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitPeeringsGetOptionalParams
  ): Promise<ExpressRouteCircuitPeeringsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a peering in the specified express route circuits.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update express route circuit peering
   *                          operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCircuitPeering,
    options?: ExpressRouteCircuitPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitPeeringsCreateOrUpdateResponse>,
      ExpressRouteCircuitPeeringsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitPeeringsCreateOrUpdateResponse> => {
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
        peeringParameters,
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
   * Creates or updates a peering in the specified express route circuits.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update express route circuit peering
   *                          operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCircuitPeering,
    options?: ExpressRouteCircuitPeeringsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitPeeringsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      circuitName,
      peeringName,
      peeringParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all peerings in a specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitPeeringsListOptionalParams
  ): Promise<ExpressRouteCircuitPeeringsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    circuitName: string,
    nextLink: string,
    options?: ExpressRouteCircuitPeeringsListNextOptionalParams
  ): Promise<ExpressRouteCircuitPeeringsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}",
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitPeering
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
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitPeering
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitPeering
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitPeering
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitPeering
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.peeringParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitPeeringListResult
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitPeeringListResult
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
