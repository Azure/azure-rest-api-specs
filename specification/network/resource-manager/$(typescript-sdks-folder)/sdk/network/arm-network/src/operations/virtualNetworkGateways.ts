import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualNetworkGateways } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualNetworkGateway,
  VirtualNetworkGatewaysListNextOptionalParams,
  VirtualNetworkGatewaysListOptionalParams,
  VirtualNetworkGatewayConnectionListEntity,
  VirtualNetworkGatewaysListConnectionsNextOptionalParams,
  VirtualNetworkGatewaysListConnectionsOptionalParams,
  VirtualNetworkGatewaysCreateOrUpdateOptionalParams,
  VirtualNetworkGatewaysCreateOrUpdateResponse,
  VirtualNetworkGatewaysGetOptionalParams,
  VirtualNetworkGatewaysGetResponse,
  VirtualNetworkGatewaysDeleteOptionalParams,
  TagsObject,
  VirtualNetworkGatewaysUpdateTagsOptionalParams,
  VirtualNetworkGatewaysUpdateTagsResponse,
  VirtualNetworkGatewaysListResponse,
  VirtualNetworkGatewaysListConnectionsResponse,
  VirtualNetworkGatewaysResetOptionalParams,
  VirtualNetworkGatewaysResetResponse,
  VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams,
  VpnClientParameters,
  VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams,
  VirtualNetworkGatewaysGeneratevpnclientpackageResponse,
  VirtualNetworkGatewaysGenerateVpnProfileOptionalParams,
  VirtualNetworkGatewaysGenerateVpnProfileResponse,
  VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams,
  VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse,
  VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams,
  VirtualNetworkGatewaysGetBgpPeerStatusResponse,
  VirtualNetworkGatewaysSupportedVpnDevicesOptionalParams,
  VirtualNetworkGatewaysSupportedVpnDevicesResponse,
  VirtualNetworkGatewaysGetLearnedRoutesOptionalParams,
  VirtualNetworkGatewaysGetLearnedRoutesResponse,
  VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams,
  VirtualNetworkGatewaysGetAdvertisedRoutesResponse,
  VpnClientIPsecParameters,
  VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams,
  VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse,
  VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams,
  VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse,
  VpnDeviceScriptParameters,
  VirtualNetworkGatewaysVpnDeviceConfigurationScriptOptionalParams,
  VirtualNetworkGatewaysVpnDeviceConfigurationScriptResponse,
  VirtualNetworkGatewaysStartPacketCaptureOptionalParams,
  VirtualNetworkGatewaysStartPacketCaptureResponse,
  VpnPacketCaptureStopParameters,
  VirtualNetworkGatewaysStopPacketCaptureOptionalParams,
  VirtualNetworkGatewaysStopPacketCaptureResponse,
  VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams,
  VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse,
  P2SVpnConnectionRequest,
  VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams,
  VirtualNetworkGatewaysListNextResponse,
  VirtualNetworkGatewaysListConnectionsNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualNetworkGateways operations. */
export class VirtualNetworkGatewaysImpl implements VirtualNetworkGateways {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualNetworkGateways class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all virtual network gateways by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGateway> {
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
    options?: VirtualNetworkGatewaysListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGateway[]> {
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
    options?: VirtualNetworkGatewaysListOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGateway> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all the connections in a virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  public listConnections(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysListConnectionsOptionalParams
  ): PagedAsyncIterableIterator<VirtualNetworkGatewayConnectionListEntity> {
    const iter = this.listConnectionsPagingAll(
      resourceGroupName,
      virtualNetworkGatewayName,
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
        return this.listConnectionsPagingPage(
          resourceGroupName,
          virtualNetworkGatewayName,
          options
        );
      }
    };
  }

  private async *listConnectionsPagingPage(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysListConnectionsOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayConnectionListEntity[]> {
    let result = await this._listConnections(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listConnectionsNext(
        resourceGroupName,
        virtualNetworkGatewayName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listConnectionsPagingAll(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysListConnectionsOptionalParams
  ): AsyncIterableIterator<VirtualNetworkGatewayConnectionListEntity> {
    for await (const page of this.listConnectionsPagingPage(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates or updates a virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to create or update virtual network gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VirtualNetworkGateway,
    options?: VirtualNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysCreateOrUpdateResponse>,
      VirtualNetworkGatewaysCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysCreateOrUpdateResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, parameters, options },
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
   * Creates or updates a virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to create or update virtual network gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VirtualNetworkGateway,
    options?: VirtualNetworkGatewaysCreateOrUpdateOptionalParams
  ): Promise<VirtualNetworkGatewaysCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      virtualNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified virtual network gateway by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetOptionalParams
  ): Promise<VirtualNetworkGatewaysGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysDeleteOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayName, options },
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
   * Deletes the specified virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a virtual network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to update virtual network gateway tags.
   * @param options The options parameters.
   */
  async beginUpdateTags(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysUpdateTagsResponse>,
      VirtualNetworkGatewaysUpdateTagsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysUpdateTagsResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, parameters, options },
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
   * Updates a virtual network gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to update virtual network gateway tags.
   * @param options The options parameters.
   */
  async beginUpdateTagsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: TagsObject,
    options?: VirtualNetworkGatewaysUpdateTagsOptionalParams
  ): Promise<VirtualNetworkGatewaysUpdateTagsResponse> {
    const poller = await this.beginUpdateTags(
      resourceGroupName,
      virtualNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all virtual network gateways by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: VirtualNetworkGatewaysListOptionalParams
  ): Promise<VirtualNetworkGatewaysListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all the connections in a virtual network gateway.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  private _listConnections(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysListConnectionsOptionalParams
  ): Promise<VirtualNetworkGatewaysListConnectionsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, options },
      listConnectionsOperationSpec
    );
  }

  /**
   * Resets the primary of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginReset(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysResetResponse>,
      VirtualNetworkGatewaysResetResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysResetResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      resetOperationSpec
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
   * Resets the primary of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginResetAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetOptionalParams
  ): Promise<VirtualNetworkGatewaysResetResponse> {
    const poller = await this.beginReset(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Resets the VPN client shared key of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginResetVpnClientSharedKey(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      resetVpnClientSharedKeyOperationSpec
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
   * Resets the VPN client shared key of the virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginResetVpnClientSharedKeyAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysResetVpnClientSharedKeyOptionalParams
  ): Promise<void> {
    const poller = await this.beginResetVpnClientSharedKey(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Generates VPN client package for P2S client of the virtual network gateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  async beginGeneratevpnclientpackage(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGeneratevpnclientpackageResponse
      >,
      VirtualNetworkGatewaysGeneratevpnclientpackageResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGeneratevpnclientpackageResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, parameters, options },
      generatevpnclientpackageOperationSpec
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
   * Generates VPN client package for P2S client of the virtual network gateway in the specified resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  async beginGeneratevpnclientpackageAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGeneratevpnclientpackageOptionalParams
  ): Promise<VirtualNetworkGatewaysGeneratevpnclientpackageResponse> {
    const poller = await this.beginGeneratevpnclientpackage(
      resourceGroupName,
      virtualNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Generates VPN profile for P2S client of the virtual network gateway in the specified resource group.
   * Used for IKEV2 and radius based authentication.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  async beginGenerateVpnProfile(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGenerateVpnProfileOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGenerateVpnProfileResponse>,
      VirtualNetworkGatewaysGenerateVpnProfileResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGenerateVpnProfileResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, parameters, options },
      generateVpnProfileOperationSpec
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
   * Generates VPN profile for P2S client of the virtual network gateway in the specified resource group.
   * Used for IKEV2 and radius based authentication.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Parameters supplied to the generate virtual network gateway VPN client package
   *                   operation.
   * @param options The options parameters.
   */
  async beginGenerateVpnProfileAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnClientParameters,
    options?: VirtualNetworkGatewaysGenerateVpnProfileOptionalParams
  ): Promise<VirtualNetworkGatewaysGenerateVpnProfileResponse> {
    const poller = await this.beginGenerateVpnProfile(
      resourceGroupName,
      virtualNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets pre-generated VPN profile for P2S client of the virtual network gateway in the specified
   * resource group. The profile needs to be generated first using generateVpnProfile.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetVpnProfilePackageUrl(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse>,
      VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      getVpnProfilePackageUrlOperationSpec
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
   * Gets pre-generated VPN profile for P2S client of the virtual network gateway in the specified
   * resource group. The profile needs to be generated first using generateVpnProfile.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetVpnProfilePackageUrlAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnProfilePackageUrlOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnProfilePackageUrlResponse> {
    const poller = await this.beginGetVpnProfilePackageUrl(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * The GetBgpPeerStatus operation retrieves the status of all BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetBgpPeerStatus(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetBgpPeerStatusResponse>,
      VirtualNetworkGatewaysGetBgpPeerStatusResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetBgpPeerStatusResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      getBgpPeerStatusOperationSpec
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
   * The GetBgpPeerStatus operation retrieves the status of all BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetBgpPeerStatusAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetBgpPeerStatusOptionalParams
  ): Promise<VirtualNetworkGatewaysGetBgpPeerStatusResponse> {
    const poller = await this.beginGetBgpPeerStatus(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets a xml format representation for supported vpn devices.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  supportedVpnDevices(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysSupportedVpnDevicesOptionalParams
  ): Promise<VirtualNetworkGatewaysSupportedVpnDevicesResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, options },
      supportedVpnDevicesOperationSpec
    );
  }

  /**
   * This operation retrieves a list of routes the virtual network gateway has learned, including routes
   * learned from BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetLearnedRoutes(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetLearnedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetLearnedRoutesResponse>,
      VirtualNetworkGatewaysGetLearnedRoutesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetLearnedRoutesResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      getLearnedRoutesOperationSpec
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
   * This operation retrieves a list of routes the virtual network gateway has learned, including routes
   * learned from BGP peers.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetLearnedRoutesAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetLearnedRoutesOptionalParams
  ): Promise<VirtualNetworkGatewaysGetLearnedRoutesResponse> {
    const poller = await this.beginGetLearnedRoutes(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * This operation retrieves a list of routes the virtual network gateway is advertising to the
   * specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param peer The IP address of the peer.
   * @param options The options parameters.
   */
  async beginGetAdvertisedRoutes(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    peer: string,
    options?: VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysGetAdvertisedRoutesResponse>,
      VirtualNetworkGatewaysGetAdvertisedRoutesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetAdvertisedRoutesResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, peer, options },
      getAdvertisedRoutesOperationSpec
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
   * This operation retrieves a list of routes the virtual network gateway is advertising to the
   * specified peer.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param peer The IP address of the peer.
   * @param options The options parameters.
   */
  async beginGetAdvertisedRoutesAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    peer: string,
    options?: VirtualNetworkGatewaysGetAdvertisedRoutesOptionalParams
  ): Promise<VirtualNetworkGatewaysGetAdvertisedRoutesResponse> {
    const poller = await this.beginGetAdvertisedRoutes(
      resourceGroupName,
      virtualNetworkGatewayName,
      peer,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * The Set VpnclientIpsecParameters operation sets the vpnclient ipsec policy for P2S client of virtual
   * network gateway in the specified resource group through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param vpnclientIpsecParams Parameters supplied to the Begin Set vpnclient ipsec parameters of
   *                             Virtual Network Gateway P2S client operation through Network resource provider.
   * @param options The options parameters.
   */
  async beginSetVpnclientIpsecParameters(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    vpnclientIpsecParams: VpnClientIPsecParameters,
    options?: VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse
      >,
      VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse> => {
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
        virtualNetworkGatewayName,
        vpnclientIpsecParams,
        options
      },
      setVpnclientIpsecParametersOperationSpec
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
   * The Set VpnclientIpsecParameters operation sets the vpnclient ipsec policy for P2S client of virtual
   * network gateway in the specified resource group through Network resource provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param vpnclientIpsecParams Parameters supplied to the Begin Set vpnclient ipsec parameters of
   *                             Virtual Network Gateway P2S client operation through Network resource provider.
   * @param options The options parameters.
   */
  async beginSetVpnclientIpsecParametersAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    vpnclientIpsecParams: VpnClientIPsecParameters,
    options?: VirtualNetworkGatewaysSetVpnclientIpsecParametersOptionalParams
  ): Promise<VirtualNetworkGatewaysSetVpnclientIpsecParametersResponse> {
    const poller = await this.beginSetVpnclientIpsecParameters(
      resourceGroupName,
      virtualNetworkGatewayName,
      vpnclientIpsecParams,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * The Get VpnclientIpsecParameters operation retrieves information about the vpnclient ipsec policy
   * for P2S client of virtual network gateway in the specified resource group through Network resource
   * provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The virtual network gateway name.
   * @param options The options parameters.
   */
  async beginGetVpnclientIpsecParameters(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse
      >,
      VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      getVpnclientIpsecParametersOperationSpec
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
   * The Get VpnclientIpsecParameters operation retrieves information about the vpnclient ipsec policy
   * for P2S client of virtual network gateway in the specified resource group through Network resource
   * provider.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The virtual network gateway name.
   * @param options The options parameters.
   */
  async beginGetVpnclientIpsecParametersAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientIpsecParametersOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnclientIpsecParametersResponse> {
    const poller = await this.beginGetVpnclientIpsecParameters(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets a xml format representation for vpn device configuration script.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayConnectionName The name of the virtual network gateway connection for
   *                                            which the configuration script is generated.
   * @param parameters Parameters supplied to the generate vpn device script operation.
   * @param options The options parameters.
   */
  vpnDeviceConfigurationScript(
    resourceGroupName: string,
    virtualNetworkGatewayConnectionName: string,
    parameters: VpnDeviceScriptParameters,
    options?: VirtualNetworkGatewaysVpnDeviceConfigurationScriptOptionalParams
  ): Promise<VirtualNetworkGatewaysVpnDeviceConfigurationScriptResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualNetworkGatewayConnectionName,
        parameters,
        options
      },
      vpnDeviceConfigurationScriptOperationSpec
    );
  }

  /**
   * Starts packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginStartPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysStartPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysStartPacketCaptureResponse>,
      VirtualNetworkGatewaysStartPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysStartPacketCaptureResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
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
   * Starts packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginStartPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysStartPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewaysStartPacketCaptureResponse> {
    const poller = await this.beginStartPacketCapture(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Stops packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway.
   * @param options The options parameters.
   */
  async beginStopPacketCapture(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewaysStopPacketCaptureOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualNetworkGatewaysStopPacketCaptureResponse>,
      VirtualNetworkGatewaysStopPacketCaptureResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysStopPacketCaptureResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, parameters, options },
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
   * Stops packet capture on virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param parameters Virtual network gateway packet capture parameters supplied to stop packet capture
   *                   on gateway.
   * @param options The options parameters.
   */
  async beginStopPacketCaptureAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    parameters: VpnPacketCaptureStopParameters,
    options?: VirtualNetworkGatewaysStopPacketCaptureOptionalParams
  ): Promise<VirtualNetworkGatewaysStopPacketCaptureResponse> {
    const poller = await this.beginStopPacketCapture(
      resourceGroupName,
      virtualNetworkGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get VPN client connection health detail per P2S client connection of the virtual network gateway in
   * the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetVpnclientConnectionHealth(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse
      >,
      VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse> => {
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
      { resourceGroupName, virtualNetworkGatewayName, options },
      getVpnclientConnectionHealthOperationSpec
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
   * Get VPN client connection health detail per P2S client connection of the virtual network gateway in
   * the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param options The options parameters.
   */
  async beginGetVpnclientConnectionHealthAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    options?: VirtualNetworkGatewaysGetVpnclientConnectionHealthOptionalParams
  ): Promise<VirtualNetworkGatewaysGetVpnclientConnectionHealthResponse> {
    const poller = await this.beginGetVpnclientConnectionHealth(
      resourceGroupName,
      virtualNetworkGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Disconnect vpn connections of virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param request The parameters are supplied to disconnect vpn connections.
   * @param options The options parameters.
   */
  async beginDisconnectVirtualNetworkGatewayVpnConnections(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
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
      { resourceGroupName, virtualNetworkGatewayName, request, options },
      disconnectVirtualNetworkGatewayVpnConnectionsOperationSpec
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
   * Disconnect vpn connections of virtual network gateway in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param request The parameters are supplied to disconnect vpn connections.
   * @param options The options parameters.
   */
  async beginDisconnectVirtualNetworkGatewayVpnConnectionsAndWait(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    request: P2SVpnConnectionRequest,
    options?: VirtualNetworkGatewaysDisconnectVirtualNetworkGatewayVpnConnectionsOptionalParams
  ): Promise<void> {
    const poller = await this.beginDisconnectVirtualNetworkGatewayVpnConnections(
      resourceGroupName,
      virtualNetworkGatewayName,
      request,
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
    options?: VirtualNetworkGatewaysListNextOptionalParams
  ): Promise<VirtualNetworkGatewaysListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListConnectionsNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkGatewayName The name of the virtual network gateway.
   * @param nextLink The nextLink from the previous successful call to the ListConnections method.
   * @param options The options parameters.
   */
  private _listConnectionsNext(
    resourceGroupName: string,
    virtualNetworkGatewayName: string,
    nextLink: string,
    options?: VirtualNetworkGatewaysListConnectionsNextOptionalParams
  ): Promise<VirtualNetworkGatewaysListConnectionsNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkGatewayName, nextLink, options },
      listConnectionsNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters68,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGateway
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}",
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGateway
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayListResult
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
const listConnectionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/connections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayListConnectionsResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const resetOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/reset",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    201: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    202: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    204: {
      bodyMapper: Mappers.VirtualNetworkGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.gatewayVip],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const resetVpnClientSharedKeyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/resetvpnclientsharedkey",
  httpMethod: "POST",
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const generatevpnclientpackageOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnclientpackage",
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
  requestBody: Parameters.parameters69,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const generateVpnProfileOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/generatevpnprofile",
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
  requestBody: Parameters.parameters69,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getVpnProfilePackageUrlOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnprofilepackageurl",
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
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getBgpPeerStatusOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getBgpPeerStatus",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.BgpPeerStatusListResult
    },
    201: {
      bodyMapper: Mappers.BgpPeerStatusListResult
    },
    202: {
      bodyMapper: Mappers.BgpPeerStatusListResult
    },
    204: {
      bodyMapper: Mappers.BgpPeerStatusListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.peer],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const supportedVpnDevicesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/supportedvpndevices",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: { type: { name: "String" } }
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getLearnedRoutesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getLearnedRoutes",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    201: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    202: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    204: {
      bodyMapper: Mappers.GatewayRouteListResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getAdvertisedRoutesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getAdvertisedRoutes",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    201: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    202: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    204: {
      bodyMapper: Mappers.GatewayRouteListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.peer1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const setVpnclientIpsecParametersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/setvpnclientipsecparameters",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    201: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    202: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    204: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnclientIpsecParams,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getVpnclientIpsecParametersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getvpnclientipsecparameters",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    201: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    202: {
      bodyMapper: Mappers.VpnClientIPsecParameters
    },
    204: {
      bodyMapper: Mappers.VpnClientIPsecParameters
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const vpnDeviceConfigurationScriptOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/connections/{virtualNetworkGatewayConnectionName}/vpndeviceconfigurationscript",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: { type: { name: "String" } }
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters70,
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/startPacketCapture",
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const stopPacketCaptureOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/stopPacketCapture",
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getVpnclientConnectionHealthOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/getVpnClientConnectionHealth",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VpnClientConnectionHealthDetailListResult
    },
    201: {
      bodyMapper: Mappers.VpnClientConnectionHealthDetailListResult
    },
    202: {
      bodyMapper: Mappers.VpnClientConnectionHealthDetailListResult
    },
    204: {
      bodyMapper: Mappers.VpnClientConnectionHealthDetailListResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const disconnectVirtualNetworkGatewayVpnConnectionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworkGateways/{virtualNetworkGatewayName}/disconnectVirtualNetworkGatewayVpnConnections",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.request1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayListResult
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
const listConnectionsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualNetworkGatewayListConnectionsResult
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
    Parameters.virtualNetworkGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
