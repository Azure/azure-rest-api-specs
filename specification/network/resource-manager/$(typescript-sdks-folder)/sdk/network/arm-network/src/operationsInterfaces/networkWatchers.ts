import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
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
/** Interface representing a NetworkWatchers. */
export interface NetworkWatchers {
  /**
   * Gets all network watchers by resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: NetworkWatchersListOptionalParams
  ): PagedAsyncIterableIterator<NetworkWatcher>;
  /**
   * Gets all network watchers by subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: NetworkWatchersListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkWatcher>;
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
  ): Promise<NetworkWatchersCreateOrUpdateResponse>;
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
  ): Promise<NetworkWatchersGetResponse>;
  /**
   * Deletes the specified network watcher resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: NetworkWatchersDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified network watcher resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    options?: NetworkWatchersDeleteOptionalParams
  ): Promise<void>;
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
  ): Promise<NetworkWatchersUpdateTagsResponse>;
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
  ): Promise<NetworkWatchersGetTopologyResponse>;
  /**
   * Verify IP flow from the specified VM to a location given the currently configured NSG rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the IP flow to be verified.
   * @param options The options parameters.
   */
  beginVerifyIPFlow(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: VerificationIPFlowParameters,
    options?: NetworkWatchersVerifyIPFlowOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersVerifyIPFlowResponse>,
      NetworkWatchersVerifyIPFlowResponse
    >
  >;
  /**
   * Verify IP flow from the specified VM to a location given the currently configured NSG rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the IP flow to be verified.
   * @param options The options parameters.
   */
  beginVerifyIPFlowAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: VerificationIPFlowParameters,
    options?: NetworkWatchersVerifyIPFlowOptionalParams
  ): Promise<NetworkWatchersVerifyIPFlowResponse>;
  /**
   * Gets the next hop from the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the source and destination endpoint.
   * @param options The options parameters.
   */
  beginGetNextHop(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NextHopParameters,
    options?: NetworkWatchersGetNextHopOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetNextHopResponse>,
      NetworkWatchersGetNextHopResponse
    >
  >;
  /**
   * Gets the next hop from the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the source and destination endpoint.
   * @param options The options parameters.
   */
  beginGetNextHopAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NextHopParameters,
    options?: NetworkWatchersGetNextHopOptionalParams
  ): Promise<NetworkWatchersGetNextHopResponse>;
  /**
   * Gets the configured and effective security group rules on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the VM to check security groups for.
   * @param options The options parameters.
   */
  beginGetVMSecurityRules(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: SecurityGroupViewParameters,
    options?: NetworkWatchersGetVMSecurityRulesOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetVMSecurityRulesResponse>,
      NetworkWatchersGetVMSecurityRulesResponse
    >
  >;
  /**
   * Gets the configured and effective security group rules on the specified VM.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher.
   * @param parameters Parameters that define the VM to check security groups for.
   * @param options The options parameters.
   */
  beginGetVMSecurityRulesAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: SecurityGroupViewParameters,
    options?: NetworkWatchersGetVMSecurityRulesOptionalParams
  ): Promise<NetworkWatchersGetVMSecurityRulesResponse>;
  /**
   * Initiate troubleshooting on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to troubleshoot.
   * @param options The options parameters.
   */
  beginGetTroubleshooting(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetTroubleshootingResponse>,
      NetworkWatchersGetTroubleshootingResponse
    >
  >;
  /**
   * Initiate troubleshooting on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to troubleshoot.
   * @param options The options parameters.
   */
  beginGetTroubleshootingAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: TroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingOptionalParams
  ): Promise<NetworkWatchersGetTroubleshootingResponse>;
  /**
   * Get the last completed troubleshooting result on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to query the troubleshooting result.
   * @param options The options parameters.
   */
  beginGetTroubleshootingResult(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: QueryTroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingResultOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetTroubleshootingResultResponse>,
      NetworkWatchersGetTroubleshootingResultResponse
    >
  >;
  /**
   * Get the last completed troubleshooting result on a specified resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the resource to query the troubleshooting result.
   * @param options The options parameters.
   */
  beginGetTroubleshootingResultAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: QueryTroubleshootingParameters,
    options?: NetworkWatchersGetTroubleshootingResultOptionalParams
  ): Promise<NetworkWatchersGetTroubleshootingResultResponse>;
  /**
   * Configures flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the configuration of flow log.
   * @param options The options parameters.
   */
  beginSetFlowLogConfiguration(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogInformation,
    options?: NetworkWatchersSetFlowLogConfigurationOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersSetFlowLogConfigurationResponse>,
      NetworkWatchersSetFlowLogConfigurationResponse
    >
  >;
  /**
   * Configures flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define the configuration of flow log.
   * @param options The options parameters.
   */
  beginSetFlowLogConfigurationAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogInformation,
    options?: NetworkWatchersSetFlowLogConfigurationOptionalParams
  ): Promise<NetworkWatchersSetFlowLogConfigurationResponse>;
  /**
   * Queries status of flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define a resource to query flow log and traffic analytics
   *                   (optional) status.
   * @param options The options parameters.
   */
  beginGetFlowLogStatus(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogStatusParameters,
    options?: NetworkWatchersGetFlowLogStatusOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetFlowLogStatusResponse>,
      NetworkWatchersGetFlowLogStatusResponse
    >
  >;
  /**
   * Queries status of flow log and traffic analytics (optional) on a specified resource.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that define a resource to query flow log and traffic analytics
   *                   (optional) status.
   * @param options The options parameters.
   */
  beginGetFlowLogStatusAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: FlowLogStatusParameters,
    options?: NetworkWatchersGetFlowLogStatusOptionalParams
  ): Promise<NetworkWatchersGetFlowLogStatusResponse>;
  /**
   * Verifies the possibility of establishing a direct TCP connection from a virtual machine to a given
   * endpoint including another VM or an arbitrary remote server.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine how the connectivity check will be performed.
   * @param options The options parameters.
   */
  beginCheckConnectivity(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: ConnectivityParameters,
    options?: NetworkWatchersCheckConnectivityOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersCheckConnectivityResponse>,
      NetworkWatchersCheckConnectivityResponse
    >
  >;
  /**
   * Verifies the possibility of establishing a direct TCP connection from a virtual machine to a given
   * endpoint including another VM or an arbitrary remote server.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine how the connectivity check will be performed.
   * @param options The options parameters.
   */
  beginCheckConnectivityAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: ConnectivityParameters,
    options?: NetworkWatchersCheckConnectivityOptionalParams
  ): Promise<NetworkWatchersCheckConnectivityResponse>;
  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Gets the relative
   * latency score for internet service providers from a specified location to Azure regions.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine Azure reachability report configuration.
   * @param options The options parameters.
   */
  beginGetAzureReachabilityReport(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AzureReachabilityReportParameters,
    options?: NetworkWatchersGetAzureReachabilityReportOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersGetAzureReachabilityReportResponse>,
      NetworkWatchersGetAzureReachabilityReportResponse
    >
  >;
  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Gets the relative
   * latency score for internet service providers from a specified location to Azure regions.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that determine Azure reachability report configuration.
   * @param options The options parameters.
   */
  beginGetAzureReachabilityReportAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AzureReachabilityReportParameters,
    options?: NetworkWatchersGetAzureReachabilityReportOptionalParams
  ): Promise<NetworkWatchersGetAzureReachabilityReportResponse>;
  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Lists all available
   * internet service providers for a specified Azure region.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that scope the list of available providers.
   * @param options The options parameters.
   */
  beginListAvailableProviders(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AvailableProvidersListParameters,
    options?: NetworkWatchersListAvailableProvidersOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkWatchersListAvailableProvidersResponse>,
      NetworkWatchersListAvailableProvidersResponse
    >
  >;
  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Lists all available
   * internet service providers for a specified Azure region.
   * @param resourceGroupName The name of the network watcher resource group.
   * @param networkWatcherName The name of the network watcher resource.
   * @param parameters Parameters that scope the list of available providers.
   * @param options The options parameters.
   */
  beginListAvailableProvidersAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: AvailableProvidersListParameters,
    options?: NetworkWatchersListAvailableProvidersOptionalParams
  ): Promise<NetworkWatchersListAvailableProvidersResponse>;
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
  beginGetNetworkConfigurationDiagnostic(
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
  >;
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
  beginGetNetworkConfigurationDiagnosticAndWait(
    resourceGroupName: string,
    networkWatcherName: string,
    parameters: NetworkConfigurationDiagnosticParameters,
    options?: NetworkWatchersGetNetworkConfigurationDiagnosticOptionalParams
  ): Promise<NetworkWatchersGetNetworkConfigurationDiagnosticResponse>;
}
