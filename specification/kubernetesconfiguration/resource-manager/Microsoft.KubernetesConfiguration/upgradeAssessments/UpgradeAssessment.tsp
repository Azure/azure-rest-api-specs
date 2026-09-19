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

/** Allowed instance name for the upgrade assessment singleton. */
union UpgradeAssessmentName {
  string,

  /** The only valid instance; one assessment per cluster. */
  default: "default",
}

/**
 * ARM resource representing a Kubernetes cluster upgrade assessment.
 */
model UpgradeAssessment
  is Azure.ResourceManager.ProxyResource<UpgradeAssessmentProperties> {
  @path
  @key("upgradeAssessmentName")
  @segment("upgradeAssessments")
  @pattern("^default$")
  name: UpgradeAssessmentName;
}

/**
 * Operations alias for UpgradeAssessments using the cluster extension routing pattern.
 * Generates URLs of the form:
 *   /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/upgradeAssessments[/{upgradeAssessmentName}]
 */
alias UpgradeAssessmentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  @tag("UpgradeAssessments")
  get is UpgradeAssessmentOps.Read<UpgradeAssessment>;

  /**
   * List upgrade assessments for the cluster.
   */
  @tag("UpgradeAssessments")
  list is UpgradeAssessmentOps.List<UpgradeAssessment>;
}

@@doc(
  UpgradeAssessment.name,
  "Name of the upgrade assessment. Must be 'default'; only one upgrade assessment exists per cluster."
);
@@doc(
  UpgradeAssessment.properties,
  "Properties of the UpgradeAssessments resource."
);
