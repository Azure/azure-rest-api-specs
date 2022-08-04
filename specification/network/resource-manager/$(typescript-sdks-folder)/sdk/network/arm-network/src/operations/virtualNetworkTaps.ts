import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworkTaps } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetworkTap,
  VirtualNetworkTapsListAllNextOptionalParams,
  VirtualNetworkTapsListAllOptionalParams,
  VirtualNetworkTapsListByResourceGroupNextOptionalParams,
  VirtualNetworkTapsListByResourceGroupOptionalParams,
  VirtualNetworkTapsDeleteOptionalParams,
  VirtualNetworkTapsGetOptionalParams,
  VirtualNetworkTapsGetResponse,
  VirtualNetworkTapsCreateOrUpdateOptionalParams,
  VirtualNetworkTapsCreateOrUpdateResponse,
  TagsObject,
  VirtualNetworkTapsUpdateTagsOptionalParams,
  VirtualNetworkTapsUpdateTagsResponse,
  VirtualNetworkTapsListAllResponse,
  VirtualNetworkTapsListByResourceGroupResponse,
  VirtualNetworkTapsListAllNextResponse,
  VirtualNetworkTapsListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworkTaps operations. */
export class VirtualNetworkTapsImpl implements VirtualNetworkTaps {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworkTaps class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: VirtualNetworkTapsListAllOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkTap> {
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
    options?: VirtualNetworkTapsListAllOptionalParams
  ): AsyncIterableIterator<VirtualNetworkTap[]> {
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
    options?: VirtualNetworkTapsListAllOptionalParams
  ): AsyncIterableIterator<VirtualNetworkTap> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualNetworkTapsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkTap> {
    const iter = this.listByResourceGroupPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listByResourceGroupPagingPage(resourceGroupName, options);
      }
    };
  }

  private async *listByResourceGroupPagingPage(
    resourceGroupName: string,
    options?: VirtualNetworkTapsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VirtualNetworkTap[]> {
    let result = await this._listByResourceGroup(resourceGroupName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByResourceGroupPagingAll(
    resourceGroupName: string,
    options?: VirtualNetworkTapsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VirtualNetworkTap> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified virtual network tap.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of the virtual network tap.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    tapName: string,
    options?: VirtualNetworkTapsDeleteOptionalParams
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
      { resourceGroupName, tapName, options },
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
   * Deletes the specified virtual network tap.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of the virtual network tap.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    tapName: string,
    options?: VirtualNetworkTapsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(resourceGroupName, tapName, options);
    return poller.pollUntilDone();
  }

  /**
   * Gets information about the specified virtual network tap.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of virtual network tap.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    tapName: string,
    options?: VirtualNetworkTapsGetOptionalParams
  ): Promise<VirtualNetworkTapsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, tapName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a Virtual Network Tap.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of the virtual network tap.
   * @param parameters Parameters supplied to the create or update virtual network tap operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    tapName: string,
    parameters: VirtualNetworkTap,
    options?: VirtualNetworkTapsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkTapsCreateOrUpdateResponse>,
      VirtualNetworkTapsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkTapsCreateOrUpdateResponse> => {
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
      { resourceGroupName, tapName, parameters, options },
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
   * Creates or updates a Virtual Network Tap.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of the virtual network tap.
   * @param parameters Parameters supplied to the create or update virtual network tap operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    tapName: string,
    parameters: VirtualNetworkTap,
    options?: VirtualNetworkTapsCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkTapsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      tapName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates an VirtualNetworkTap tags.
   * @param resourceGroupName The name of the resource group.
   * @param tapName The name of the tap.
   * @param tapParameters Parameters supplied to update VirtualNetworkTap tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    tapName: string,
    tapParameters: TagsObject,
    options?: VirtualNetworkTapsUpdateTagsOptionalParams
  ): Promise<VirtualNetworkTapsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, tapName, tapParameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: VirtualNetworkTapsListAllOptionalParams
  ): Promise<VirtualNetworkTapsListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all the VirtualNetworkTaps in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualNetworkTapsListByResourceGroupOptionalParams
  ): Promise<VirtualNetworkTapsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: VirtualNetworkTapsListAllNextOptionalParams
  ): Promise<VirtualNetworkTapsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    nextLink: string,
    options?: VirtualNetworkTapsListByResourceGroupNextOptionalParams
  ): Promise<VirtualNetworkTapsListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkTaps/{tapName}",
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
    Parameters.tapName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkTaps/{tapName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTap
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
    Parameters.tapName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkTaps/{tapName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTap
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkTap
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkTap
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkTap
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters77,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.tapName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkTaps/{tapName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTap
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.tapParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.tapName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworkTaps",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTapListResult
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
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkTaps",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTapListResult
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
      bodyMapper: Mappers.VirtualNetworkTapListResult
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
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkTapListResult
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
