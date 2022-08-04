import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworkGatewayConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetworkGatewayConnection,
  VirtualNetworkGatewayConnectionsListNextOptionalParams,
  VirtualNetworkGatewayConnectionsListOptionalParams,
  VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams,
  VirtualNetworkGatewayConnectionsCreateOrUpdateResponse,
  VirtualNetworkGatewayConnectionsGetOptionalParams,
  VirtualNetworkGatewayConnectionsGetResponse,
  VirtualNetworkGatewayConnectionsDeleteOptionalParams,
  TagsObject,
  VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams,
  VirtualNetworkGatewayConnectionsUpdateTagsResponse,
  ConnectionSharedKey,
  VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsSetSharedKeyResponse,
  VirtualNetworkGatewayConnectionsGetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsGetSharedKeyResponse,
  VirtualNetworkGatewayConnectionsListResponse,
  ConnectionResetSharedKey,
  VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams,
  VirtualNetworkGatewayConnectionsResetSharedKeyResponse,
  VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams,
  VirtualNetworkGatewayConnectionsStartPacketCaptureResponse,
  VpnPacketCaptureStopParameters,
  VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams,
  VirtualNetworkGatewayConnectionsStopPacketCaptureResponse,
  VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams,
  VirtualNetworkGatewayConnectionsGetIkeSasResponse,
  VirtualNetworkGatewayConnectionsResetConnectionOptionalParams,
  VirtualNetworkGatewayConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworkGatewayConnections operations. */
export class VirtualNetworkGatewayConnectionsImpl
  implements VirtualNetworkGatewayConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworkGatewayConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * The List VirtualNetworkGatewayConnections operation retrieves all the virtual network gateways
   * connections created.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewayConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayConnection> {
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
    options?: VirtualNetworkGatewayConnectionsListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayConnection[]> {
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
    options?: VirtualNetworkGatewayConnectionsListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayConnection> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Creates or updates a virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to the create or update virtual network gateway connection
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VirtualNetworkGatewayConnection,
    options?: VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsCreateOrUpdateResponse
      >,
      VirtualNetworkGatewayConnectionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsCreateOrUpdateResponse> => {
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
        virtualNetworkGatewayConnectionName,
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
   * Creates or updates a virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to the create or update virtual network gateway connection
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VirtualNetworkGatewayConnection,
    options?: VirtualNetworkGatewayConnectionsCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified virtual network gateway connection by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified virtual network Gateway connection.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsDeleteOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
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
   * Deletes the specified virtual network Gateway connection.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a virtual network gateway connection tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to update virtual network gateway connection tags.
   * @param options The options parameters.
   */
  async beginUpdateTags(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsUpdateTagsResponse>,
      VirtualNetworkGatewayConnectionsUpdateTagsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsUpdateTagsResponse> => {
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
        virtualNetworkGatewayConnectionName,
        parameters,
        options
      },
      updateTagsOperationSpec
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
   * Updates a virtual network gateway connection tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param parameters Parameters supplied to update virtual network gateway connection tags.
   * @param options The options parameters.
   */
  async beginUpdateTagsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewayConnectionsUpdateTagsOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsUpdateTagsResponse> {
    const poller = await this.beginUpdateTags(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * The Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection name.
   * @param parameters Parameters supplied to the Begin Set Virtual Network Gateway connection Shared key
   *                   operation throughNetwork resource provider.
   * @param options The options parameters.
   */
  async beginSetSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionSharedKey,
    options?: VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsSetSharedKeyResponse>,
      VirtualNetworkGatewayConnectionsSetSharedKeyResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsSetSharedKeyResponse> => {
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
        virtualNetworkGatewayConnectionName,
        parameters,
        options
      },
      setSharedKeyOperationSpec
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
   * The Put VirtualNetworkGatewayConnectionSharedKey operation sets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection name.
   * @param parameters Parameters supplied to the Begin Set Virtual Network Gateway connection Shared key
   *                   operation throughNetwork resource provider.
   * @param options The options parameters.
   */
  async beginSetSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionSharedKey,
    options?: VirtualNetworkGatewayConnectionsSetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsSetSharedKeyResponse> {
    const poller = await this.beginSetSharedKey(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * The Get VirtualNetworkGatewayConnectionSharedKey operation retrieves information about the specified
   * virtual network gateway connection shared key through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection shared key name.
   * @param options The options parameters.
   */
  getSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetSharedKeyResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
      getSharedKeyOperationSpec
    );
  }

  /**
   * The List VirtualNetworkGatewayConnections operation retrieves all the virtual network gateways
   * connections created.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewayConnectionsListOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * The VirtualNetworkGatewayConnectionResetSharedKey operation resets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection reset shared key
   *                                            Name.
   * @param parameters Parameters supplied to the begin reset virtual network gateway connection shared
   *                   key operation through network resource provider.
   * @param options The options parameters.
   */
  async beginResetSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionResetSharedKey,
    options?: VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsResetSharedKeyResponse
      >,
      VirtualNetworkGatewayConnectionsResetSharedKeyResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsResetSharedKeyResponse> => {
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
        virtualNetworkGatewayConnectionName,
        parameters,
        options
      },
      resetSharedKeyOperationSpec
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
   * The VirtualNetworkGatewayConnectionResetSharedKey operation resets the virtual network gateway
   * connection shared key for passed virtual network gateway connection in the specified resource group
   * through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The virtual network gateway connection reset shared key
   *                                            Name.
   * @param parameters Parameters supplied to the begin reset virtual network gateway connection shared
   *                   key operation through network resource provider.
   * @param options The options parameters.
   */
  async beginResetSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: ConnectionResetSharedKey,
    options?: VirtualNetworkGatewayConnectionsResetSharedKeyOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsResetSharedKeyResponse> {
    const poller = await this.beginResetSharedKey(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Starts packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  async beginStartPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsStartPacketCaptureResponse
      >,
      VirtualNetworkGatewayConnectionsStartPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsStartPacketCaptureResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
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
   * Starts packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection.
   * @param options The options parameters.
   */
  async beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsStartPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsStartPacketCaptureResponse> {
    const poller = await this.beginStartPacketCapture(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Stops packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway connection.
   * @param options The options parameters.
   */
  async beginStopPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewayConnectionsStopPacketCaptureResponse
      >,
      VirtualNetworkGatewayConnectionsStopPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsStopPacketCaptureResponse> => {
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
        virtualNetworkGatewayConnectionName,
        parameters,
        options
      },
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
   * Stops packet capture on virtual network gateway connection in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway connection.
   * @param options The options parameters.
   */
  async beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewayConnectionsStopPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsStopPacketCaptureResponse> {
    const poller = await this.beginStopPacketCapture(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists IKE Security Associations for the virtual network gateway connection in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  async beginGetIkeSas(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewayConnectionsGetIkeSasResponse>,
      VirtualNetworkGatewayConnectionsGetIkeSasResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewayConnectionsGetIkeSasResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
      getIkeSasOperationSpec
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
   * Lists IKE Security Associations for the virtual network gateway connection in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  async beginGetIkeSasAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsGetIkeSasOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsGetIkeSasResponse> {
    const poller = await this.beginGetIkeSas(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Resets the virtual network gateway connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  async beginResetConnection(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayConnectionName, options },
      resetConnectionOperationSpec
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
   * Resets the virtual network gateway connection specified.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway Connection.
   * @param options The options parameters.
   */
  async beginResetConnectionAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    options?: VirtualNetworkGatewayConnectionsResetConnectionOptionalParams
  ): Promise<void> {
    const poller = await this.beginResetConnection(
      resourceGroupName,
      virtualNetworkGatewayConnectionName,
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
    options?: VirtualNetworkGatewayConnectionsListNextOptionalParams
  ): Promise<VirtualNetworkGatewayConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters73,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
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
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}",
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
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnection
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
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const setSharedKeyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionSharedKey
    },
    201: {
      bodyMapper: Mappers.ConnectionSharedKey
    },
    202: {
      bodyMapper: Mappers.ConnectionSharedKey
    },
    204: {
      bodyMapper: Mappers.ConnectionSharedKey
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters74,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getSharedKeyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionSharedKey
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
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnectionListResult
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
const resetSharedKeyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/sharedkey/reset",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectionResetSharedKey
    },
    201: {
      bodyMapper: Mappers.ConnectionResetSharedKey
    },
    202: {
      bodyMapper: Mappers.ConnectionResetSharedKey
    },
    204: {
      bodyMapper: Mappers.ConnectionResetSharedKey
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters75,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const startPacketCaptureOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/startPacketCapture",
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
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters71,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const stopPacketCaptureOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/stopPacketCapture",
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
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters72,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getIkeSasOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/getikesas",
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
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const resetConnectionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/resetconnection",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayConnectionListResult
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
