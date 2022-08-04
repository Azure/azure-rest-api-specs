import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { SecurityPartnerProviders } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  SecurityPartnerProvider,
  SecurityPartnerProvidersListByResourceGroupNextOptionalParams,
  SecurityPartnerProvidersListByResourceGroupOptionalParams,
  SecurityPartnerProvidersListNextOptionalParams,
  SecurityPartnerProvidersListOptionalParams,
  SecurityPartnerProvidersDeleteOptionalParams,
  SecurityPartnerProvidersGetOptionalParams,
  SecurityPartnerProvidersGetResponse,
  SecurityPartnerProvidersCreateOrUpdateOptionalParams,
  SecurityPartnerProvidersCreateOrUpdateResponse,
  TagsObject,
  SecurityPartnerProvidersUpdateTagsOptionalParams,
  SecurityPartnerProvidersUpdateTagsResponse,
  SecurityPartnerProvidersListByResourceGroupResponse,
  SecurityPartnerProvidersListResponse,
  SecurityPartnerProvidersListByResourceGroupNextResponse,
  SecurityPartnerProvidersListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing SecurityPartnerProviders operations. */
export class SecurityPartnerProvidersImpl implements SecurityPartnerProviders {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class SecurityPartnerProviders class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all Security Partner Providers in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: SecurityPartnerProvidersListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<SecurityPartnerProvider> {
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
    options?: SecurityPartnerProvidersListByResourceGroupOptionalParams
  ): AsyncIterableIterator<SecurityPartnerProvider[]> {
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
    options?: SecurityPartnerProvidersListByResourceGroupOptionalParams
  ): AsyncIterableIterator<SecurityPartnerProvider> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all the Security Partner Providers in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: SecurityPartnerProvidersListOptionalParams
  ): PagedAsyncIterableIterator<SecurityPartnerProvider> {
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
    options?: SecurityPartnerProvidersListOptionalParams
  ): AsyncIterableIterator<SecurityPartnerProvider[]> {
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
    options?: SecurityPartnerProvidersListOptionalParams
  ): AsyncIterableIterator<SecurityPartnerProvider> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified Security Partner Provider.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    options?: SecurityPartnerProvidersDeleteOptionalParams
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
      { resourceGroupName, securityPartnerProviderName, options },
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
   * Deletes the specified Security Partner Provider.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    options?: SecurityPartnerProvidersDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      securityPartnerProviderName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Security Partner Provider.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    options?: SecurityPartnerProvidersGetOptionalParams
  ): Promise<SecurityPartnerProvidersGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, securityPartnerProviderName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified Security Partner Provider.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param parameters Parameters supplied to the create or update Security Partner Provider operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    parameters: SecurityPartnerProvider,
    options?: SecurityPartnerProvidersCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<SecurityPartnerProvidersCreateOrUpdateResponse>,
      SecurityPartnerProvidersCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<SecurityPartnerProvidersCreateOrUpdateResponse> => {
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
      { resourceGroupName, securityPartnerProviderName, parameters, options },
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
   * Creates or updates the specified Security Partner Provider.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param parameters Parameters supplied to the create or update Security Partner Provider operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    parameters: SecurityPartnerProvider,
    options?: SecurityPartnerProvidersCreateOrUpdateOptionalParams
  ): Promise<SecurityPartnerProvidersCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      securityPartnerProviderName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates tags of a Security Partner Provider resource.
   * @param resourceGroupName The name of the resource group.
   * @param securityPartnerProviderName The name of the Security Partner Provider.
   * @param parameters Parameters supplied to update Security Partner Provider tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    securityPartnerProviderName: string,
    parameters: TagsObject,
    options?: SecurityPartnerProvidersUpdateTagsOptionalParams
  ): Promise<SecurityPartnerProvidersUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, securityPartnerProviderName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Lists all Security Partner Providers in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: SecurityPartnerProvidersListByResourceGroupOptionalParams
  ): Promise<SecurityPartnerProvidersListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Gets all the Security Partner Providers in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: SecurityPartnerProvidersListOptionalParams
  ): Promise<SecurityPartnerProvidersListResponse> {
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
    options?: SecurityPartnerProvidersListByResourceGroupNextOptionalParams
  ): Promise<SecurityPartnerProvidersListByResourceGroupNextResponse> {
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
    options?: SecurityPartnerProvidersListNextOptionalParams
  ): Promise<SecurityPartnerProvidersListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}",
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
    Parameters.securityPartnerProviderName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityPartnerProvider
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
    Parameters.securityPartnerProviderName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityPartnerProvider
    },
    201: {
      bodyMapper: Mappers.SecurityPartnerProvider
    },
    202: {
      bodyMapper: Mappers.SecurityPartnerProvider
    },
    204: {
      bodyMapper: Mappers.SecurityPartnerProvider
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters65,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.securityPartnerProviderName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityPartnerProvider
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
    Parameters.securityPartnerProviderName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/securityPartnerProviders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityPartnerProviderListResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/securityPartnerProviders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityPartnerProviderListResult
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
      bodyMapper: Mappers.SecurityPartnerProviderListResult
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
      bodyMapper: Mappers.SecurityPartnerProviderListResult
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
