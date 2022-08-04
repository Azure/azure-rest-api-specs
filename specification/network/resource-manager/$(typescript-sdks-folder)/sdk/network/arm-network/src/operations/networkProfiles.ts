import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkProfiles } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkProfile,
  NetworkProfilesListAllNextOptionalParams,
  NetworkProfilesListAllOptionalParams,
  NetworkProfilesListNextOptionalParams,
  NetworkProfilesListOptionalParams,
  NetworkProfilesDeleteOptionalParams,
  NetworkProfilesGetOptionalParams,
  NetworkProfilesGetResponse,
  NetworkProfilesCreateOrUpdateOptionalParams,
  NetworkProfilesCreateOrUpdateResponse,
  TagsObject,
  NetworkProfilesUpdateTagsOptionalParams,
  NetworkProfilesUpdateTagsResponse,
  NetworkProfilesListAllResponse,
  NetworkProfilesListResponse,
  NetworkProfilesListAllNextResponse,
  NetworkProfilesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkProfiles operations. */
export class NetworkProfilesImpl implements NetworkProfiles {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkProfiles class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the network profiles in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: NetworkProfilesListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkProfile> {
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
    options?: NetworkProfilesListAllOptionalParams
  ): AsyncIterableIterator<NetworkProfile[]> {
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
    options?: NetworkProfilesListAllOptionalParams
  ): AsyncIterableIterator<NetworkProfile> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all network profiles in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: NetworkProfilesListOptionalParams
  ): PagedAsyncIterableIterator<NetworkProfile> {
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
    options?: NetworkProfilesListOptionalParams
  ): AsyncIterableIterator<NetworkProfile[]> {
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
    options?: NetworkProfilesListOptionalParams
  ): AsyncIterableIterator<NetworkProfile> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the NetworkProfile.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesDeleteOptionalParams
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
      { resourceGroupName, networkProfileName, options },
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
   * Deletes the specified network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the NetworkProfile.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkProfileName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified network profile in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the public IP prefix.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkProfileName: string,
    options?: NetworkProfilesGetOptionalParams
  ): Promise<NetworkProfilesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkProfileName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a network profile.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the network profile.
   * @param parameters Parameters supplied to the create or update network profile operation.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkProfileName: string,
    parameters: NetworkProfile,
    options?: NetworkProfilesCreateOrUpdateOptionalParams
  ): Promise<NetworkProfilesCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkProfileName, parameters, options },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Updates network profile tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkProfileName The name of the network profile.
   * @param parameters Parameters supplied to update network profile tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkProfileName: string,
    parameters: TagsObject,
    options?: NetworkProfilesUpdateTagsOptionalParams
  ): Promise<NetworkProfilesUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkProfileName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all the network profiles in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: NetworkProfilesListAllOptionalParams
  ): Promise<NetworkProfilesListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all network profiles in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: NetworkProfilesListOptionalParams
  ): Promise<NetworkProfilesListResponse> {
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
    options?: NetworkProfilesListAllNextOptionalParams
  ): Promise<NetworkProfilesListAllNextResponse> {
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
    options?: NetworkProfilesListNextOptionalParams
  ): Promise<NetworkProfilesListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkProfiles/{networkProfileName}",
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
    Parameters.networkProfileName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkProfiles/{networkProfileName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkProfile
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
    Parameters.networkProfileName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkProfiles/{networkProfileName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkProfile
    },
    201: {
      bodyMapper: Mappers.NetworkProfile
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters37,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkProfileName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkProfiles/{networkProfileName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkProfile
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
    Parameters.networkProfileName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkProfiles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkProfileListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkProfiles",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkProfileListResult
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
      bodyMapper: Mappers.NetworkProfileListResult
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
      bodyMapper: Mappers.NetworkProfileListResult
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
