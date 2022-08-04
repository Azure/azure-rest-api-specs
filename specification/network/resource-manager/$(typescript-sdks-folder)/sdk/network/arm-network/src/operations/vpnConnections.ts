import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VpnConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VpnConnection,
  VpnConnectionsListByVpnGatewayNextOptionalParams,
  VpnConnectionsListByVpnGatewayOptionalParams,
  VpnConnectionsGetOptionalParams,
  VpnConnectionsGetResponse,
  VpnConnectionsCreateOrUpdateOptionalParams,
  VpnConnectionsCreateOrUpdateResponse,
  VpnConnectionsDeleteOptionalParams,
  VpnConnectionsStartPacketCaptureOptionalParams,
  VpnConnectionsStartPacketCaptureResponse,
  VpnConnectionsStopPacketCaptureOptionalParams,
  VpnConnectionsStopPacketCaptureResponse,
  VpnConnectionsListByVpnGatewayResponse,
  VpnConnectionsListByVpnGatewayNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VpnConnections operations. */
export class VpnConnectionsImpl implements VpnConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  public listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnConnectionsListByVpnGatewayOptionalParams
  ): PagedAsyncIterableIterator<VpnConnection> {
    const iter = this.listByVpnGatewayPagingAll(
      resourceGroupName,
      gatewayName,
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
        return this.listByVpnGatewayPagingPage(
          resourceGroupName,
          gatewayName,
          options
        );
      }
    };
  }

  private async *listByVpnGatewayPagingPage(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnConnectionsListByVpnGatewayOptionalParams
  ): AsyncIterableIterator<VpnConnection[]> {
    let result = await this._listByVpnGateway(
      resourceGroupName,
      gatewayName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByVpnGatewayNext(
        resourceGroupName,
        gatewayName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByVpnGatewayPagingAll(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnConnectionsListByVpnGatewayOptionalParams
  ): AsyncIterableIterator<VpnConnection> {
    for await (const page of this.listByVpnGatewayPagingPage(
      resourceGroupName,
      gatewayName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsGetOptionalParams
  ): Promise<VpnConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, connectionName, options },
      getOperationSpec
    );
  }

  /**
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing
   * connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param vpnConnectionParameters Parameters supplied to create or Update a VPN Connection.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    vpnConnectionParameters: VpnConnection,
    options?: VpnConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsCreateOrUpdateResponse>,
      VpnConnectionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VpnConnectionsCreateOrUpdateResponse> => {
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
        gatewayName,
        connectionName,
        vpnConnectionParameters,
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
   * Creates a vpn connection to a scalable vpn gateway if it doesn't exist else updates the existing
   * connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param vpnConnectionParameters Parameters supplied to create or Update a VPN Connection.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    vpnConnectionParameters: VpnConnection,
    options?: VpnConnectionsCreateOrUpdateOptionalParams
  ): Promise<VpnConnectionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      gatewayName,
      connectionName,
      vpnConnectionParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Deletes a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsDeleteOptionalParams
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
      { resourceGroupName, gatewayName, connectionName, options },
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
   * Deletes a vpn connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the connection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    options?: VpnConnectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      gatewayName,
      connectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Starts packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  async beginStartPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsStartPacketCaptureResponse>,
      VpnConnectionsStartPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VpnConnectionsStartPacketCaptureResponse> => {
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
      { resourceGroupName, gatewayName, vpnConnectionName, options },
      startPacketCaptureOperationSpec
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
   * Starts packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  async beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStartPacketCaptureOptionalParams
  ): Promise<VpnConnectionsStartPacketCaptureResponse> {
    const poller = await this.beginStartPacketCapture(
      resourceGroupName,
      gatewayName,
      vpnConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Stops packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  async beginStopPacketCapture(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnConnectionsStopPacketCaptureResponse>,
      VpnConnectionsStopPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VpnConnectionsStopPacketCaptureResponse> => {
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
      { resourceGroupName, gatewayName, vpnConnectionName, options },
      stopPacketCaptureOperationSpec
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
   * Stops packet capture on Vpn connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param gatewayName The name of the gateway.
   * @param vpnConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  async beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    gatewayName: string,
    vpnConnectionName: string,
    options?: VpnConnectionsStopPacketCaptureOptionalParams
  ): Promise<VpnConnectionsStopPacketCaptureResponse> {
    const poller = await this.beginStopPacketCapture(
      resourceGroupName,
      gatewayName,
      vpnConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Retrieves all vpn connections for a particular virtual wan vpn gateway.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param options The options parameters.
   */
  private _listByVpnGateway(
    resourceGroupName: string,
    gatewayName: string,
    options?: VpnConnectionsListByVpnGatewayOptionalParams
  ): Promise<VpnConnectionsListByVpnGatewayResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, options },
      listByVpnGatewayOperationSpec
    );
  }

  /**
   * ListByVpnGatewayNext
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param nextLink The nextLink from the previous successful call to the ListByVpnGateway method.
   * @param options The options parameters.
   */
  private _listByVpnGatewayNext(
    resourceGroupName: string,
    gatewayName: string,
    nextLink: string,
    options?: VpnConnectionsListByVpnGatewayNextOptionalParams
  ): Promise<VpnConnectionsListByVpnGatewayNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, gatewayName, nextLink, options },
      listByVpnGatewayNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnConnection
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
    Parameters.connectionName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VpnConnection
    },
    201: {
      bodyMapper: Mappers.VpnConnection
    },
    202: {
      bodyMapper: Mappers.VpnConnection
    },
    204: {
      bodyMapper: Mappers.VpnConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnConnectionParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.connectionName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}",
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
    Parameters.connectionName,
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const startPacketCaptureOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/startpacketcapture",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: { type: { name: "String" } }
    },
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    202: {
      bodyMapper: { type: { name: "String" } }
    },
    204: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters82,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.gatewayName,
    Parameters.vpnConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const stopPacketCaptureOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{vpnConnectionName}/stoppacketcapture",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: { type: { name: "String" } }
    },
    201: {
      bodyMapper: { type: { name: "String" } }
    },
    202: {
      bodyMapper: { type: { name: "String" } }
    },
    204: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters83,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.gatewayName,
    Parameters.vpnConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listByVpnGatewayOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnConnectionsResult
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
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnGatewayNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnConnectionsResult
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
    Parameters.gatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
