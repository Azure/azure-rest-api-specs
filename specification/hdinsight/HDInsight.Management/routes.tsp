// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("Regions")
interface LocationsOperationGroup {
  /**
   * Gets the capabilities for the specified location.
   */
  @autoRoute
  @get
  @action("capabilities")
  getCapabilities is ArmProviderActionSync<
    Response = ArmResponse<CapabilitiesResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Lists the usages for the specified location.
   */
  @autoRoute
  @get
  @action("usages")
  listUsages is ArmProviderActionSync<
    Response = ArmResponse<UsagesListResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Lists the billingSpecs for the specified subscription and location.
   */
  @autoRoute
  @get
  @action("billingSpecs")
  listBillingSpecs is ArmProviderActionSync<
    Response = BillingResponseListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Get the async operation status.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/azureasyncoperations/{operationId}")
  @get
  getAzureAsyncOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The long running operation id.
     */
    @path
    operationId: string,
  ): ArmResponse<AsyncOperationResult> | ErrorResponse;

  /**
   * Check the cluster name is available or not.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityCheckRequestParameters,
    Response = NameAvailabilityCheckResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
  /**
   * Validate the cluster create request spec is valid or not.
   */
  @autoRoute
  @action("validateCreateRequest")
  validateClusterCreateRequest is ArmProviderActionSync<
    Request = ClusterCreateRequestValidationParameters,
    Response = ClusterCreateValidationResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorResponse
  >;
}

@armResourceOperations
interface Configurations {
  /**
   * Gets all configuration information for an HDI cluster.
   */
  @action("configurations")
  list is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ClusterConfigurations>,
    Error = ErrorResponse
  >;

  /**
   * Configures the HTTP settings on the specified cluster. This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #deprecated "This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead."
  @post
  update is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Cluster,
    ClusterConfiguration,
    Parameters = {
      /**
       * The name of the cluster configuration.
       */
      @path
      @segment("configurations")
      @key
      configurationName: string;
    },
    Response = OkResponse | NoContentResponse | ArmAcceptedLroResponse,
    Error = ErrorResponse
  >;

  /**
   * The configuration object for the specified cluster. This API is not recommended and might be removed in the future. Please consider using List configurations API instead.
   */
  get is ArmResourceRead<
    Cluster,
    Response = ArmResponse<ClusterConfiguration>,
    Parameters = {
      /**
       * The name of the cluster configuration.
       */
      @path
      @segment("configurations")
      @key
      configurationName: string;
    },
    Error = ErrorResponse
  >;
}

@armResourceOperations
interface Extensions {
  /**
   * Enables the Operations Management Suite (OMS) on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @action("extensions/clustermonitoring")
  enableMonitoring is ArmResourceActionAsyncBase<
    Cluster,
    ClusterMonitoringRequest,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the status of Operations Management Suite (OMS) on the HDInsight cluster.
   */
  @get
  @action("extensions/clustermonitoring")
  getMonitoringStatus is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ClusterMonitoringResponse>,
    Error = ErrorResponse
  >;

  /**
   * Disables the Operations Management Suite (OMS) on the HDInsight cluster.
   */
  @delete
  @action("extensions/clustermonitoring")
  disableMonitoring is ArmResourceActionAsyncBase<
    Cluster,
    void,
    OkResponse | NoContentResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Enables the Azure Monitor on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @action("extensions/azureMonitor")
  enableAzureMonitor is ArmResourceActionAsyncBase<
    Cluster,
    AzureMonitorRequest,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the status of Azure Monitor on the HDInsight cluster.
   */
  @get
  @action("extensions/azureMonitor")
  getAzureMonitorStatus is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<AzureMonitorResponse>,
    Error = ErrorResponse
  >;

  /**
   * Disables the Azure Monitor on the HDInsight cluster.
   */
  @delete
  @action("extensions/azureMonitor")
  disableAzureMonitor is ArmResourceActionAsyncBase<
    Cluster,
    void,
    OkResponse | NoContentResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Enables the Azure Monitor Agent on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @action("extensions/azureMonitorAgent")
  enableAzureMonitorAgent is ArmResourceActionAsyncBase<
    Cluster,
    AzureMonitorRequest,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the status of Azure Monitor Agent on the HDInsight cluster.
   */
  @get
  @action("extensions/azureMonitorAgent")
  getAzureMonitorAgentStatus is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<AzureMonitorResponse>,
    Error = ErrorResponse
  >;

  /**
   * Disables the Azure Monitor Agent on the HDInsight cluster.
   */
  @delete
  @action("extensions/azureMonitorAgent")
  disableAzureMonitorAgent is ArmResourceActionAsyncBase<
    Cluster,
    void,
    OkResponse | NoContentResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Creates an HDInsight cluster extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    Cluster,
    Request = Extension,
    Parameters = {
      /**
       * The name of the cluster extension.
       */
      @path
      @segment("extensions")
      @key
      extensionName: string;
    },
    Response = ArmAcceptedLroResponse | OkResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets the extension properties for the specified HDInsight cluster extension.
   */
  get is ArmResourceRead<
    Cluster,
    Response = ArmResponse<ClusterMonitoringResponse>,
    Parameters = {
      /**
       * The name of the cluster extension.
       */
      @path
      @segment("extensions")
      @key
      extensionName: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified extension for HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = OkResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Parameters = {
      /**
       * The name of the cluster extension.
       */
      @path
      @segment("extensions")
      @key
      extensionName: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Gets the async operation status.
   */
  getAzureAsyncOperationStatus is ArmResourceRead<
    Cluster,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The name of the cluster extension.
       */
      @path
      @segment("extensions")
      @key
      extensionName: string;

      /**
       * The long running operation id.
       */
      @path
      @segment("azureAsyncOperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ScriptActions {
  /**
   * Deletes a specified persisted script action of the cluster.
   */
  @tag("ScriptActions")
  delete is ArmResourceDeleteSync<
    Cluster,
    Parameters = {
      /**
       * The name of the script.
       */
      @path
      @segment("scriptActions")
      scriptName: string;
    },
    Response = OkResponse | NoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists all the persisted script actions for the specified cluster.
   */
  @list
  @get
  @action("scriptActions")
  @tag("ScriptActions")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ScriptActionsList>,
    Error = ErrorResponse
  >;

  /**
   * Gets the async operation status of execution operation.
   */
  @tag("ScriptActions")
  getExecutionAsyncOperationStatus is ArmResourceRead<
    Cluster,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The long running operation id.
       */
      @path
      @segment("executeScriptActions/azureasyncoperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Gets the script execution detail for the given script execution ID.
   */
  @tag("ScriptExecutionHistory")
  getExecutionDetail is ArmResourceRead<
    Cluster,
    Response = ArmResponse<RuntimeScriptActionDetail>,
    Parameters = {
      /**
       * The script execution Id
       */
      @path
      @segment("scriptExecutionHistory")
      @key
      scriptExecutionId: string;
    },
    Error = ErrorResponse
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ScriptExecutionHistory {
  /**
   * Lists all scripts' execution history for the specified cluster.
   */
  @list
  @get
  @action("scriptExecutionHistory")
  @tag("ScriptExecutionHistory")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ScriptActionExecutionHistoryList>,
    Error = ErrorResponse
  >;

  /**
   * Promotes the specified ad-hoc script execution to a persisted script.
   */
  @tag("Promote")
  promote is ArmResourceActionSync<
    Cluster,
    void,
    OkResponse,
    Parameters = {
      /**
       * The script execution Id
       */
      @path
      @segment("scriptExecutionHistory")
      @key
      scriptExecutionId: string;
    },
    Error = ErrorResponse
  >;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Lists the HDInsight clusters hosts
   */
  listHosts is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<HostInfo[]>,
    Error = ErrorResponse
  >;

  /**
   * Restarts the specified HDInsight cluster hosts.
   */
  restartHosts is ArmResourceActionAsyncBase<
    Cluster,
    string[],
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the async operation status.
   */
  @get
  getAsyncOperationStatus is ArmResourceRead<
    Cluster,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The long running operation id.
       */
      @path
      @segment("restartHosts/azureasyncoperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;
}
