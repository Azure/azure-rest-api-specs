import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AzureFirewalls } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  AzureFirewall,
  AzureFirewallsListNextOptionalParams,
  AzureFirewallsListOptionalParams,
  AzureFirewallsListAllNextOptionalParams,
  AzureFirewallsListAllOptionalParams,
  AzureFirewallsDeleteOptionalParams,
  AzureFirewallsGetOptionalParams,
  AzureFirewallsGetResponse,
  AzureFirewallsCreateOrUpdateOptionalParams,
  AzureFirewallsCreateOrUpdateResponse,
  TagsObject,
  AzureFirewallsUpdateTagsOptionalParams,
  AzureFirewallsUpdateTagsResponse,
  AzureFirewallsListResponse,
  AzureFirewallsListAllResponse,
  AzureFirewallsListLearnedPrefixesOptionalParams,
  AzureFirewallsListLearnedPrefixesResponse,
  AzureFirewallsListNextResponse,
  AzureFirewallsListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AzureFirewalls operations. */
export class AzureFirewallsImpl implements AzureFirewalls {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AzureFirewalls class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all Azure Firewalls in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: AzureFirewallsListOptionalParams
  ): PagedAsyncIterableIterator<AzureFirewall> {
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
    options?: AzureFirewallsListOptionalParams
  ): AsyncIterableIterator<AzureFirewall[]> {
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
    options?: AzureFirewallsListOptionalParams
  ): AsyncIterableIterator<AzureFirewall> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all the Azure Firewalls in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: AzureFirewallsListAllOptionalParams
  ): PagedAsyncIterableIterator<AzureFirewall> {
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
    options?: AzureFirewallsListAllOptionalParams
  ): AsyncIterableIterator<AzureFirewall[]> {
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
    options?: AzureFirewallsListAllOptionalParams
  ): AsyncIterableIterator<AzureFirewall> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified Azure Firewall.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    azureFirewallName: string,
    options?: AzureFirewallsDeleteOptionalParams
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
      { resourceGroupName, azureFirewallName, options },
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
   * Deletes the specified Azure Firewall.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    azureFirewallName: string,
    options?: AzureFirewallsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      azureFirewallName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Azure Firewall.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    azureFirewallName: string,
    options?: AzureFirewallsGetOptionalParams
  ): Promise<AzureFirewallsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, azureFirewallName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified Azure Firewall.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param parameters Parameters supplied to the create or update Azure Firewall operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    azureFirewallName: string,
    parameters: AzureFirewall,
    options?: AzureFirewallsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<AzureFirewallsCreateOrUpdateResponse>,
      AzureFirewallsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<AzureFirewallsCreateOrUpdateResponse> => {
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
      { resourceGroupName, azureFirewallName, parameters, options },
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
   * Creates or updates the specified Azure Firewall.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param parameters Parameters supplied to the create or update Azure Firewall operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    azureFirewallName: string,
    parameters: AzureFirewall,
    options?: AzureFirewallsCreateOrUpdateOptionalParams
  ): Promise<AzureFirewallsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      azureFirewallName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates tags of an Azure Firewall resource.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param parameters Parameters supplied to update azure firewall tags.
   * @param options The options parameters.
   */
  async beginUpdateTags(
    resourceGroupName: string,
    azureFirewallName: string,
    parameters: TagsObject,
    options?: AzureFirewallsUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<AzureFirewallsUpdateTagsResponse>,
      AzureFirewallsUpdateTagsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<AzureFirewallsUpdateTagsResponse> => {
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
      { resourceGroupName, azureFirewallName, parameters, options },
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
   * Updates tags of an Azure Firewall resource.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the Azure Firewall.
   * @param parameters Parameters supplied to update azure firewall tags.
   * @param options The options parameters.
   */
  async beginUpdateTagsAndWait(
    resourceGroupName: string,
    azureFirewallName: string,
    parameters: TagsObject,
    options?: AzureFirewallsUpdateTagsOptionalParams
  ): Promise<AzureFirewallsUpdateTagsResponse> {
    const poller = await this.beginUpdateTags(
      resourceGroupName,
      azureFirewallName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all Azure Firewalls in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: AzureFirewallsListOptionalParams
  ): Promise<AzureFirewallsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all the Azure Firewalls in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: AzureFirewallsListAllOptionalParams
  ): Promise<AzureFirewallsListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Retrieves a list of all IP prefixes that azure firewall has learned to not SNAT.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the azure firewall.
   * @param options The options parameters.
   */
  async beginListLearnedPrefixes(
    resourceGroupName: string,
    azureFirewallName: string,
    options?: AzureFirewallsListLearnedPrefixesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<AzureFirewallsListLearnedPrefixesResponse>,
      AzureFirewallsListLearnedPrefixesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<AzureFirewallsListLearnedPrefixesResponse> => {
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
      { resourceGroupName, azureFirewallName, options },
      listLearnedPrefixesOperationSpec
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
   * Retrieves a list of all IP prefixes that azure firewall has learned to not SNAT.
   * @param resourceGroupName The name of the resource group.
   * @param azureFirewallName The name of the azure firewall.
   * @param options The options parameters.
   */
  async beginListLearnedPrefixesAndWait(
    resourceGroupName: string,
    azureFirewallName: string,
    options?: AzureFirewallsListLearnedPrefixesOptionalParams
  ): Promise<AzureFirewallsListLearnedPrefixesResponse> {
    const poller = await this.beginListLearnedPrefixes(
      resourceGroupName,
      azureFirewallName,
      options
    );
    return poller.pollUntilDone();
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
    options?: AzureFirewallsListNextOptionalParams
  ): Promise<AzureFirewallsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: AzureFirewallsListAllNextOptionalParams
  ): Promise<AzureFirewallsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls/{azureFirewallName}",
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
    Parameters.azureFirewallName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls/{azureFirewallName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewall
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
    Parameters.azureFirewallName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls/{azureFirewallName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewall
    },
    201: {
      bodyMapper: Mappers.AzureFirewall
    },
    202: {
      bodyMapper: Mappers.AzureFirewall
    },
    204: {
      bodyMapper: Mappers.AzureFirewall
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters4,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.azureFirewallName1
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls/{azureFirewallName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewall
    },
    201: {
      bodyMapper: Mappers.AzureFirewall
    },
    202: {
      bodyMapper: Mappers.AzureFirewall
    },
    204: {
      bodyMapper: Mappers.AzureFirewall
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
    Parameters.azureFirewallName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallListResult
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
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/azureFirewalls",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallListResult
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
const listLearnedPrefixesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/azureFirewalls/{azureFirewallName}/learnedIPPrefixes",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.IPPrefixesList
    },
    201: {
      bodyMapper: Mappers.IPPrefixesList
    },
    202: {
      bodyMapper: Mappers.IPPrefixesList
    },
    204: {
      bodyMapper: Mappers.IPPrefixesList
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
    Parameters.azureFirewallName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallListResult
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
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallListResult
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
