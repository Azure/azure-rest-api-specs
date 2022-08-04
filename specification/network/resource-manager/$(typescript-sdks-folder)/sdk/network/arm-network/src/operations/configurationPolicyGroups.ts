import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ConfigurationPolicyGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VpnServerConfigurationPolicyGroup,
  ConfigurationPolicyGroupsListByVpnServerConfigurationNextOptionalParams,
  ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams,
  ConfigurationPolicyGroupsCreateOrUpdateOptionalParams,
  ConfigurationPolicyGroupsCreateOrUpdateResponse,
  ConfigurationPolicyGroupsDeleteOptionalParams,
  ConfigurationPolicyGroupsGetOptionalParams,
  ConfigurationPolicyGroupsGetResponse,
  ConfigurationPolicyGroupsListByVpnServerConfigurationResponse,
  ConfigurationPolicyGroupsListByVpnServerConfigurationNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ConfigurationPolicyGroups operations. */
export class ConfigurationPolicyGroupsImpl
  implements ConfigurationPolicyGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ConfigurationPolicyGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all the configurationPolicyGroups in a resource group for a vpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param options The options parameters.
   */
  public listByVpnServerConfiguration(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams
  ): PagedAsyncIterableIterator<VpnServerConfigurationPolicyGroup> {
    const iter = this.listByVpnServerConfigurationPagingAll(
      resourceGroupName,
      vpnServerConfigurationName,
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
        return this.listByVpnServerConfigurationPagingPage(
          resourceGroupName,
          vpnServerConfigurationName,
          options
        );
      }
    };
  }

  private async *listByVpnServerConfigurationPagingPage(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams
  ): AsyncIterableIterator<VpnServerConfigurationPolicyGroup[]> {
    let result = await this._listByVpnServerConfiguration(
      resourceGroupName,
      vpnServerConfigurationName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByVpnServerConfigurationNext(
        resourceGroupName,
        vpnServerConfigurationName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByVpnServerConfigurationPagingAll(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams
  ): AsyncIterableIterator<VpnServerConfigurationPolicyGroup> {
    for await (const page of this.listByVpnServerConfigurationPagingPage(
      resourceGroupName,
      vpnServerConfigurationName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates a ConfigurationPolicyGroup if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param configurationPolicyGroupName The name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationPolicyGroupParameters Parameters supplied to create or update a
   *                                                    VpnServerConfiguration PolicyGroup.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    configurationPolicyGroupName: string,
    vpnServerConfigurationPolicyGroupParameters: VpnServerConfigurationPolicyGroup,
    options?: ConfigurationPolicyGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ConfigurationPolicyGroupsCreateOrUpdateResponse>,
      ConfigurationPolicyGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ConfigurationPolicyGroupsCreateOrUpdateResponse> => {
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
        configurationPolicyGroupName,
        vpnServerConfigurationPolicyGroupParameters,
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
   * Creates a ConfigurationPolicyGroup if it doesn't exist else updates the existing one.
   * @param resourceGroupName The resource group name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param configurationPolicyGroupName The name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationPolicyGroupParameters Parameters supplied to create or update a
   *                                                    VpnServerConfiguration PolicyGroup.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    configurationPolicyGroupName: string,
    vpnServerConfigurationPolicyGroupParameters: VpnServerConfigurationPolicyGroup,
    options?: ConfigurationPolicyGroupsCreateOrUpdateOptionalParams
  ): Promise<ConfigurationPolicyGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      vpnServerConfigurationName,
      configurationPolicyGroupName,
      vpnServerConfigurationPolicyGroupParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a ConfigurationPolicyGroup.
   * @param resourceGroupName The resource group name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param configurationPolicyGroupName The name of the ConfigurationPolicyGroup.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    configurationPolicyGroupName: string,
    options?: ConfigurationPolicyGroupsDeleteOptionalParams
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
        vpnServerConfigurationName,
        configurationPolicyGroupName,
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
   * Deletes a ConfigurationPolicyGroup.
   * @param resourceGroupName The resource group name of the ConfigurationPolicyGroup.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param configurationPolicyGroupName The name of the ConfigurationPolicyGroup.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    configurationPolicyGroupName: string,
    options?: ConfigurationPolicyGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      vpnServerConfigurationName,
      configurationPolicyGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves the details of a ConfigurationPolicyGroup.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param configurationPolicyGroupName The name of the ConfigurationPolicyGroup being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    configurationPolicyGroupName: string,
    options?: ConfigurationPolicyGroupsGetOptionalParams
  ): Promise<ConfigurationPolicyGroupsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        vpnServerConfigurationName,
        configurationPolicyGroupName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Lists all the configurationPolicyGroups in a resource group for a vpnServerConfiguration.
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param options The options parameters.
   */
  private _listByVpnServerConfiguration(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    options?: ConfigurationPolicyGroupsListByVpnServerConfigurationOptionalParams
  ): Promise<ConfigurationPolicyGroupsListByVpnServerConfigurationResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnServerConfigurationName, options },
      listByVpnServerConfigurationOperationSpec
    );
  }

  /**
   * ListByVpnServerConfigurationNext
   * @param resourceGroupName The resource group name of the VpnServerConfiguration.
   * @param vpnServerConfigurationName The name of the VpnServerConfiguration.
   * @param nextLink The nextLink from the previous successful call to the ListByVpnServerConfiguration
   *                 method.
   * @param options The options parameters.
   */
  private _listByVpnServerConfigurationNext(
    resourceGroupName: string,
    vpnServerConfigurationName: string,
    nextLink: string,
    options?: ConfigurationPolicyGroupsListByVpnServerConfigurationNextOptionalParams
  ): Promise<
    ConfigurationPolicyGroupsListByVpnServerConfigurationNextResponse
  > {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnServerConfigurationName, nextLink, options },
      listByVpnServerConfigurationNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfigurationPolicyGroup
    },
    201: {
      bodyMapper: Mappers.VpnServerConfigurationPolicyGroup
    },
    202: {
      bodyMapper: Mappers.VpnServerConfigurationPolicyGroup
    },
    204: {
      bodyMapper: Mappers.VpnServerConfigurationPolicyGroup
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnServerConfigurationPolicyGroupParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.vpnServerConfigurationName,
    Parameters.configurationPolicyGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}",
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
    Parameters.vpnServerConfigurationName,
    Parameters.configurationPolicyGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups/{configurationPolicyGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfigurationPolicyGroup
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
    Parameters.vpnServerConfigurationName,
    Parameters.configurationPolicyGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnServerConfigurationOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnServerConfigurations/{vpnServerConfigurationName}/configurationPolicyGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnServerConfigurationPolicyGroupsResult
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
const listByVpnServerConfigurationNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnServerConfigurationPolicyGroupsResult
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
    Parameters.vpnServerConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
