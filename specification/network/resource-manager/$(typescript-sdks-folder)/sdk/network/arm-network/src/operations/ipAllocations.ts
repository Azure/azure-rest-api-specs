import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { IpAllocations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  IpAllocation,
  IpAllocationsListNextOptionalParams,
  IpAllocationsListOptionalParams,
  IpAllocationsListByResourceGroupNextOptionalParams,
  IpAllocationsListByResourceGroupOptionalParams,
  IpAllocationsDeleteOptionalParams,
  IpAllocationsGetOptionalParams,
  IpAllocationsGetResponse,
  IpAllocationsCreateOrUpdateOptionalParams,
  IpAllocationsCreateOrUpdateResponse,
  TagsObject,
  IpAllocationsUpdateTagsOptionalParams,
  IpAllocationsUpdateTagsResponse,
  IpAllocationsListResponse,
  IpAllocationsListByResourceGroupResponse,
  IpAllocationsListNextResponse,
  IpAllocationsListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing IpAllocations operations. */
export class IpAllocationsImpl implements IpAllocations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class IpAllocations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all IpAllocations in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: IpAllocationsListOptionalParams
  ): PagedAsyncIterableIterator<IpAllocation> {
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
    options?: IpAllocationsListOptionalParams
  ): AsyncIterableIterator<IpAllocation[]> {
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
    options?: IpAllocationsListOptionalParams
  ): AsyncIterableIterator<IpAllocation> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all IpAllocations in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: IpAllocationsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<IpAllocation> {
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
    options?: IpAllocationsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<IpAllocation[]> {
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
    options?: IpAllocationsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<IpAllocation> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified IpAllocation.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsDeleteOptionalParams
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
      { resourceGroupName, ipAllocationName, options },
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
   * Deletes the specified IpAllocation.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      ipAllocationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified IpAllocation by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ipAllocationName: string,
    options?: IpAllocationsGetOptionalParams
  ): Promise<IpAllocationsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ipAllocationName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an IpAllocation in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: IpAllocation,
    options?: IpAllocationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<IpAllocationsCreateOrUpdateResponse>,
      IpAllocationsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<IpAllocationsCreateOrUpdateResponse> => {
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
      { resourceGroupName, ipAllocationName, parameters, options },
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
   * Creates or updates an IpAllocation in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: IpAllocation,
    options?: IpAllocationsCreateOrUpdateOptionalParams
  ): Promise<IpAllocationsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      ipAllocationName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a IpAllocation tags.
   * @param resourceGroupName The name of the resource group.
   * @param ipAllocationName The name of the IpAllocation.
   * @param parameters Parameters supplied to update IpAllocation tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ipAllocationName: string,
    parameters: TagsObject,
    options?: IpAllocationsUpdateTagsOptionalParams
  ): Promise<IpAllocationsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ipAllocationName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all IpAllocations in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: IpAllocationsListOptionalParams
  ): Promise<IpAllocationsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Gets all IpAllocations in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: IpAllocationsListByResourceGroupOptionalParams
  ): Promise<IpAllocationsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: IpAllocationsListNextOptionalParams
  ): Promise<IpAllocationsListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
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
    options?: IpAllocationsListByResourceGroupNextOptionalParams
  ): Promise<IpAllocationsListByResourceGroupNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/IpAllocations/{ipAllocationName}",
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
    Parameters.ipAllocationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/IpAllocations/{ipAllocationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpAllocation
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
    Parameters.ipAllocationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/IpAllocations/{ipAllocationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.IpAllocation
    },
    201: {
      bodyMapper: Mappers.IpAllocation
    },
    202: {
      bodyMapper: Mappers.IpAllocation
    },
    204: {
      bodyMapper: Mappers.IpAllocation
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters22,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ipAllocationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/IpAllocations/{ipAllocationName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.IpAllocation
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
    Parameters.ipAllocationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/IpAllocations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpAllocationListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/IpAllocations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpAllocationListResult
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
      bodyMapper: Mappers.IpAllocationListResult
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
      bodyMapper: Mappers.IpAllocationListResult
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
