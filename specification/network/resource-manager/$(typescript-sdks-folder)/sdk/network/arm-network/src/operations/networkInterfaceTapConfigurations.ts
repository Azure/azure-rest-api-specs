import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkInterfaceTapConfigurations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkInterfaceTapConfiguration,
  NetworkInterfaceTapConfigurationsListNextOptionalParams,
  NetworkInterfaceTapConfigurationsListOptionalParams,
  NetworkInterfaceTapConfigurationsDeleteOptionalParams,
  NetworkInterfaceTapConfigurationsGetOptionalParams,
  NetworkInterfaceTapConfigurationsGetResponse,
  NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams,
  NetworkInterfaceTapConfigurationsCreateOrUpdateResponse,
  NetworkInterfaceTapConfigurationsListResponse,
  NetworkInterfaceTapConfigurationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkInterfaceTapConfigurations operations. */
export class NetworkInterfaceTapConfigurationsImpl
  implements NetworkInterfaceTapConfigurations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkInterfaceTapConfigurations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Get all Tap configurations in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceTapConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterfaceTapConfiguration> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkInterfaceName,
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
          networkInterfaceName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceTapConfigurationsListOptionalParams
  ): AsyncIterableIterator<NetworkInterfaceTapConfiguration[]> {
    let result = await this._list(
      resourceGroupName,
      networkInterfaceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkInterfaceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceTapConfigurationsListOptionalParams
  ): AsyncIterableIterator<NetworkInterfaceTapConfiguration> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkInterfaceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified tap configuration from the NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsDeleteOptionalParams
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
        networkInterfaceName,
        tapConfigurationName,
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
   * Deletes the specified tap configuration from the NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkInterfaceName,
      tapConfigurationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get the specified tap configuration on a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    options?: NetworkInterfaceTapConfigurationsGetOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkInterfaceName,
        tapConfigurationName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param tapConfigurationParameters Parameters supplied to the create or update tap configuration
   *                                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    tapConfigurationParameters: NetworkInterfaceTapConfiguration,
    options?: NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        NetworkInterfaceTapConfigurationsCreateOrUpdateResponse
      >,
      NetworkInterfaceTapConfigurationsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkInterfaceTapConfigurationsCreateOrUpdateResponse> => {
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
        networkInterfaceName,
        tapConfigurationName,
        tapConfigurationParameters,
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
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param tapConfigurationName The name of the tap configuration.
   * @param tapConfigurationParameters Parameters supplied to the create or update tap configuration
   *                                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    tapConfigurationName: string,
    tapConfigurationParameters: NetworkInterfaceTapConfiguration,
    options?: NetworkInterfaceTapConfigurationsCreateOrUpdateOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkInterfaceName,
      tapConfigurationName,
      tapConfigurationParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get all Tap configurations in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceTapConfigurationsListOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkInterfaceName: string,
    nextLink: string,
    options?: NetworkInterfaceTapConfigurationsListNextOptionalParams
  ): Promise<NetworkInterfaceTapConfigurationsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}",
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
    Parameters.networkInterfaceName,
    Parameters.tapConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceTapConfiguration
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
    Parameters.networkInterfaceName,
    Parameters.tapConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceTapConfiguration
    },
    201: {
      bodyMapper: Mappers.NetworkInterfaceTapConfiguration
    },
    202: {
      bodyMapper: Mappers.NetworkInterfaceTapConfiguration
    },
    204: {
      bodyMapper: Mappers.NetworkInterfaceTapConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.tapConfigurationParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName,
    Parameters.tapConfigurationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceTapConfigurationListResult
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
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceTapConfigurationListResult
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
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
