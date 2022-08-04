import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteCrossConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteCrossConnection,
  ExpressRouteCrossConnectionsListNextOptionalParams,
  ExpressRouteCrossConnectionsListOptionalParams,
  ExpressRouteCrossConnectionsListByResourceGroupNextOptionalParams,
  ExpressRouteCrossConnectionsListByResourceGroupOptionalParams,
  ExpressRouteCrossConnectionsListResponse,
  ExpressRouteCrossConnectionsListByResourceGroupResponse,
  ExpressRouteCrossConnectionsGetOptionalParams,
  ExpressRouteCrossConnectionsGetResponse,
  ExpressRouteCrossConnectionsCreateOrUpdateOptionalParams,
  ExpressRouteCrossConnectionsCreateOrUpdateResponse,
  TagsObject,
  ExpressRouteCrossConnectionsUpdateTagsOptionalParams,
  ExpressRouteCrossConnectionsUpdateTagsResponse,
  ExpressRouteCrossConnectionsListArpTableOptionalParams,
  ExpressRouteCrossConnectionsListArpTableResponse,
  ExpressRouteCrossConnectionsListRoutesTableSummaryOptionalParams,
  ExpressRouteCrossConnectionsListRoutesTableSummaryResponse,
  ExpressRouteCrossConnectionsListRoutesTableOptionalParams,
  ExpressRouteCrossConnectionsListRoutesTableResponse,
  ExpressRouteCrossConnectionsListNextResponse,
  ExpressRouteCrossConnectionsListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteCrossConnections operations. */
export class ExpressRouteCrossConnectionsImpl
  implements ExpressRouteCrossConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteCrossConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   * @param options The options parameters.
   */
  public list(
    options?: ExpressRouteCrossConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCrossConnection> {
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
    options?: ExpressRouteCrossConnectionsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnection[]> {
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
    options?: ExpressRouteCrossConnectionsListOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnection> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Retrieves all the ExpressRouteCrossConnections in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    options?: ExpressRouteCrossConnectionsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCrossConnection> {
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
    options?: ExpressRouteCrossConnectionsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnection[]> {
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
    options?: ExpressRouteCrossConnectionsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<ExpressRouteCrossConnection> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves all the ExpressRouteCrossConnections in a subscription.
   * @param options The options parameters.
   */
  private _list(
    options?: ExpressRouteCrossConnectionsListOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Retrieves all the ExpressRouteCrossConnections in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    options?: ExpressRouteCrossConnectionsListByResourceGroupOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Gets details about the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group (peering location of the circuit).
   * @param crossConnectionName The name of the ExpressRouteCrossConnection (service key of the circuit).
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    crossConnectionName: string,
    options?: ExpressRouteCrossConnectionsGetOptionalParams
  ): Promise<ExpressRouteCrossConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, crossConnectionName, options },
      getOperationSpec
    );
  }

  /**
   * Update the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param parameters Parameters supplied to the update express route crossConnection operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    crossConnectionName: string,
    parameters: ExpressRouteCrossConnection,
    options?: ExpressRouteCrossConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCrossConnectionsCreateOrUpdateResponse>,
      ExpressRouteCrossConnectionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCrossConnectionsCreateOrUpdateResponse> => {
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
      { resourceGroupName, crossConnectionName, parameters, options },
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
   * Update the specified ExpressRouteCrossConnection.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param parameters Parameters supplied to the update express route crossConnection operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    parameters: ExpressRouteCrossConnection,
    options?: ExpressRouteCrossConnectionsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCrossConnectionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      crossConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates an express route cross connection tags.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the cross connection.
   * @param crossConnectionParameters Parameters supplied to update express route cross connection tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    crossConnectionName: string,
    crossConnectionParameters: TagsObject,
    options?: ExpressRouteCrossConnectionsUpdateTagsOptionalParams
  ): Promise<ExpressRouteCrossConnectionsUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        crossConnectionName,
        crossConnectionParameters,
        options
      },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets the currently advertised ARP table associated with the express route cross connection in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListArpTable(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListArpTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCrossConnectionsListArpTableResponse>,
      ExpressRouteCrossConnectionsListArpTableResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCrossConnectionsListArpTableResponse> => {
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
        crossConnectionName,
        peeringName,
        devicePath,
        options
      },
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
   * Gets the currently advertised ARP table associated with the express route cross connection in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListArpTableAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListArpTableOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListArpTableResponse> {
    const poller = await this.beginListArpTable(
      resourceGroupName,
      crossConnectionName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the route table summary associated with the express route cross connection in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableSummary(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListRoutesTableSummaryOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ExpressRouteCrossConnectionsListRoutesTableSummaryResponse
      >,
      ExpressRouteCrossConnectionsListRoutesTableSummaryResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCrossConnectionsListRoutesTableSummaryResponse> => {
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
        crossConnectionName,
        peeringName,
        devicePath,
        options
      },
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
   * Gets the route table summary associated with the express route cross connection in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableSummaryAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListRoutesTableSummaryOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListRoutesTableSummaryResponse> {
    const poller = await this.beginListRoutesTableSummary(
      resourceGroupName,
      crossConnectionName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the currently advertised routes table associated with the express route cross connection in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTable(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListRoutesTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteCrossConnectionsListRoutesTableResponse>,
      ExpressRouteCrossConnectionsListRoutesTableResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteCrossConnectionsListRoutesTableResponse> => {
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
        crossConnectionName,
        peeringName,
        devicePath,
        options
      },
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
   * Gets the currently advertised routes table associated with the express route cross connection in a
   * resource group.
   * @param resourceGroupName The name of the resource group.
   * @param crossConnectionName The name of the ExpressRouteCrossConnection.
   * @param peeringName The name of the peering.
   * @param devicePath The path of the device.
   * @param options The options parameters.
   */
  async beginListRoutesTableAndWait(
    resourceGroupName: string,
    crossConnectionName: string,
    peeringName: string,
    devicePath: string,
    options?: ExpressRouteCrossConnectionsListRoutesTableOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListRoutesTableResponse> {
    const poller = await this.beginListRoutesTable(
      resourceGroupName,
      crossConnectionName,
      peeringName,
      devicePath,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: ExpressRouteCrossConnectionsListNextOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListNextResponse> {
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
    options?: ExpressRouteCrossConnectionsListByResourceGroupNextOptionalParams
  ): Promise<ExpressRouteCrossConnectionsListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteCrossConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionListResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionListResult
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
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
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
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
    },
    201: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
    },
    202: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
    },
    204: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters15,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.crossConnectionParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listArpTableOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/arpTables/{devicePath}",
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
    Parameters.peeringName,
    Parameters.devicePath,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listRoutesTableSummaryOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTablesSummary/{devicePath}",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper:
        Mappers.ExpressRouteCrossConnectionsRoutesTableSummaryListResult
    },
    201: {
      bodyMapper:
        Mappers.ExpressRouteCrossConnectionsRoutesTableSummaryListResult
    },
    202: {
      bodyMapper:
        Mappers.ExpressRouteCrossConnectionsRoutesTableSummaryListResult
    },
    204: {
      bodyMapper:
        Mappers.ExpressRouteCrossConnectionsRoutesTableSummaryListResult
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
    Parameters.peeringName,
    Parameters.devicePath,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listRoutesTableOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCrossConnections/{crossConnectionName}/peerings/{peeringName}/routeTables/{devicePath}",
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
    Parameters.peeringName,
    Parameters.devicePath,
    Parameters.crossConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteCrossConnectionListResult
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
      bodyMapper: Mappers.ExpressRouteCrossConnectionListResult
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
