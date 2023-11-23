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
  @path
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
  update is ArmResourcePatchAsync<Cluster, ClusterResourceProperties>;
  @doc("Deletes a cluster.")
  delete is ArmResourceDeleteAsync<Cluster>;
  @doc("Lists the HDInsight cluster pools under a resource group.")
  listByClusterPoolName is ArmResourceListByParent<Cluster>;
  @doc("Resize an existing Cluster.")
  resize is ArmResourceActionAsync<Cluster, ClusterResizeData, Cluster>;
  @doc("Operations on jobs of HDInsight on AKS cluster.")
  runJob is ArmResourceActionAsync<Cluster, ClusterJob, ClusterJob>;
  @doc("Lists the config dump of all services running in cluster.")
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

  @doc("Get jobs of HDInsight on AKS cluster.")
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
