import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualRouterPeerings } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualRouterPeering,
  VirtualRouterPeeringsListNextOptionalParams,
  VirtualRouterPeeringsListOptionalParams,
  VirtualRouterPeeringsDeleteOptionalParams,
  VirtualRouterPeeringsGetOptionalParams,
  VirtualRouterPeeringsGetResponse,
  VirtualRouterPeeringsCreateOrUpdateOptionalParams,
  VirtualRouterPeeringsCreateOrUpdateResponse,
  VirtualRouterPeeringsListResponse,
  VirtualRouterPeeringsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualRouterPeerings operations. */
export class VirtualRouterPeeringsImpl implements VirtualRouterPeerings {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualRouterPeerings class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all Virtual Router Peerings in a Virtual Router resource.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualRouterName: string,
    options?: VirtualRouterPeeringsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualRouterPeering> {
    const iter = this.listPagingAll(
      resourceGroupName,
      virtualRouterName,
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
          virtualRouterName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    virtualRouterName: string,
    options?: VirtualRouterPeeringsListOptionalParams
  ): AsyncIterableIterator<VirtualRouterPeering[]> {
    let result = await this._list(
      resourceGroupName,
      virtualRouterName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        virtualRouterName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    virtualRouterName: string,
    options?: VirtualRouterPeeringsListOptionalParams
  ): AsyncIterableIterator<VirtualRouterPeering> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualRouterName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified peering from a Virtual Router.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsDeleteOptionalParams
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
      { resourceGroupName, virtualRouterName, peeringName, options },
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
   * Deletes the specified peering from a Virtual Router.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualRouterName,
      peeringName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    options?: VirtualRouterPeeringsGetOptionalParams
  ): Promise<VirtualRouterPeeringsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualRouterName, peeringName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param parameters Parameters supplied to the create or update Virtual Router Peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    parameters: VirtualRouterPeering,
    options?: VirtualRouterPeeringsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualRouterPeeringsCreateOrUpdateResponse>,
      VirtualRouterPeeringsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualRouterPeeringsCreateOrUpdateResponse> => {
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
        virtualRouterName,
        peeringName,
        parameters,
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
   * Creates or updates the specified Virtual Router Peering.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param peeringName The name of the Virtual Router Peering.
   * @param parameters Parameters supplied to the create or update Virtual Router Peering operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualRouterName: string,
    peeringName: string,
    parameters: VirtualRouterPeering,
    options?: VirtualRouterPeeringsCreateOrUpdateOptionalParams
  ): Promise<VirtualRouterPeeringsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualRouterName,
      peeringName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all Virtual Router Peerings in a Virtual Router resource.
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualRouterName: string,
    options?: VirtualRouterPeeringsListOptionalParams
  ): Promise<VirtualRouterPeeringsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualRouterName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualRouterName The name of the Virtual Router.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    virtualRouterName: string,
    nextLink: string,
    options?: VirtualRouterPeeringsListNextOptionalParams
  ): Promise<VirtualRouterPeeringsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualRouterName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}",
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
    Parameters.peeringName,
    Parameters.virtualRouterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualRouterPeering
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
    Parameters.peeringName,
    Parameters.virtualRouterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualRouterPeering
    },
    201: {
      bodyMapper: Mappers.VirtualRouterPeering
    },
    202: {
      bodyMapper: Mappers.VirtualRouterPeering
    },
    204: {
      bodyMapper: Mappers.VirtualRouterPeering
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters79,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.peeringName,
    Parameters.virtualRouterName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualRouters/{virtualRouterName}/peerings",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualRouterPeeringListResult
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
    Parameters.virtualRouterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualRouterPeeringListResult
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
    Parameters.nextLink,
    Parameters.virtualRouterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
