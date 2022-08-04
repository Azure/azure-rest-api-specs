import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { HubRouteTables } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  HubRouteTable,
  HubRouteTablesListNextOptionalParams,
  HubRouteTablesListOptionalParams,
  HubRouteTablesCreateOrUpdateOptionalParams,
  HubRouteTablesCreateOrUpdateResponse,
  HubRouteTablesGetOptionalParams,
  HubRouteTablesGetResponse,
  HubRouteTablesDeleteOptionalParams,
  HubRouteTablesListResponse,
  HubRouteTablesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing HubRouteTables operations. */
export class HubRouteTablesImpl implements HubRouteTables {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class HubRouteTables class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of all RouteTables.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubRouteTablesListOptionalParams
  ): PagedAsyncIterableIterator<HubRouteTable> {
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
    options?: HubRouteTablesListOptionalParams
  ): AsyncIterableIterator<HubRouteTable[]> {
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
    options?: HubRouteTablesListOptionalParams
  ): AsyncIterableIterator<HubRouteTable> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualHubName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates a RouteTable resource if it doesn't exist else updates the existing RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param routeTableParameters Parameters supplied to create or update RouteTable.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    routeTableParameters: HubRouteTable,
    options?: HubRouteTablesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<HubRouteTablesCreateOrUpdateResponse>,
      HubRouteTablesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<HubRouteTablesCreateOrUpdateResponse> => {
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
        virtualHubName,
        routeTableName,
        routeTableParameters,
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
   * Creates a RouteTable resource if it doesn't exist else updates the existing RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param routeTableParameters Parameters supplied to create or update RouteTable.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    routeTableParameters: HubRouteTable,
    options?: HubRouteTablesCreateOrUpdateOptionalParams
  ): Promise<HubRouteTablesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualHubName,
      routeTableName,
      routeTableParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves the details of a RouteTable.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesGetOptionalParams
  ): Promise<HubRouteTablesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, routeTableName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes a RouteTable.
   * @param resourceGroupName The resource group name of the RouteTable.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesDeleteOptionalParams
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
      { resourceGroupName, virtualHubName, routeTableName, options },
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
   * Deletes a RouteTable.
   * @param resourceGroupName The resource group name of the RouteTable.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the RouteTable.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: HubRouteTablesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualHubName,
      routeTableName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves the details of all RouteTables.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: HubRouteTablesListOptionalParams
  ): Promise<HubRouteTablesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, options },
      listOperationSpec
    );
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
    options?: HubRouteTablesListNextOptionalParams
  ): Promise<HubRouteTablesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.HubRouteTable
    },
    201: {
      bodyMapper: Mappers.HubRouteTable
    },
    202: {
      bodyMapper: Mappers.HubRouteTable
    },
    204: {
      bodyMapper: Mappers.HubRouteTable
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.routeTableParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.routeTableName,
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.HubRouteTable
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
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables/{routeTableName}",
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
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/hubRouteTables",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListHubRouteTablesResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListHubRouteTablesResult
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
