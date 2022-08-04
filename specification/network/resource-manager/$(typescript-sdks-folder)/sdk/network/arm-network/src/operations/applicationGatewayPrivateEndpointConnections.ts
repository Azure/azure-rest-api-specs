import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ApplicationGatewayPrivateEndpointConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ApplicationGatewayPrivateEndpointConnection,
  ApplicationGatewayPrivateEndpointConnectionsListNextOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsListOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsUpdateResponse,
  ApplicationGatewayPrivateEndpointConnectionsGetOptionalParams,
  ApplicationGatewayPrivateEndpointConnectionsGetResponse,
  ApplicationGatewayPrivateEndpointConnectionsListResponse,
  ApplicationGatewayPrivateEndpointConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ApplicationGatewayPrivateEndpointConnections operations. */
export class ApplicationGatewayPrivateEndpointConnectionsImpl
  implements ApplicationGatewayPrivateEndpointConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ApplicationGatewayPrivateEndpointConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all private endpoint connections on an application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGatewayPrivateEndpointConnection> {
    const iter = this.listPagingAll(
      resourceGroupName,
      applicationGatewayName,
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
          applicationGatewayName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  ): AsyncIterableIterator<ApplicationGatewayPrivateEndpointConnection[]> {
    let result = await this._list(
      resourceGroupName,
      applicationGatewayName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        applicationGatewayName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  ): AsyncIterableIterator<ApplicationGatewayPrivateEndpointConnection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      applicationGatewayName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams
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
      { resourceGroupName, applicationGatewayName, connectionName, options },
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
   * Deletes the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      applicationGatewayName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param parameters Parameters supplied to update application gateway private endpoint connection
   *                   operation.
   * @param options The options parameters.
   */
  async beginUpdate(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    parameters: ApplicationGatewayPrivateEndpointConnection,
    options?: ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ApplicationGatewayPrivateEndpointConnectionsUpdateResponse
      >,
      ApplicationGatewayPrivateEndpointConnectionsUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ApplicationGatewayPrivateEndpointConnectionsUpdateResponse> => {
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
        applicationGatewayName,
        connectionName,
        parameters,
        options
      },
      updateOperationSpec
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
   * Updates the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param parameters Parameters supplied to update application gateway private endpoint connection
   *                   operation.
   * @param options The options parameters.
   */
  async beginUpdateAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    parameters: ApplicationGatewayPrivateEndpointConnection,
    options?: ApplicationGatewayPrivateEndpointConnectionsUpdateOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsUpdateResponse> {
    const poller = await this.beginUpdate(
      resourceGroupName,
      applicationGatewayName,
      connectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified private endpoint connection on application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param connectionName The name of the application gateway private endpoint connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationGatewayName: string,
    connectionName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsGetOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationGatewayName, connectionName, options },
      getOperationSpec
    );
  }

  /**
   * Lists all private endpoint connections on an application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationGatewayName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    applicationGatewayName: string,
    nextLink: string,
    options?: ApplicationGatewayPrivateEndpointConnectionsListNextOptionalParams
  ): Promise<ApplicationGatewayPrivateEndpointConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationGatewayName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}",
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
    Parameters.applicationGatewayName,
    Parameters.subscriptionId,
    Parameters.connectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnection
    },
    201: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnection
    },
    202: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnection
    },
    204: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters2,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId,
    Parameters.connectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections/{connectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId,
    Parameters.connectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/privateEndpointConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
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
      bodyMapper: Mappers.ApplicationGatewayPrivateEndpointConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
