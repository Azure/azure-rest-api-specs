import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworks } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetwork,
  VirtualNetworksListAllNextOptionalParams,
  VirtualNetworksListAllOptionalParams,
  VirtualNetworksListNextOptionalParams,
  VirtualNetworksListOptionalParams,
  VirtualNetworkUsage,
  VirtualNetworksListUsageNextOptionalParams,
  VirtualNetworksListUsageOptionalParams,
  VirtualNetworksDeleteOptionalParams,
  VirtualNetworksGetOptionalParams,
  VirtualNetworksGetResponse,
  VirtualNetworksCreateOrUpdateOptionalParams,
  VirtualNetworksCreateOrUpdateResponse,
  TagsObject,
  VirtualNetworksUpdateTagsOptionalParams,
  VirtualNetworksUpdateTagsResponse,
  VirtualNetworksListAllResponse,
  VirtualNetworksListResponse,
  VirtualNetworksCheckIPAddressAvailabilityOptionalParams,
  VirtualNetworksCheckIPAddressAvailabilityResponse,
  VirtualNetworksListUsageResponse,
  VirtualNetworksListAllNextResponse,
  VirtualNetworksListNextResponse,
  VirtualNetworksListUsageNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworks operations. */
export class VirtualNetworksImpl implements VirtualNetworks {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworks class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all virtual networks in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: VirtualNetworksListAllOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetwork> {
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
    options?: VirtualNetworksListAllOptionalParams
  ): AsyncIterableIterator<VirtualNetwork[]> {
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
    options?: VirtualNetworksListAllOptionalParams
  ): AsyncIterableIterator<VirtualNetwork> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all virtual networks in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: VirtualNetworksListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetwork> {
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
    options?: VirtualNetworksListOptionalParams
  ): AsyncIterableIterator<VirtualNetwork[]> {
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
    options?: VirtualNetworksListOptionalParams
  ): AsyncIterableIterator<VirtualNetwork> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Lists usage stats.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  public listUsage(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksListUsageOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkUsage> {
    const iter = this.listUsagePagingAll(
      resourceGroupName,
      virtualNetworkName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listUsagePagingPage(
          resourceGroupName,
          virtualNetworkName,
          options
        );
      }
    };
  }

  private async *listUsagePagingPage(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksListUsageOptionalParams
  ): AsyncIterableIterator<VirtualNetworkUsage[]> {
    let result = await this._listUsage(
      resourceGroupName,
      virtualNetworkName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listUsageNext(
        resourceGroupName,
        virtualNetworkName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listUsagePagingAll(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksListUsageOptionalParams
  ): AsyncIterableIterator<VirtualNetworkUsage> {
    for await (const page of this.listUsagePagingPage(
      resourceGroupName,
      virtualNetworkName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksDeleteOptionalParams
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
      { resourceGroupName, virtualNetworkName, options },
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
   * Deletes the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified virtual network by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksGetOptionalParams
  ): Promise<VirtualNetworksGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a virtual network in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: VirtualNetwork,
    options?: VirtualNetworksCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworksCreateOrUpdateResponse>,
      VirtualNetworksCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworksCreateOrUpdateResponse> => {
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
      { resourceGroupName, virtualNetworkName, parameters, options },
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
   * Creates or updates a virtual network in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to the create or update virtual network operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: VirtualNetwork,
    options?: VirtualNetworksCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworksCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a virtual network tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to update virtual network tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: TagsObject,
    options?: VirtualNetworksUpdateTagsOptionalParams
  ): Promise<VirtualNetworksUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all virtual networks in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: VirtualNetworksListAllOptionalParams
  ): Promise<VirtualNetworksListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all virtual networks in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: VirtualNetworksListOptionalParams
  ): Promise<VirtualNetworksListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Checks whether a private IP address is available for use.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param ipAddress The private IP address to be verified.
   * @param options The options parameters.
   */
  checkIPAddressAvailability(
    resourceGroupName: string,
    virtualNetworkName: string,
    ipAddress: string,
    options?: VirtualNetworksCheckIPAddressAvailabilityOptionalParams
  ): Promise<VirtualNetworksCheckIPAddressAvailabilityResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, ipAddress, options },
      checkIPAddressAvailabilityOperationSpec
    );
  }

  /**
   * Lists usage stats.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  private _listUsage(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworksListUsageOptionalParams
  ): Promise<VirtualNetworksListUsageResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, options },
      listUsageOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: VirtualNetworksListAllNextOptionalParams
  ): Promise<VirtualNetworksListAllNextResponse> {
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
    options?: VirtualNetworksListNextOptionalParams
  ): Promise<VirtualNetworksListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListUsageNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param nextLink The nextLink from the previous successful call to the ListUsage method.
   * @param options The options parameters.
   */
  private _listUsageNext(
    resourceGroupName: string,
    virtualNetworkName: string,
    nextLink: string,
    options?: VirtualNetworksListUsageNextOptionalParams
  ): Promise<VirtualNetworksListUsageNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, nextLink, options },
      listUsageNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}",
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
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetwork
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
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetwork
    },
    201: {
      bodyMapper: Mappers.VirtualNetwork
    },
    202: {
      bodyMapper: Mappers.VirtualNetwork
    },
    204: {
      bodyMapper: Mappers.VirtualNetwork
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters67,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetwork
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
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/virtualNetworks",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkListResult
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
const checkIPAddressAvailabilityOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/CheckIPAddressAvailability",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.IPAddressAvailabilityResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.ipAddress],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listUsageOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/usages",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkListUsageResult
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
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkListResult
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
      bodyMapper: Mappers.VirtualNetworkListResult
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
const listUsageNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkListUsageResult
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
    Parameters.nextLink,
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
