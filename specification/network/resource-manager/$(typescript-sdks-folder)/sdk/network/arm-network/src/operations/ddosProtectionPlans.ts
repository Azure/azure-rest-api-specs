import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { DdosProtectionPlans } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  DdosProtectionPlan,
  DdosProtectionPlansListNextOptionalParams,
  DdosProtectionPlansListOptionalParams,
  DdosProtectionPlansListByResourceGroupNextOptionalParams,
  DdosProtectionPlansListByResourceGroupOptionalParams,
  DdosProtectionPlansDeleteOptionalParams,
  DdosProtectionPlansGetOptionalParams,
  DdosProtectionPlansGetResponse,
  DdosProtectionPlansCreateOrUpdateOptionalParams,
  DdosProtectionPlansCreateOrUpdateResponse,
  TagsObject,
  DdosProtectionPlansUpdateTagsOptionalParams,
  DdosProtectionPlansUpdateTagsResponse,
  DdosProtectionPlansListResponse,
  DdosProtectionPlansListByResourceGroupResponse,
  DdosProtectionPlansListNextResponse,
  DdosProtectionPlansListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing DdosProtectionPlans operations. */
export class DdosProtectionPlansImpl implements DdosProtectionPlans {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class DdosProtectionPlans class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all DDoS protection plans in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: DdosProtectionPlansListOptionalParams
  ): PagedAsyncIterableIterator<DdosProtectionPlan> {
    const iter = this.listPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(options);
      }
    };
  }

  private async *listPagingPage(
    options?: DdosProtectionPlansListOptionalParams
  ): AsyncIterableIterator<DdosProtectionPlan[]> {
    let result = await this._list(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    options?: DdosProtectionPlansListOptionalParams
  ): AsyncIterableIterator<DdosProtectionPlan> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all the DDoS protection plans in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: DdosProtectionPlansListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<DdosProtectionPlan> {
    const iter = this.listByResourceGroupPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listByResourceGroupPagingPage(resourceGroupName, options);
      }
    };
  }

  private async *listByResourceGroupPagingPage(
    resourceGroupName: string,
    options?: DdosProtectionPlansListByResourceGroupOptionalParams
  ): AsyncIterableIterator<DdosProtectionPlan[]> {
    let result = await this._listByResourceGroup(resourceGroupName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByResourceGroupPagingAll(
    resourceGroupName: string,
    options?: DdosProtectionPlansListByResourceGroupOptionalParams
  ): AsyncIterableIterator<DdosProtectionPlan> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansDeleteOptionalParams
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
      { resourceGroupName, ddosProtectionPlanName, options },
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
   * Deletes the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      ddosProtectionPlanName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets information about the specified DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    options?: DdosProtectionPlansGetOptionalParams
  ): Promise<DdosProtectionPlansGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ddosProtectionPlanName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: DdosProtectionPlan,
    options?: DdosProtectionPlansCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<DdosProtectionPlansCreateOrUpdateResponse>,
      DdosProtectionPlansCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<DdosProtectionPlansCreateOrUpdateResponse> => {
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
      { resourceGroupName, ddosProtectionPlanName, parameters, options },
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
   * Creates or updates a DDoS protection plan.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: DdosProtectionPlan,
    options?: DdosProtectionPlansCreateOrUpdateOptionalParams
  ): Promise<DdosProtectionPlansCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      ddosProtectionPlanName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Update a DDoS protection plan tags.
   * @param resourceGroupName The name of the resource group.
   * @param ddosProtectionPlanName The name of the DDoS protection plan.
   * @param parameters Parameters supplied to the update DDoS protection plan resource tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ddosProtectionPlanName: string,
    parameters: TagsObject,
    options?: DdosProtectionPlansUpdateTagsOptionalParams
  ): Promise<DdosProtectionPlansUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ddosProtectionPlanName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all DDoS protection plans in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: DdosProtectionPlansListOptionalParams
  ): Promise<DdosProtectionPlansListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Gets all the DDoS protection plans in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: DdosProtectionPlansListByResourceGroupOptionalParams
  ): Promise<DdosProtectionPlansListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: DdosProtectionPlansListNextOptionalParams
  ): Promise<DdosProtectionPlansListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    nextLink: string,
    options?: DdosProtectionPlansListByResourceGroupNextOptionalParams
  ): Promise<DdosProtectionPlansListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}",
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
    Parameters.ddosProtectionPlanName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlan
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
    Parameters.ddosProtectionPlanName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlan
    },
    201: {
      bodyMapper: Mappers.DdosProtectionPlan
    },
    202: {
      bodyMapper: Mappers.DdosProtectionPlan
    },
    204: {
      bodyMapper: Mappers.DdosProtectionPlan
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters12,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ddosProtectionPlanName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlan
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ddosProtectionPlanName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/ddosProtectionPlans",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlanListResult
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
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosProtectionPlans",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlanListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlanListResult
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
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosProtectionPlanListResult
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
