import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualWans } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualWAN,
  VirtualWansListByResourceGroupNextOptionalParams,
  VirtualWansListByResourceGroupOptionalParams,
  VirtualWansListNextOptionalParams,
  VirtualWansListOptionalParams,
  VirtualWansGetOptionalParams,
  VirtualWansGetResponse,
  VirtualWansCreateOrUpdateOptionalParams,
  VirtualWansCreateOrUpdateResponse,
  TagsObject,
  VirtualWansUpdateTagsOptionalParams,
  VirtualWansUpdateTagsResponse,
  VirtualWansDeleteOptionalParams,
  VirtualWansListByResourceGroupResponse,
  VirtualWansListResponse,
  VirtualWansListByResourceGroupNextResponse,
  VirtualWansListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualWans operations. */
export class VirtualWansImpl implements VirtualWans {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualWans class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all the VirtualWANs in a resource group.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualWansListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VirtualWAN> {
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
    options?: VirtualWansListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VirtualWAN[]> {
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
    options?: VirtualWansListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VirtualWAN> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Lists all the VirtualWANs in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: VirtualWansListOptionalParams
  ): PagedAsyncIterableIterator<VirtualWAN> {
    const iter = this.listPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(options);
      }
    };
  }

  private async *listPagingPage(
    options?: VirtualWansListOptionalParams
  ): AsyncIterableIterator<VirtualWAN[]> {
    let result = await this._list(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    options?: VirtualWansListOptionalParams
  ): AsyncIterableIterator<VirtualWAN> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansGetOptionalParams
  ): Promise<VirtualWansGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualWANName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being created or updated.
   * @param wANParameters Parameters supplied to create or update VirtualWAN.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: VirtualWAN,
    options?: VirtualWansCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualWansCreateOrUpdateResponse>,
      VirtualWansCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualWansCreateOrUpdateResponse> => {
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
      { resourceGroupName, virtualWANName, wANParameters, options },
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
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being created or updated.
   * @param wANParameters Parameters supplied to create or update VirtualWAN.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: VirtualWAN,
    options?: VirtualWansCreateOrUpdateOptionalParams
  ): Promise<VirtualWansCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualWANName,
      wANParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a VirtualWAN tags.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being updated.
   * @param wANParameters Parameters supplied to Update VirtualWAN tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    virtualWANName: string,
    wANParameters: TagsObject,
    options?: VirtualWansUpdateTagsOptionalParams
  ): Promise<VirtualWansUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualWANName, wANParameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Deletes a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being deleted.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansDeleteOptionalParams
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
      { resourceGroupName, virtualWANName, options },
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
   * Deletes a VirtualWAN.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param virtualWANName The name of the VirtualWAN being deleted.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VirtualWansDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualWANName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all the VirtualWANs in a resource group.
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: VirtualWansListByResourceGroupOptionalParams
  ): Promise<VirtualWansListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Lists all the VirtualWANs in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: VirtualWansListOptionalParams
  ): Promise<VirtualWansListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The resource group name of the VirtualWan.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    nextLink: string,
    options?: VirtualWansListByResourceGroupNextOptionalParams
  ): Promise<VirtualWansListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: VirtualWansListNextOptionalParams
  ): Promise<VirtualWansListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{VirtualWANName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualWAN
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
    Parameters.virtualWANName1
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{VirtualWANName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualWAN
    },
    201: {
      bodyMapper: Mappers.VirtualWAN
    },
    202: {
      bodyMapper: Mappers.VirtualWAN
    },
    204: {
      bodyMapper: Mappers.VirtualWAN
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.wANParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualWANName1
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{VirtualWANName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualWAN
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.wANParameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualWANName1
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{VirtualWANName}",
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
    Parameters.virtualWANName1
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualWANsResult
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
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualWans",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualWANsResult
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
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualWANsResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualWANsResult
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
