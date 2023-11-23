import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.KubernetesConfiguration;

interface OperationStatusOperations {
  @doc("List Async Operations, currently in progress, in a cluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/operations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.")
      @path
      clusterRp: string;

      @doc("The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters.")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;
    },
    OperationStatusList
  >;
}
