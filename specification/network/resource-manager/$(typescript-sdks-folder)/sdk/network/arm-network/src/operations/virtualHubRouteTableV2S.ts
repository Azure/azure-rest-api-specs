import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualHubRouteTableV2S } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualHubRouteTableV2,
  VirtualHubRouteTableV2SListNextOptionalParams,
  VirtualHubRouteTableV2SListOptionalParams,
  VirtualHubRouteTableV2SGetOptionalParams,
  VirtualHubRouteTableV2SGetResponse,
  VirtualHubRouteTableV2SCreateOrUpdateOptionalParams,
  VirtualHubRouteTableV2SCreateOrUpdateResponse,
  VirtualHubRouteTableV2SDeleteOptionalParams,
  VirtualHubRouteTableV2SListResponse,
  VirtualHubRouteTableV2SListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualHubRouteTableV2S operations. */
export class VirtualHubRouteTableV2SImpl implements VirtualHubRouteTableV2S {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualHubRouteTableV2S class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of all VirtualHubRouteTableV2s.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubRouteTableV2SListOptionalParams
  ): PagedAsyncIterableIterator<VirtualHubRouteTableV2> {
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
    options?: VirtualHubRouteTableV2SListOptionalParams
  ): AsyncIterableIterator<VirtualHubRouteTableV2[]> {
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
    options?: VirtualHubRouteTableV2SListOptionalParams
  ): AsyncIterableIterator<VirtualHubRouteTableV2> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualHubName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a VirtualHubRouteTableV2.
   * @param resourceGroupName The resource group name of the VirtualHubRouteTableV2.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the VirtualHubRouteTableV2.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: VirtualHubRouteTableV2SGetOptionalParams
  ): Promise<VirtualHubRouteTableV2SGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, routeTableName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a VirtualHubRouteTableV2 resource if it doesn't exist else updates the existing
   * VirtualHubRouteTableV2.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the VirtualHubRouteTableV2.
   * @param virtualHubRouteTableV2Parameters Parameters supplied to create or update
   *                                         VirtualHubRouteTableV2.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    virtualHubRouteTableV2Parameters: VirtualHubRouteTableV2,
    options?: VirtualHubRouteTableV2SCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubRouteTableV2SCreateOrUpdateResponse>,
      VirtualHubRouteTableV2SCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualHubRouteTableV2SCreateOrUpdateResponse> => {
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
        virtualHubRouteTableV2Parameters,
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
   * Creates a VirtualHubRouteTableV2 resource if it doesn't exist else updates the existing
   * VirtualHubRouteTableV2.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the VirtualHubRouteTableV2.
   * @param virtualHubRouteTableV2Parameters Parameters supplied to create or update
   *                                         VirtualHubRouteTableV2.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    virtualHubRouteTableV2Parameters: VirtualHubRouteTableV2,
    options?: VirtualHubRouteTableV2SCreateOrUpdateOptionalParams
  ): Promise<VirtualHubRouteTableV2SCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualHubName,
      routeTableName,
      virtualHubRouteTableV2Parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a VirtualHubRouteTableV2.
   * @param resourceGroupName The resource group name of the VirtualHubRouteTableV2.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the VirtualHubRouteTableV2.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: VirtualHubRouteTableV2SDeleteOptionalParams
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
   * Deletes a VirtualHubRouteTableV2.
   * @param resourceGroupName The resource group name of the VirtualHubRouteTableV2.
   * @param virtualHubName The name of the VirtualHub.
   * @param routeTableName The name of the VirtualHubRouteTableV2.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    routeTableName: string,
    options?: VirtualHubRouteTableV2SDeleteOptionalParams
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
   * Retrieves the details of all VirtualHubRouteTableV2s.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubRouteTableV2SListOptionalParams
  ): Promise<VirtualHubRouteTableV2SListResponse> {
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
    options?: VirtualHubRouteTableV2SListNextOptionalParams
  ): Promise<VirtualHubRouteTableV2SListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualHubRouteTableV2
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualHubRouteTableV2
    },
    201: {
      bodyMapper: Mappers.VirtualHubRouteTableV2
    },
    202: {
      bodyMapper: Mappers.VirtualHubRouteTableV2
    },
    204: {
      bodyMapper: Mappers.VirtualHubRouteTableV2
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.virtualHubRouteTableV2Parameters,
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
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables/{routeTableName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorModel
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/routeTables",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualHubRouteTableV2SResult
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
      bodyMapper: Mappers.ListVirtualHubRouteTableV2SResult
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
