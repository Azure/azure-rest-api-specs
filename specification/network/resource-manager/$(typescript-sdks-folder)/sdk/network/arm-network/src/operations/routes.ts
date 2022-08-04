import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { Routes } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  Route,
  RoutesListNextOptionalParams,
  RoutesListOptionalParams,
  RoutesDeleteOptionalParams,
  RoutesGetOptionalParams,
  RoutesGetResponse,
  RoutesCreateOrUpdateOptionalParams,
  RoutesCreateOrUpdateResponse,
  RoutesListResponse,
  RoutesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing Routes operations. */
export class RoutesImpl implements Routes {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class Routes class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all routes in a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    routeTableName: string,
    options?: RoutesListOptionalParams
  ): PagedAsyncIterableIterator<Route> {
    const iter = this.listPagingAll(resourceGroupName, routeTableName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, routeTableName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    routeTableName: string,
    options?: RoutesListOptionalParams
  ): AsyncIterableIterator<Route[]> {
    let result = await this._list(resourceGroupName, routeTableName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        routeTableName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    routeTableName: string,
    options?: RoutesListOptionalParams
  ): AsyncIterableIterator<Route> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      routeTableName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesDeleteOptionalParams
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
      { resourceGroupName, routeTableName, routeName, options },
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
   * Deletes the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      routeTableName,
      routeName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified route from a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    options?: RoutesGetOptionalParams
  ): Promise<RoutesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeTableName, routeName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a route in the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param routeParameters Parameters supplied to the create or update route operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    routeParameters: Route,
    options?: RoutesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RoutesCreateOrUpdateResponse>,
      RoutesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<RoutesCreateOrUpdateResponse> => {
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
        routeTableName,
        routeName,
        routeParameters,
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
   * Creates or updates a route in the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param routeName The name of the route.
   * @param routeParameters Parameters supplied to the create or update route operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeTableName: string,
    routeName: string,
    routeParameters: Route,
    options?: RoutesCreateOrUpdateOptionalParams
  ): Promise<RoutesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      routeTableName,
      routeName,
      routeParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all routes in a route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    routeTableName: string,
    options?: RoutesListOptionalParams
  ): Promise<RoutesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeTableName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    routeTableName: string,
    nextLink: string,
    options?: RoutesListNextOptionalParams
  ): Promise<RoutesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeTableName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes/{routeName}",
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
    Parameters.routeTableName,
    Parameters.routeName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes/{routeName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.Route
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
    Parameters.routeTableName,
    Parameters.routeName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes/{routeName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.Route
    },
    201: {
      bodyMapper: Mappers.Route
    },
    202: {
      bodyMapper: Mappers.Route
    },
    204: {
      bodyMapper: Mappers.Route
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.routeParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.routeTableName,
    Parameters.routeName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteListResult
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
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteListResult
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
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
