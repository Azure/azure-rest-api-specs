import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkWatchers } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkWatcher,
  NetworkWatchersListOptionalParams,
  NetworkWatchersListAllOptionalParams,
  NetworkWatchersCreateOrUpdateOptionalParams,
  NetworkWatchersCreateOrUpdateResponse,
  NetworkWatchersGetOptionalParams,
  NetworkWatchersGetResponse,
  NetworkWatchersDeleteOptionalParams,
  TagsObject,
  NetworkWatchersUpdateTagsOptionalParams,
  NetworkWatchersUpdateTagsResponse,
  NetworkWatchersListResponse,
  NetworkWatchersListAllResponse,
  TopologyParameters,
  NetworkWatchersGetTopologyOptionalParams,
  NetworkWatchersGetTopologyResponse,
  VerificationIPFlowParameters,
  NetworkWatchersVerifyIPFlowOptionalParams,
  NetworkWatchersVerifyIPFlowResponse,
  NextHopParameters,
  NetworkWatchersGetNextHopOptionalParams,
  NetworkWatchersGetNextHopResponse,
  SecurityGroupViewParameters,
  NetworkWatchersGetVMSecurityRulesOptionalParams,
  NetworkWatchersGetVMSecurityRulesResponse,
  TroubleshootingParameters,
  NetworkWatchersGetTroubleshootingOptionalParams,
  NetworkWatchersGetTroubleshootingResponse,
  QueryTroubleshootingParameters,
  NetworkWatchersGetTroubleshootingResultOptionalParams,
  NetworkWatchersGetTroubleshootingResultResponse,
  FlowLogInformation,
  NetworkWatchersSetFlowLogConfigurationOptionalParams,
  NetworkWatchersSetFlowLogConfigurationResponse,
  FlowLogStatusParameters,
  NetworkWatchersGetFlowLogStatusOptionalParams,
  NetworkWatchersGetFlowLogStatusResponse,
  ConnectivityParameters,
  NetworkWatchersCheckConnectivityOptionalParams,
  NetworkWatchersCheckConnectivityResponse,
  AzureReachabilityReportParameters,
  NetworkWatchersGetAzureReachabilityReportOptionalParams,
  NetworkWatchersGetAzureReachabilityReportResponse,
  AvailableProvidersListParameters,
  NetworkWatchersListAvailableProvidersOptionalParams,
  NetworkWatchersListAvailableProvidersResponse,
  NetworkConfigurationDiagnosticParameters,
  NetworkWatchersGetNetworkConfigurationDiagnosticOptionalParams,
  NetworkWatchersGetNetworkConfigurationDiagnosticResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkWatchers operations. */
export class NetworkWatchersImpl implements NetworkWatchers {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkWatchers class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all network watchers by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: NetworkWatchersListOptionalParams
  ): PagedAsyncIterableIterator<NetworkWatcher> {
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
    options?: NetworkWatchersListOptionalParams
  ): AsyncIterableIterator<NetworkWatcher[]> {
    let result = await this._list(resourceGroupName, options);
    yield result.value || [];
  }

  private async *listPagingAll(
    resourceGroupName: string,
    options?: NetworkWatchersListOptionalParams
  ): AsyncIterableIterator<NetworkWatcher> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets all network watchers by subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: NetworkWatchersListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkWatcher> {
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
    options?: NetworkWatchersListAllOptionalParams
  ): AsyncIterableIterator<NetworkWatcher[]> {
    let result = await this._listAll(options);
    yield result.value || [];
  }

  private async *listAllPagingAll(
    options?: NetworkWatchersListAllOptionalParams
  ): AsyncIterableIterator<NetworkWatcher> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Creates or updates a network watcher in the specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the network watcher resource.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NetworkWatcher,
    options?: NetworkWatchersCreateOrUpdateOptionalParams
  ): Promise<NetworkWatchersCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, parameters, options },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Gets the specified network watcher by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: NetworkWatchersGetOptionalParams
  ): Promise<NetworkWatchersGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified network watcher resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: NetworkWatchersDeleteOptionalParams
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
      { resourceGroupName, networkWatcherName, options },
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
   * Deletes the specified network watcher resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: NetworkWatchersDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkWatcherName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates a network watcher tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters supplied to update network watcher tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TagsObject,
    options?: NetworkWatchersUpdateTagsOptionalParams
  ): Promise<NetworkWatchersUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all network watchers by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: NetworkWatchersListOptionalParams
  ): Promise<NetworkWatchersListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all network watchers by subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: NetworkWatchersListAllOptionalParams
  ): Promise<NetworkWatchersListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets the current network topology by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the representation of topology.
   * @param options The options parameters.
   */
  getTopology(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TopologyParameters,
    options?: NetworkWatchersGetTopologyOptionalParams
  ): Promise<NetworkWatchersGetTopologyResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkWatcherName, parameters, options },
      getTopologyOperationSpec
    );
  }

  /**
   * Verify IP flow from the specified VM to a location given the currently configured NSG rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the IP flow to be verified.
   * @param options The options parameters.
   */
  async beginVerifyIPFlow(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: VerificationIPFlowParameters,
    options?: NetworkWatchersVerifyIPFlowOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersVerifyIPFlowResponse>,
      NetworkWatchersVerifyIPFlowResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersVerifyIPFlowResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      verifyIPFlowOperationSpec
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
   * Verify IP flow from the specified VM to a location given the currently configured NSG rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the IP flow to be verified.
   * @param options The options parameters.
   */
  async beginVerifyIPFlowAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: VerificationIPFlowParameters,
    options?: NetworkWatchersVerifyIPFlowOptionalParams
  ): Promise<NetworkWatchersVerifyIPFlowResponse> {
    const poller = await this.beginVerifyIPFlow(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the next hop from the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the source and destination endpoint.
   * @param options The options parameters.
   */
  async beginGetNextHop(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NextHopParameters,
    options?: NetworkWatchersGetNextHopOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetNextHopResponse>,
      NetworkWatchersGetNextHopResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetNextHopResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getNextHopOperationSpec
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
   * Gets the next hop from the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the source and destination endpoint.
   * @param options The options parameters.
   */
  async beginGetNextHopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NextHopParameters,
    options?: NetworkWatchersGetNextHopOptionalParams
  ): Promise<NetworkWatchersGetNextHopResponse> {
    const poller = await this.beginGetNextHop(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the configured and effective security group rules on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the VM to check security groups for.
   * @param options The options parameters.
   */
  async beginGetVMSecurityRules(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: SecurityGroupViewParameters,
    options?: NetworkWatchersGetVMSecurityRulesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetVMSecurityRulesResponse>,
      NetworkWatchersGetVMSecurityRulesResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetVMSecurityRulesResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getVMSecurityRulesOperationSpec
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
   * Gets the configured and effective security group rules on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the VM to check security groups for.
   * @param options The options parameters.
   */
  async beginGetVMSecurityRulesAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: SecurityGroupViewParameters,
    options?: NetworkWatchersGetVMSecurityRulesOptionalParams
  ): Promise<NetworkWatchersGetVMSecurityRulesResponse> {
    const poller = await this.beginGetVMSecurityRules(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Initiate troubleshooting on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to troubleshoot.
   * @param options The options parameters.
   */
  async beginGetTroubleshooting(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetTroubleshootingResponse>,
      NetworkWatchersGetTroubleshootingResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetTroubleshootingResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getTroubleshootingOperationSpec
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
   * Initiate troubleshooting on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to troubleshoot.
   * @param options The options parameters.
   */
  async beginGetTroubleshootingAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingOptionalParams
  ): Promise<NetworkWatchersGetTroubleshootingResponse> {
    const poller = await this.beginGetTroubleshooting(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get the last completed troubleshooting result on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to query the troubleshooting result.
   * @param options The options parameters.
   */
  async beginGetTroubleshootingResult(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: QueryTroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingResultOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetTroubleshootingResultResponse>,
      NetworkWatchersGetTroubleshootingResultResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetTroubleshootingResultResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getTroubleshootingResultOperationSpec
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
   * Get the last completed troubleshooting result on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to query the troubleshooting result.
   * @param options The options parameters.
   */
  async beginGetTroubleshootingResultAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: QueryTroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingResultOptionalParams
  ): Promise<NetworkWatchersGetTroubleshootingResultResponse> {
    const poller = await this.beginGetTroubleshootingResult(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Configures flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the configuration of flow log.
   * @param options The options parameters.
   */
  async beginSetFlowLogConfiguration(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogInformation,
    options?: NetworkWatchersSetFlowLogConfigurationOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersSetFlowLogConfigurationResponse>,
      NetworkWatchersSetFlowLogConfigurationResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersSetFlowLogConfigurationResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      setFlowLogConfigurationOperationSpec
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
   * Configures flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the configuration of flow log.
   * @param options The options parameters.
   */
  async beginSetFlowLogConfigurationAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogInformation,
    options?: NetworkWatchersSetFlowLogConfigurationOptionalParams
  ): Promise<NetworkWatchersSetFlowLogConfigurationResponse> {
    const poller = await this.beginSetFlowLogConfiguration(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Queries status of flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define a resource to query flow log and traffic analytics
   *                   (optional) status.
   * @param options The options parameters.
   */
  async beginGetFlowLogStatus(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogStatusParameters,
    options?: NetworkWatchersGetFlowLogStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetFlowLogStatusResponse>,
      NetworkWatchersGetFlowLogStatusResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetFlowLogStatusResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getFlowLogStatusOperationSpec
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
   * Queries status of flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define a resource to query flow log and traffic analytics
   *                   (optional) status.
   * @param options The options parameters.
   */
  async beginGetFlowLogStatusAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogStatusParameters,
    options?: NetworkWatchersGetFlowLogStatusOptionalParams
  ): Promise<NetworkWatchersGetFlowLogStatusResponse> {
    const poller = await this.beginGetFlowLogStatus(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Verifies the possibility of establishing a direct TCP connection from a virtual machine to a given
   * endpoint including another VM or an arbitrary remote server.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine how the connectivity check will be performed.
   * @param options The options parameters.
   */
  async beginCheckConnectivity(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: ConnectivityParameters,
    options?: NetworkWatchersCheckConnectivityOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersCheckConnectivityResponse>,
      NetworkWatchersCheckConnectivityResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersCheckConnectivityResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      checkConnectivityOperationSpec
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
   * Verifies the possibility of establishing a direct TCP connection from a virtual machine to a given
   * endpoint including another VM or an arbitrary remote server.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine how the connectivity check will be performed.
   * @param options The options parameters.
   */
  async beginCheckConnectivityAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: ConnectivityParameters,
    options?: NetworkWatchersCheckConnectivityOptionalParams
  ): Promise<NetworkWatchersCheckConnectivityResponse> {
    const poller = await this.beginCheckConnectivity(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Gets the relative
   * latency score for internet service providers from a specified location to Azure regions.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine Azure reachability report configuration.
   * @param options The options parameters.
   */
  async beginGetAzureReachabilityReport(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AzureReachabilityReportParameters,
    options?: NetworkWatchersGetAzureReachabilityReportOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetAzureReachabilityReportResponse>,
      NetworkWatchersGetAzureReachabilityReportResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetAzureReachabilityReportResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getAzureReachabilityReportOperationSpec
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
   * NOTE: This feature is currently in preview and still being tested for stability. Gets the relative
   * latency score for internet service providers from a specified location to Azure regions.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine Azure reachability report configuration.
   * @param options The options parameters.
   */
  async beginGetAzureReachabilityReportAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AzureReachabilityReportParameters,
    options?: NetworkWatchersGetAzureReachabilityReportOptionalParams
  ): Promise<NetworkWatchersGetAzureReachabilityReportResponse> {
    const poller = await this.beginGetAzureReachabilityReport(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Lists all available
   * internet service providers for a specified Azure region.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that scope the list of available providers.
   * @param options The options parameters.
   */
  async beginListAvailableProviders(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AvailableProvidersListParameters,
    options?: NetworkWatchersListAvailableProvidersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersListAvailableProvidersResponse>,
      NetworkWatchersListAvailableProvidersResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersListAvailableProvidersResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      listAvailableProvidersOperationSpec
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
   * NOTE: This feature is currently in preview and still being tested for stability. Lists all available
   * internet service providers for a specified Azure region.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that scope the list of available providers.
   * @param options The options parameters.
   */
  async beginListAvailableProvidersAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AvailableProvidersListParameters,
    options?: NetworkWatchersListAvailableProvidersOptionalParams
  ): Promise<NetworkWatchersListAvailableProvidersResponse> {
    const poller = await this.beginListAvailableProviders(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets Network Configuration Diagnostic data to help customers understand and debug network behavior.
   * It provides detailed information on what security rules were applied to a specified traffic flow and
   * the result of evaluating these rules. Customers must provide details of a flow like source,
   * destination, protocol, etc. The API returns whether traffic was allowed or denied, the rules
   * evaluated for the specified flow and the evaluation results.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters to get network configuration diagnostic.
   * @param options The options parameters.
   */
  async beginGetNetworkConfigurationDiagnostic(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NetworkConfigurationDiagnosticParameters,
    options?: NetworkWatchersGetNetworkConfigurationDiagnosticOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        NetworkWatchersGetNetworkConfigurationDiagnosticResponse
      >,
      NetworkWatchersGetNetworkConfigurationDiagnosticResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkWatchersGetNetworkConfigurationDiagnosticResponse> => {
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
      { resourceGroupName, networkWatcherName, parameters, options },
      getNetworkConfigurationDiagnosticOperationSpec
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
   * Gets Network Configuration Diagnostic data to help customers understand and debug network behavior.
   * It provides detailed information on what security rules were applied to a specified traffic flow and
   * the result of evaluating these rules. Customers must provide details of a flow like source,
   * destination, protocol, etc. The API returns whether traffic was allowed or denied, the rules
   * evaluated for the specified flow and the evaluation results.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters to get network configuration diagnostic.
   * @param options The options parameters.
   */
  async beginGetNetworkConfigurationDiagnosticAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NetworkConfigurationDiagnosticParameters,
    options?: NetworkWatchersGetNetworkConfigurationDiagnosticOptionalParams
  ): Promise<NetworkWatchersGetNetworkConfigurationDiagnosticResponse> {
    const poller = await this.beginGetNetworkConfigurationDiagnostic(
      resourceGroupName,
      networkWatcherName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkWatcher
    },
    201: {
      bodyMapper: Mappers.NetworkWatcher
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters42,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkWatcher
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
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}",
  httpMethod: "DELETE",
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
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkWatcher
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkWatcherListResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkWatchers",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkWatcherListResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getTopologyOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/topology",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.Topology
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters43,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const verifyIPFlowOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/ipFlowVerify",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VerificationIPFlowResult
    },
    201: {
      bodyMapper: Mappers.VerificationIPFlowResult
    },
    202: {
      bodyMapper: Mappers.VerificationIPFlowResult
    },
    204: {
      bodyMapper: Mappers.VerificationIPFlowResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters44,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getNextHopOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/nextHop",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.NextHopResult
    },
    201: {
      bodyMapper: Mappers.NextHopResult
    },
    202: {
      bodyMapper: Mappers.NextHopResult
    },
    204: {
      bodyMapper: Mappers.NextHopResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters45,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getVMSecurityRulesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/securityGroupView",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.SecurityGroupViewResult
    },
    201: {
      bodyMapper: Mappers.SecurityGroupViewResult
    },
    202: {
      bodyMapper: Mappers.SecurityGroupViewResult
    },
    204: {
      bodyMapper: Mappers.SecurityGroupViewResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters46,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getTroubleshootingOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/troubleshoot",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    201: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    202: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    204: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters47,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getTroubleshootingResultOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/queryTroubleshootResult",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    201: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    202: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    204: {
      bodyMapper: Mappers.TroubleshootingResult
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters48,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const setFlowLogConfigurationOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/configureFlowLog",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLogInformation
    },
    201: {
      bodyMapper: Mappers.FlowLogInformation
    },
    202: {
      bodyMapper: Mappers.FlowLogInformation
    },
    204: {
      bodyMapper: Mappers.FlowLogInformation
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters49,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getFlowLogStatusOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/queryFlowLogStatus",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.FlowLogInformation
    },
    201: {
      bodyMapper: Mappers.FlowLogInformation
    },
    202: {
      bodyMapper: Mappers.FlowLogInformation
    },
    204: {
      bodyMapper: Mappers.FlowLogInformation
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters50,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const checkConnectivityOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/connectivityCheck",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ConnectivityInformation
    },
    201: {
      bodyMapper: Mappers.ConnectivityInformation
    },
    202: {
      bodyMapper: Mappers.ConnectivityInformation
    },
    204: {
      bodyMapper: Mappers.ConnectivityInformation
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters51,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getAzureReachabilityReportOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/azureReachabilityReport",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.AzureReachabilityReport
    },
    201: {
      bodyMapper: Mappers.AzureReachabilityReport
    },
    202: {
      bodyMapper: Mappers.AzureReachabilityReport
    },
    204: {
      bodyMapper: Mappers.AzureReachabilityReport
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters52,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAvailableProvidersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/availableProvidersList",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.AvailableProvidersList
    },
    201: {
      bodyMapper: Mappers.AvailableProvidersList
    },
    202: {
      bodyMapper: Mappers.AvailableProvidersList
    },
    204: {
      bodyMapper: Mappers.AvailableProvidersList
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters53,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getNetworkConfigurationDiagnosticOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/networkConfigurationDiagnostic",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkConfigurationDiagnosticResponse
    },
    201: {
      bodyMapper: Mappers.NetworkConfigurationDiagnosticResponse
    },
    202: {
      bodyMapper: Mappers.NetworkConfigurationDiagnosticResponse
    },
    204: {
      bodyMapper: Mappers.NetworkConfigurationDiagnosticResponse
    },
    default: {
      bodyMapper: Mappers.ErrorResponse
    }
  },
  requestBody: Parameters.parameters54,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkWatcherName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
