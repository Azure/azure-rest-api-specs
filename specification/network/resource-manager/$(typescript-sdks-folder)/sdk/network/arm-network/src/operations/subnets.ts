import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { Subnets } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  Subnet,
  SubnetsListNextOptionalParams,
  SubnetsListOptionalParams,
  SubnetsDeleteOptionalParams,
  SubnetsGetOptionalParams,
  SubnetsGetResponse,
  SubnetsCreateOrUpdateOptionalParams,
  SubnetsCreateOrUpdateResponse,
  PrepareNetworkPoliciesRequest,
  SubnetsPrepareNetworkPoliciesOptionalParams,
  UnprepareNetworkPoliciesRequest,
  SubnetsUnprepareNetworkPoliciesOptionalParams,
  SubnetsListResponse,
  SubnetsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing Subnets operations. */
export class SubnetsImpl implements Subnets {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class Subnets class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all subnets in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: SubnetsListOptionalParams
  ): PagedAsyncIterableIterator<Subnet> {
    const iter = this.listPagingAll(
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
        return this.listPagingPage(
          resourceGroupName,
          virtualNetworkName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: SubnetsListOptionalParams
  ): AsyncIterableIterator<Subnet[]> {
    let result = await this._list(
      resourceGroupName,
      virtualNetworkName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        virtualNetworkName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: SubnetsListOptionalParams
  ): AsyncIterableIterator<Subnet> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualNetworkName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsDeleteOptionalParams
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
      { resourceGroupName, virtualNetworkName, subnetName, options },
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
   * Deletes the specified subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkName,
      subnetName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified subnet by virtual network and resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: SubnetsGetOptionalParams
  ): Promise<SubnetsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, subnetName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a subnet in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param subnetParameters Parameters supplied to the create or update subnet operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    subnetParameters: Subnet,
    options?: SubnetsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<SubnetsCreateOrUpdateResponse>,
      SubnetsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<SubnetsCreateOrUpdateResponse> => {
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
      {
        resourceGroupName,
        virtualNetworkName,
        subnetName,
        subnetParameters,
        options
      },
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
   * Creates or updates a subnet in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param subnetParameters Parameters supplied to the create or update subnet operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    subnetParameters: Subnet,
    options?: SubnetsCreateOrUpdateOptionalParams
  ): Promise<SubnetsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkName,
      subnetName,
      subnetParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Prepares a subnet by applying network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param prepareNetworkPoliciesRequestParameters Parameters supplied to prepare subnet by applying
   *                                                network intent policies.
   * @param options The options parameters.
   */
  async beginPrepareNetworkPolicies(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    prepareNetworkPoliciesRequestParameters: PrepareNetworkPoliciesRequest,
    options?: SubnetsPrepareNetworkPoliciesOptionalParams
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
      {
        resourceGroupName,
        virtualNetworkName,
        subnetName,
        prepareNetworkPoliciesRequestParameters,
        options
      },
      prepareNetworkPoliciesOperationSpec
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
   * Prepares a subnet by applying network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param prepareNetworkPoliciesRequestParameters Parameters supplied to prepare subnet by applying
   *                                                network intent policies.
   * @param options The options parameters.
   */
  async beginPrepareNetworkPoliciesAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    prepareNetworkPoliciesRequestParameters: PrepareNetworkPoliciesRequest,
    options?: SubnetsPrepareNetworkPoliciesOptionalParams
  ): Promise<void> {
    const poller = await this.beginPrepareNetworkPolicies(
      resourceGroupName,
      virtualNetworkName,
      subnetName,
      prepareNetworkPoliciesRequestParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Unprepares a subnet by removing network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param unprepareNetworkPoliciesRequestParameters Parameters supplied to unprepare subnet to remove
   *                                                  network intent policies.
   * @param options The options parameters.
   */
  async beginUnprepareNetworkPolicies(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    unprepareNetworkPoliciesRequestParameters: UnprepareNetworkPoliciesRequest,
    options?: SubnetsUnprepareNetworkPoliciesOptionalParams
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
      {
        resourceGroupName,
        virtualNetworkName,
        subnetName,
        unprepareNetworkPoliciesRequestParameters,
        options
      },
      unprepareNetworkPoliciesOperationSpec
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
   * Unprepares a subnet by removing network intent policies.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param unprepareNetworkPoliciesRequestParameters Parameters supplied to unprepare subnet to remove
   *                                                  network intent policies.
   * @param options The options parameters.
   */
  async beginUnprepareNetworkPoliciesAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    unprepareNetworkPoliciesRequestParameters: UnprepareNetworkPoliciesRequest,
    options?: SubnetsUnprepareNetworkPoliciesOptionalParams
  ): Promise<void> {
    const poller = await this.beginUnprepareNetworkPolicies(
      resourceGroupName,
      virtualNetworkName,
      subnetName,
      unprepareNetworkPoliciesRequestParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all subnets in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: SubnetsListOptionalParams
  ): Promise<SubnetsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    virtualNetworkName: string,
    nextLink: string,
    options?: SubnetsListNextOptionalParams
  ): Promise<SubnetsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}",
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
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.Subnet
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
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.Subnet
    },
    201: {
      bodyMapper: Mappers.Subnet
    },
    202: {
      bodyMapper: Mappers.Subnet
    },
    204: {
      bodyMapper: Mappers.Subnet
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.subnetParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const prepareNetworkPoliciesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/PrepareNetworkPolicies",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.prepareNetworkPoliciesRequestParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const unprepareNetworkPoliciesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/UnprepareNetworkPolicies",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.unprepareNetworkPoliciesRequestParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SubnetListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SubnetListResult
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
