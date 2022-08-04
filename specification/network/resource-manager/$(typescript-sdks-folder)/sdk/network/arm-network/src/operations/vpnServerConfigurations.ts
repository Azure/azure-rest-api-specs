import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VpnServerConfigurations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VpnServerConfiguration,
  VpnServerConfigurationsListByResourceGroupNextOptionalParams,
  VpnServerConfigurationsListByResourceGroupOptionalParams,
  VpnServerConfigurationsListNextOptionalParams,
  VpnServerConfigurationsListOptionalParams,
  VpnServerConfigurationsGetOptionalParams,
  VpnServerConfigurationsGetResponse,
  VpnServerConfigurationsCreateOrUpdateOptionalParams,
  VpnServerConfigurationsCreateOrUpdateResponse,
  TagsObject,
  VpnServerConfigurationsUpdateTagsOptionalParams,
  VpnServerConfigurationsUpdateTagsResponse,
  VpnServerConfigurationsDeleteOptionalParams,
  VpnServerConfigurationsListByResourceGroupResponse,
  VpnServerConfigurationsListResponse,
  VpnServerConfigurationsListByResourceGroupNextResponse,
  VpnServerConfigurationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VpnServerConfigurations operations. */
export class VpnServerConfigurationsImpl implements VpnServerConfigurations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnServerConfigurations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all the vpnServerConfigurations in a resource group.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: VpnServerConfigurationsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VpnServerConfiguration> {
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
    options?: VpnServerConfigurationsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VpnServerConfiguration[]> {
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
    options?: VpnServerConfigurationsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<VpnServerConfiguration> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Lists all the VpnServerConfigurations in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: VpnServerConfigurationsListOptionalParams
  ): PagedAsyncIterableIterator<VpnServerConfiguration> {
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
    options?: VpnServerConfigurationsListOptionalParams
  ): AsyncIterableIterator<VpnServerConfiguration[]> {
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
    options?: VpnServerConfigurationsListOptionalParams
  ): AsyncIterableIterator<VpnServerConfiguration> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsGetOptionalParams
  ): Promise<VpnServerConfigurationsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnServerConfigurationName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a VpnServerConfiguration resource if it doesn't exist else updates the existing
   * VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being created or updated.
   * @param vpnServerConfigurationParameters Parameters supplied to create or update
   *                                         VpnServerConfiguration.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: VpnServerConfiguration,
    options?: VpnServerConfigurationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnServerConfigurationsCreateOrUpdateResponse>,
      VpnServerConfigurationsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VpnServerConfigurationsCreateOrUpdateResponse> => {
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
        vpnServerConfigurationName,
        vpnServerConfigurationParameters,
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
   * Creates a VpnServerConfiguration resource if it doesn't exist else updates the existing
   * VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being created or updated.
   * @param vpnServerConfigurationParameters Parameters supplied to create or update
   *                                         VpnServerConfiguration.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: VpnServerConfiguration,
    options?: VpnServerConfigurationsCreateOrUpdateOptionalParams
  ): Promise<VpnServerConfigurationsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      vpnServerConfigurationName,
      vpnServerConfigurationParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates VpnServerConfiguration tags.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being updated.
   * @param vpnServerConfigurationParameters Parameters supplied to update VpnServerConfiguration tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    vpnServerConfigurationParameters: TagsObject,
    options?: VpnServerConfigurationsUpdateTagsOptionalParams
  ): Promise<VpnServerConfigurationsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        vpnServerConfigurationName,
        vpnServerConfigurationParameters,
        options
      },
      updateTagsOperationSpec
    );
  }

  /**
   * Deletes a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being deleted.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsDeleteOptionalParams
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
      { resourceGroupName, vpnServerConfigurationName, options },
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
   * Deletes a VpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration being deleted.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: VpnServerConfigurationsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      vpnServerConfigurationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all the vpnServerConfigurations in a resource group.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: VpnServerConfigurationsListByResourceGroupOptionalParams
  ): Promise<VpnServerConfigurationsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Lists all the VpnServerConfigurations in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: VpnServerConfigurationsListOptionalParams
  ): Promise<VpnServerConfigurationsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    nextLink: string,
    options?: VpnServerConfigurationsListByResourceGroupNextOptionalParams
  ): Promise<VpnServerConfigurationsListByResourceGroupNextResponse> {
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
    options?: VpnServerConfigurationsListNextOptionalParams
  ): Promise<VpnServerConfigurationsListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfiguration
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
    Parameters.vpnServerConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfiguration
    },
    201: {
      bodyMapper: Mappers.VpnServerConfiguration
    },
    202: {
      bodyMapper: Mappers.VpnServerConfiguration
    },
    204: {
      bodyMapper: Mappers.VpnServerConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnServerConfigurationParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.vpnServerConfigurationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnServerConfigurationParameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.vpnServerConfigurationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}",
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
    Parameters.vpnServerConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnServerConfigurationsResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/vpnServerConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnServerConfigurationsResult
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
      bodyMapper: Mappers.ListVpnServerConfigurationsResult
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
      bodyMapper: Mappers.ListVpnServerConfigurationsResult
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
