import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MachineLearningComputeManagementClient;

interface OperationalizationClustersOperations {
  @doc("Create or update an operationalization cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("Parameters supplied to create or update an Operationalization cluster.")
      @body
      parameters: OperationalizationCluster;
    },
    OperationalizationCluster
  >;

  @doc("""
Gets the operationalization cluster resource view. Note that the credentials
are not returned by this call. Call ListKeys to get them.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    OperationalizationCluster
  >;

  @doc("""
The PATCH operation can be used to update only the tags for a cluster. Use PUT
operation to update other properties.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("The parameters supplied to patch the cluster.")
      @body
      parameters: OperationalizationClusterUpdateParameters;
    },
    OperationalizationCluster
  >;

  @doc("Deletes the specified cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;

      @doc("If true, deletes all resources associated with this cluster.")
      @query
      deleteAll: boolean;
    },
    void
  >;

  @doc("""
Gets the credentials for the specified cluster such as Storage, ACR and ACS
credentials. This is a long running operation because it fetches keys from
dependencies.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    OperationalizationClusterCredentials
  >;

  @doc("Checks if updates are available for system services in the cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}/checkSystemServicesUpdatesAvailable")
  @post
  CheckSystemServicesUpdatesAvailable is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    CheckSystemServicesUpdatesAvailableResponse
  >;

  @doc("Updates system services in a cluster.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters/{clusterName}/updateSystemServices")
  @post
  UpdateSystemServices is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("The name of the cluster.")
      @path
      clusterName: string;
    },
    UpdateSystemServicesResponse | void
  >;

  @doc("Gets the clusters in the specified resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.MachineLearningCompute/operationalizationClusters")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group in which the cluster is located.")
      @path
      resourceGroupName: string;

      @doc("Continuation token for pagination.")
      @query
      $skiptoken: string;
    },
    PaginatedOperationalizationClustersList
  >;

  @doc("Gets the operationalization clusters in the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.MachineLearningCompute/operationalizationClusters")
  @get
  ListBySubscriptionId is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Continuation token for pagination.")
      @query
      $skiptoken: string;
    },
    PaginatedOperationalizationClustersList
  >;
}

interface MachineLearningComputeOperations {
  @doc("Gets all available operations.")
  @route("/providers/Microsoft.MachineLearningCompute/operations")
  @get
  ListAvailableOperations is Azure.Core.Foundations.Operation<
    {},
    AvailableOperations
  >;
}
