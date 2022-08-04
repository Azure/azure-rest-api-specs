import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCrossConnectionPeerings } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCrossConnectionPeering,
  ExpressRouteCrossConnectionPeeringsListNextOptionalParams,
  ExpressRouteCrossConnectionPeeringsListOptionalParams,
  ExpressRouteCrossConnectionPeeringsListResponse,
  ExpressRouteCrossConnectionPeeringsDeleteOptionalParams,
  ExpressRouteCrossConnectionPeeringsGetOptionalParams,
  ExpressRouteCrossConnectionPeeringsGetResponse,
  ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams,
  ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse,
  ExpressRouteCrossConnectionPeeringsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCrossConnectionPeerings operations. */
export class ExpressRouteCrossConnectionPeeringsImpl
  implements ExpressRouteCrossConnectionPeerings {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCrossConnectionPeerings class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCrossConnectionPeering> {
    const iter = this.listPagingAll(
      resourceGroupName,
      crossConnectionName,
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
          crossConnectionName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionPeeringsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnectionPeering[]> {
    let result = await this._list(
      resourceGroupName,
      crossConnectionName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        crossConnectionName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionPeeringsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnectionPeering> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      crossConnectionName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all peerings in a specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionPeeringsListOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, crossConnectionName, options },
      listOperationSpec
    );
  }

  /**
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsDeleteOptionalParams
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
      { resourceGroupName, crossConnectionName, peeringName, options },
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
   * Deletes the specified peering from the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      crossConnectionName,
      peeringName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified peering for the ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    options?: ExpressRouteCrossConnectionPeeringsGetOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, crossConnectionName, peeringName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update ExpressRouteCrossConnection
   *                          peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCrossConnectionPeering,
    options?: ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse
      >,
      ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse> => {
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
        crossConnectionName,
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
   * Creates or updates a peering in the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param peeringParameters Parameters supplied to the create or update ExpressRouteCrossConnection
   *                          peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    peeringParameters: ExpressRouteCrossConnectionPeering,
    options?: ExpressRouteCrossConnectionPeeringsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      crossConnectionName,
      peeringName,
      peeringParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    crossConnectionName: string,
    nextLink: string,
    options?: ExpressRouteCrossConnectionPeeringsListNextOptionalParams
  ): Promise<ExpressRouteCrossConnectionPeeringsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, crossConnectionName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeeringList
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
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}",
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
    Parameters.peeringName,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeering
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
    Parameters.peeringName,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeering
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeering
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeering
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeering
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.peeringParameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.peeringName,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionPeeringList
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
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
