import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConnectedKubernetesClient;

interface ConnectedClusterOperations {
  @summary("Register a new Kubernetes cluster with Azure Resource Manager.")
  @doc("""
API to register a new Kubernetes cluster and create a tracked resource in Azure
Resource Manager (ARM).
""")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [ConnectedCluster]
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters/{clusterName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Kubernetes cluster on which get is called.")
      @path
      clusterName: string;

      @doc("Parameters supplied to Create a Connected Cluster.")
      @body
      ConnectedCluster: ConnectedCluster;
    },
    ConnectedCluster
  >;

  @summary("Updates a connected cluster.")
  @doc("API to update certain properties of the connected cluster resource")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters/{clusterName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Kubernetes cluster on which get is called.")
      @path
      clusterName: string;

      @doc("Parameters supplied to update Connected Cluster.")
      @body
      ConnectedClusterPatch: ConnectedClusterPatch;
    },
    ConnectedCluster
  >;

  @summary("Get the properties of the specified connected cluster.")
  @doc("""
Returns the properties of the specified connected cluster, including name,
identity, properties, and additional cluster details.
""")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters/{clusterName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Kubernetes cluster on which get is called.")
      @path
      clusterName: string;
    },
    ConnectedCluster
  >;

  @summary("Delete a connected cluster.")
  @doc("""
Delete a connected cluster, removing the tracked resource in Azure Resource
Manager (ARM).
""")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters/{clusterName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Kubernetes cluster on which get is called.")
      @path
      clusterName: string;
    },
    void
  >;

  @summary("Gets cluster user credentials of a connected cluster")
  @doc("""
Gets cluster user credentials of the connected cluster with a specified
resource group and name.
""")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters/{clusterName}/listClusterUserCredential")
  @post
  ListClusterUserCredential is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Kubernetes cluster on which get is called.")
      @path
      clusterName: string;

      @doc("ListClusterUserCredential properties")
      @body
      Properties: ListClusterUserCredentialProperties;
    },
    CredentialResults
  >;

  @summary("Lists all connected clusters")
  @doc("API to enumerate registered connected K8s clusters under a Resource Group")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.Kubernetes/connectedClusters")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    ConnectedClusterList
  >;

  @summary("Lists all connected clusters")
  @doc("API to enumerate registered connected K8s clusters under a Subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Kubernetes/connectedClusters")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    ConnectedClusterList
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available API operations for Connected Cluster resource.")
  @route("/providers/Microsoft.Kubernetes/operations")
  @get
  Get is Azure.Core.Foundations.Operation<{}, OperationList>;
}
