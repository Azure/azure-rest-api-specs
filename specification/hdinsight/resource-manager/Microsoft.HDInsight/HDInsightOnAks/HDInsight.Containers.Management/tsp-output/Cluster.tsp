import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ClusterPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HDInsight;
@doc("The cluster.")
@parentResource(ClusterPool)
model Cluster is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the HDInsight cluster.")
  @key("clusterName")
  @segment("clusters")
  name: string;
}

@armResourceOperations
interface Clusters {
  @doc("Gets a HDInsight cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Creates a cluster.")
  create is ArmResourceCreateOrUpdateAsync<Cluster>;

  @doc("Updates an existing Cluster.")
  update is ArmCustomPatchAsync<Cluster, ClusterPatch>;

  @doc("Deletes a cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;

  @doc("Lists the HDInsight cluster pools under a resource group.")
  listByClusterPoolName is ArmResourceListByParent<Cluster>;

  @doc("Resize an existing Cluster.")
  resize is ArmResourceActionAsync<Cluster, ClusterResizeData, Cluster>;

  @doc("Lists the config dump of all services running in cluster.")
  // FIXME: Clusters_ListServiceConfigs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/serviceConfigs")
  @get
  ListServiceConfigs is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the cluster pool.")
      @path
      clusterPoolName: string;

      @doc("The name of the HDInsight cluster.")
      @path
      clusterName: string;
    },
    ServiceConfigListResult
  >;

  @doc("Lists the lists of instance views")
  // FIXME: Clusters_ListInstanceViews could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/instanceViews")
  @get
  ListInstanceViews is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the cluster pool.")
      @path
      clusterPoolName: string;

      @doc("The name of the HDInsight cluster.")
      @path
      clusterName: string;
    },
    ClusterInstanceViewsResult
  >;

  @doc("Gets the status of a cluster instance.")
  // FIXME: Clusters_GetInstanceView could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/instanceViews/default")
  @get
  GetInstanceView is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the cluster pool.")
      @path
      clusterPoolName: string;

      @doc("The name of the HDInsight cluster.")
      @path
      clusterName: string;
    },
    ClusterInstanceViewResult
  >;
}

@armResourceOperations
@projectedName("client", "ClusterJobs")
interface Clusters_ClusterJobs {
  @doc("Operations on jobs of HDInsight on AKS cluster.")
  runJob is ArmResourceActionAsync<Cluster, ClusterJob, ClusterJob>;

  @doc("Get jobs of HDInsight on AKS cluster.")
  // FIXME: ClusterJobs_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HDInsight/clusterpools/{clusterPoolName}/clusters/{clusterName}/jobs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the cluster pool.")
      @path
      clusterPoolName: string;

      @doc("The name of the HDInsight cluster.")
      @path
      clusterName: string;
    },
    ClusterJobList
  >;
}
