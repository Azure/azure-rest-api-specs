import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { SecurityRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  SecurityRule,
  SecurityRulesListNextOptionalParams,
  SecurityRulesListOptionalParams,
  SecurityRulesDeleteOptionalParams,
  SecurityRulesGetOptionalParams,
  SecurityRulesGetResponse,
  SecurityRulesCreateOrUpdateOptionalParams,
  SecurityRulesCreateOrUpdateResponse,
  SecurityRulesListResponse,
  SecurityRulesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing SecurityRules operations. */
export class SecurityRulesImpl implements SecurityRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class SecurityRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: SecurityRulesListOptionalParams
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
    options?: SecurityRulesListOptionalParams
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
    options?: SecurityRulesListOptionalParams
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
   * Deletes the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesDeleteOptionalParams
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
        networkSecurityGroupName,
        securityRuleName,
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
   * Deletes the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkSecurityGroupName,
      securityRuleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get the specified network security rule.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    options?: SecurityRulesGetOptionalParams
  ): Promise<SecurityRulesGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkSecurityGroupName,
        securityRuleName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a security rule in the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param securityRuleParameters Parameters supplied to the create or update network security rule
   *                               operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    securityRuleParameters: SecurityRule,
    options?: SecurityRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<SecurityRulesCreateOrUpdateResponse>,
      SecurityRulesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<SecurityRulesCreateOrUpdateResponse> => {
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
        networkSecurityGroupName,
        securityRuleName,
        securityRuleParameters,
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
   * Creates or updates a security rule in the specified network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param securityRuleName The name of the security rule.
   * @param securityRuleParameters Parameters supplied to the create or update network security rule
   *                               operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    securityRuleName: string,
    securityRuleParameters: SecurityRule,
    options?: SecurityRulesCreateOrUpdateOptionalParams
  ): Promise<SecurityRulesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkSecurityGroupName,
      securityRuleName,
      securityRuleParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all security rules in a network security group.
   * @param resourceGroupName The name of the resource group.
   * @param networkSecurityGroupName The name of the network security group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkSecurityGroupName: string,
    options?: SecurityRulesListOptionalParams
  ): Promise<SecurityRulesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, options },
      listOperationSpec
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
    options?: SecurityRulesListNextOptionalParams
  ): Promise<SecurityRulesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkSecurityGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}",
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
    Parameters.networkSecurityGroupName,
    Parameters.securityRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}",
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
    Parameters.securityRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityRule
    },
    201: {
      bodyMapper: Mappers.SecurityRule
    },
    202: {
      bodyMapper: Mappers.SecurityRule
    },
    204: {
      bodyMapper: Mappers.SecurityRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.securityRuleParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkSecurityGroupName,
    Parameters.securityRuleName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules",
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
