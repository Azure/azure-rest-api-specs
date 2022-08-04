import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PrivateLinkServices } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  PrivateLinkService,
  PrivateLinkServicesListNextOptionalParams,
  PrivateLinkServicesListOptionalParams,
  PrivateLinkServicesListBySubscriptionNextOptionalParams,
  PrivateLinkServicesListBySubscriptionOptionalParams,
  PrivateEndpointConnection,
  PrivateLinkServicesListPrivateEndpointConnectionsNextOptionalParams,
  PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams,
  AutoApprovedPrivateLinkService,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextOptionalParams,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextOptionalParams,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams,
  PrivateLinkServicesDeleteOptionalParams,
  PrivateLinkServicesGetOptionalParams,
  PrivateLinkServicesGetResponse,
  PrivateLinkServicesCreateOrUpdateOptionalParams,
  PrivateLinkServicesCreateOrUpdateResponse,
  PrivateLinkServicesListResponse,
  PrivateLinkServicesListBySubscriptionResponse,
  PrivateLinkServicesGetPrivateEndpointConnectionOptionalParams,
  PrivateLinkServicesGetPrivateEndpointConnectionResponse,
  PrivateLinkServicesUpdatePrivateEndpointConnectionOptionalParams,
  PrivateLinkServicesUpdatePrivateEndpointConnectionResponse,
  PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams,
  PrivateLinkServicesListPrivateEndpointConnectionsResponse,
  CheckPrivateLinkServiceVisibilityRequest,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams,
  PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesResponse,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupResponse,
  PrivateLinkServicesListNextResponse,
  PrivateLinkServicesListBySubscriptionNextResponse,
  PrivateLinkServicesListPrivateEndpointConnectionsNextResponse,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextResponse,
  PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing PrivateLinkServices operations. */
export class PrivateLinkServicesImpl implements PrivateLinkServices {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class PrivateLinkServices class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all private link services in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: PrivateLinkServicesListOptionalParams
  ): PagedAsyncIterableIterator<PrivateLinkService> {
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
    options?: PrivateLinkServicesListOptionalParams
  ): AsyncIterableIterator<PrivateLinkService[]> {
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
    options?: PrivateLinkServicesListOptionalParams
  ): AsyncIterableIterator<PrivateLinkService> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all private link service in a subscription.
   * @param options The options parameters.
   */
  public listBySubscription(
    options?: PrivateLinkServicesListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<PrivateLinkService> {
    const iter = this.listBySubscriptionPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listBySubscriptionPagingPage(options);
      }
    };
  }

  private async *listBySubscriptionPagingPage(
    options?: PrivateLinkServicesListBySubscriptionOptionalParams
  ): AsyncIterableIterator<PrivateLinkService[]> {
    let result = await this._listBySubscription(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listBySubscriptionNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listBySubscriptionPagingAll(
    options?: PrivateLinkServicesListBySubscriptionOptionalParams
  ): AsyncIterableIterator<PrivateLinkService> {
    for await (const page of this.listBySubscriptionPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all private end point connections for a specific private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  public listPrivateEndpointConnections(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  ): PagedAsyncIterableIterator<PrivateEndpointConnection> {
    const iter = this.listPrivateEndpointConnectionsPagingAll(
      resourceGroupName,
      serviceName,
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
        return this.listPrivateEndpointConnectionsPagingPage(
          resourceGroupName,
          serviceName,
          options
        );
      }
    };
  }

  private async *listPrivateEndpointConnectionsPagingPage(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  ): AsyncIterableIterator<PrivateEndpointConnection[]> {
    let result = await this._listPrivateEndpointConnections(
      resourceGroupName,
      serviceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listPrivateEndpointConnectionsNext(
        resourceGroupName,
        serviceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPrivateEndpointConnectionsPagingAll(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  ): AsyncIterableIterator<PrivateEndpointConnection> {
    for await (const page of this.listPrivateEndpointConnectionsPagingPage(
      resourceGroupName,
      serviceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  public listAutoApprovedPrivateLinkServices(
    location: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  ): PagedAsyncIterableIterator<AutoApprovedPrivateLinkService> {
    const iter = this.listAutoApprovedPrivateLinkServicesPagingAll(
      location,
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
        return this.listAutoApprovedPrivateLinkServicesPagingPage(
          location,
          options
        );
      }
    };
  }

  private async *listAutoApprovedPrivateLinkServicesPagingPage(
    location: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  ): AsyncIterableIterator<AutoApprovedPrivateLinkService[]> {
    let result = await this._listAutoApprovedPrivateLinkServices(
      location,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAutoApprovedPrivateLinkServicesNext(
        location,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAutoApprovedPrivateLinkServicesPagingAll(
    location: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  ): AsyncIterableIterator<AutoApprovedPrivateLinkService> {
    for await (const page of this.listAutoApprovedPrivateLinkServicesPagingPage(
      location,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listAutoApprovedPrivateLinkServicesByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AutoApprovedPrivateLinkService> {
    const iter = this.listAutoApprovedPrivateLinkServicesByResourceGroupPagingAll(
      location,
      resourceGroupName,
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
        return this.listAutoApprovedPrivateLinkServicesByResourceGroupPagingPage(
          location,
          resourceGroupName,
          options
        );
      }
    };
  }

  private async *listAutoApprovedPrivateLinkServicesByResourceGroupPagingPage(
    location: string,
    resourceGroupName: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  ): AsyncIterableIterator<AutoApprovedPrivateLinkService[]> {
    let result = await this._listAutoApprovedPrivateLinkServicesByResourceGroup(
      location,
      resourceGroupName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAutoApprovedPrivateLinkServicesByResourceGroupNext(
        location,
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAutoApprovedPrivateLinkServicesByResourceGroupPagingAll(
    location: string,
    resourceGroupName: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  ): AsyncIterableIterator<AutoApprovedPrivateLinkService> {
    for await (const page of this.listAutoApprovedPrivateLinkServicesByResourceGroupPagingPage(
      location,
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesDeleteOptionalParams
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
      { resourceGroupName, serviceName, options },
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
   * Deletes the specified private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      serviceName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified private link service by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesGetOptionalParams
  ): Promise<PrivateLinkServicesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates an private link service in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param parameters Parameters supplied to the create or update private link service operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    serviceName: string,
    parameters: PrivateLinkService,
    options?: PrivateLinkServicesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PrivateLinkServicesCreateOrUpdateResponse>,
      PrivateLinkServicesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PrivateLinkServicesCreateOrUpdateResponse> => {
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
      { resourceGroupName, serviceName, parameters, options },
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
   * Creates or updates an private link service in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param parameters Parameters supplied to the create or update private link service operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    serviceName: string,
    parameters: PrivateLinkService,
    options?: PrivateLinkServicesCreateOrUpdateOptionalParams
  ): Promise<PrivateLinkServicesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      serviceName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all private link services in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: PrivateLinkServicesListOptionalParams
  ): Promise<PrivateLinkServicesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all private link service in a subscription.
   * @param options The options parameters.
   */
  private _listBySubscription(
    options?: PrivateLinkServicesListBySubscriptionOptionalParams
  ): Promise<PrivateLinkServicesListBySubscriptionResponse> {
    return this.client.sendOperationRequest(
      { options },
      listBySubscriptionOperationSpec
    );
  }

  /**
   * Get the specific private end point connection by specific private link service in the resource
   * group.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  getPrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesGetPrivateEndpointConnectionOptionalParams
  ): Promise<PrivateLinkServicesGetPrivateEndpointConnectionResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceName, peConnectionName, options },
      getPrivateEndpointConnectionOperationSpec
    );
  }

  /**
   * Approve or reject private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param parameters Parameters supplied to approve or reject the private end point connection.
   * @param options The options parameters.
   */
  updatePrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    parameters: PrivateEndpointConnection,
    options?: PrivateLinkServicesUpdatePrivateEndpointConnectionOptionalParams
  ): Promise<PrivateLinkServicesUpdatePrivateEndpointConnectionResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceName, peConnectionName, parameters, options },
      updatePrivateEndpointConnectionOperationSpec
    );
  }

  /**
   * Delete private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  async beginDeletePrivateEndpointConnection(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams
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
      { resourceGroupName, serviceName, peConnectionName, options },
      deletePrivateEndpointConnectionOperationSpec
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
   * Delete private end point connection for a private link service in a subscription.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param peConnectionName The name of the private end point connection.
   * @param options The options parameters.
   */
  async beginDeletePrivateEndpointConnectionAndWait(
    resourceGroupName: string,
    serviceName: string,
    peConnectionName: string,
    options?: PrivateLinkServicesDeletePrivateEndpointConnectionOptionalParams
  ): Promise<void> {
    const poller = await this.beginDeletePrivateEndpointConnection(
      resourceGroupName,
      serviceName,
      peConnectionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all private end point connections for a specific private link service.
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param options The options parameters.
   */
  private _listPrivateEndpointConnections(
    resourceGroupName: string,
    serviceName: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsOptionalParams
  ): Promise<PrivateLinkServicesListPrivateEndpointConnectionsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceName, options },
      listPrivateEndpointConnectionsOperationSpec
    );
  }

  /**
   * Checks whether the subscription is visible to private link service.
   * @param location The location of the domain name.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  async beginCheckPrivateLinkServiceVisibility(
    location: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse
      >,
      PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse> => {
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
      { location, parameters, options },
      checkPrivateLinkServiceVisibilityOperationSpec
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
   * Checks whether the subscription is visible to private link service.
   * @param location The location of the domain name.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  async beginCheckPrivateLinkServiceVisibilityAndWait(
    location: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityOptionalParams
  ): Promise<PrivateLinkServicesCheckPrivateLinkServiceVisibilityResponse> {
    const poller = await this.beginCheckPrivateLinkServiceVisibility(
      location,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Checks whether the subscription is visible to private link service in the specified resource group.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  async beginCheckPrivateLinkServiceVisibilityByResourceGroup(
    location: string,
    resourceGroupName: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
      >,
      PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse> => {
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
      { location, resourceGroupName, parameters, options },
      checkPrivateLinkServiceVisibilityByResourceGroupOperationSpec
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
   * Checks whether the subscription is visible to private link service in the specified resource group.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param parameters The request body of CheckPrivateLinkService API call.
   * @param options The options parameters.
   */
  async beginCheckPrivateLinkServiceVisibilityByResourceGroupAndWait(
    location: string,
    resourceGroupName: string,
    parameters: CheckPrivateLinkServiceVisibilityRequest,
    options?: PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupOptionalParams
  ): Promise<
    PrivateLinkServicesCheckPrivateLinkServiceVisibilityByResourceGroupResponse
  > {
    const poller = await this.beginCheckPrivateLinkServiceVisibilityByResourceGroup(
      location,
      resourceGroupName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  private _listAutoApprovedPrivateLinkServices(
    location: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesOptionalParams
  ): Promise<PrivateLinkServicesListAutoApprovedPrivateLinkServicesResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listAutoApprovedPrivateLinkServicesOperationSpec
    );
  }

  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto
   * approved in this subscription in this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listAutoApprovedPrivateLinkServicesByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupOptionalParams
  ): Promise<
    PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupResponse
  > {
    return this.client.sendOperationRequest(
      { location, resourceGroupName, options },
      listAutoApprovedPrivateLinkServicesByResourceGroupOperationSpec
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
    options?: PrivateLinkServicesListNextOptionalParams
  ): Promise<PrivateLinkServicesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListBySubscriptionNext
   * @param nextLink The nextLink from the previous successful call to the ListBySubscription method.
   * @param options The options parameters.
   */
  private _listBySubscriptionNext(
    nextLink: string,
    options?: PrivateLinkServicesListBySubscriptionNextOptionalParams
  ): Promise<PrivateLinkServicesListBySubscriptionNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listBySubscriptionNextOperationSpec
    );
  }

  /**
   * ListPrivateEndpointConnectionsNext
   * @param resourceGroupName The name of the resource group.
   * @param serviceName The name of the private link service.
   * @param nextLink The nextLink from the previous successful call to the ListPrivateEndpointConnections
   *                 method.
   * @param options The options parameters.
   */
  private _listPrivateEndpointConnectionsNext(
    resourceGroupName: string,
    serviceName: string,
    nextLink: string,
    options?: PrivateLinkServicesListPrivateEndpointConnectionsNextOptionalParams
  ): Promise<PrivateLinkServicesListPrivateEndpointConnectionsNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceName, nextLink, options },
      listPrivateEndpointConnectionsNextOperationSpec
    );
  }

  /**
   * ListAutoApprovedPrivateLinkServicesNext
   * @param location The location of the domain name.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListAutoApprovedPrivateLinkServices method.
   * @param options The options parameters.
   */
  private _listAutoApprovedPrivateLinkServicesNext(
    location: string,
    nextLink: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextOptionalParams
  ): Promise<
    PrivateLinkServicesListAutoApprovedPrivateLinkServicesNextResponse
  > {
    return this.client.sendOperationRequest(
      { location, nextLink, options },
      listAutoApprovedPrivateLinkServicesNextOperationSpec
    );
  }

  /**
   * ListAutoApprovedPrivateLinkServicesByResourceGroupNext
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListAutoApprovedPrivateLinkServicesByResourceGroup method.
   * @param options The options parameters.
   */
  private _listAutoApprovedPrivateLinkServicesByResourceGroupNext(
    location: string,
    resourceGroupName: string,
    nextLink: string,
    options?: PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextOptionalParams
  ): Promise<
    PrivateLinkServicesListAutoApprovedPrivateLinkServicesByResourceGroupNextResponse
  > {
    return this.client.sendOperationRequest(
      { location, resourceGroupName, nextLink, options },
      listAutoApprovedPrivateLinkServicesByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkService
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkService
    },
    201: {
      bodyMapper: Mappers.PrivateLinkService
    },
    202: {
      bodyMapper: Mappers.PrivateLinkService
    },
    204: {
      bodyMapper: Mappers.PrivateLinkService
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters60,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
const listBySubscriptionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/privateLinkServices",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getPrivateEndpointConnectionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateEndpointConnection
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName,
    Parameters.peConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updatePrivateEndpointConnectionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateEndpointConnection
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  requestBody: Parameters.parameters61,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName,
    Parameters.peConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deletePrivateEndpointConnectionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName,
    Parameters.peConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listPrivateEndpointConnectionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateEndpointConnectionListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const checkPrivateLinkServiceVisibilityOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    201: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    202: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    204: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters62,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const checkPrivateLinkServiceVisibilityByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    201: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    202: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    204: {
      bodyMapper: Mappers.PrivateLinkServiceVisibility
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters62,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAutoApprovedPrivateLinkServicesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AutoApprovedPrivateLinkServicesResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAutoApprovedPrivateLinkServicesByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AutoApprovedPrivateLinkServicesResult
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
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
const listBySubscriptionNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateLinkServiceListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
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
const listPrivateEndpointConnectionsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.PrivateEndpointConnectionListResult
    },
    default: {
      bodyMapper: Mappers.ErrorModel
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.serviceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAutoApprovedPrivateLinkServicesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AutoApprovedPrivateLinkServicesResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAutoApprovedPrivateLinkServicesByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AutoApprovedPrivateLinkServicesResult
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
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
