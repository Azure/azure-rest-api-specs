import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HDInsight;
@doc("The HDInsight cluster.")
model Cluster is TrackedResource<ClusterGetProperties> {
  @doc("The name of the cluster.")
  @path
  @key("clusterName")
  @segment("clusters")
  name: string;

  @doc("The ETag for the resource")
  etag?: string;

  @doc("The availability zones.")
  zones?: string[];

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Clusters {
  @doc("Gets the specified cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a new HDInsight cluster with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("Patch HDInsight cluster with the specified parameters.")
  update is ArmCustomPatchSync<Cluster, ClusterPatchParameters>;

  @doc("Deletes the specified HDInsight cluster.")
  delete is ArmResourceDeleteAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("Lists the HDInsight clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("Lists all the HDInsight clusters under the subscription.")
  list is ArmListBySubscription<Cluster>;

  @doc("Resizes the specified HDInsight cluster to the specified size.")
  resize is ArmResourceActionAsync<
    Cluster,
    ClusterResizeParameters,
    void,
    {
      ...BaseParameters<Cluster>;

      @doc("The constant value for the roleName")
      @path
      roleName: RoleName;
    },
    ArmLroLocationHeader
  >;

  @doc("Updates the Autoscale Configuration for HDInsight cluster.")
  updateAutoScaleConfiguration is ArmResourceActionAsync<
    Cluster,
    AutoscaleConfigurationUpdateParameter,
    void,
    {
      ...BaseParameters<Cluster>;

      @doc("The constant value for the roleName")
      @path
      roleName: RoleName;
    },
    ArmLroLocationHeader
  >;

  @doc("Rotate disk encryption key of the specified HDInsight cluster.")
  rotateDiskEncryptionKey is ArmResourceActionAsync<
    Cluster,
    ClusterDiskEncryptionParameters,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("Gets the gateway settings for the specified cluster.")
  getGatewaySettings is ArmResourceActionSync<Cluster, void, GatewaySettings>;

  @doc("Configures the gateway settings on the specified cluster.")
  updateGatewaySettings is ArmResourceActionAsync<
    Cluster,
    UpdateGatewaySettingsParameters,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("Updates the cluster identity certificate.")
  updateIdentityCertificate is ArmResourceActionAsync<
    Cluster,
    UpdateClusterIdentityCertificateParameters,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("Executes script actions on the specified HDInsight cluster.")
  executeScriptActions is ArmResourceActionAsync<
    Cluster,
    ExecuteScriptActionParameters,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all configuration information for an HDI cluster.")
  @operationId("Configurations_List")
  list is ArmResourceActionSync<Cluster, void, ClusterConfigurations>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Configures the HTTP settings on the specified cluster. This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead.")
  @operationId("Configurations_Update")
  update is ArmResourceActionAsync<
    Cluster,
    ClusterConfiguration,
    void,
    {
      ...BaseParameters<Cluster>;

      @doc("The name of the cluster configuration.")
      @path
      configurationName: string;
    },
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Promotes the specified ad-hoc script execution to a persisted script.")
  @operationId("ScriptExecutionHistory_Promote")
  promote is ArmResourceActionSync<
    Cluster,
    void,
    void,
    {
      ...BaseParameters<Cluster>;

      @doc("The script execution Id")
      @path
      scriptExecutionId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the HDInsight clusters hosts")
  @operationId("VirtualMachines_ListHosts")
  listHosts is ArmResourceActionSync<Cluster, void, HostInfoListResult>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Restarts the specified HDInsight cluster hosts.")
  @operationId("VirtualMachines_RestartHosts")
  restartHosts is ArmResourceActionAsync<
    Cluster,
    RestartHostsParameters,
    void,
    BaseParameters<Cluster>,
    ArmLroLocationHeader
  >;

  @doc("The the async operation status.")
  // FIXME: Clusters_GetAzureAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/azureasyncoperations/{operationId}")
  @get
  getAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The long running operation id.")
      @path
      operationId: string;
    },
    AsyncOperationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Configurations_Get")
  @doc("The configuration object for the specified cluster. This API is not recommended and might be removed in the future. Please consider using List configurations API instead.")
  // FIXME: Configurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/configurations/{configurationName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The name of the cluster configuration.")
      @path
      configurationName: string;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_GetMonitoringStatus")
  @doc("Gets the status of Operations Management Suite (OMS) on the HDInsight cluster.")
  // FIXME: Extensions_GetMonitoringStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/clustermonitoring")
  @get
  getMonitoringStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    ClusterMonitoringResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_GetAzureMonitorStatus")
  @doc("Gets the status of Azure Monitor on the HDInsight cluster.")
  // FIXME: Extensions_GetAzureMonitorStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/azureMonitor")
  @get
  getAzureMonitorStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    AzureMonitorResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_Get")
  @doc("Gets the extension properties for the specified HDInsight cluster extension.")
  // FIXME: Extensions_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/{extensionName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The name of the cluster extension.")
      @path
      extensionName: string;
    },
    ClusterMonitoringResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Extensions_GetAzureAsyncOperationStatus")
  @doc("Gets the async operation status.")
  // FIXME: Extensions_GetAzureAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/{extensionName}/azureAsyncOperations/{operationId}")
  @get
  getAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The name of the cluster extension.")
      @path
      extensionName: string;

      @doc("The long running operation id.")
      @path
      operationId: string;
    },
    AsyncOperationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptActions_ListByCluster")
  @doc("Lists all the persisted script actions for the specified cluster.")
  // FIXME: ScriptActions_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptActions")
  @get
  listByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    ScriptActionsList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptActions_GetExecutionDetail")
  @doc("Gets the script execution detail for the given script execution ID.")
  // FIXME: ScriptActions_GetExecutionDetail could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptExecutionHistory/{scriptExecutionId}")
  @get
  getExecutionDetail is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The script execution Id")
      @path
      scriptExecutionId: string;
    },
    RuntimeScriptActionDetail
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptActions_GetExecutionAsyncOperationStatus")
  @doc("Gets the async operation status of execution operation.")
  // FIXME: ScriptActions_GetExecutionAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/executeScriptActions/azureasyncoperations/{operationId}")
  @get
  getExecutionAsyncOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The long running operation id.")
      @path
      operationId: string;
    },
    AsyncOperationResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptExecutionHistory_ListByCluster")
  @doc("Lists all scripts' execution history for the specified cluster.")
  // FIXME: ScriptExecutionHistory_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptExecutionHistory")
  @get
  listByCluster is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    ScriptActionExecutionHistoryList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachines_GetAsyncOperationStatus")
  @doc("Gets the async operation status.")
  // FIXME: VirtualMachines_GetAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/restartHosts/azureasyncoperations/{operationId}")
  @get
  getAsyncOperationStatus is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The long running operation id.")
      @path
      operationId: string;
    },
    AsyncOperationResult
  >;
}

@@projectedName(Clusters.create::parameters.resource, "json", "parameters");
@@extension(Clusters.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.create::parameters.resource, "The cluster create request.");
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties, "The cluster patch request.");
@@projectedName(Clusters.resize::parameters.body, "json", "parameters");
@@extension(Clusters.resize::parameters.body, "x-ms-client-name", "parameters");
@@doc(Clusters.resize::parameters.body,
  "The parameters for the resize operation."
);
@@projectedName(Clusters.updateAutoScaleConfiguration::parameters.body,
  "json",
  "parameters"
);
@@extension(Clusters.updateAutoScaleConfiguration::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.updateAutoScaleConfiguration::parameters.body,
  "The parameters for the update autoscale configuration operation."
);
@@projectedName(Clusters.rotateDiskEncryptionKey::parameters.body,
  "json",
  "parameters"
);
@@extension(Clusters.rotateDiskEncryptionKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.rotateDiskEncryptionKey::parameters.body,
  "The parameters for the disk encryption operation."
);
@@projectedName(Clusters.updateGatewaySettings::parameters.body,
  "json",
  "parameters"
);
@@extension(Clusters.updateGatewaySettings::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.updateGatewaySettings::parameters.body,
  "The cluster configurations."
);
@@projectedName(Clusters.updateIdentityCertificate::parameters.body,
  "json",
  "parameters"
);
@@extension(Clusters.updateIdentityCertificate::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.updateIdentityCertificate::parameters.body,
  "The cluster configurations."
);
@@projectedName(Clusters.executeScriptActions::parameters.body,
  "json",
  "parameters"
);
@@extension(Clusters.executeScriptActions::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.executeScriptActions::parameters.body,
  "The parameters for executing script actions."
);
@@projectedName(Clusters.update::parameters.body, "json", "parameters");
@@extension(Clusters.update::parameters.body, "x-ms-client-name", "parameters");
@@doc(Clusters.update::parameters.body, "The cluster configurations.");
@@projectedName(Clusters.restartHosts::parameters.body, "json", "hosts");
@@extension(Clusters.restartHosts::parameters.body,
  "x-ms-client-name",
  "hosts"
);
@@doc(Clusters.restartHosts::parameters.body, "The list of hosts to restart");
