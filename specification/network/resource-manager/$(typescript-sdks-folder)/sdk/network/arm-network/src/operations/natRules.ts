import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NatRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VpnGatewayNatRule,
  NatRulesListByVpnGatewayNextOptionalParams,
  NatRulesListByVpnGatewayOptionalParams,
  NatRulesGetOptionalParams,
  NatRulesGetResponse,
  NatRulesCreateOrUpdateOptionalParams,
  NatRulesCreateOrUpdateResponse,
  NatRulesDeleteOptionalParams,
  NatRulesListByVpnGatewayResponse,
  NatRulesListByVpnGatewayNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NatRules operations. */
export class NatRulesImpl implements NatRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NatRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all nat rules for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  public listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: NatRulesListByVpnGatewayOptionalParams
  ): PagedAsyncIterableIterator<VpnGatewayNatRule> {
    const iter = this.listByVpnGatewayPagingAll(
      resourceGroupName,
      gatewayName,
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
        return this.listByVpnGatewayPagingPage(
          resourceGroupName,
          gatewayName,
          options
        );
      }
    };
  }

  private async *listByVpnGatewayPagingPage(
    resourceGroupName: string,
    gatewayName: string,
    options?: NatRulesListByVpnGatewayOptionalParams
  ): AsyncIterableIterator<VpnGatewayNatRule[]> {
    let result = await this._listByVpnGateway(
      resourceGroupName,
      gatewayName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByVpnGatewayNext(
        resourceGroupName,
        gatewayName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByVpnGatewayPagingAll(
    resourceGroupName: string,
    gatewayName: string,
    options?: NatRulesListByVpnGatewayOptionalParams
  ): AsyncIterableIterator<VpnGatewayNatRule> {
    for await (const page of this.listByVpnGatewayPagingPage(
      resourceGroupName,
      gatewayName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a nat ruleGet.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesGetOptionalParams
  ): Promise<NatRulesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, natRuleName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat
   * rules.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    natRuleParameters: VpnGatewayNatRule,
    options?: NatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NatRulesCreateOrUpdateResponse>,
      NatRulesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NatRulesCreateOrUpdateResponse> => {
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
        gatewayName,
        natRuleName,
        natRuleParameters,
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
   * Creates a nat rule to a scalable vpn gateway if it doesn't exist else updates the existing nat
   * rules.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    natRuleParameters: VpnGatewayNatRule,
    options?: NatRulesCreateOrUpdateOptionalParams
  ): Promise<NatRulesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      gatewayName,
      natRuleName,
      natRuleParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesDeleteOptionalParams
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
      { resourceGroupName, gatewayName, natRuleName, options },
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
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    natRuleName: string,
    options?: NatRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      gatewayName,
      natRuleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves all nat rules for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  private _listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: NatRulesListByVpnGatewayOptionalParams
  ): Promise<NatRulesListByVpnGatewayResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, options },
      listByVpnGatewayOperationSpec
    );
  }

  /**
   * ListByVpnGatewayNext
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param nextLink The nextLink from the previous successful call to the ListByVpnGateway method.
   * @param options The options parameters.
   */
  private _listByVpnGatewayNext(
    resourceGroupName: string,
    gatewayName: string,
    nextLink: string,
    options?: NatRulesListByVpnGatewayNextOptionalParams
  ): Promise<NatRulesListByVpnGatewayNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, nextLink, options },
      listByVpnGatewayNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnGatewayNatRule
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
    Parameters.natRuleName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VpnGatewayNatRule
    },
    201: {
      bodyMapper: Mappers.VpnGatewayNatRule
    },
    202: {
      bodyMapper: Mappers.VpnGatewayNatRule
    },
    204: {
      bodyMapper: Mappers.VpnGatewayNatRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.natRuleParameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.natRuleName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/natRules/{natRuleName}",
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
    Parameters.natRuleName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnGatewayOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/natRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnGatewayNatRulesResult
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
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnGatewayNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnGatewayNatRulesResult
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
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
