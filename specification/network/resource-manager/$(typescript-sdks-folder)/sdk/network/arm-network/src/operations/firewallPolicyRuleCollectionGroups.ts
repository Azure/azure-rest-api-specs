import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { FirewallPolicyRuleCollectionGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  FirewallPolicyRuleCollectionGroup,
  FirewallPolicyRuleCollectionGroupsListNextOptionalParams,
  FirewallPolicyRuleCollectionGroupsListOptionalParams,
  FirewallPolicyRuleCollectionGroupsDeleteOptionalParams,
  FirewallPolicyRuleCollectionGroupsGetOptionalParams,
  FirewallPolicyRuleCollectionGroupsGetResponse,
  FirewallPolicyRuleCollectionGroupsCreateOrUpdateOptionalParams,
  FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse,
  FirewallPolicyRuleCollectionGroupsListResponse,
  FirewallPolicyRuleCollectionGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing FirewallPolicyRuleCollectionGroups operations. */
export class FirewallPolicyRuleCollectionGroupsImpl
  implements FirewallPolicyRuleCollectionGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class FirewallPolicyRuleCollectionGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all FirewallPolicyRuleCollectionGroups in a FirewallPolicy resource.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyRuleCollectionGroupsListOptionalParams
  ): PagedAsyncIterableIterator<FirewallPolicyRuleCollectionGroup> {
    const iter = this.listPagingAll(
      resourceGroupName,
      firewallPolicyName,
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
          firewallPolicyName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyRuleCollectionGroupsListOptionalParams
  ): AsyncIterableIterator<FirewallPolicyRuleCollectionGroup[]> {
    let result = await this._list(
      resourceGroupName,
      firewallPolicyName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        firewallPolicyName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyRuleCollectionGroupsListOptionalParams
  ): AsyncIterableIterator<FirewallPolicyRuleCollectionGroup> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      firewallPolicyName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified FirewallPolicyRuleCollectionGroup.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param ruleCollectionGroupName The name of the FirewallPolicyRuleCollectionGroup.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    firewallPolicyName: string,
    ruleCollectionGroupName: string,
    options?: FirewallPolicyRuleCollectionGroupsDeleteOptionalParams
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
        firewallPolicyName,
        ruleCollectionGroupName,
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
   * Deletes the specified FirewallPolicyRuleCollectionGroup.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param ruleCollectionGroupName The name of the FirewallPolicyRuleCollectionGroup.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    firewallPolicyName: string,
    ruleCollectionGroupName: string,
    options?: FirewallPolicyRuleCollectionGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      firewallPolicyName,
      ruleCollectionGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified FirewallPolicyRuleCollectionGroup.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param ruleCollectionGroupName The name of the FirewallPolicyRuleCollectionGroup.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    firewallPolicyName: string,
    ruleCollectionGroupName: string,
    options?: FirewallPolicyRuleCollectionGroupsGetOptionalParams
  ): Promise<FirewallPolicyRuleCollectionGroupsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        firewallPolicyName,
        ruleCollectionGroupName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified FirewallPolicyRuleCollectionGroup.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param ruleCollectionGroupName The name of the FirewallPolicyRuleCollectionGroup.
   * @param parameters Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    firewallPolicyName: string,
    ruleCollectionGroupName: string,
    parameters: FirewallPolicyRuleCollectionGroup,
    options?: FirewallPolicyRuleCollectionGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse
      >,
      FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse> => {
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
        firewallPolicyName,
        ruleCollectionGroupName,
        parameters,
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
   * Creates or updates the specified FirewallPolicyRuleCollectionGroup.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param ruleCollectionGroupName The name of the FirewallPolicyRuleCollectionGroup.
   * @param parameters Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    firewallPolicyName: string,
    ruleCollectionGroupName: string,
    parameters: FirewallPolicyRuleCollectionGroup,
    options?: FirewallPolicyRuleCollectionGroupsCreateOrUpdateOptionalParams
  ): Promise<FirewallPolicyRuleCollectionGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      firewallPolicyName,
      ruleCollectionGroupName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all FirewallPolicyRuleCollectionGroups in a FirewallPolicy resource.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyRuleCollectionGroupsListOptionalParams
  ): Promise<FirewallPolicyRuleCollectionGroupsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    firewallPolicyName: string,
    nextLink: string,
    options?: FirewallPolicyRuleCollectionGroupsListNextOptionalParams
  ): Promise<FirewallPolicyRuleCollectionGroupsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}",
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
    Parameters.firewallPolicyName,
    Parameters.ruleCollectionGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroup
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
    Parameters.firewallPolicyName,
    Parameters.ruleCollectionGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups/{ruleCollectionGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroup
    },
    201: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroup
    },
    202: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroup
    },
    204: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroup
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters18,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.firewallPolicyName,
    Parameters.ruleCollectionGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/ruleCollectionGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroupListResult
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
    Parameters.firewallPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FirewallPolicyRuleCollectionGroupListResult
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
    Parameters.firewallPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
