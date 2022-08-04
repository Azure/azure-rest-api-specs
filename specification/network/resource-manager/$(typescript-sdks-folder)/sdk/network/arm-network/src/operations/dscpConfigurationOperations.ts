import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { DscpConfigurationOperations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  DscpConfiguration,
  DscpConfigurationListNextOptionalParams,
  DscpConfigurationListOptionalParams,
  DscpConfigurationListAllNextOptionalParams,
  DscpConfigurationListAllOptionalParams,
  DscpConfigurationCreateOrUpdateOptionalParams,
  DscpConfigurationCreateOrUpdateResponse,
  DscpConfigurationDeleteOptionalParams,
  DscpConfigurationGetOptionalParams,
  DscpConfigurationGetResponse,
  DscpConfigurationListResponse,
  DscpConfigurationListAllResponse,
  DscpConfigurationListNextResponse,
  DscpConfigurationListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing DscpConfigurationOperations operations. */
export class DscpConfigurationOperationsImpl
  implements DscpConfigurationOperations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class DscpConfigurationOperations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: DscpConfigurationListOptionalParams
  ): PagedAsyncIterableIterator<DscpConfiguration> {
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
    options?: DscpConfigurationListOptionalParams
  ): AsyncIterableIterator<DscpConfiguration[]> {
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
    options?: DscpConfigurationListOptionalParams
  ): AsyncIterableIterator<DscpConfiguration> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all dscp configurations in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: DscpConfigurationListAllOptionalParams
  ): PagedAsyncIterableIterator<DscpConfiguration> {
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
    options?: DscpConfigurationListAllOptionalParams
  ): AsyncIterableIterator<DscpConfiguration[]> {
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
    options?: DscpConfigurationListAllOptionalParams
  ): AsyncIterableIterator<DscpConfiguration> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Creates or updates a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param dscpConfigurationName The name of the resource.
   * @param parameters Parameters supplied to the create or update dscp configuration operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    dscpConfigurationName: string,
    parameters: DscpConfiguration,
    options?: DscpConfigurationCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<DscpConfigurationCreateOrUpdateResponse>,
      DscpConfigurationCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<DscpConfigurationCreateOrUpdateResponse> => {
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
      { resourceGroupName, dscpConfigurationName, parameters, options },
      createOrUpdateOperationSpec
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
   * Creates or updates a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param dscpConfigurationName The name of the resource.
   * @param parameters Parameters supplied to the create or update dscp configuration operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    dscpConfigurationName: string,
    parameters: DscpConfiguration,
    options?: DscpConfigurationCreateOrUpdateOptionalParams
  ): Promise<DscpConfigurationCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      dscpConfigurationName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param dscpConfigurationName The name of the resource.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    dscpConfigurationName: string,
    options?: DscpConfigurationDeleteOptionalParams
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
      { resourceGroupName, dscpConfigurationName, options },
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
   * Deletes a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param dscpConfigurationName The name of the resource.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    dscpConfigurationName: string,
    options?: DscpConfigurationDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      dscpConfigurationName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param dscpConfigurationName The name of the resource.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    dscpConfigurationName: string,
    options?: DscpConfigurationGetOptionalParams
  ): Promise<DscpConfigurationGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, dscpConfigurationName, options },
      getOperationSpec
    );
  }

  /**
   * Gets a DSCP Configuration.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: DscpConfigurationListOptionalParams
  ): Promise<DscpConfigurationListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all dscp configurations in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: DscpConfigurationListAllOptionalParams
  ): Promise<DscpConfigurationListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
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
    options?: DscpConfigurationListNextOptionalParams
  ): Promise<DscpConfigurationListNextResponse> {
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
    options?: DscpConfigurationListAllNextOptionalParams
  ): Promise<DscpConfigurationListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dscpConfigurations/{dscpConfigurationName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.DscpConfiguration
    },
    201: {
      bodyMapper: Mappers.DscpConfiguration
    },
    202: {
      bodyMapper: Mappers.DscpConfiguration
    },
    204: {
      bodyMapper: Mappers.DscpConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters13,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.dscpConfigurationName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dscpConfigurations/{dscpConfigurationName}",
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
    Parameters.dscpConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dscpConfigurations/{dscpConfigurationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DscpConfiguration
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
    Parameters.dscpConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dscpConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DscpConfigurationListResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/dscpConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DscpConfigurationListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DscpConfigurationListResult
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
      bodyMapper: Mappers.DscpConfigurationListResult
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
