import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KubernetesConfiguration;

/**
 * Singleton container resource grouping cluster inventory reports.
 */
model KubeInventory
  is Azure.ResourceManager.ProxyResource<KubeInventoryProperties> {
  ...ResourceNameParameter<
    Resource = KubeInventory,
    KeyName = "kubeInventoryName",
    SegmentName = "kubeInventory",
    NamePattern = "^[a-z]([a-z0-9._-]{0,126}[a-z0-9])?$"
  >;
}

/**
 * Operations alias for KubeInventory using the cluster extension routing pattern.
 * Generates URLs of the form:
 *   /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/kubeInventory[/{kubeInventoryName}]
 */
alias KubeInventoryOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes,
     * Microsoft.HybridContainerService.
     */
    @path
    @segment("providers")
    @key
    @pattern("^Microsoft\\.(ContainerService|Kubernetes|HybridContainerService)$")
    clusterRp: string;

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
     * provisionedClusters, appliances.
     */
    @key
    @path
    @pattern("^[a-zA-Z]+$")
    clusterResourceName: string;

    /**
     * The name of the kubernetes cluster.
     */
    @key
    @path
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{0,62}$")
    clusterName: string;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<KubeInventory>;
    ...ParentKeysOf<KubeInventory>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<KubeInventory>;
    ...KeysOf<KubeInventory>;
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface KubeInventories {
  /**
   * Get the kubeInventory singleton for a cluster.
   */
  @tag("KubeInventory")
  get is KubeInventoryOps.Read<KubeInventory>;

  /**
   * List kubeInventory containers for the cluster (currently always a single 'default').
   */
  @tag("KubeInventory")
  list is KubeInventoryOps.List<KubeInventory>;
}

@@doc(KubeInventory.name, "Name of the KubeInventory resource.");
@@doc(KubeInventory.properties, "Properties of the KubeInventory resource.");
