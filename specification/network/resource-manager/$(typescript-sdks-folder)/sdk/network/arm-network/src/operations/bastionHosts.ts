import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { BastionHosts } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  BastionHost,
  BastionHostsListNextOptionalParams,
  BastionHostsListOptionalParams,
  BastionHostsListByResourceGroupNextOptionalParams,
  BastionHostsListByResourceGroupOptionalParams,
  BastionHostsDeleteOptionalParams,
  BastionHostsGetOptionalParams,
  BastionHostsGetResponse,
  BastionHostsCreateOrUpdateOptionalParams,
  BastionHostsCreateOrUpdateResponse,
  TagsObject,
  BastionHostsUpdateTagsOptionalParams,
  BastionHostsUpdateTagsResponse,
  BastionHostsListResponse,
  BastionHostsListByResourceGroupResponse,
  BastionHostsListNextResponse,
  BastionHostsListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing BastionHosts operations. */
export class BastionHostsImpl implements BastionHosts {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class BastionHosts class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all Bastion Hosts in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: BastionHostsListOptionalParams
  ): PagedAsyncIterableIterator<BastionHost> {
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
    options?: BastionHostsListOptionalParams
  ): AsyncIterableIterator<BastionHost[]> {
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
    options?: BastionHostsListOptionalParams
  ): AsyncIterableIterator<BastionHost> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Lists all Bastion Hosts in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: BastionHostsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<BastionHost> {
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
    options?: BastionHostsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<BastionHost[]> {
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
    options?: BastionHostsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<BastionHost> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsDeleteOptionalParams
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
      { resourceGroupName, bastionHostName, options },
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
   * Deletes the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      bastionHostName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    bastionHostName: string,
    options?: BastionHostsGetOptionalParams
  ): Promise<BastionHostsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, bastionHostName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to the create or update Bastion Host operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: BastionHost,
    options?: BastionHostsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<BastionHostsCreateOrUpdateResponse>,
      BastionHostsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<BastionHostsCreateOrUpdateResponse> => {
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
      { resourceGroupName, bastionHostName, parameters, options },
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
   * Creates or updates the specified Bastion Host.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to the create or update Bastion Host operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: BastionHost,
    options?: BastionHostsCreateOrUpdateOptionalParams
  ): Promise<BastionHostsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      bastionHostName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates Tags for BastionHost resource
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to update BastionHost tags.
   * @param options The options parameters.
   */
  async beginUpdateTags(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: TagsObject,
    options?: BastionHostsUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<BastionHostsUpdateTagsResponse>,
      BastionHostsUpdateTagsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<BastionHostsUpdateTagsResponse> => {
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
      { resourceGroupName, bastionHostName, parameters, options },
      updateTagsOperationSpec
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
   * Updates Tags for BastionHost resource
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param parameters Parameters supplied to update BastionHost tags.
   * @param options The options parameters.
   */
  async beginUpdateTagsAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    parameters: TagsObject,
    options?: BastionHostsUpdateTagsOptionalParams
  ): Promise<BastionHostsUpdateTagsResponse> {
    const poller = await this.beginUpdateTags(
      resourceGroupName,
      bastionHostName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all Bastion Hosts in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: BastionHostsListOptionalParams
  ): Promise<BastionHostsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Lists all Bastion Hosts in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: BastionHostsListByResourceGroupOptionalParams
  ): Promise<BastionHostsListByResourceGroupResponse> {
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
    options?: BastionHostsListNextOptionalParams
  ): Promise<BastionHostsListNextResponse> {
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
    options?: BastionHostsListByResourceGroupNextOptionalParams
  ): Promise<BastionHostsListByResourceGroupNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}",
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
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionHost
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
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.BastionHost
    },
    201: {
      bodyMapper: Mappers.BastionHost
    },
    202: {
      bodyMapper: Mappers.BastionHost
    },
    204: {
      bodyMapper: Mappers.BastionHost
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters5,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.BastionHost
    },
    201: {
      bodyMapper: Mappers.BastionHost
    },
    202: {
      bodyMapper: Mappers.BastionHost
    },
    204: {
      bodyMapper: Mappers.BastionHost
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
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/bastionHosts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionHostListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionHostListResult
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
      bodyMapper: Mappers.BastionHostListResult
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
      bodyMapper: Mappers.BastionHostListResult
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
