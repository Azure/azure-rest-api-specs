import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { LoadBalancerOutboundRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  OutboundRule,
  LoadBalancerOutboundRulesListNextOptionalParams,
  LoadBalancerOutboundRulesListOptionalParams,
  LoadBalancerOutboundRulesListResponse,
  LoadBalancerOutboundRulesGetOptionalParams,
  LoadBalancerOutboundRulesGetResponse,
  LoadBalancerOutboundRulesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing LoadBalancerOutboundRules operations. */
export class LoadBalancerOutboundRulesImpl
  implements LoadBalancerOutboundRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class LoadBalancerOutboundRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the outbound rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancerOutboundRulesListOptionalParams
  ): PagedAsyncIterableIterator<OutboundRule> {
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
    options?: LoadBalancerOutboundRulesListOptionalParams
  ): AsyncIterableIterator<OutboundRule[]> {
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
    options?: LoadBalancerOutboundRulesListOptionalParams
  ): AsyncIterableIterator<OutboundRule> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      loadBalancerName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all the outbound rules in a load balancer.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    loadBalancerName: string,
    options?: LoadBalancerOutboundRulesListOptionalParams
  ): Promise<LoadBalancerOutboundRulesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, loadBalancerName, options },
      listOperationSpec
    );
  }

  /**
   * Gets the specified load balancer outbound rule.
   * @param resourceGroupName The name of the resource group.
   * @param loadBalancerName The name of the load balancer.
   * @param outboundRuleName The name of the outbound rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    loadBalancerName: string,
    outboundRuleName: string,
    options?: LoadBalancerOutboundRulesGetOptionalParams
  ): Promise<LoadBalancerOutboundRulesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, loadBalancerName, outboundRuleName, options },
      getOperationSpec
    );
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
    options?: LoadBalancerOutboundRulesListNextOptionalParams
  ): Promise<LoadBalancerOutboundRulesListNextResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LoadBalancerOutboundRuleListResult
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
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.OutboundRule
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
    Parameters.loadBalancerName,
    Parameters.outboundRuleName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.LoadBalancerOutboundRuleListResult
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
