import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AdminRuleCollections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  AdminRuleCollection,
  AdminRuleCollectionsListNextOptionalParams,
  AdminRuleCollectionsListOptionalParams,
  AdminRuleCollectionsListResponse,
  AdminRuleCollectionsGetOptionalParams,
  AdminRuleCollectionsGetResponse,
  AdminRuleCollectionsCreateOrUpdateOptionalParams,
  AdminRuleCollectionsCreateOrUpdateResponse,
  AdminRuleCollectionsDeleteOptionalParams,
  AdminRuleCollectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AdminRuleCollections operations. */
export class AdminRuleCollectionsImpl implements AdminRuleCollections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AdminRuleCollections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all the rule collections in a security admin configuration, in a paginated format.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: AdminRuleCollectionsListOptionalParams
  ): PagedAsyncIterableIterator<AdminRuleCollection> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkManagerName,
      configurationName,
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
          networkManagerName,
          configurationName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: AdminRuleCollectionsListOptionalParams
  ): AsyncIterableIterator<AdminRuleCollection[]> {
    let result = await this._list(
      resourceGroupName,
      networkManagerName,
      configurationName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkManagerName,
        configurationName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: AdminRuleCollectionsListOptionalParams
  ): AsyncIterableIterator<AdminRuleCollection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkManagerName,
      configurationName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Lists all the rule collections in a security admin configuration, in a paginated format.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    options?: AdminRuleCollectionsListOptionalParams
  ): Promise<AdminRuleCollectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, configurationName, options },
      listOperationSpec
    );
  }

  /**
   * Gets a network manager security admin configuration rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsGetOptionalParams
  ): Promise<AdminRuleCollectionsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleCollection The Rule Collection to create or update
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleCollection: AdminRuleCollection,
    options?: AdminRuleCollectionsCreateOrUpdateOptionalParams
  ): Promise<AdminRuleCollectionsCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
        ruleCollection,
        options
      },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Deletes an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsDeleteOptionalParams
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
        networkManagerName,
        configurationName,
        ruleCollectionName,
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
   * Deletes an admin rule collection.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRuleCollectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkManagerName,
      configurationName,
      ruleCollectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    nextLink: string,
    options?: AdminRuleCollectionsListNextOptionalParams
  ): Promise<AdminRuleCollectionsListNextResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        nextLink,
        options
      },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleCollectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.configurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleCollection
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
    Parameters.networkManagerName,
    Parameters.configurationName,
    Parameters.ruleCollectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleCollection
    },
    201: {
      bodyMapper: Mappers.AdminRuleCollection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.ruleCollection,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.configurationName,
    Parameters.ruleCollectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}",
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
  queryParameters: [Parameters.apiVersion, Parameters.force],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.configurationName,
    Parameters.ruleCollectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleCollectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.networkManagerName,
    Parameters.configurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
