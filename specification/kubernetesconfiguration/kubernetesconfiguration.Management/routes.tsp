import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.KubernetesConfiguration;

@armResourceOperations
interface OperationStatus {
  /**
   * List Async Operations, currently in progress, in a cluster
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/operations")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.
     */
    @path
    clusterRp: string,

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters.
     */
    @path
    clusterResourceName: string,

    /**
     * The name of the kubernetes cluster.
     */
    @path
    clusterName: string,
  ): ArmResponse<OperationStatusList> | ErrorResponse;
}
