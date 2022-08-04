import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ApplicationSecurityGroups } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ApplicationSecurityGroup,
  ApplicationSecurityGroupsListAllNextOptionalParams,
  ApplicationSecurityGroupsListAllOptionalParams,
  ApplicationSecurityGroupsListNextOptionalParams,
  ApplicationSecurityGroupsListOptionalParams,
  ApplicationSecurityGroupsDeleteOptionalParams,
  ApplicationSecurityGroupsGetOptionalParams,
  ApplicationSecurityGroupsGetResponse,
  ApplicationSecurityGroupsCreateOrUpdateOptionalParams,
  ApplicationSecurityGroupsCreateOrUpdateResponse,
  TagsObject,
  ApplicationSecurityGroupsUpdateTagsOptionalParams,
  ApplicationSecurityGroupsUpdateTagsResponse,
  ApplicationSecurityGroupsListAllResponse,
  ApplicationSecurityGroupsListResponse,
  ApplicationSecurityGroupsListAllNextResponse,
  ApplicationSecurityGroupsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ApplicationSecurityGroups operations. */
export class ApplicationSecurityGroupsImpl
  implements ApplicationSecurityGroups {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ApplicationSecurityGroups class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all application security groups in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: ApplicationSecurityGroupsListAllOptionalParams
  ): PagedAsyncIterableIterator<ApplicationSecurityGroup> {
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
    options?: ApplicationSecurityGroupsListAllOptionalParams
  ): AsyncIterableIterator<ApplicationSecurityGroup[]> {
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
    options?: ApplicationSecurityGroupsListAllOptionalParams
  ): AsyncIterableIterator<ApplicationSecurityGroup> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all the application security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: ApplicationSecurityGroupsListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationSecurityGroup> {
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
    options?: ApplicationSecurityGroupsListOptionalParams
  ): AsyncIterableIterator<ApplicationSecurityGroup[]> {
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
    options?: ApplicationSecurityGroupsListOptionalParams
  ): AsyncIterableIterator<ApplicationSecurityGroup> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsDeleteOptionalParams
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
      { resourceGroupName, applicationSecurityGroupName, options },
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
   * Deletes the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      applicationSecurityGroupName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets information about the specified application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    options?: ApplicationSecurityGroupsGetOptionalParams
  ): Promise<ApplicationSecurityGroupsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationSecurityGroupName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to the create or update ApplicationSecurityGroup operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: ApplicationSecurityGroup,
    options?: ApplicationSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationSecurityGroupsCreateOrUpdateResponse>,
      ApplicationSecurityGroupsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ApplicationSecurityGroupsCreateOrUpdateResponse> => {
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
      { resourceGroupName, applicationSecurityGroupName, parameters, options },
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
   * Creates or updates an application security group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to the create or update ApplicationSecurityGroup operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: ApplicationSecurityGroup,
    options?: ApplicationSecurityGroupsCreateOrUpdateOptionalParams
  ): Promise<ApplicationSecurityGroupsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      applicationSecurityGroupName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates an application security group's tags.
   * @param resourceGroupName The name of the resource group.
   * @param applicationSecurityGroupName The name of the application security group.
   * @param parameters Parameters supplied to update application security group tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    applicationSecurityGroupName: string,
    parameters: TagsObject,
    options?: ApplicationSecurityGroupsUpdateTagsOptionalParams
  ): Promise<ApplicationSecurityGroupsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationSecurityGroupName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all application security groups in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: ApplicationSecurityGroupsListAllOptionalParams
  ): Promise<ApplicationSecurityGroupsListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all the application security groups in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: ApplicationSecurityGroupsListOptionalParams
  ): Promise<ApplicationSecurityGroupsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: ApplicationSecurityGroupsListAllNextOptionalParams
  ): Promise<ApplicationSecurityGroupsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
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
    options?: ApplicationSecurityGroupsListNextOptionalParams
  ): Promise<ApplicationSecurityGroupsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}",
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
    Parameters.applicationSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroup
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
    Parameters.applicationSecurityGroupName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroup
    },
    201: {
      bodyMapper: Mappers.ApplicationSecurityGroup
    },
    202: {
      bodyMapper: Mappers.ApplicationSecurityGroup
    },
    204: {
      bodyMapper: Mappers.ApplicationSecurityGroup
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters3,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.applicationSecurityGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroup
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
    Parameters.applicationSecurityGroupName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationSecurityGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroupListResult
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
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroupListResult
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
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroupListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationSecurityGroupListResult
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
