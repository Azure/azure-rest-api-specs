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
model KubernetesResource
  is Azure.ResourceManager.ProxyResource<KubernetesResourceProperties> {
  ...ResourceNameParameter<
    Resource = KubernetesResource,
    KeyName = "kubernetesResourceName",
    SegmentName = "kubernetesResources",
    NamePattern = "^[a-z]([a-z0-9._-]{0,126}[a-z0-9])?$"
  >;
}

/**
 * Operations alias for KubernetesResources using the cluster extension routing pattern.
 * Generates URLs of the form:
 *   /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/kubernetesResources[/{kubernetesResourceName}]
 */
alias KubernetesResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes,
     * Microsoft.HybridContainerService, Microsoft.KubernetesConfiguration.
     */
    @path
    @segment("providers")
    @key
    @pattern("^Microsoft\\.(ContainerService|Kubernetes|HybridContainerService|KubernetesConfiguration)$")
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
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<KubernetesResource>;
    ...ParentKeysOf<KubernetesResource>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<KubernetesResource>;
    ...KeysOf<KubernetesResource>;
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface KubernetesResources {
  /**
   * Get the kubernetesResources singleton for a cluster.
   */
  @tag("KubernetesResources")
  get is KubernetesResourceOps.Read<KubernetesResource>;

  /**
   * List kubernetesResources containers for the cluster (currently always a single 'default').
   */
  @tag("KubernetesResources")
  list is KubernetesResourceOps.List<KubernetesResource>;
}

@@doc(KubernetesResource.name, "Name of the KubernetesResources resource.");
@@doc(
  KubernetesResource.properties,
  "Properties of the KubernetesResources resource."
);
