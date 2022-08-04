import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkSecurityGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkSecurityGroup,
  NetworkSecurityGroupsListAllNextOptionalParams,
  NetworkSecurityGroupsListAllOptionalParams,
  NetworkSecurityGroupsListNextOptionalParams,
  NetworkSecurityGroupsListOptionalParams,
  NetworkSecurityGroupsDeleteOptionalParams,
  NetworkSecurityGroupsGetOptionalParams,
  NetworkSecurityGroupsGetResponse,
  NetworkSecurityGroupsCreateOrUpdateOptionalParams,
  NetworkSecurityGroupsCreateOrUpdateResponse,
  TagsObject,
  NetworkSecurityGroupsUpdateTagsOptionalParams,
  NetworkSecurityGroupsUpdateTagsResponse,
  NetworkSecurityGroupsListAllResponse,
  NetworkSecurityGroupsListResponse,
  NetworkSecurityGroupsListAllNextResponse,
  NetworkSecurityGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkSecurityGroups operations. */
export class NetworkSecurityGroupsImpl implements NetworkSecurityGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkSecurityGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all network security groups in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: NetworkSecurityGroupsListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkSecurityGroup> {
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
    options?: NetworkSecurityGroupsListAllOptionalParams
  ): AsyncIterableIterator<NetworkSecurityGroup[]> {
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
    options?: NetworkSecurityGroupsListAllOptionalParams
  ): AsyncIterableIterator<NetworkSecurityGroup> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all network security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: NetworkSecurityGroupsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkSecurityGroup> {
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
    options?: NetworkSecurityGroupsListOptionalParams
  ): AsyncIterableIterator<NetworkSecurityGroup[]> {
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
    options?: NetworkSecurityGroupsListOptionalParams
  ): AsyncIterableIterator<NetworkSecurityGroup> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsDeleteOptionalParams
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
      { resourceGroupName, networkSecurityGroupName, options },
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
   * Deletes the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkSecurityGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: NetworkSecurityGroupsGetOptionalParams
  ): Promise<NetworkSecurityGroupsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a network security group in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to the create or update network security group operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: NetworkSecurityGroup,
    options?: NetworkSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkSecurityGroupsCreateOrUpdateResponse>,
      NetworkSecurityGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkSecurityGroupsCreateOrUpdateResponse> => {
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
      { resourceGroupName, networkSecurityGroupName, parameters, options },
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
   * Creates or updates a network security group in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to the create or update network security group operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: NetworkSecurityGroup,
    options?: NetworkSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<NetworkSecurityGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkSecurityGroupName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a network security group tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param parameters Parameters supplied to update network security group tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    parameters: TagsObject,
    options?: NetworkSecurityGroupsUpdateTagsOptionalParams
  ): Promise<NetworkSecurityGroupsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all network security groups in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: NetworkSecurityGroupsListAllOptionalParams
  ): Promise<NetworkSecurityGroupsListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all network security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: NetworkSecurityGroupsListOptionalParams
  ): Promise<NetworkSecurityGroupsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: NetworkSecurityGroupsListAllNextOptionalParams
  ): Promise<NetworkSecurityGroupsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
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
    options?: NetworkSecurityGroupsListNextOptionalParams
  ): Promise<NetworkSecurityGroupsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}",
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
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroup
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
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroup
    },
    201: {
      bodyMapper: Mappers.NetworkSecurityGroup
    },
    202: {
      bodyMapper: Mappers.NetworkSecurityGroup
    },
    204: {
      bodyMapper: Mappers.NetworkSecurityGroup
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters38,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroup
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
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkSecurityGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroupListResult
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
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroupListResult
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
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroupListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkSecurityGroupListResult
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
