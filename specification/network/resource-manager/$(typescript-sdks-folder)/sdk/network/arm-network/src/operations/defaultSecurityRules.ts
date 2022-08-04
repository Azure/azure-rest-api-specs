import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { DefaultSecurityRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  SecurityRule,
  DefaultSecurityRulesListNextOptionalParams,
  DefaultSecurityRulesListOptionalParams,
  DefaultSecurityRulesListResponse,
  DefaultSecurityRulesGetOptionalParams,
  DefaultSecurityRulesGetResponse,
  DefaultSecurityRulesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing DefaultSecurityRules operations. */
export class DefaultSecurityRulesImpl implements DefaultSecurityRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class DefaultSecurityRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all default security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: DefaultSecurityRulesListOptionalParams
  ): PagedAsyncIterableIterator<SecurityRule> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkSecurityGroupName,
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
          networkSecurityGroupName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: DefaultSecurityRulesListOptionalParams
  ): AsyncIterableIterator<SecurityRule[]> {
    let result = await this._list(
      resourceGroupName,
      networkSecurityGroupName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkSecurityGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: DefaultSecurityRulesListOptionalParams
  ): AsyncIterableIterator<SecurityRule> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkSecurityGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all default security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: DefaultSecurityRulesListOptionalParams
  ): Promise<DefaultSecurityRulesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Get the specified default network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param defaultSecurityRuleName The name of the default security rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    defaultSecurityRuleName: string,
    options?: DefaultSecurityRulesGetOptionalParams
  ): Promise<DefaultSecurityRulesGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkSecurityGroupName,
        defaultSecurityRuleName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    nextLink: string,
    options?: DefaultSecurityRulesListNextOptionalParams
  ): Promise<DefaultSecurityRulesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityRuleListResult
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
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules/{defaultSecurityRuleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityRule
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
    Parameters.networkSecurityGroupName,
    Parameters.defaultSecurityRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityRuleListResult
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
    Parameters.networkSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
