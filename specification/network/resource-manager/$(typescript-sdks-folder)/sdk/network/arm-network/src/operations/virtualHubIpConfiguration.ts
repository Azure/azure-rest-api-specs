import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualHubIpConfiguration } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  HubIpConfiguration,
  VirtualHubIpConfigurationListNextOptionalParams,
  VirtualHubIpConfigurationListOptionalParams,
  VirtualHubIpConfigurationGetOptionalParams,
  VirtualHubIpConfigurationGetResponse,
  VirtualHubIpConfigurationCreateOrUpdateOptionalParams,
  VirtualHubIpConfigurationCreateOrUpdateResponse,
  VirtualHubIpConfigurationDeleteOptionalParams,
  VirtualHubIpConfigurationListResponse,
  VirtualHubIpConfigurationListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualHubIpConfiguration operations. */
export class VirtualHubIpConfigurationImpl
  implements VirtualHubIpConfiguration {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualHubIpConfiguration class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of all VirtualHubIpConfigurations.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubIpConfigurationListOptionalParams
  ): PagedAsyncIterableIterator<HubIpConfiguration> {
    const iter = this.listPagingAll(resourceGroupName, virtualHubName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, virtualHubName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubIpConfigurationListOptionalParams
  ): AsyncIterableIterator<HubIpConfiguration[]> {
    let result = await this._list(resourceGroupName, virtualHubName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        virtualHubName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubIpConfigurationListOptionalParams
  ): AsyncIterableIterator<HubIpConfiguration> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      virtualHubName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a Virtual Hub Ip configuration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationGetOptionalParams
  ): Promise<VirtualHubIpConfigurationGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, ipConfigName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a VirtualHubIpConfiguration resource if it doesn't exist else updates the existing
   * VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param parameters Hub Ip Configuration parameters.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    parameters: HubIpConfiguration,
    options?: VirtualHubIpConfigurationCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualHubIpConfigurationCreateOrUpdateResponse>,
      VirtualHubIpConfigurationCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualHubIpConfigurationCreateOrUpdateResponse> => {
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
      { resourceGroupName, virtualHubName, ipConfigName, parameters, options },
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
   * Creates a VirtualHubIpConfiguration resource if it doesn't exist else updates the existing
   * VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param parameters Hub Ip Configuration parameters.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    parameters: HubIpConfiguration,
    options?: VirtualHubIpConfigurationCreateOrUpdateOptionalParams
  ): Promise<VirtualHubIpConfigurationCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualHubName,
      ipConfigName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationDeleteOptionalParams
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
      { resourceGroupName, virtualHubName, ipConfigName, options },
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
   * Deletes a VirtualHubIpConfiguration.
   * @param resourceGroupName The resource group name of the VirtualHubBgpConnection.
   * @param virtualHubName The name of the VirtualHub.
   * @param ipConfigName The name of the ipconfig.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualHubName: string,
    ipConfigName: string,
    options?: VirtualHubIpConfigurationDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualHubName,
      ipConfigName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves the details of all VirtualHubIpConfigurations.
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    virtualHubName: string,
    options?: VirtualHubIpConfigurationListOptionalParams
  ): Promise<VirtualHubIpConfigurationListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The resource group name of the VirtualHub.
   * @param virtualHubName The name of the VirtualHub.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    virtualHubName: string,
    nextLink: string,
    options?: VirtualHubIpConfigurationListNextOptionalParams
  ): Promise<VirtualHubIpConfigurationListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualHubName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.HubIpConfiguration
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
    Parameters.virtualHubName,
    Parameters.ipConfigName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.HubIpConfiguration
    },
    201: {
      bodyMapper: Mappers.HubIpConfiguration
    },
    202: {
      bodyMapper: Mappers.HubIpConfiguration
    },
    204: {
      bodyMapper: Mappers.HubIpConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters86,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualHubName,
    Parameters.ipConfigName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations/{ipConfigName}",
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
    Parameters.virtualHubName,
    Parameters.ipConfigName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualHubs/{virtualHubName}/ipConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualHubIpConfigurationResults
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
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualHubIpConfigurationResults
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
    Parameters.virtualHubName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
