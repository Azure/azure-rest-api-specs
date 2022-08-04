import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkGroup,
  NetworkGroupsListNextOptionalParams,
  NetworkGroupsListOptionalParams,
  NetworkGroupsGetOptionalParams,
  NetworkGroupsGetResponse,
  NetworkGroupsCreateOrUpdateOptionalParams,
  NetworkGroupsCreateOrUpdateResponse,
  NetworkGroupsDeleteOptionalParams,
  NetworkGroupsListResponse,
  NetworkGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkGroups operations. */
export class NetworkGroupsImpl implements NetworkGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists the specified network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkGroupsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkGroup> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkManagerName,
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
          networkManagerName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkGroupsListOptionalParams
  ): AsyncIterableIterator<NetworkGroup[]> {
    let result = await this._list(
      resourceGroupName,
      networkManagerName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkManagerName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkGroupsListOptionalParams
  ): AsyncIterableIterator<NetworkGroup> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkManagerName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets the specified network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsGetOptionalParams
  ): Promise<NetworkGroupsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, networkGroupName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param parameters Parameters supplied to the specify which network group need to create
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    parameters: NetworkGroup,
    options?: NetworkGroupsCreateOrUpdateOptionalParams
  ): Promise<NetworkGroupsCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        networkGroupName,
        parameters,
        options
      },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Deletes a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsDeleteOptionalParams
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
      { resourceGroupName, networkManagerName, networkGroupName, options },
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
   * Deletes a network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: NetworkGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkManagerName,
      networkGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists the specified network group.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: NetworkGroupsListOptionalParams
  ): Promise<NetworkGroupsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkManagerName: string,
    nextLink: string,
    options?: NetworkGroupsListNextOptionalParams
  ): Promise<NetworkGroupsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkGroup
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
    Parameters.networkManagerName,
    Parameters.networkGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkGroup,
      headersMapper: Mappers.NetworkGroupsCreateOrUpdateHeaders
    },
    201: {
      bodyMapper: Mappers.NetworkGroup,
      headersMapper: Mappers.NetworkGroupsCreateOrUpdateHeaders
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters34,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.networkGroupName
  ],
  headerParameters: [
    Parameters.accept,
    Parameters.contentType,
    Parameters.ifMatch
  ],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}",
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
  queryParameters: [Parameters.apiVersion, Parameters.force],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.networkGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/networkGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkGroupListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkGroupListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
