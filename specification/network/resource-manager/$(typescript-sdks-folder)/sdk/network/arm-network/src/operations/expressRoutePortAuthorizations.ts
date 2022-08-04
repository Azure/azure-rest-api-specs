import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRoutePortAuthorizations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRoutePortAuthorization,
  ExpressRoutePortAuthorizationsListNextOptionalParams,
  ExpressRoutePortAuthorizationsListOptionalParams,
  ExpressRoutePortAuthorizationsDeleteOptionalParams,
  ExpressRoutePortAuthorizationsGetOptionalParams,
  ExpressRoutePortAuthorizationsGetResponse,
  ExpressRoutePortAuthorizationsCreateOrUpdateOptionalParams,
  ExpressRoutePortAuthorizationsCreateOrUpdateResponse,
  ExpressRoutePortAuthorizationsListResponse,
  ExpressRoutePortAuthorizationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRoutePortAuthorizations operations. */
export class ExpressRoutePortAuthorizationsImpl
  implements ExpressRoutePortAuthorizations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRoutePortAuthorizations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all authorizations in an express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRoutePortAuthorizationsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRoutePortAuthorization> {
    const iter = this.listPagingAll(
      resourceGroupName,
      expressRoutePortName,
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
          expressRoutePortName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRoutePortAuthorizationsListOptionalParams
  ): AsyncIterableIterator<ExpressRoutePortAuthorization[]> {
    let result = await this._list(
      resourceGroupName,
      expressRoutePortName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        expressRoutePortName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRoutePortAuthorizationsListOptionalParams
  ): AsyncIterableIterator<ExpressRoutePortAuthorization> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      expressRoutePortName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified authorization from the specified express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    expressRoutePortName: string,
    authorizationName: string,
    options?: ExpressRoutePortAuthorizationsDeleteOptionalParams
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
      { resourceGroupName, expressRoutePortName, authorizationName, options },
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
   * Deletes the specified authorization from the specified express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    expressRoutePortName: string,
    authorizationName: string,
    options?: ExpressRoutePortAuthorizationsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      expressRoutePortName,
      authorizationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified authorization from the specified express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    expressRoutePortName: string,
    authorizationName: string,
    options?: ExpressRoutePortAuthorizationsGetOptionalParams
  ): Promise<ExpressRoutePortAuthorizationsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, authorizationName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an authorization in the specified express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route port
   *                                authorization operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    expressRoutePortName: string,
    authorizationName: string,
    authorizationParameters: ExpressRoutePortAuthorization,
    options?: ExpressRoutePortAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRoutePortAuthorizationsCreateOrUpdateResponse>,
      ExpressRoutePortAuthorizationsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRoutePortAuthorizationsCreateOrUpdateResponse> => {
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
        expressRoutePortName,
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
   * Creates or updates an authorization in the specified express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route port
   *                                authorization operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    expressRoutePortName: string,
    authorizationName: string,
    authorizationParameters: ExpressRoutePortAuthorization,
    options?: ExpressRoutePortAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<ExpressRoutePortAuthorizationsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      expressRoutePortName,
      authorizationName,
      authorizationParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all authorizations in an express route port.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRoutePortAuthorizationsListOptionalParams
  ): Promise<ExpressRoutePortAuthorizationsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the express route port.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    expressRoutePortName: string,
    nextLink: string,
    options?: ExpressRoutePortAuthorizationsListNextOptionalParams
  ): Promise<ExpressRoutePortAuthorizationsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}",
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
    Parameters.authorizationName,
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortAuthorization
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
    Parameters.authorizationName,
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations/{authorizationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortAuthorization
    },
    201: {
      bodyMapper: Mappers.ExpressRoutePortAuthorization
    },
    202: {
      bodyMapper: Mappers.ExpressRoutePortAuthorization
    },
    204: {
      bodyMapper: Mappers.ExpressRoutePortAuthorization
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.authorizationParameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.authorizationName,
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRoutePorts/{expressRoutePortName}/authorizations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortAuthorizationListResult
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
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortAuthorizationListResult
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
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
