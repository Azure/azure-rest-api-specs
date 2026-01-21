import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
/**
 * The HDInsight cluster.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterGetProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  /**
   * The ETag for the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the cluster, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ClusterIdentity;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets the specified cluster.
   */
  get is ArmResourceRead<Cluster, Error = ErrorResponse>;

  /**
   * Creates a new HDInsight cluster with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Cluster,
    Request = ClusterCreateParametersExtended,
    Response = ArmResourceUpdatedResponse<Cluster> & {
      ...ArmLroLocationHeader<FinalResult = Cluster>;
      ...Azure.Core.Foundations.RetryAfterHeader;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = Cluster> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Patch HDInsight cluster with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Cluster,
    PatchModel = ClusterPatchParameters,
    Error = ErrorResponse
  >;

  /**
   * Deletes the specified HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Lists the HDInsight clusters in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Error = ErrorResponse
  >;

  /**
   * Lists all the HDInsight clusters under the subscription.
   */
  list is ArmListBySubscription<Cluster, Error = ErrorResponse>;

  /**
   * Resizes the specified HDInsight cluster to the specified size.
   */
  resize is ArmResourceActionAsyncBase<
    Cluster,
    ClusterResizeParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Parameters = {
      /**
       * The constant value for the roleName
       */
      @path
      @segment("roles")
      @key
      roleName: RoleName;
    },
    Error = ErrorResponse
  >;

  /**
   * Updates the Autoscale Configuration for HDInsight cluster.
   */
  @action("autoscale")
  updateAutoScaleConfiguration is ArmResourceActionAsyncBase<
    Cluster,
    AutoscaleConfigurationUpdateParameter,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Parameters = {
      /**
       * The constant value for the roleName
       */
      @path
      @segment("roles")
      @key
      roleName: RoleName;
    },
    Error = ErrorResponse
  >;

  /**
   * Rotate disk encryption key of the specified HDInsight cluster.
   */
  @action("rotatediskencryptionkey")
  rotateDiskEncryptionKey is ArmResourceActionAsyncBase<
    Cluster,
    ClusterDiskEncryptionParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the gateway settings for the specified cluster.
   */
  getGatewaySettings is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<GatewaySettings>,
    Error = ErrorResponse
  >;

  /**
   * Configures the gateway settings on the specified cluster.
   */
  updateGatewaySettings is ArmResourceActionAsyncBase<
    Cluster,
    UpdateGatewaySettingsParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * The the async operation status.
   */
  getAzureAsyncOperationStatus is ArmResourceRead<
    Cluster,
    Response = ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The long running operation id.
       */
      @path
      @segment("azureasyncoperations")
      @key
      operationId: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Updates the cluster identity certificate.
   */
  @action("updateClusterIdentityCertificate")
  updateIdentityCertificate is ArmResourceActionAsyncBase<
    Cluster,
    UpdateClusterIdentityCertificateParameters,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Executes script actions on the specified HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  executeScriptActions is ArmResourceActionAsyncBase<
    Cluster,
    ExecuteScriptActionParameters,
    OkResponse | ClustersExecuteScriptActionsBadRequestError | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets all configuration information for an HDI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_List")
  @action("configurations")
  configurationsList is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ClusterConfigurations>,
    Error = ErrorResponse
  >;

  /**
   * Configures the HTTP settings on the specified cluster. This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead.
   */
  #deprecated "This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_Update")
  @post
  configurationsUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Configurations_Get")
  configurationsGet is ArmResourceRead<
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

  /**
   * Enables the Operations Management Suite (OMS) on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_EnableMonitoring")
  @put
  @action("extensions/clustermonitoring")
  enableMonitoring is ArmResourceActionAsyncBase<
    Cluster,
    ClusterMonitoringRequest,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Gets the status of Operations Management Suite (OMS) on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_GetMonitoringStatus")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_DisableMonitoring")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_EnableAzureMonitor")
  @put
  @action("extensions/azureMonitor")
  enableAzureMonitor is ArmResourceActionAsyncBase<
    Cluster,
    AzureMonitorRequest,
    OkResponse | ArmAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Cluster>
  >;

  /**
   * Gets the status of Azure Monitor on the HDInsight cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_GetAzureMonitorStatus")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_DisableAzureMonitor")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_EnableAzureMonitorAgent")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_GetAzureMonitorAgentStatus")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_DisableAzureMonitorAgent")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_Create")
  extensionsCreate is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
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
    Response = ArmAcceptedLroResponse | ArmResourceUpdatedResponse<Cluster>,
    Error = ErrorResponse
  >;

  /**
   * Gets the extension properties for the specified HDInsight cluster extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_Get")
  extensionsGet is ArmResourceRead<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_Delete")
  extensionsDelete is ArmResourceDeleteWithoutOkAsync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Extensions_GetAzureAsyncOperationStatus")
  extensionsGetAzureAsyncOperationStatus is ArmResourceRead<
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

  /**
   * Deletes a specified persisted script action of the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptActions_Delete")
  scriptActionsDelete is ArmResourceDeleteSync<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptActions_ListByCluster")
  @list
  @get
  @action("scriptActions")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ScriptActionsList>,
    Error = ErrorResponse
  >;

  /**
   * Gets the script execution detail for the given script execution ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptActions_GetExecutionDetail")
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

  /**
   * Gets the async operation status of execution operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptActions_GetExecutionAsyncOperationStatus")
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
   * Lists all scripts' execution history for the specified cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptExecutionHistory_ListByCluster")
  @list
  @get
  @action("scriptExecutionHistory")
  scriptExecutionHistoryListByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<ScriptActionExecutionHistoryList>,
    Error = ErrorResponse
  >;

  /**
   * Promotes the specified ad-hoc script execution to a persisted script.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ScriptExecutionHistory_Promote")
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

  /**
   * Lists the HDInsight clusters hosts
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_ListHosts")
  listHosts is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<HostInfoListResult>,
    Error = ErrorResponse
  >;

  /**
   * Restarts the specified HDInsight cluster hosts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_RestartHosts")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachines_GetAsyncOperationStatus")
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

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "The properties of the cluster.");
@@doc(Clusters.create::parameters.resource, "The cluster create request.");
@@doc(Clusters.update::parameters.properties, "The cluster patch request.");
@@doc(Clusters.resize::parameters.body,
  "The parameters for the resize operation."
);
@@doc(Clusters.updateAutoScaleConfiguration::parameters.body,
  "The parameters for the update autoscale configuration operation."
);
@@doc(Clusters.rotateDiskEncryptionKey::parameters.body,
  "The parameters for the disk encryption operation."
);
@@doc(Clusters.updateGatewaySettings::parameters.body,
  "The cluster configurations."
);
@@doc(Clusters.updateIdentityCertificate::parameters.body,
  "The cluster configurations."
);
@@doc(Clusters.executeScriptActions::parameters.body,
  "The parameters for executing script actions."
);
// @@doc(Clusters.configurationsUpdate::parameters.body,
//   "The cluster configurations."
// );
@@doc(Clusters.enableMonitoring::parameters.body,
  "The Operations Management Suite (OMS) workspace parameters."
);
@@doc(Clusters.enableAzureMonitor::parameters.body,
  "The Log Analytics workspace parameters."
);
@@doc(Clusters.enableAzureMonitorAgent::parameters.body,
  "The Log Analytics workspace parameters."
);
@@doc(Clusters.extensionsCreate::parameters.resource,
  "The cluster extensions create request."
);
@@doc(Clusters.restartHosts::parameters.body, "The list of hosts to restart");
