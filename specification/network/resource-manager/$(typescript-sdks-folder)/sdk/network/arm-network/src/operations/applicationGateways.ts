import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ApplicationGateways } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ApplicationGateway,
  ApplicationGatewaysListNextOptionalParams,
  ApplicationGatewaysListOptionalParams,
  ApplicationGatewaysListAllNextOptionalParams,
  ApplicationGatewaysListAllOptionalParams,
  ApplicationGatewaySslPredefinedPolicy,
  ApplicationGatewaysListAvailableSslPredefinedPoliciesNextOptionalParams,
  ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams,
  ApplicationGatewaysDeleteOptionalParams,
  ApplicationGatewaysGetOptionalParams,
  ApplicationGatewaysGetResponse,
  ApplicationGatewaysCreateOrUpdateOptionalParams,
  ApplicationGatewaysCreateOrUpdateResponse,
  TagsObject,
  ApplicationGatewaysUpdateTagsOptionalParams,
  ApplicationGatewaysUpdateTagsResponse,
  ApplicationGatewaysListResponse,
  ApplicationGatewaysListAllResponse,
  ApplicationGatewaysStartOptionalParams,
  ApplicationGatewaysStopOptionalParams,
  ApplicationGatewaysBackendHealthOptionalParams,
  ApplicationGatewaysBackendHealthResponse,
  ApplicationGatewayOnDemandProbe,
  ApplicationGatewaysBackendHealthOnDemandOptionalParams,
  ApplicationGatewaysBackendHealthOnDemandResponse,
  ApplicationGatewaysListAvailableServerVariablesOptionalParams,
  ApplicationGatewaysListAvailableServerVariablesResponse,
  ApplicationGatewaysListAvailableRequestHeadersOptionalParams,
  ApplicationGatewaysListAvailableRequestHeadersResponse,
  ApplicationGatewaysListAvailableResponseHeadersOptionalParams,
  ApplicationGatewaysListAvailableResponseHeadersResponse,
  ApplicationGatewaysListAvailableWafRuleSetsOptionalParams,
  ApplicationGatewaysListAvailableWafRuleSetsResponse,
  ApplicationGatewaysListAvailableSslOptionsOptionalParams,
  ApplicationGatewaysListAvailableSslOptionsResponse,
  ApplicationGatewaysListAvailableSslPredefinedPoliciesResponse,
  ApplicationGatewaysGetSslPredefinedPolicyOptionalParams,
  ApplicationGatewaysGetSslPredefinedPolicyResponse,
  ApplicationGatewaysListNextResponse,
  ApplicationGatewaysListAllNextResponse,
  ApplicationGatewaysListAvailableSslPredefinedPoliciesNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ApplicationGateways operations. */
export class ApplicationGatewaysImpl implements ApplicationGateways {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ApplicationGateways class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all application gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: ApplicationGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGateway> {
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
    options?: ApplicationGatewaysListOptionalParams
  ): AsyncIterableIterator<ApplicationGateway[]> {
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
    options?: ApplicationGatewaysListOptionalParams
  ): AsyncIterableIterator<ApplicationGateway> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all the application gateways in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: ApplicationGatewaysListAllOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGateway> {
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
    options?: ApplicationGatewaysListAllOptionalParams
  ): AsyncIterableIterator<ApplicationGateway[]> {
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
    options?: ApplicationGatewaysListAllOptionalParams
  ): AsyncIterableIterator<ApplicationGateway> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Lists all SSL predefined policies for configuring Ssl policy.
   * @param options The options parameters.
   */
  public listAvailableSslPredefinedPolicies(
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGatewaySslPredefinedPolicy> {
    const iter = this.listAvailableSslPredefinedPoliciesPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listAvailableSslPredefinedPoliciesPagingPage(options);
      }
    };
  }

  private async *listAvailableSslPredefinedPoliciesPagingPage(
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  ): AsyncIterableIterator<ApplicationGatewaySslPredefinedPolicy[]> {
    let result = await this._listAvailableSslPredefinedPolicies(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAvailableSslPredefinedPoliciesNext(
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAvailableSslPredefinedPoliciesPagingAll(
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  ): AsyncIterableIterator<ApplicationGatewaySslPredefinedPolicy> {
    for await (const page of this.listAvailableSslPredefinedPoliciesPagingPage(
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysDeleteOptionalParams
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
      { resourceGroupName, applicationGatewayName, options },
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
   * Deletes the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      applicationGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysGetOptionalParams
  ): Promise<ApplicationGatewaysGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationGatewayName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to the create or update application gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: ApplicationGateway,
    options?: ApplicationGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysCreateOrUpdateResponse>,
      ApplicationGatewaysCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ApplicationGatewaysCreateOrUpdateResponse> => {
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
      { resourceGroupName, applicationGatewayName, parameters, options },
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
   * Creates or updates the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to the create or update application gateway operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: ApplicationGateway,
    options?: ApplicationGatewaysCreateOrUpdateOptionalParams
  ): Promise<ApplicationGatewaysCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      applicationGatewayName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates the specified application gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to update application gateway tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: TagsObject,
    options?: ApplicationGatewaysUpdateTagsOptionalParams
  ): Promise<ApplicationGatewaysUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, applicationGatewayName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Lists all application gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: ApplicationGatewaysListOptionalParams
  ): Promise<ApplicationGatewaysListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all the application gateways in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: ApplicationGatewaysListAllOptionalParams
  ): Promise<ApplicationGatewaysListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Starts the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginStart(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStartOptionalParams
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
      { resourceGroupName, applicationGatewayName, options },
      startOperationSpec
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
   * Starts the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginStartAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStartOptionalParams
  ): Promise<void> {
    const poller = await this.beginStart(
      resourceGroupName,
      applicationGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Stops the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginStop(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStopOptionalParams
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
      { resourceGroupName, applicationGatewayName, options },
      stopOperationSpec
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
   * Stops the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginStopAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStopOptionalParams
  ): Promise<void> {
    const poller = await this.beginStop(
      resourceGroupName,
      applicationGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the backend health of the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginBackendHealth(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysBackendHealthOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysBackendHealthResponse>,
      ApplicationGatewaysBackendHealthResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ApplicationGatewaysBackendHealthResponse> => {
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
      { resourceGroupName, applicationGatewayName, options },
      backendHealthOperationSpec
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
   * Gets the backend health of the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  async beginBackendHealthAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysBackendHealthOptionalParams
  ): Promise<ApplicationGatewaysBackendHealthResponse> {
    const poller = await this.beginBackendHealth(
      resourceGroupName,
      applicationGatewayName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the backend health for given combination of backend pool and http setting of the specified
   * application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param probeRequest Request body for on-demand test probe operation.
   * @param options The options parameters.
   */
  async beginBackendHealthOnDemand(
    resourceGroupName: string,
    applicationGatewayName: string,
    probeRequest: ApplicationGatewayOnDemandProbe,
    options?: ApplicationGatewaysBackendHealthOnDemandOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysBackendHealthOnDemandResponse>,
      ApplicationGatewaysBackendHealthOnDemandResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ApplicationGatewaysBackendHealthOnDemandResponse> => {
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
      { resourceGroupName, applicationGatewayName, probeRequest, options },
      backendHealthOnDemandOperationSpec
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
   * Gets the backend health for given combination of backend pool and http setting of the specified
   * application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param probeRequest Request body for on-demand test probe operation.
   * @param options The options parameters.
   */
  async beginBackendHealthOnDemandAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    probeRequest: ApplicationGatewayOnDemandProbe,
    options?: ApplicationGatewaysBackendHealthOnDemandOptionalParams
  ): Promise<ApplicationGatewaysBackendHealthOnDemandResponse> {
    const poller = await this.beginBackendHealthOnDemand(
      resourceGroupName,
      applicationGatewayName,
      probeRequest,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all available server variables.
   * @param options The options parameters.
   */
  listAvailableServerVariables(
    options?: ApplicationGatewaysListAvailableServerVariablesOptionalParams
  ): Promise<ApplicationGatewaysListAvailableServerVariablesResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableServerVariablesOperationSpec
    );
  }

  /**
   * Lists all available request headers.
   * @param options The options parameters.
   */
  listAvailableRequestHeaders(
    options?: ApplicationGatewaysListAvailableRequestHeadersOptionalParams
  ): Promise<ApplicationGatewaysListAvailableRequestHeadersResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableRequestHeadersOperationSpec
    );
  }

  /**
   * Lists all available response headers.
   * @param options The options parameters.
   */
  listAvailableResponseHeaders(
    options?: ApplicationGatewaysListAvailableResponseHeadersOptionalParams
  ): Promise<ApplicationGatewaysListAvailableResponseHeadersResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableResponseHeadersOperationSpec
    );
  }

  /**
   * Lists all available web application firewall rule sets.
   * @param options The options parameters.
   */
  listAvailableWafRuleSets(
    options?: ApplicationGatewaysListAvailableWafRuleSetsOptionalParams
  ): Promise<ApplicationGatewaysListAvailableWafRuleSetsResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableWafRuleSetsOperationSpec
    );
  }

  /**
   * Lists available Ssl options for configuring Ssl policy.
   * @param options The options parameters.
   */
  listAvailableSslOptions(
    options?: ApplicationGatewaysListAvailableSslOptionsOptionalParams
  ): Promise<ApplicationGatewaysListAvailableSslOptionsResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableSslOptionsOperationSpec
    );
  }

  /**
   * Lists all SSL predefined policies for configuring Ssl policy.
   * @param options The options parameters.
   */
  private _listAvailableSslPredefinedPolicies(
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  ): Promise<ApplicationGatewaysListAvailableSslPredefinedPoliciesResponse> {
    return this.client.sendOperationRequest(
      { options },
      listAvailableSslPredefinedPoliciesOperationSpec
    );
  }

  /**
   * Gets Ssl predefined policy with the specified policy name.
   * @param predefinedPolicyName Name of Ssl predefined policy.
   * @param options The options parameters.
   */
  getSslPredefinedPolicy(
    predefinedPolicyName: string,
    options?: ApplicationGatewaysGetSslPredefinedPolicyOptionalParams
  ): Promise<ApplicationGatewaysGetSslPredefinedPolicyResponse> {
    return this.client.sendOperationRequest(
      { predefinedPolicyName, options },
      getSslPredefinedPolicyOperationSpec
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
    options?: ApplicationGatewaysListNextOptionalParams
  ): Promise<ApplicationGatewaysListNextResponse> {
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
    options?: ApplicationGatewaysListAllNextOptionalParams
  ): Promise<ApplicationGatewaysListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }

  /**
   * ListAvailableSslPredefinedPoliciesNext
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListAvailableSslPredefinedPolicies method.
   * @param options The options parameters.
   */
  private _listAvailableSslPredefinedPoliciesNext(
    nextLink: string,
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesNextOptionalParams
  ): Promise<
    ApplicationGatewaysListAvailableSslPredefinedPoliciesNextResponse
  > {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAvailableSslPredefinedPoliciesNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}",
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
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGateway
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
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGateway
    },
    201: {
      bodyMapper: Mappers.ApplicationGateway
    },
    202: {
      bodyMapper: Mappers.ApplicationGateway
    },
    204: {
      bodyMapper: Mappers.ApplicationGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGateway
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
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayListResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayListResult
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
const startOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/start",
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
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const stopOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/stop",
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
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const backendHealthOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/backendhealth",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealth
    },
    201: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealth
    },
    202: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealth
    },
    204: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealth
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const backendHealthOnDemandOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/getBackendHealthOnDemand",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealthOnDemand
    },
    201: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealthOnDemand
    },
    202: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealthOnDemand
    },
    204: {
      bodyMapper: Mappers.ApplicationGatewayBackendHealthOnDemand
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.probeRequest,
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.applicationGatewayName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAvailableServerVariablesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableServerVariables",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "String" } } }
      }
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
const listAvailableRequestHeadersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableRequestHeaders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "String" } } }
      }
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
const listAvailableResponseHeadersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableResponseHeaders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: {
        type: { name: "Sequence", element: { type: { name: "String" } } }
      }
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
const listAvailableWafRuleSetsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableWafRuleSets",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayAvailableWafRuleSetsResult
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
const listAvailableSslOptionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableSslOptions/default",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayAvailableSslOptions
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
const listAvailableSslPredefinedPoliciesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayAvailableSslPredefinedPolicies
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
const getSslPredefinedPolicyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewaySslPredefinedPolicy
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.predefinedPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayListResult
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
      bodyMapper: Mappers.ApplicationGatewayListResult
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
const listAvailableSslPredefinedPoliciesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ApplicationGatewayAvailableSslPredefinedPolicies
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
