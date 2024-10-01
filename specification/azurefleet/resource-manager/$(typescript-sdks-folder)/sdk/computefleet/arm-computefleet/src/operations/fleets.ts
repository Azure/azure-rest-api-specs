import { PagedAsyncIterableIterator, PageSettings } from "@azure/core-paging";
import { setContinuationToken } from "../pagingHelper";
import { Fleets } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { MicrosoftAzureFleet } from "../microsoftAzureFleet";
import {
  SimplePollerLike,
  OperationState,
  createHttpPoller,
} from "@azure/core-lro";
import { createLroSpec } from "../lroImpl";
import {
  Fleet,
  FleetsListBySubscriptionNextOptionalParams,
  FleetsListBySubscriptionOptionalParams,
  FleetsListBySubscriptionResponse,
  FleetsListByResourceGroupNextOptionalParams,
  FleetsListByResourceGroupOptionalParams,
  FleetsListByResourceGroupResponse,
  VirtualMachineScaleSet,
  FleetsListVirtualMachineScaleSetsNextOptionalParams,
  FleetsListVirtualMachineScaleSetsOptionalParams,
  FleetsListVirtualMachineScaleSetsResponse,
  FleetsGetOptionalParams,
  FleetsGetResponse,
  FleetsCreateOrUpdateOptionalParams,
  FleetsCreateOrUpdateResponse,
  FleetUpdate,
  FleetsUpdateOptionalParams,
  FleetsUpdateResponse,
  FleetsDeleteOptionalParams,
  FleetsDeleteResponse,
  FleetsListBySubscriptionNextResponse,
  FleetsListByResourceGroupNextResponse,
  FleetsListVirtualMachineScaleSetsNextResponse,
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing Fleets operations. */
export class FleetsImpl implements Fleets {
  private readonly client: MicrosoftAzureFleet;

  /**
   * Initialize a new instance of the class Fleets class.
   * @param client Reference to the service client
   */
  constructor(client: MicrosoftAzureFleet) {
    this.client = client;
  }

  /**
   * List Fleet resources by subscription ID
   * @param options The options parameters.
   */
  public listBySubscription(
    options?: FleetsListBySubscriptionOptionalParams,
  ): PagedAsyncIterableIterator<Fleet> {
    const iter = this.listBySubscriptionPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listBySubscriptionPagingPage(options, settings);
      },
    };
  }

  private async *listBySubscriptionPagingPage(
    options?: FleetsListBySubscriptionOptionalParams,
    settings?: PageSettings,
  ): AsyncIterableIterator<Fleet[]> {
    let result: FleetsListBySubscriptionResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listBySubscription(options);
      let page = result.value || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listBySubscriptionNext(continuationToken, options);
      continuationToken = result.nextLink;
      let page = result.value || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listBySubscriptionPagingAll(
    options?: FleetsListBySubscriptionOptionalParams,
  ): AsyncIterableIterator<Fleet> {
    for await (const page of this.listBySubscriptionPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * List Fleet resources by resource group
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: FleetsListByResourceGroupOptionalParams,
  ): PagedAsyncIterableIterator<Fleet> {
    const iter = this.listByResourceGroupPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listByResourceGroupPagingPage(
          resourceGroupName,
          options,
          settings,
        );
      },
    };
  }

  private async *listByResourceGroupPagingPage(
    resourceGroupName: string,
    options?: FleetsListByResourceGroupOptionalParams,
    settings?: PageSettings,
  ): AsyncIterableIterator<Fleet[]> {
    let result: FleetsListByResourceGroupResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listByResourceGroup(resourceGroupName, options);
      let page = result.value || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        resourceGroupName,
        continuationToken,
        options,
      );
      continuationToken = result.nextLink;
      let page = result.value || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listByResourceGroupPagingAll(
    resourceGroupName: string,
    options?: FleetsListByResourceGroupOptionalParams,
  ): AsyncIterableIterator<Fleet> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options,
    )) {
      yield* page;
    }
  }

  /**
   * List VirtualMachineScaleSet resources by Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param name The name of the Fleet
   * @param options The options parameters.
   */
  public listVirtualMachineScaleSets(
    resourceGroupName: string,
    name: string,
    options?: FleetsListVirtualMachineScaleSetsOptionalParams,
  ): PagedAsyncIterableIterator<VirtualMachineScaleSet> {
    const iter = this.listVirtualMachineScaleSetsPagingAll(
      resourceGroupName,
      name,
      options,
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: (settings?: PageSettings) => {
        if (settings?.maxPageSize) {
          throw new Error("maxPageSize is not supported by this operation.");
        }
        return this.listVirtualMachineScaleSetsPagingPage(
          resourceGroupName,
          name,
          options,
          settings,
        );
      },
    };
  }

  private async *listVirtualMachineScaleSetsPagingPage(
    resourceGroupName: string,
    name: string,
    options?: FleetsListVirtualMachineScaleSetsOptionalParams,
    settings?: PageSettings,
  ): AsyncIterableIterator<VirtualMachineScaleSet[]> {
    let result: FleetsListVirtualMachineScaleSetsResponse;
    let continuationToken = settings?.continuationToken;
    if (!continuationToken) {
      result = await this._listVirtualMachineScaleSets(
        resourceGroupName,
        name,
        options,
      );
      let page = result.value || [];
      continuationToken = result.nextLink;
      setContinuationToken(page, continuationToken);
      yield page;
    }
    while (continuationToken) {
      result = await this._listVirtualMachineScaleSetsNext(
        resourceGroupName,
        name,
        continuationToken,
        options,
      );
      continuationToken = result.nextLink;
      let page = result.value || [];
      setContinuationToken(page, continuationToken);
      yield page;
    }
  }

  private async *listVirtualMachineScaleSetsPagingAll(
    resourceGroupName: string,
    name: string,
    options?: FleetsListVirtualMachineScaleSetsOptionalParams,
  ): AsyncIterableIterator<VirtualMachineScaleSet> {
    for await (const page of this.listVirtualMachineScaleSetsPagingPage(
      resourceGroupName,
      name,
      options,
    )) {
      yield* page;
    }
  }

  /**
   * List Fleet resources by subscription ID
   * @param options The options parameters.
   */
  private _listBySubscription(
    options?: FleetsListBySubscriptionOptionalParams,
  ): Promise<FleetsListBySubscriptionResponse> {
    return this.client.sendOperationRequest(
      { options },
      listBySubscriptionOperationSpec,
    );
  }

  /**
   * List Fleet resources by resource group
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: FleetsListByResourceGroupOptionalParams,
  ): Promise<FleetsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec,
    );
  }

  /**
   * Get a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsGetOptionalParams,
  ): Promise<FleetsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, fleetName, options },
      getOperationSpec,
    );
  }

  /**
   * Create a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param resource Resource create parameters.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    fleetName: string,
    resource: Fleet,
    options?: FleetsCreateOrUpdateOptionalParams,
  ): Promise<
    SimplePollerLike<
      OperationState<FleetsCreateOrUpdateResponse>,
      FleetsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ): Promise<FleetsCreateOrUpdateResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ) => {
      let currentRawResponse: coreClient.FullOperationResponse | undefined =
        undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown,
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback,
        },
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON(),
        },
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { resourceGroupName, fleetName, resource, options },
      spec: createOrUpdateOperationSpec,
    });
    const poller = await createHttpPoller<
      FleetsCreateOrUpdateResponse,
      OperationState<FleetsCreateOrUpdateResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      resourceLocationConfig: "azure-async-operation",
    });
    await poller.poll();
    return poller;
  }

  /**
   * Create a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param resource Resource create parameters.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    fleetName: string,
    resource: Fleet,
    options?: FleetsCreateOrUpdateOptionalParams,
  ): Promise<FleetsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      fleetName,
      resource,
      options,
    );
    return poller.pollUntilDone();
  }

  /**
   * Update a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param properties The resource properties to be updated.
   * @param options The options parameters.
   */
  async beginUpdate(
    resourceGroupName: string,
    fleetName: string,
    properties: FleetUpdate,
    options?: FleetsUpdateOptionalParams,
  ): Promise<
    SimplePollerLike<OperationState<FleetsUpdateResponse>, FleetsUpdateResponse>
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ): Promise<FleetsUpdateResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ) => {
      let currentRawResponse: coreClient.FullOperationResponse | undefined =
        undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown,
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback,
        },
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON(),
        },
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { resourceGroupName, fleetName, properties, options },
      spec: updateOperationSpec,
    });
    const poller = await createHttpPoller<
      FleetsUpdateResponse,
      OperationState<FleetsUpdateResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      resourceLocationConfig: "location",
    });
    await poller.poll();
    return poller;
  }

  /**
   * Update a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param properties The resource properties to be updated.
   * @param options The options parameters.
   */
  async beginUpdateAndWait(
    resourceGroupName: string,
    fleetName: string,
    properties: FleetUpdate,
    options?: FleetsUpdateOptionalParams,
  ): Promise<FleetsUpdateResponse> {
    const poller = await this.beginUpdate(
      resourceGroupName,
      fleetName,
      properties,
      options,
    );
    return poller.pollUntilDone();
  }

  /**
   * Delete a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsDeleteOptionalParams,
  ): Promise<
    SimplePollerLike<OperationState<FleetsDeleteResponse>, FleetsDeleteResponse>
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ): Promise<FleetsDeleteResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperationFn = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec,
    ) => {
      let currentRawResponse: coreClient.FullOperationResponse | undefined =
        undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown,
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback,
        },
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON(),
        },
      };
    };

    const lro = createLroSpec({
      sendOperationFn,
      args: { resourceGroupName, fleetName, options },
      spec: deleteOperationSpec,
    });
    const poller = await createHttpPoller<
      FleetsDeleteResponse,
      OperationState<FleetsDeleteResponse>
    >(lro, {
      restoreFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      resourceLocationConfig: "location",
    });
    await poller.poll();
    return poller;
  }

  /**
   * Delete a Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param fleetName The name of the Compute Fleet
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    fleetName: string,
    options?: FleetsDeleteOptionalParams,
  ): Promise<FleetsDeleteResponse> {
    const poller = await this.beginDelete(
      resourceGroupName,
      fleetName,
      options,
    );
    return poller.pollUntilDone();
  }

  /**
   * List VirtualMachineScaleSet resources by Fleet
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param name The name of the Fleet
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSets(
    resourceGroupName: string,
    name: string,
    options?: FleetsListVirtualMachineScaleSetsOptionalParams,
  ): Promise<FleetsListVirtualMachineScaleSetsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, name, options },
      listVirtualMachineScaleSetsOperationSpec,
    );
  }

  /**
   * ListBySubscriptionNext
   * @param nextLink The nextLink from the previous successful call to the ListBySubscription method.
   * @param options The options parameters.
   */
  private _listBySubscriptionNext(
    nextLink: string,
    options?: FleetsListBySubscriptionNextOptionalParams,
  ): Promise<FleetsListBySubscriptionNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listBySubscriptionNextOperationSpec,
    );
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    nextLink: string,
    options?: FleetsListByResourceGroupNextOptionalParams,
  ): Promise<FleetsListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec,
    );
  }

  /**
   * ListVirtualMachineScaleSetsNext
   * @param resourceGroupName The name of the resource group. The name is case insensitive.
   * @param name The name of the Fleet
   * @param nextLink The nextLink from the previous successful call to the ListVirtualMachineScaleSets
   *                 method.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetsNext(
    resourceGroupName: string,
    name: string,
    nextLink: string,
    options?: FleetsListVirtualMachineScaleSetsNextOptionalParams,
  ): Promise<FleetsListVirtualMachineScaleSetsNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, name, nextLink, options },
      listVirtualMachineScaleSetsNextOperationSpec,
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listBySubscriptionOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/providers/Microsoft.AzureFleet/fleets",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FleetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer,
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FleetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const getOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets/{fleetName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.Fleet,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.fleetName,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets/{fleetName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.Fleet,
    },
    201: {
      bodyMapper: Mappers.Fleet,
    },
    202: {
      bodyMapper: Mappers.Fleet,
    },
    204: {
      bodyMapper: Mappers.Fleet,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  requestBody: Parameters.resource,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.fleetName,
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer,
};
const updateOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets/{fleetName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.Fleet,
    },
    201: {
      bodyMapper: Mappers.Fleet,
    },
    202: {
      bodyMapper: Mappers.Fleet,
    },
    204: {
      bodyMapper: Mappers.Fleet,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  requestBody: Parameters.properties,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.fleetName,
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer,
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets/{fleetName}",
  httpMethod: "DELETE",
  responses: {
    200: {
      headersMapper: Mappers.FleetsDeleteHeaders,
    },
    201: {
      headersMapper: Mappers.FleetsDeleteHeaders,
    },
    202: {
      headersMapper: Mappers.FleetsDeleteHeaders,
    },
    204: {
      headersMapper: Mappers.FleetsDeleteHeaders,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.fleetName,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const listVirtualMachineScaleSetsOperationSpec: coreClient.OperationSpec = {
  path: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureFleet/fleets/{name}/virtualMachineScaleSets",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualMachineScaleSetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.name,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const listBySubscriptionNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FleetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  urlParameters: [
    Parameters.$host,
    Parameters.nextLink,
    Parameters.subscriptionId,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.FleetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  urlParameters: [
    Parameters.$host,
    Parameters.nextLink,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
const listVirtualMachineScaleSetsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualMachineScaleSetListResult,
    },
    default: {
      bodyMapper: Mappers.ErrorResponse,
    },
  },
  urlParameters: [
    Parameters.$host,
    Parameters.nextLink,
    Parameters.subscriptionId,
    Parameters.resourceGroupName,
    Parameters.name,
  ],
  headerParameters: [Parameters.accept],
  serializer,
};
