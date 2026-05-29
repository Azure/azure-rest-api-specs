import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KubeInventory.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KubernetesConfiguration;

/**
 * Periodic, cluster-computed Kubernetes upgrade assessment.
 */
@parentResource(KubeInventory)
model UpgradeAssessment is Azure.ResourceManager.ProxyResource<UpgradeAssessmentProperties> {
  ...ResourceNameParameter<
    Resource = UpgradeAssessment,
    KeyName = "assessmentName",
    SegmentName = "upgradeAssessments",
    NamePattern = ""
  >;
}

/**
 * Operations alias for UpgradeAssessment using the cluster + KubeInventory extension routing pattern.
 * Generates URLs of the form:
 *   .../providers/Microsoft.KubernetesConfiguration/kubeInventory/{kubeInventoryName}/upgradeAssessments[/{assessmentName}]
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
    clusterRp: string;

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
     * provisionedClusters, appliances.
     */
    @key
    @path
    @pattern("^[a-zA-Z]*$")
    clusterResourceName: string;

    /**
     * The name of the kubernetes cluster.
     */
    @key
    @path
    @pattern("^.*")
    clusterName: string;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<UpgradeAssessment>;
    ...ParentKeysOf<UpgradeAssessment>;
  },
  {
    ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<UpgradeAssessment>;
    ...ParentKeysOf<UpgradeAssessment>;
    ...KeysOf<UpgradeAssessment>;
  }
>;

/**
 * RoutedOperations alias used for the refresh action on a specific UpgradeAssessment instance.
 * Includes all path params up to and including assessmentName so the action route resolves correctly.
 */
alias UpgradeAssessmentBuildingOps = Azure.ResourceManager.Legacy.RoutedOperations<
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
    clusterRp: string;

    /**
     * The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters,
     * provisionedClusters, appliances.
     */
    @key
    @path
    @pattern("^[a-zA-Z]*$")
    clusterResourceName: string;

    /**
     * The name of the kubernetes cluster.
     */
    @key
    @path
    @pattern("^.*")
    clusterName: string;

    ...KeysOf<KubeInventory>;
    ...KeysOf<UpgradeAssessment>;
  },
  {},
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/kubeInventory",
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
   * List upgrade assessments under a kubeInventory (currently always a single 'current').
   */
  @tag("UpgradeAssessments")
  list is UpgradeAssessmentOps.List<UpgradeAssessment>;

  /**
   * Internal write path used by the in-cluster agent to publish or update an upgrade assessment.
   * End users do NOT have RBAC for this operation; access is restricted to the cluster's managed identity.
   */
  @tag("UpgradeAssessments")
  createOrUpdate is UpgradeAssessmentOps.CreateOrUpdateAsync<UpgradeAssessment>;

  /**
   * Trigger the in-cluster agent to recompute the upgrade assessment.
   * Long-running; only one refresh per cluster may be in flight at a time (returns 409 otherwise).
   */
  @tag("UpgradeAssessments")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/kubeInventory/{kubeInventoryName}/upgradeAssessments/{assessmentName}/refresh")
  refresh is UpgradeAssessmentBuildingOps.ActionAsync<
    UpgradeAssessment,
    RefreshRequest,
    | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = UpgradeAssessment>>
    | ArmResponse<UpgradeAssessment>
  >;
}

@@doc(UpgradeAssessment.name, "Name of the UpgradeAssessment resource.");
@@doc(
  UpgradeAssessment.properties,
  "Properties of the UpgradeAssessment resource."
);
@@doc(
  UpgradeAssessments.createOrUpdate::parameters.resource,
  "The UpgradeAssessment resource body."
);
