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
 * ARM resource representing a Kubernetes cluster upgrade assessment.
 */
model UpgradeAssessment
  is Azure.ResourceManager.ProxyResource<UpgradeAssessmentProperties> {
  ...ResourceNameParameter<
    Resource = UpgradeAssessment,
    KeyName = "upgradeAssessmentName",
    SegmentName = "upgradeAssessment",
    NamePattern = "^[a-z]([a-z0-9._-]{0,126}[a-z0-9])?$"
  >;
}

/**
 * Operations alias for UpgradeAssessment using the cluster extension routing pattern.
 * Generates URLs of the form:
 *   /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/upgradeAssessment[/{upgradeAssessmentName}]
 */
alias UpgradeAssessmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<UpgradeAssessment>;
    ...ParentKeysOf<UpgradeAssessment>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<UpgradeAssessment>;
    ...KeysOf<UpgradeAssessment>;
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface UpgradeAssessments {
  /**
   * Get the upgrade assessment for a cluster.
   */
  @tag("UpgradeAssessment")
  get is UpgradeAssessmentOps.Read<UpgradeAssessment>;

  /**
   * List upgrade assessments for the cluster.
   */
  @tag("UpgradeAssessment")
  list is UpgradeAssessmentOps.List<UpgradeAssessment>;
}

@@doc(UpgradeAssessment.name, "Name of the UpgradeAssessment resource.");
@@doc(
  UpgradeAssessment.properties,
  "Properties of the UpgradeAssessment resource."
);
