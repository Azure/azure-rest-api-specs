import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCircuits } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCircuit,
  ExpressRouteCircuitsListNextOptionalParams,
  ExpressRouteCircuitsListOptionalParams,
  ExpressRouteCircuitsListAllNextOptionalParams,
  ExpressRouteCircuitsListAllOptionalParams,
  ExpressRouteCircuitsDeleteOptionalParams,
  ExpressRouteCircuitsGetOptionalParams,
  ExpressRouteCircuitsGetResponse,
  ExpressRouteCircuitsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitsCreateOrUpdateResponse,
  TagsObject,
  ExpressRouteCircuitsUpdateTagsOptionalParams,
  ExpressRouteCircuitsUpdateTagsResponse,
  ExpressRouteCircuitsListArpTableOptionalParams,
  ExpressRouteCircuitsListArpTableResponse,
  ExpressRouteCircuitsListRoutesTableOptionalParams,
  ExpressRouteCircuitsListRoutesTableResponse,
  ExpressRouteCircuitsListRoutesTableSummaryOptionalParams,
  ExpressRouteCircuitsListRoutesTableSummaryResponse,
  ExpressRouteCircuitsGetStatsOptionalParams,
  ExpressRouteCircuitsGetStatsResponse,
  ExpressRouteCircuitsGetPeeringStatsOptionalParams,
  ExpressRouteCircuitsGetPeeringStatsResponse,
  ExpressRouteCircuitsListResponse,
  ExpressRouteCircuitsListAllResponse,
  ExpressRouteCircuitsListNextResponse,
  ExpressRouteCircuitsListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCircuits operations. */
export class ExpressRouteCircuitsImpl implements ExpressRouteCircuits {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCircuits class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the express route circuits in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: ExpressRouteCircuitsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuit> {
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
    options?: ExpressRouteCircuitsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuit[]> {
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
    options?: ExpressRouteCircuitsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuit> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all the express route circuits in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: ExpressRouteCircuitsListAllOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuit> {
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
    options?: ExpressRouteCircuitsListAllOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuit[]> {
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
    options?: ExpressRouteCircuitsListAllOptionalParams
  ): AsyncIterableIterator<ExpressRouteCircuit> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Deletes the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsDeleteOptionalParams
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
      { resourceGroupName, circuitName, options },
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
   * Deletes the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      circuitName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets information about the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of express route circuit.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsGetOptionalParams
  ): Promise<ExpressRouteCircuitsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to the create or update express route circuit operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    parameters: ExpressRouteCircuit,
    options?: ExpressRouteCircuitsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsCreateOrUpdateResponse>,
      ExpressRouteCircuitsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitsCreateOrUpdateResponse> => {
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
      { resourceGroupName, circuitName, parameters, options },
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
   * Creates or updates an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to the create or update express route circuit operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    parameters: ExpressRouteCircuit,
    options?: ExpressRouteCircuitsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      circuitName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates an express route circuit tags.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param parameters Parameters supplied to update express route circuit tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    circuitName: string,
    parameters: TagsObject,
    options?: ExpressRouteCircuitsUpdateTagsOptionalParams
  ): Promise<ExpressRouteCircuitsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets the currently advertised ARP table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListArpTable(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListArpTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListArpTableResponse>,
      ExpressRouteCircuitsListArpTableResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitsListArpTableResponse> => {
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
      { resourceGroupName, circuitName, peeringName, devicePath, options },
      listArpTableOperationSpec
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
   * Gets the currently advertised ARP table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListArpTableAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListArpTableOptionalParams
  ): Promise<ExpressRouteCircuitsListArpTableResponse> {
    const poller = await this.beginListArpTable(
      resourceGroupName,
      circuitName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the currently advertised routes table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTable(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListRoutesTableResponse>,
      ExpressRouteCircuitsListRoutesTableResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitsListRoutesTableResponse> => {
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
      { resourceGroupName, circuitName, peeringName, devicePath, options },
      listRoutesTableOperationSpec
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
   * Gets the currently advertised routes table associated with the express route circuit in a resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableOptionalParams
  ): Promise<ExpressRouteCircuitsListRoutesTableResponse> {
    const poller = await this.beginListRoutesTable(
      resourceGroupName,
      circuitName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the currently advertised routes table summary associated with the express route circuit in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableSummary(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableSummaryOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCircuitsListRoutesTableSummaryResponse>,
      ExpressRouteCircuitsListRoutesTableSummaryResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCircuitsListRoutesTableSummaryResponse> => {
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
      { resourceGroupName, circuitName, peeringName, devicePath, options },
      listRoutesTableSummaryOperationSpec
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
   * Gets the currently advertised routes table summary associated with the express route circuit in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableSummaryAndWait(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCircuitsListRoutesTableSummaryOptionalParams
  ): Promise<ExpressRouteCircuitsListRoutesTableSummaryResponse> {
    const poller = await this.beginListRoutesTableSummary(
      resourceGroupName,
      circuitName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all the stats from an express route circuit in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param options The options parameters.
   */
  getStats(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitsGetStatsOptionalParams
  ): Promise<ExpressRouteCircuitsGetStatsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, options },
      getStatsOperationSpec
    );
  }

  /**
   * Gets all stats from an express route circuit in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param peeringName The name of the peering.
   * @param options The options parameters.
   */
  getPeeringStats(
    resourceGroupName: string,
    circuitName: string,
    peeringName: string,
    options?: ExpressRouteCircuitsGetPeeringStatsOptionalParams
  ): Promise<ExpressRouteCircuitsGetPeeringStatsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, circuitName, peeringName, options },
      getPeeringStatsOperationSpec
    );
  }

  /**
   * Gets all the express route circuits in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: ExpressRouteCircuitsListOptionalParams
  ): Promise<ExpressRouteCircuitsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all the express route circuits in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: ExpressRouteCircuitsListAllOptionalParams
  ): Promise<ExpressRouteCircuitsListAllResponse> {
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
    options?: ExpressRouteCircuitsListNextOptionalParams
  ): Promise<ExpressRouteCircuitsListNextResponse> {
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
    options?: ExpressRouteCircuitsListAllNextOptionalParams
  ): Promise<ExpressRouteCircuitsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}",
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuit
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuit
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuit
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuit
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuit
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters14,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuit
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listArpTableOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/arpTables/{devicePath}",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitsArpTableListResult
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitsArpTableListResult
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitsArpTableListResult
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitsArpTableListResult
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
    Parameters.circuitName,
    Parameters.peeringName,
    Parameters.devicePath
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listRoutesTableOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTables/{devicePath}",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableListResult
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableListResult
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableListResult
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableListResult
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
    Parameters.circuitName,
    Parameters.peeringName,
    Parameters.devicePath
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listRoutesTableSummaryOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableSummaryListResult
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableSummaryListResult
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableSummaryListResult
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCircuitsRoutesTableSummaryListResult
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
    Parameters.circuitName,
    Parameters.peeringName,
    Parameters.devicePath
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getStatsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/stats",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitStats
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
    Parameters.circuitName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getPeeringStatsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/stats",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitStats
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
    Parameters.circuitName,
    Parameters.peeringName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitListResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteCircuits",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCircuitListResult
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
      bodyMapper: Mappers.ExpressRouteCircuitListResult
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
      bodyMapper: Mappers.ExpressRouteCircuitListResult
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
