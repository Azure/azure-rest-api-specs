import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { WebApplicationFirewallPolicies } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  WebApplicationFirewallPolicy,
  WebApplicationFirewallPoliciesListNextOptionalParams,
  WebApplicationFirewallPoliciesListOptionalParams,
  WebApplicationFirewallPoliciesListAllNextOptionalParams,
  WebApplicationFirewallPoliciesListAllOptionalParams,
  WebApplicationFirewallPoliciesListResponse,
  WebApplicationFirewallPoliciesListAllResponse,
  WebApplicationFirewallPoliciesGetOptionalParams,
  WebApplicationFirewallPoliciesGetResponse,
  WebApplicationFirewallPoliciesCreateOrUpdateOptionalParams,
  WebApplicationFirewallPoliciesCreateOrUpdateResponse,
  WebApplicationFirewallPoliciesDeleteOptionalParams,
  WebApplicationFirewallPoliciesListNextResponse,
  WebApplicationFirewallPoliciesListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing WebApplicationFirewallPolicies operations. */
export class WebApplicationFirewallPoliciesImpl
  implements WebApplicationFirewallPolicies {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class WebApplicationFirewallPolicies class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all of the protection policies within a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: WebApplicationFirewallPoliciesListOptionalParams
  ): PagedAsyncIterableIterator<WebApplicationFirewallPolicy> {
    const iter = this.listPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    options?: WebApplicationFirewallPoliciesListOptionalParams
  ): AsyncIterableIterator<WebApplicationFirewallPolicy[]> {
    let result = await this._list(resourceGroupName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    options?: WebApplicationFirewallPoliciesListOptionalParams
  ): AsyncIterableIterator<WebApplicationFirewallPolicy> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all the WAF policies in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: WebApplicationFirewallPoliciesListAllOptionalParams
  ): PagedAsyncIterableIterator<WebApplicationFirewallPolicy> {
    const iter = this.listAllPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listAllPagingPage(options);
      }
    };
  }

  private async *listAllPagingPage(
    options?: WebApplicationFirewallPoliciesListAllOptionalParams
  ): AsyncIterableIterator<WebApplicationFirewallPolicy[]> {
    let result = await this._listAll(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAllNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAllPagingAll(
    options?: WebApplicationFirewallPoliciesListAllOptionalParams
  ): AsyncIterableIterator<WebApplicationFirewallPolicy> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Lists all of the protection policies within a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: WebApplicationFirewallPoliciesListOptionalParams
  ): Promise<WebApplicationFirewallPoliciesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all the WAF policies in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: WebApplicationFirewallPoliciesListAllOptionalParams
  ): Promise<WebApplicationFirewallPoliciesListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Retrieve protection policy with specified name within a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param policyName The name of the policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    policyName: string,
    options?: WebApplicationFirewallPoliciesGetOptionalParams
  ): Promise<WebApplicationFirewallPoliciesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, policyName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or update policy with specified rule set name within a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param policyName The name of the policy.
   * @param parameters Policy to be created.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    policyName: string,
    parameters: WebApplicationFirewallPolicy,
    options?: WebApplicationFirewallPoliciesCreateOrUpdateOptionalParams
  ): Promise<WebApplicationFirewallPoliciesCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, policyName, parameters, options },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Deletes Policy.
   * @param resourceGroupName The name of the resource group.
   * @param policyName The name of the policy.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    policyName: string,
    options?: WebApplicationFirewallPoliciesDeleteOptionalParams
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
      { resourceGroupName, policyName, options },
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
   * Deletes Policy.
   * @param resourceGroupName The name of the resource group.
   * @param policyName The name of the policy.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    policyName: string,
    options?: WebApplicationFirewallPoliciesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      policyName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    nextLink: string,
    options?: WebApplicationFirewallPoliciesListNextOptionalParams
  ): Promise<WebApplicationFirewallPoliciesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: WebApplicationFirewallPoliciesListAllNextOptionalParams
  ): Promise<WebApplicationFirewallPoliciesListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicyListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicyListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/{policyName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicy
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
    Parameters.policyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/{policyName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicy
    },
    201: {
      bodyMapper: Mappers.WebApplicationFirewallPolicy
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters87,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.policyName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/{policyName}",
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
    Parameters.policyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicyListResult
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
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.WebApplicationFirewallPolicyListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
