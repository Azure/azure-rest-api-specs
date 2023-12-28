import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HDInsight;
@doc("The HDInsight cluster.")
model Cluster is TrackedResource<ClusterGetProperties> {
  @doc("The name of the cluster.")
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
  create is ArmResourceCreateOrUpdateAsync<Cluster>;
  @doc("Patch HDInsight cluster with the specified parameters.")
  update is ArmCustomPatchSync<Cluster, ClusterPatchParameters>;
  @doc("Deletes the specified HDInsight cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;
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
    }
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
    }
  >;
  @doc("Rotate disk encryption key of the specified HDInsight cluster.")
  rotateDiskEncryptionKey is ArmResourceActionAsync<
    Cluster,
    ClusterDiskEncryptionParameters,
    void
  >;
  @doc("Gets the gateway settings for the specified cluster.")
  getGatewaySettings is ArmResourceActionSync<Cluster, void, GatewaySettings>;
  @doc("Configures the gateway settings on the specified cluster.")
  updateGatewaySettings is ArmResourceActionAsync<
    Cluster,
    UpdateGatewaySettingsParameters,
    void
  >;
  @doc("Updates the cluster identity certificate.")
  updateIdentityCertificate is ArmResourceActionAsync<
    Cluster,
    UpdateClusterIdentityCertificateParameters,
    void
  >;
  @doc("Executes script actions on the specified HDInsight cluster.")
  executeScriptActions is ArmResourceActionAsync<
    Cluster,
    ExecuteScriptActionParameters,
    void
  >;
  @doc("The the async operation status.")
  // FIXME: Clusters_GetAzureAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/azureasyncoperations/{operationId}")
  @get
  GetAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
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

@armResourceOperations
interface Configurations {
  @doc("Gets all configuration information for an HDI cluster.")
  list is ArmResourceActionSync<Cluster, void, ClusterConfigurations>;
  @doc("Configures the HTTP settings on the specified cluster. This API is deprecated, please use UpdateGatewaySettings in cluster endpoint instead.")
  update is ArmResourceActionAsync<
    Cluster,
    Record<string>,
    void,
    {
      ...BaseParameters<Cluster>;

      @doc("The name of the cluster configuration.")
      @path
      configurationName: string;
    }
  >;
  @doc("The configuration object for the specified cluster. This API is not recommended and might be removed in the future. Please consider using List configurations API instead.")
  // FIXME: Configurations_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/configurations/{configurationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface ScriptExecutionHistory {
  @doc("Promotes the specified ad-hoc script execution to a persisted script.")
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
  @doc("Lists all scripts' execution history for the specified cluster.")
  // FIXME: ScriptExecutionHistory_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptExecutionHistory")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface VirtualMachines {
  @doc("Lists the HDInsight clusters hosts")
  listHosts is ArmResourceActionSync<Cluster, void, HostInfoListResult>;
  @doc("Restarts the specified HDInsight cluster hosts.")
  restartHosts is ArmResourceActionAsync<Cluster, string[], void>;
  @doc("Gets the async operation status.")
  // FIXME: VirtualMachines_GetAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/restartHosts/azureasyncoperations/{operationId}")
  @get
  GetAsyncOperationStatus is Azure.Core.Foundations.Operation<
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

@armResourceOperations
interface Extensions {
  @doc("Gets the status of Operations Management Suite (OMS) on the HDInsight cluster.")
  // FIXME: Extensions_GetMonitoringStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/clustermonitoring")
  @get
  GetMonitoringStatus is Azure.Core.Foundations.Operation<
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

  @doc("Gets the status of Azure Monitor on the HDInsight cluster.")
  // FIXME: Extensions_GetAzureMonitorStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/azureMonitor")
  @get
  GetAzureMonitorStatus is Azure.Core.Foundations.Operation<
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

  @doc("Gets the extension properties for the specified HDInsight cluster extension.")
  // FIXME: Extensions_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/{extensionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
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

  @doc("Gets the async operation status.")
  // FIXME: Extensions_GetAzureAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/extensions/{extensionName}/azureAsyncOperations/{operationId}")
  @get
  GetAzureAsyncOperationStatus is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface ScriptActions {
  @doc("Lists all the persisted script actions for the specified cluster.")
  // FIXME: ScriptActions_ListByCluster could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptActions")
  @get
  ListByCluster is Azure.Core.Foundations.Operation<
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

  @doc("Gets the script execution detail for the given script execution ID.")
  // FIXME: ScriptActions_GetExecutionDetail could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/scriptExecutionHistory/{scriptExecutionId}")
  @get
  GetExecutionDetail is Azure.Core.Foundations.Operation<
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

  @doc("Gets the async operation status of execution operation.")
  // FIXME: ScriptActions_GetExecutionAsyncOperationStatus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusters/{clusterName}/executeScriptActions/azureasyncoperations/{operationId}")
  @get
  GetExecutionAsyncOperationStatus is Azure.Core.Foundations.Operation<
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
