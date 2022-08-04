import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { RouteTables } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  RouteTable,
  RouteTablesListNextOptionalParams,
  RouteTablesListOptionalParams,
  RouteTablesListAllNextOptionalParams,
  RouteTablesListAllOptionalParams,
  RouteTablesDeleteOptionalParams,
  RouteTablesGetOptionalParams,
  RouteTablesGetResponse,
  RouteTablesCreateOrUpdateOptionalParams,
  RouteTablesCreateOrUpdateResponse,
  TagsObject,
  RouteTablesUpdateTagsOptionalParams,
  RouteTablesUpdateTagsResponse,
  RouteTablesListResponse,
  RouteTablesListAllResponse,
  RouteTablesListNextResponse,
  RouteTablesListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing RouteTables operations. */
export class RouteTablesImpl implements RouteTables {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class RouteTables class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all route tables in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: RouteTablesListOptionalParams
  ): PagedAsyncIterableIterator<RouteTable> {
    const iter = this.listPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    options?: RouteTablesListOptionalParams
  ): AsyncIterableIterator<RouteTable[]> {
    let result = await this._list(resourceGroupName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    options?: RouteTablesListOptionalParams
  ): AsyncIterableIterator<RouteTable> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all route tables in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: RouteTablesListAllOptionalParams
  ): PagedAsyncIterableIterator<RouteTable> {
    const iter = this.listAllPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listAllPagingPage(options);
      }
    };
  }

  private async *listAllPagingPage(
    options?: RouteTablesListAllOptionalParams
  ): AsyncIterableIterator<RouteTable[]> {
    let result = await this._listAll(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAllNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAllPagingAll(
    options?: RouteTablesListAllOptionalParams
  ): AsyncIterableIterator<RouteTable> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesDeleteOptionalParams
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
      { resourceGroupName, routeTableName, options },
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
   * Deletes the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      routeTableName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified route table.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeTableName: string,
    options?: RouteTablesGetOptionalParams
  ): Promise<RouteTablesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeTableName, options },
      getOperationSpec
    );
  }

  /**
   * Create or updates a route table in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to the create or update route table operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    routeTableName: string,
    parameters: RouteTable,
    options?: RouteTablesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RouteTablesCreateOrUpdateResponse>,
      RouteTablesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<RouteTablesCreateOrUpdateResponse> => {
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
      { resourceGroupName, routeTableName, parameters, options },
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
   * Create or updates a route table in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to the create or update route table operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeTableName: string,
    parameters: RouteTable,
    options?: RouteTablesCreateOrUpdateOptionalParams
  ): Promise<RouteTablesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      routeTableName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a route table tags.
   * @param resourceGroupName The name of the resource group.
   * @param routeTableName The name of the route table.
   * @param parameters Parameters supplied to update route table tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    routeTableName: string,
    parameters: TagsObject,
    options?: RouteTablesUpdateTagsOptionalParams
  ): Promise<RouteTablesUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeTableName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all route tables in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: RouteTablesListOptionalParams
  ): Promise<RouteTablesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all route tables in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: RouteTablesListAllOptionalParams
  ): Promise<RouteTablesListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    nextLink: string,
    options?: RouteTablesListNextOptionalParams
  ): Promise<RouteTablesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: RouteTablesListAllNextOptionalParams
  ): Promise<RouteTablesListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}",
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
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTable
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTable
    },
    201: {
      bodyMapper: Mappers.RouteTable
    },
    202: {
      bodyMapper: Mappers.RouteTable
    },
    204: {
      bodyMapper: Mappers.RouteTable
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters64,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTable
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.routeTableName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTableListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/routeTables",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTableListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTableListResult
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
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteTableListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
