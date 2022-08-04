import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworkGatewayNatRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetworkGatewayNatRule,
  VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextOptionalParams,
  VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams,
  VirtualNetworkGatewayNatRulesGetOptionalParams,
  VirtualNetworkGatewayNatRulesGetResponse,
  VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams,
  VirtualNetworkGatewayNatRulesCreateOrUpdateResponse,
  VirtualNetworkGatewayNatRulesDeleteOptionalParams,
  VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayResponse,
  VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworkGatewayNatRules operations. */
export class VirtualNetworkGatewayNatRulesImpl
  implements VirtualNetworkGatewayNatRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworkGatewayNatRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all nat rules for a particular virtual network gateway.
   * @param resourceGroupName The resource group name of the virtual network gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param options The options parameters.
   */
  public listByVirtualNetworkGateway(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayNatRule> {
    const iter = this.listByVirtualNetworkGatewayPagingAll(
      resourceGroupName,
      virtualNetworkGatewayName,
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
        return this.listByVirtualNetworkGatewayPagingPage(
          resourceGroupName,
          virtualNetworkGatewayName,
          options
        );
      }
    };
  }

  private async *listByVirtualNetworkGatewayPagingPage(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayNatRule[]> {
    let result = await this._listByVirtualNetworkGateway(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByVirtualNetworkGatewayNext(
        resourceGroupName,
        virtualNetworkGatewayName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByVirtualNetworkGatewayPagingAll(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayNatRule> {
    for await (const page of this.listByVirtualNetworkGatewayPagingPage(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a nat rule.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesGetOptionalParams
  ): Promise<VirtualNetworkGatewayNatRulesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, natRuleName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the
   * existing nat rules.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    natRuleParameters: VirtualNetworkGatewayNatRule,
    options?: VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayNatRulesCreateOrUpdateResponse>,
      VirtualNetworkGatewayNatRulesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayNatRulesCreateOrUpdateResponse> => {
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
        virtualNetworkGatewayName,
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
   * Creates a nat rule to a scalable virtual network gateway if it doesn't exist else updates the
   * existing nat rules.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param natRuleParameters Parameters supplied to create or Update a Nat Rule.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    natRuleParameters: VirtualNetworkGatewayNatRule,
    options?: VirtualNetworkGatewayNatRulesCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewayNatRulesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkGatewayName,
      natRuleName,
      natRuleParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a nat rule.
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesDeleteOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayName, natRuleName, options },
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
   * @param resourceGroupName The resource group name of the Virtual Network Gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param natRuleName The name of the nat rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    natRuleName: string,
    options?: VirtualNetworkGatewayNatRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkGatewayName,
      natRuleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves all nat rules for a particular virtual network gateway.
   * @param resourceGroupName The resource group name of the virtual network gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param options The options parameters.
   */
  private _listByVirtualNetworkGateway(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayOptionalParams
  ): Promise<VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, options },
      listByVirtualNetworkGatewayOperationSpec
    );
  }

  /**
   * ListByVirtualNetworkGatewayNext
   * @param resourceGroupName The resource group name of the virtual network gateway.
   * @param virtualNetworkGatewayName The name of the gateway.
   * @param nextLink The nextLink from the previous successful call to the ListByVirtualNetworkGateway
   *                 method.
   * @param options The options parameters.
   */
  private _listByVirtualNetworkGatewayNext(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    nextLink: string,
    options?: VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextOptionalParams
  ): Promise<
    VirtualNetworkGatewayNatRulesListByVirtualNetworkGatewayNextResponse
  > {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, nextLink, options },
      listByVirtualNetworkGatewayNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayNatRule
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
    Parameters.virtualNetworkGatewayName,
    Parameters.natRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayNatRule
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGatewayNatRule
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGatewayNatRule
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGatewayNatRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.natRuleParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName,
    Parameters.natRuleName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules/{natRuleName}",
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
    Parameters.virtualNetworkGatewayName,
    Parameters.natRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVirtualNetworkGatewayOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/natRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualNetworkGatewayNatRulesResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVirtualNetworkGatewayNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVirtualNetworkGatewayNatRulesResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
