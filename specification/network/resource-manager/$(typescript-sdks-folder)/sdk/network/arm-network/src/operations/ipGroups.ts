import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { IpGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  IpGroup,
  IpGroupsListByResourceGroupNextOptionalParams,
  IpGroupsListByResourceGroupOptionalParams,
  IpGroupsListNextOptionalParams,
  IpGroupsListOptionalParams,
  IpGroupsGetOptionalParams,
  IpGroupsGetResponse,
  IpGroupsCreateOrUpdateOptionalParams,
  IpGroupsCreateOrUpdateResponse,
  TagsObject,
  IpGroupsUpdateGroupsOptionalParams,
  IpGroupsUpdateGroupsResponse,
  IpGroupsDeleteOptionalParams,
  IpGroupsListByResourceGroupResponse,
  IpGroupsListResponse,
  IpGroupsListByResourceGroupNextResponse,
  IpGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing IpGroups operations. */
export class IpGroupsImpl implements IpGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class IpGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all IpGroups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: IpGroupsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<IpGroup> {
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
    options?: IpGroupsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<IpGroup[]> {
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
    options?: IpGroupsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<IpGroup> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all IpGroups in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: IpGroupsListOptionalParams
  ): PagedAsyncIterableIterator<IpGroup> {
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
    options?: IpGroupsListOptionalParams
  ): AsyncIterableIterator<IpGroup[]> {
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
    options?: IpGroupsListOptionalParams
  ): AsyncIterableIterator<IpGroup> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsGetOptionalParams
  ): Promise<IpGroupsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ipGroupsName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an ipGroups in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the create or update IpGroups operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: IpGroup,
    options?: IpGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<IpGroupsCreateOrUpdateResponse>,
      IpGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<IpGroupsCreateOrUpdateResponse> => {
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
      { resourceGroupName, ipGroupsName, parameters, options },
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
   * Creates or updates an ipGroups in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the create or update IpGroups operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: IpGroup,
    options?: IpGroupsCreateOrUpdateOptionalParams
  ): Promise<IpGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      ipGroupsName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates tags of an IpGroups resource.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param parameters Parameters supplied to the update ipGroups operation.
   * @param options The options parameters.
   */
  updateGroups(
    resourceGroupName: string,
    ipGroupsName: string,
    parameters: TagsObject,
    options?: IpGroupsUpdateGroupsOptionalParams
  ): Promise<IpGroupsUpdateGroupsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ipGroupsName, parameters, options },
      updateGroupsOperationSpec
    );
  }

  /**
   * Deletes the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsDeleteOptionalParams
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
      { resourceGroupName, ipGroupsName, options },
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
   * Deletes the specified ipGroups.
   * @param resourceGroupName The name of the resource group.
   * @param ipGroupsName The name of the ipGroups.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    ipGroupsName: string,
    options?: IpGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      ipGroupsName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all IpGroups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: IpGroupsListByResourceGroupOptionalParams
  ): Promise<IpGroupsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Gets all IpGroups in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: IpGroupsListOptionalParams
  ): Promise<IpGroupsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
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
    options?: IpGroupsListByResourceGroupNextOptionalParams
  ): Promise<IpGroupsListByResourceGroupNextResponse> {
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
    options?: IpGroupsListNextOptionalParams
  ): Promise<IpGroupsListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ipGroups/{ipGroupsName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpGroup
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ipGroupsName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ipGroups/{ipGroupsName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.IpGroup
    },
    201: {
      bodyMapper: Mappers.IpGroup
    },
    202: {
      bodyMapper: Mappers.IpGroup
    },
    204: {
      bodyMapper: Mappers.IpGroup
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters23,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ipGroupsName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateGroupsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ipGroups/{ipGroupsName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.IpGroup
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ipGroupsName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ipGroups/{ipGroupsName}",
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
    Parameters.ipGroupsName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ipGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpGroupListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
  path: "/subscriptions/{subscriptionId}/providers/Microsoft.Network/ipGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IpGroupListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
      bodyMapper: Mappers.IpGroupListResult
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
      bodyMapper: Mappers.IpGroupListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
