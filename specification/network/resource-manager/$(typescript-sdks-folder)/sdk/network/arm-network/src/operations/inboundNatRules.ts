import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { InboundNatRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  InboundNatRule,
  InboundNatRulesListNextOptionalParams,
  InboundNatRulesListOptionalParams,
  InboundNatRulesListResponse,
  InboundNatRulesDeleteOptionalParams,
  InboundNatRulesGetOptionalParams,
  InboundNatRulesGetResponse,
  InboundNatRulesCreateOrUpdateOptionalParams,
  InboundNatRulesCreateOrUpdateResponse,
  InboundNatRulesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing InboundNatRules operations. */
export class InboundNatRulesImpl implements InboundNatRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class InboundNatRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the inbound NAT rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: InboundNatRulesListOptionalParams
  ): PagedAsyncIterableIterator<InboundNatRule> {
    const iter = this.listPagingAll(
      resourceGroupName,
      loadBalancerName,
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
          loadBalancerName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: InboundNatRulesListOptionalParams
  ): AsyncIterableIterator<InboundNatRule[]> {
    let result = await this._list(resourceGroupName, loadBalancerName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        loadBalancerName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: InboundNatRulesListOptionalParams
  ): AsyncIterableIterator<InboundNatRule> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      loadBalancerName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all the inbound NAT rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: InboundNatRulesListOptionalParams
  ): Promise<InboundNatRulesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, loadBalancerName, options },
      listOperationSpec
    );
  }

  /**
   * Deletes the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesDeleteOptionalParams
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
      { resourceGroupName, loadBalancerName, inboundNatRuleName, options },
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
   * Deletes the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      loadBalancerName,
      inboundNatRuleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    options?: InboundNatRulesGetOptionalParams
  ): Promise<InboundNatRulesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, loadBalancerName, inboundNatRuleName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param inboundNatRuleParameters Parameters supplied to the create or update inbound NAT rule
   *                                 operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    inboundNatRuleParameters: InboundNatRule,
    options?: InboundNatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<InboundNatRulesCreateOrUpdateResponse>,
      InboundNatRulesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<InboundNatRulesCreateOrUpdateResponse> => {
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
        loadBalancerName,
        inboundNatRuleName,
        inboundNatRuleParameters,
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
   * Creates or updates a load balancer inbound NAT rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param inboundNatRuleName The name of the inbound NAT rule.
   * @param inboundNatRuleParameters Parameters supplied to the create or update inbound NAT rule
   *                                 operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    loadBalancerName: string,
    inboundNatRuleName: string,
    inboundNatRuleParameters: InboundNatRule,
    options?: InboundNatRulesCreateOrUpdateOptionalParams
  ): Promise<InboundNatRulesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      loadBalancerName,
      inboundNatRuleName,
      inboundNatRuleParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    loadBalancerName: string,
    nextLink: string,
    options?: InboundNatRulesListNextOptionalParams
  ): Promise<InboundNatRulesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, loadBalancerName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.InboundNatRuleListResult
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
    Parameters.loadBalancerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}",
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
    Parameters.loadBalancerName,
    Parameters.inboundNatRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.InboundNatRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.loadBalancerName,
    Parameters.inboundNatRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.InboundNatRule
    },
    201: {
      bodyMapper: Mappers.InboundNatRule
    },
    202: {
      bodyMapper: Mappers.InboundNatRule
    },
    204: {
      bodyMapper: Mappers.InboundNatRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.inboundNatRuleParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.loadBalancerName,
    Parameters.inboundNatRuleName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.InboundNatRuleListResult
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
    Parameters.loadBalancerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
