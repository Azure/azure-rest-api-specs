import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AdminRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  BaseAdminRuleUnion,
  AdminRulesListNextOptionalParams,
  AdminRulesListOptionalParams,
  AdminRulesListResponse,
  AdminRulesGetOptionalParams,
  AdminRulesGetResponse,
  AdminRulesCreateOrUpdateOptionalParams,
  AdminRulesCreateOrUpdateResponse,
  AdminRulesDeleteOptionalParams,
  AdminRulesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AdminRules operations. */
export class AdminRulesImpl implements AdminRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AdminRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List all network manager security configuration admin rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRulesListOptionalParams
  ): PagedAsyncIterableIterator<BaseAdminRuleUnion> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkManagerName,
      configurationName,
      ruleCollectionName,
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
          ruleCollectionName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRulesListOptionalParams
  ): AsyncIterableIterator<BaseAdminRuleUnion[]> {
    let result = await this._list(
      resourceGroupName,
      networkManagerName,
      configurationName,
      ruleCollectionName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
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
    ruleCollectionName: string,
    options?: AdminRulesListOptionalParams
  ): AsyncIterableIterator<BaseAdminRuleUnion> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkManagerName,
      configurationName,
      ruleCollectionName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * List all network manager security configuration admin rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    options?: AdminRulesListOptionalParams
  ): Promise<AdminRulesListResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
        options
      },
      listOperationSpec
    );
  }

  /**
   * Gets a network manager security configuration admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesGetOptionalParams
  ): Promise<AdminRulesGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
        ruleName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param adminRule The admin rule to create or update
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    adminRule: BaseAdminRuleUnion,
    options?: AdminRulesCreateOrUpdateOptionalParams
  ): Promise<AdminRulesCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
        ruleName,
        adminRule,
        options
      },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Deletes an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesDeleteOptionalParams
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
        ruleName,
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
   * Deletes an admin rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    ruleName: string,
    options?: AdminRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkManagerName,
      configurationName,
      ruleCollectionName,
      ruleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param configurationName The name of the network manager Security Configuration.
   * @param ruleCollectionName The name of the network manager security Configuration rule collection.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkManagerName: string,
    configurationName: string,
    ruleCollectionName: string,
    nextLink: string,
    options?: AdminRulesListNextOptionalParams
  ): Promise<AdminRulesListNextResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        configurationName,
        ruleCollectionName,
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleListResult
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
    Parameters.configurationName,
    Parameters.ruleCollectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BaseAdminRule
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
    Parameters.ruleCollectionName,
    Parameters.ruleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.BaseAdminRule
    },
    201: {
      bodyMapper: Mappers.BaseAdminRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.adminRule,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.configurationName,
    Parameters.ruleCollectionName,
    Parameters.ruleName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}",
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
    Parameters.ruleCollectionName,
    Parameters.ruleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AdminRuleListResult
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
    Parameters.configurationName,
    Parameters.ruleCollectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
