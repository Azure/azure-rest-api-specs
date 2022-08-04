import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCircuitAuthorizations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCircuitAuthorization,
  ExpressRouteCircuitAuthorizationsListNextOptionalParams,
  ExpressRouteCircuitAuthorizationsListOptionalParams,
  ExpressRouteCircuitAuthorizationsDeleteOptionalParams,
  ExpressRouteCircuitAuthorizationsGetOptionalParams,
  ExpressRouteCircuitAuthorizationsGetResponse,
  ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse,
  ExpressRouteCircuitAuthorizationsListResponse,
  ExpressRouteCircuitAuthorizationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCircuitAuthorizations operations. */
export class ExpressRouteCircuitAuthorizationsImpl
  implements ExpressRouteCircuitAuthorizations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCircuitAuthorizations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all authorizations in an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitAuthorizationsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuitAuthorization> {
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
    options?: ExpressRouteCircuitAuthorizationsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitAuthorization[]> {
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
    options?: ExpressRouteCircuitAuthorizationsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuitAuthorization> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      circuitName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsDeleteOptionalParams
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
      { resourceGroupName, circuitName, authorizationName, options },
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
   * Deletes the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      circuitName,
      authorizationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsGetOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, authorizationName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an authorization in the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route circuit
   *                                authorization operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    authorizationParameters: ExpressRouteCircuitAuthorization,
    options?: ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse
      >,
      ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse> => {
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
        authorizationName,
        authorizationParameters,
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
   * Creates or updates an authorization in the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route circuit
   *                                authorization operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    authorizationParameters: ExpressRouteCircuitAuthorization,
    options?: ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      circuitName,
      authorizationName,
      authorizationParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all authorizations in an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitAuthorizationsListOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    circuitName: string,
    nextLink: string,
    options?: ExpressRouteCircuitAuthorizationsListNextOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}",
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
    Parameters.authorizationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitAuthorization
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
    Parameters.authorizationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitAuthorization
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitAuthorization
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitAuthorization
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitAuthorization
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.authorizationParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.circuitName,
    Parameters.authorizationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AuthorizationListResult
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
      bodyMapper: Mappers.AuthorizationListResult
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
