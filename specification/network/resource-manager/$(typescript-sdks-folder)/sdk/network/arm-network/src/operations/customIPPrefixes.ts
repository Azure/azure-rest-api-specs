import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { CustomIPPrefixes } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  CustomIpPrefix,
  CustomIPPrefixesListAllNextOptionalParams,
  CustomIPPrefixesListAllOptionalParams,
  CustomIPPrefixesListNextOptionalParams,
  CustomIPPrefixesListOptionalParams,
  CustomIPPrefixesDeleteOptionalParams,
  CustomIPPrefixesGetOptionalParams,
  CustomIPPrefixesGetResponse,
  CustomIPPrefixesCreateOrUpdateOptionalParams,
  CustomIPPrefixesCreateOrUpdateResponse,
  TagsObject,
  CustomIPPrefixesUpdateTagsOptionalParams,
  CustomIPPrefixesUpdateTagsResponse,
  CustomIPPrefixesListAllResponse,
  CustomIPPrefixesListResponse,
  CustomIPPrefixesListAllNextResponse,
  CustomIPPrefixesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing CustomIPPrefixes operations. */
export class CustomIPPrefixesImpl implements CustomIPPrefixes {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class CustomIPPrefixes class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the custom IP prefixes in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: CustomIPPrefixesListAllOptionalParams
  ): PagedAsyncIterableIterator<CustomIpPrefix> {
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
    options?: CustomIPPrefixesListAllOptionalParams
  ): AsyncIterableIterator<CustomIpPrefix[]> {
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
    options?: CustomIPPrefixesListAllOptionalParams
  ): AsyncIterableIterator<CustomIpPrefix> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all custom IP prefixes in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: CustomIPPrefixesListOptionalParams
  ): PagedAsyncIterableIterator<CustomIpPrefix> {
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
    options?: CustomIPPrefixesListOptionalParams
  ): AsyncIterableIterator<CustomIpPrefix[]> {
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
    options?: CustomIPPrefixesListOptionalParams
  ): AsyncIterableIterator<CustomIpPrefix> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the CustomIpPrefix.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesDeleteOptionalParams
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
      { resourceGroupName, customIpPrefixName, options },
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
   * Deletes the specified custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the CustomIpPrefix.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      customIpPrefixName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified custom IP prefix in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    customIpPrefixName: string,
    options?: CustomIPPrefixesGetOptionalParams
  ): Promise<CustomIPPrefixesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, customIpPrefixName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to the create or update custom IP prefix operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: CustomIpPrefix,
    options?: CustomIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<CustomIPPrefixesCreateOrUpdateResponse>,
      CustomIPPrefixesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<CustomIPPrefixesCreateOrUpdateResponse> => {
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
      { resourceGroupName, customIpPrefixName, parameters, options },
      createOrUpdateOperationSpec
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
   * Creates or updates a custom IP prefix.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to the create or update custom IP prefix operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: CustomIpPrefix,
    options?: CustomIPPrefixesCreateOrUpdateOptionalParams
  ): Promise<CustomIPPrefixesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      customIpPrefixName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates custom IP prefix tags.
   * @param resourceGroupName The name of the resource group.
   * @param customIpPrefixName The name of the custom IP prefix.
   * @param parameters Parameters supplied to update custom IP prefix tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    customIpPrefixName: string,
    parameters: TagsObject,
    options?: CustomIPPrefixesUpdateTagsOptionalParams
  ): Promise<CustomIPPrefixesUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, customIpPrefixName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all the custom IP prefixes in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: CustomIPPrefixesListAllOptionalParams
  ): Promise<CustomIPPrefixesListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all custom IP prefixes in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: CustomIPPrefixesListOptionalParams
  ): Promise<CustomIPPrefixesListResponse> {
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
    options?: CustomIPPrefixesListAllNextOptionalParams
  ): Promise<CustomIPPrefixesListAllNextResponse> {
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
    options?: CustomIPPrefixesListNextOptionalParams
  ): Promise<CustomIPPrefixesListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/customIpPrefixes/{customIpPrefixName}",
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
    Parameters.customIpPrefixName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/customIpPrefixes/{customIpPrefixName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.CustomIpPrefix
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
    Parameters.customIpPrefixName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/customIpPrefixes/{customIpPrefixName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.CustomIpPrefix
    },
    201: {
      bodyMapper: Mappers.CustomIpPrefix
    },
    202: {
      bodyMapper: Mappers.CustomIpPrefix
    },
    204: {
      bodyMapper: Mappers.CustomIpPrefix
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters10,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.customIpPrefixName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/customIpPrefixes/{customIpPrefixName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.CustomIpPrefix
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
    Parameters.customIpPrefixName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/customIpPrefixes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.CustomIpPrefixListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/customIpPrefixes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.CustomIpPrefixListResult
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
      bodyMapper: Mappers.CustomIpPrefixListResult
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
      bodyMapper: Mappers.CustomIpPrefixListResult
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
