import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { RouteFilterRules } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  RouteFilterRule,
  RouteFilterRulesListByRouteFilterNextOptionalParams,
  RouteFilterRulesListByRouteFilterOptionalParams,
  RouteFilterRulesDeleteOptionalParams,
  RouteFilterRulesGetOptionalParams,
  RouteFilterRulesGetResponse,
  RouteFilterRulesCreateOrUpdateOptionalParams,
  RouteFilterRulesCreateOrUpdateResponse,
  RouteFilterRulesListByRouteFilterResponse,
  RouteFilterRulesListByRouteFilterNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing RouteFilterRules operations. */
export class RouteFilterRulesImpl implements RouteFilterRules {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class RouteFilterRules class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all RouteFilterRules in a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  public listByRouteFilter(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFilterRulesListByRouteFilterOptionalParams
  ): PagedAsyncIterableIterator<RouteFilterRule> {
    const iter = this.listByRouteFilterPagingAll(
      resourceGroupName,
      routeFilterName,
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
        return this.listByRouteFilterPagingPage(
          resourceGroupName,
          routeFilterName,
          options
        );
      }
    };
  }

  private async *listByRouteFilterPagingPage(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFilterRulesListByRouteFilterOptionalParams
  ): AsyncIterableIterator<RouteFilterRule[]> {
    let result = await this._listByRouteFilter(
      resourceGroupName,
      routeFilterName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByRouteFilterNext(
        resourceGroupName,
        routeFilterName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByRouteFilterPagingAll(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFilterRulesListByRouteFilterOptionalParams
  ): AsyncIterableIterator<RouteFilterRule> {
    for await (const page of this.listByRouteFilterPagingPage(
      resourceGroupName,
      routeFilterName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesDeleteOptionalParams
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
      { resourceGroupName, routeFilterName, ruleName, options },
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
   * Deletes the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      routeFilterName,
      ruleName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified rule from a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the rule.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    options?: RouteFilterRulesGetOptionalParams
  ): Promise<RouteFilterRulesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeFilterName, ruleName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a route in the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the route filter rule.
   * @param routeFilterRuleParameters Parameters supplied to the create or update route filter rule
   *                                  operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    routeFilterRuleParameters: RouteFilterRule,
    options?: RouteFilterRulesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<RouteFilterRulesCreateOrUpdateResponse>,
      RouteFilterRulesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<RouteFilterRulesCreateOrUpdateResponse> => {
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
        routeFilterName,
        ruleName,
        routeFilterRuleParameters,
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
   * Creates or updates a route in the specified route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param ruleName The name of the route filter rule.
   * @param routeFilterRuleParameters Parameters supplied to the create or update route filter rule
   *                                  operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    routeFilterName: string,
    ruleName: string,
    routeFilterRuleParameters: RouteFilterRule,
    options?: RouteFilterRulesCreateOrUpdateOptionalParams
  ): Promise<RouteFilterRulesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      routeFilterName,
      ruleName,
      routeFilterRuleParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all RouteFilterRules in a route filter.
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param options The options parameters.
   */
  private _listByRouteFilter(
    resourceGroupName: string,
    routeFilterName: string,
    options?: RouteFilterRulesListByRouteFilterOptionalParams
  ): Promise<RouteFilterRulesListByRouteFilterResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeFilterName, options },
      listByRouteFilterOperationSpec
    );
  }

  /**
   * ListByRouteFilterNext
   * @param resourceGroupName The name of the resource group.
   * @param routeFilterName The name of the route filter.
   * @param nextLink The nextLink from the previous successful call to the ListByRouteFilter method.
   * @param options The options parameters.
   */
  private _listByRouteFilterNext(
    resourceGroupName: string,
    routeFilterName: string,
    nextLink: string,
    options?: RouteFilterRulesListByRouteFilterNextOptionalParams
  ): Promise<RouteFilterRulesListByRouteFilterNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, routeFilterName, nextLink, options },
      listByRouteFilterNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}",
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
    Parameters.ruleName,
    Parameters.routeFilterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteFilterRule
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
    Parameters.ruleName,
    Parameters.routeFilterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.RouteFilterRule
    },
    201: {
      bodyMapper: Mappers.RouteFilterRule
    },
    202: {
      bodyMapper: Mappers.RouteFilterRule
    },
    204: {
      bodyMapper: Mappers.RouteFilterRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.routeFilterRuleParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ruleName,
    Parameters.routeFilterName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listByRouteFilterOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteFilterRuleListResult
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
    Parameters.routeFilterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByRouteFilterNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.RouteFilterRuleListResult
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
    Parameters.routeFilterName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
