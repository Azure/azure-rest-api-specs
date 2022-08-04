import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { LocalNetworkGateways } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  LocalNetworkGateway,
  LocalNetworkGatewaysListNextOptionalParams,
  LocalNetworkGatewaysListOptionalParams,
  LocalNetworkGatewaysCreateOrUpdateOptionalParams,
  LocalNetworkGatewaysCreateOrUpdateResponse,
  LocalNetworkGatewaysGetOptionalParams,
  LocalNetworkGatewaysGetResponse,
  LocalNetworkGatewaysDeleteOptionalParams,
  TagsObject,
  LocalNetworkGatewaysUpdateTagsOptionalParams,
  LocalNetworkGatewaysUpdateTagsResponse,
  LocalNetworkGatewaysListResponse,
  LocalNetworkGatewaysListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing LocalNetworkGateways operations. */
export class LocalNetworkGatewaysImpl implements LocalNetworkGateways {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class LocalNetworkGateways class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the local network gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: LocalNetworkGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<LocalNetworkGateway> {
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
    options?: LocalNetworkGatewaysListOptionalParams
  ): AsyncIterableIterator<LocalNetworkGateway[]> {
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
    options?: LocalNetworkGatewaysListOptionalParams
  ): AsyncIterableIterator<LocalNetworkGateway> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Creates or updates a local network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to the create or update local network gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: LocalNetworkGateway,
    options?: LocalNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<LocalNetworkGatewaysCreateOrUpdateResponse>,
      LocalNetworkGatewaysCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<LocalNetworkGatewaysCreateOrUpdateResponse> => {
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
      { resourceGroupName, localNetworkGatewayName, parameters, options },
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
   * Creates or updates a local network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to the create or update local network gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: LocalNetworkGateway,
    options?: LocalNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<LocalNetworkGatewaysCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      localNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified local network gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysGetOptionalParams
  ): Promise<LocalNetworkGatewaysGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, localNetworkGatewayName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified local network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysDeleteOptionalParams
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
      { resourceGroupName, localNetworkGatewayName, options },
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
   * Deletes the specified local network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    options?: LocalNetworkGatewaysDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      localNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a local network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param localNetworkGatewayName The name of the local network gateway.
   * @param parameters Parameters supplied to update local network gateway tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    localNetworkGatewayName: string,
    parameters: TagsObject,
    options?: LocalNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<LocalNetworkGatewaysUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, localNetworkGatewayName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all the local network gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: LocalNetworkGatewaysListOptionalParams
  ): Promise<LocalNetworkGatewaysListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
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
    options?: LocalNetworkGatewaysListNextOptionalParams
  ): Promise<LocalNetworkGatewaysListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways/{localNetworkGatewayName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.LocalNetworkGateway
    },
    201: {
      bodyMapper: Mappers.LocalNetworkGateway
    },
    202: {
      bodyMapper: Mappers.LocalNetworkGateway
    },
    204: {
      bodyMapper: Mappers.LocalNetworkGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters76,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.localNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways/{localNetworkGatewayName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LocalNetworkGateway
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
    Parameters.localNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways/{localNetworkGatewayName}",
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
    Parameters.localNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways/{localNetworkGatewayName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.LocalNetworkGateway
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
    Parameters.localNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/localNetworkGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LocalNetworkGatewayListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LocalNetworkGatewayListResult
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
