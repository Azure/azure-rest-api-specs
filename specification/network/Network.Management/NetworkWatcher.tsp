import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Network watcher in a resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkWatcher extends Resource {
  properties?: NetworkWatcherPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("networkWatcherName")
  @segment("networkWatchers")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias PacketCaptureOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** The name of the network watcher. */
    @path
    @segment("networkWatchers")
    @key
    networkWatcherName: string;
  },
  {
    /** The name of the packet capture session. */
    @path
    @segment("packetCaptures")
    @key
    packetCaptureName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}",
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkWatcher)
@armResourceOperations(#{ allowStaticRoutes: true })
interface NetworkWatchers {
  /**
   * Gets the specified network watcher by resource group.
   */
  @autoRoute
  get is ArmResourceRead<NetworkWatcher, Error = ErrorResponse>;

  /**
   * Creates or updates a network watcher in the specified resource group.
   */
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NetworkWatcher,
    Error = ErrorResponse
  >;

  /**
   * Updates a network watcher tags.
   */
  @autoRoute
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    NetworkWatcher,
    PatchModel = TagsObject,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified network watcher resource.
   */
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkWatcher,
    Error = ErrorResponse
  >;

  /**
   * Gets all network watchers by resource group.
   */
  @autoRoute
  list is ArmResourceListByParent<
    NetworkWatcher,
    Response = ArmResponse<NetworkWatcherListResult>,
    Error = ErrorResponse
  >;

  /**
   * Gets all network watchers by subscription.
   */
  @autoRoute
  listAll is ArmListBySubscription<
    NetworkWatcher,
    Response = ArmResponse<NetworkWatcherListResult>,
    Error = ErrorResponse
  >;

  /**
   * Gets the current network topology by resource group.
   */
  @autoRoute
  @action("topology")
  getTopology is ArmResourceActionSync<
    NetworkWatcher,
    TopologyParameters,
    ArmResponse<Topology>,
    Error = ErrorResponse
  >;

  /**
   * Verify IP flow from the specified VM to a location given the currently configured NSG rules.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("ipFlowVerify")
  verifyIPFlow is ArmResourceActionAsyncBase<
    NetworkWatcher,
    VerificationIPFlowParameters,
    ArmResponse<VerificationIPFlowResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = VerificationIPFlowResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: VerificationIPFlowResult;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Gets the next hop from the specified VM.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("nextHop")
  getNextHop is ArmResourceActionAsyncBase<
    NetworkWatcher,
    NextHopParameters,
    ArmResponse<NextHopResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NextHopResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: NextHopResult;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Gets the configured and effective security group rules on the specified VM.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("securityGroupView")
  getVMSecurityRules is ArmResourceActionAsyncBase<
    NetworkWatcher,
    SecurityGroupViewParameters,
    ArmResponse<SecurityGroupViewResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SecurityGroupViewResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: SecurityGroupViewResult;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Initiate troubleshooting on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("troubleshoot")
  getTroubleshooting is ArmResourceActionAsyncBase<
    NetworkWatcher,
    TroubleshootingParameters,
    ArmResponse<TroubleshootingResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = TroubleshootingResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: TroubleshootingResult;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Get the last completed troubleshooting result on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("queryTroubleshootResult")
  getTroubleshootingResult is ArmResourceActionAsyncBase<
    NetworkWatcher,
    QueryTroubleshootingParameters,
    ArmResponse<TroubleshootingResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = TroubleshootingResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: TroubleshootingResult;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Configures flow log and traffic analytics (optional) on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("configureFlowLog")
  setFlowLogConfiguration is ArmResourceActionAsyncBase<
    NetworkWatcher,
    FlowLogInformation,
    ArmResponse<FlowLogInformation> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FlowLogInformation> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: FlowLogInformation;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Queries status of flow log and traffic analytics (optional) on a specified resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("queryFlowLogStatus")
  getFlowLogStatus is ArmResourceActionAsyncBase<
    NetworkWatcher,
    FlowLogStatusParameters,
    ArmResponse<FlowLogInformation> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FlowLogInformation> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: FlowLogInformation;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Verifies the possibility of establishing a direct TCP connection from a virtual machine to a given endpoint including another VM or an arbitrary remote server.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("connectivityCheck")
  checkConnectivity is ArmResourceActionAsyncBase<
    NetworkWatcher,
    ConnectivityParameters,
    ArmResponse<ConnectivityInformation> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ConnectivityInformation> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: ConnectivityInformation;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Gets the relative latency score for internet service providers from a specified location to Azure regions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("azureReachabilityReport")
  getAzureReachabilityReport is ArmResourceActionAsyncBase<
    NetworkWatcher,
    AzureReachabilityReportParameters,
    ArmResponse<AzureReachabilityReport> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AzureReachabilityReport> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: AzureReachabilityReport;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * NOTE: This feature is currently in preview and still being tested for stability. Lists all available internet service providers for a specified Azure region.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("availableProvidersList")
  listAvailableProviders is ArmResourceActionAsyncBase<
    NetworkWatcher,
    AvailableProvidersListParameters,
    ArmResponse<AvailableProvidersList> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AvailableProvidersList> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: AvailableProvidersList;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Gets Network Configuration Diagnostic data to help customers understand and debug network behavior. It provides detailed information on what security rules were applied to a specified traffic flow and the result of evaluating these rules. Customers must provide details of a flow like source, destination, protocol, etc. The API returns whether traffic was allowed or denied, the rules evaluated for the specified flow and the evaluation results.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("networkConfigurationDiagnostic")
  getNetworkConfigurationDiagnostic is ArmResourceActionAsyncBase<
    NetworkWatcher,
    NetworkConfigurationDiagnosticParameters,
    ArmResponse<NetworkConfigurationDiagnosticResponse> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkConfigurationDiagnosticResponse> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: NetworkConfigurationDiagnosticResponse;
    }),
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkWatcher>,
    Error = ErrorResponse
  >;

  /**
   * Create and start a packet capture on the specified VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("PacketCaptures_Create")
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}")
  create is PacketCaptureOps.ActionAsync<
    NetworkWatcher,
    PacketCapture,
    void,
    Response = ArmResourceCreatedResponse<
      PacketCaptureResult,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = NetworkWatcher> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Gets a packet capture session by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PacketCaptures_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}")
  packetCapturesGet is PacketCaptureOps.ActionSync<
    NetworkWatcher,
    void,
    Response = ArmResponse<PacketCaptureResult>,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Deletes the specified packet capture session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PacketCaptures_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}")
  packetCapturesDelete is PacketCaptureOps.ActionAsync<
    NetworkWatcher,
    void,
    void,
    Response = ArmAcceptedLroResponse | NoContentResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Stops a specified packet capture session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PacketCaptures_Stop")
  @action("stop")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/stop")
  stop is PacketCaptureOps.ActionAsync<
    NetworkWatcher,
    void,
    Result = void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse,
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Query the status of a running packet capture session.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PacketCaptures_GetStatus")
  @action("queryStatus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkWatchers/{networkWatcherName}/packetCaptures/{packetCaptureName}/queryStatus")
  getStatus is PacketCaptureOps.ActionAsync<
    NetworkWatcher,
    void,
    Result = void,
    Response = ArmResponse<PacketCaptureQueryStatusResult> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PacketCaptureQueryStatusResult> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: PacketCaptureQueryStatusResult;
    }),
    OverrideErrorType = ErrorResponse
  >;

  /**
   * Lists all packet capture sessions within the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PacketCaptures_List")
  @list
  @get
  @action("packetCaptures")
  packetCapturesList is ArmResourceActionSync<
    NetworkWatcher,
    void,
    ArmResponse<PacketCaptureListResult>,
    Error = ErrorResponse
  >;
}

@@doc(NetworkWatcher.name, "The name of the network watcher.");
@@doc(NetworkWatcher.properties, "Properties of the network watcher.");
@@doc(NetworkWatchers.createOrUpdate::parameters.resource,
  "Parameters that define the network watcher resource."
);
@@doc(NetworkWatchers.updateTags::parameters.properties,
  "Parameters supplied to update network watcher tags."
);
@@doc(NetworkWatchers.getTopology::parameters.body,
  "Parameters that define the representation of topology."
);
@@doc(NetworkWatchers.verifyIPFlow::parameters.body,
  "Parameters that define the IP flow to be verified."
);
@@doc(NetworkWatchers.getNextHop::parameters.body,
  "Parameters that define the source and destination endpoint."
);
@@doc(NetworkWatchers.getVMSecurityRules::parameters.body,
  "Parameters that define the VM to check security groups for."
);
@@doc(NetworkWatchers.getTroubleshooting::parameters.body,
  "Parameters that define the resource to troubleshoot."
);
@@doc(NetworkWatchers.getTroubleshootingResult::parameters.body,
  "Parameters that define the resource to query the troubleshooting result."
);
@@doc(NetworkWatchers.setFlowLogConfiguration::parameters.body,
  "Parameters that define the configuration of flow log."
);
@@doc(NetworkWatchers.getFlowLogStatus::parameters.body,
  "Parameters that define a resource to query flow log and traffic analytics (optional) status."
);
@@doc(NetworkWatchers.checkConnectivity::parameters.body,
  "Parameters that determine how the connectivity check will be performed."
);
@@doc(NetworkWatchers.getAzureReachabilityReport::parameters.body,
  "Parameters that determine Azure reachability report configuration."
);
@@doc(NetworkWatchers.listAvailableProviders::parameters.body,
  "Parameters that scope the list of available providers."
);
@@doc(NetworkWatchers.getNetworkConfigurationDiagnostic::parameters.body,
  "Parameters to get network configuration diagnostic."
);
@@doc(NetworkWatchers.create::parameters.body,
  "Parameters that define the create packet capture operation."
);
