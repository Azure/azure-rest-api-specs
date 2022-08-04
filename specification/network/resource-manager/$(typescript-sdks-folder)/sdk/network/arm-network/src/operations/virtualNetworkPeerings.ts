import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworkPeerings } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetworkPeering,
  VirtualNetworkPeeringsListNextOptionalParams,
  VirtualNetworkPeeringsListOptionalParams,
  VirtualNetworkPeeringsDeleteOptionalParams,
  VirtualNetworkPeeringsGetOptionalParams,
  VirtualNetworkPeeringsGetResponse,
  VirtualNetworkPeeringsCreateOrUpdateOptionalParams,
  VirtualNetworkPeeringsCreateOrUpdateResponse,
  VirtualNetworkPeeringsListResponse,
  VirtualNetworkPeeringsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworkPeerings operations. */
export class VirtualNetworkPeeringsImpl implements VirtualNetworkPeerings {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworkPeerings class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all virtual network peerings in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworkPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkPeering> {
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
    options?: VirtualNetworkPeeringsListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkPeering[]> {
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
    options?: VirtualNetworkPeeringsListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkPeering> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualNetworkName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsDeleteOptionalParams
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
        virtualNetworkPeeringName,
        options
      },
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
   * Deletes the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkName,
      virtualNetworkPeeringName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified virtual network peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the virtual network peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    options?: VirtualNetworkPeeringsGetOptionalParams
  ): Promise<VirtualNetworkPeeringsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualNetworkName,
        virtualNetworkPeeringName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a peering in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the peering.
   * @param virtualNetworkPeeringParameters Parameters supplied to the create or update virtual network
   *                                        peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    virtualNetworkPeeringParameters: VirtualNetworkPeering,
    options?: VirtualNetworkPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkPeeringsCreateOrUpdateResponse>,
      VirtualNetworkPeeringsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkPeeringsCreateOrUpdateResponse> => {
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
        virtualNetworkPeeringName,
        virtualNetworkPeeringParameters,
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
   * Creates or updates a peering in the specified virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param virtualNetworkPeeringName The name of the peering.
   * @param virtualNetworkPeeringParameters Parameters supplied to the create or update virtual network
   *                                        peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkName: string,
    virtualNetworkPeeringName: string,
    virtualNetworkPeeringParameters: VirtualNetworkPeering,
    options?: VirtualNetworkPeeringsCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkPeeringsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkName,
      virtualNetworkPeeringName,
      virtualNetworkPeeringParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all virtual network peerings in a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualNetworkName: string,
    options?: VirtualNetworkPeeringsListOptionalParams
  ): Promise<VirtualNetworkPeeringsListResponse> {
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
    options?: VirtualNetworkPeeringsListNextOptionalParams
  ): Promise<VirtualNetworkPeeringsListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}",
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
    Parameters.virtualNetworkPeeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkPeering
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
    Parameters.virtualNetworkName,
    Parameters.virtualNetworkPeeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkPeering
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkPeering
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkPeering
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkPeering
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.virtualNetworkPeeringParameters,
  queryParameters: [Parameters.apiVersion, Parameters.syncRemoteAddressSpace],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName,
    Parameters.virtualNetworkPeeringName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkPeeringListResult
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
      bodyMapper: Mappers.VirtualNetworkPeeringListResult
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
