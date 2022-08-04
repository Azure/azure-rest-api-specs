import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PrivateDnsZoneGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  PrivateDnsZoneGroup,
  PrivateDnsZoneGroupsListNextOptionalParams,
  PrivateDnsZoneGroupsListOptionalParams,
  PrivateDnsZoneGroupsDeleteOptionalParams,
  PrivateDnsZoneGroupsGetOptionalParams,
  PrivateDnsZoneGroupsGetResponse,
  PrivateDnsZoneGroupsCreateOrUpdateOptionalParams,
  PrivateDnsZoneGroupsCreateOrUpdateResponse,
  PrivateDnsZoneGroupsListResponse,
  PrivateDnsZoneGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing PrivateDnsZoneGroups operations. */
export class PrivateDnsZoneGroupsImpl implements PrivateDnsZoneGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class PrivateDnsZoneGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all private dns zone groups in a private endpoint.
   * @param privateEndpointName The name of the private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    privateEndpointName: string,
    resourceGroupName: string,
    options?: PrivateDnsZoneGroupsListOptionalParams
  ): PagedAsyncIterableIterator<PrivateDnsZoneGroup> {
    const iter = this.listPagingAll(
      privateEndpointName,
      resourceGroupName,
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
          privateEndpointName,
          resourceGroupName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    privateEndpointName: string,
    resourceGroupName: string,
    options?: PrivateDnsZoneGroupsListOptionalParams
  ): AsyncIterableIterator<PrivateDnsZoneGroup[]> {
    let result = await this._list(
      privateEndpointName,
      resourceGroupName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        privateEndpointName,
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    privateEndpointName: string,
    resourceGroupName: string,
    options?: PrivateDnsZoneGroupsListOptionalParams
  ): AsyncIterableIterator<PrivateDnsZoneGroup> {
    for await (const page of this.listPagingPage(
      privateEndpointName,
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified private dns zone group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsDeleteOptionalParams
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
        privateEndpointName,
        privateDnsZoneGroupName,
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
   * Deletes the specified private dns zone group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      privateEndpointName,
      privateDnsZoneGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the private dns zone group resource by specified private dns zone group name.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsGetOptionalParams
  ): Promise<PrivateDnsZoneGroupsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        privateEndpointName,
        privateDnsZoneGroupName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a private dns zone group in the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param parameters Parameters supplied to the create or update private dns zone group operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    parameters: PrivateDnsZoneGroup,
    options?: PrivateDnsZoneGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PrivateDnsZoneGroupsCreateOrUpdateResponse>,
      PrivateDnsZoneGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PrivateDnsZoneGroupsCreateOrUpdateResponse> => {
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
        privateEndpointName,
        privateDnsZoneGroupName,
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
   * Creates or updates a private dns zone group in the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param parameters Parameters supplied to the create or update private dns zone group operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    parameters: PrivateDnsZoneGroup,
    options?: PrivateDnsZoneGroupsCreateOrUpdateOptionalParams
  ): Promise<PrivateDnsZoneGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      privateEndpointName,
      privateDnsZoneGroupName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all private dns zone groups in a private endpoint.
   * @param privateEndpointName The name of the private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    privateEndpointName: string,
    resourceGroupName: string,
    options?: PrivateDnsZoneGroupsListOptionalParams
  ): Promise<PrivateDnsZoneGroupsListResponse> {
    return this.client.sendOperationRequest(
      { privateEndpointName, resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param privateEndpointName The name of the private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    privateEndpointName: string,
    resourceGroupName: string,
    nextLink: string,
    options?: PrivateDnsZoneGroupsListNextOptionalParams
  ): Promise<PrivateDnsZoneGroupsListNextResponse> {
    return this.client.sendOperationRequest(
      { privateEndpointName, resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}",
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
    Parameters.privateEndpointName,
    Parameters.privateDnsZoneGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateDnsZoneGroup
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
    Parameters.privateEndpointName,
    Parameters.privateDnsZoneGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateDnsZoneGroup
    },
    201: {
      bodyMapper: Mappers.PrivateDnsZoneGroup
    },
    202: {
      bodyMapper: Mappers.PrivateDnsZoneGroup
    },
    204: {
      bodyMapper: Mappers.PrivateDnsZoneGroup
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters59,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.privateEndpointName,
    Parameters.privateDnsZoneGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateDnsZoneGroupListResult
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
    Parameters.privateEndpointName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateDnsZoneGroupListResult
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
    Parameters.privateEndpointName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
