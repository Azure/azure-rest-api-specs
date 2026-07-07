import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// UpgradeInsight unions
// =============================================================================

/**
 * The overall upgrade insight evaluation status.
 */
@added(Versions.v2026_07_02_preview)
union UpgradeInsightStatus {
  string,

  /**
   * No upgrade issues were detected for the target version.
   */
  NoIssuesDetected: "NoIssuesDetected",

  /**
   * One or more upgrade issues were detected for the target version.
   */
  IssueDetected: "IssueDetected",
}

/**
 * The type of a detected upgrade issue.
 */
@added(Versions.v2026_07_02_preview)
union UpgradeIssueType {
  string,

  /**
   * A PodDisruptionBudget is misconfigured in a way that prevents node drain during upgrade.
   */
  PDBConstraint: "PDBConstraint",

  /**
   * The cluster subnet does not have sufficient available IP addresses for surge nodes during upgrade.
   */
  SubnetIpExhaustion: "SubnetIpExhaustion",

  /**
   * Compute quota for the node pool VM SKU is insufficient to accommodate surge nodes during upgrade.
   */
  QuotaExceeded: "QuotaExceeded",

  /**
   * The cluster is using deprecated Kubernetes APIs that are removed in the target version.
   */
  ApiBreakingChange: "ApiBreakingChange",

  /**
   * An add-on or system component is not compatible with the target Kubernetes version.
   */
  ComponentVersionMismatch: "ComponentVersionMismatch",

  /**
   * The cluster is running a Kubernetes version that is no longer supported.
   */
  UnsupportedKubernetesVersion: "UnsupportedKubernetesVersion",

  /**
   * The cluster node image has not been upgraded within the required compliance interval.
   */
  NodeImageOOSLA: "NodeImageOOSLA",
}

/**
 * The severity of a detected upgrade issue.
 */
@added(Versions.v2026_07_02_preview)
union UpgradeIssueSeverity {
  string,

  /**
   * The issue will block the upgrade from completing successfully.
   */
  Blocking: "Blocking",

  /**
   * The issue may risk the upgrade but will not necessarily prevent it from completing.
   */
  Warning: "Warning",
}

/**
 * The Kubernetes version support status of the cluster.
 */
@added(Versions.v2026_07_02_preview)
union KubernetesVersionSupportStatus {
  string,

  /**
   * The cluster is running a fully supported Kubernetes version.
   */
  InSupport: "InSupport",

  /**
   * The cluster is running a Kubernetes version that is approaching end of life.
   */
  ApproachingEOL: "ApproachingEOL",

  /**
   * The cluster is running a Kubernetes version that is no longer supported.
   */
  OutOfSupport: "OutOfSupport",
}

/**
 * The strategy currently used to upgrade the cluster's Kubernetes version.
 */
@added(Versions.v2026_07_02_preview)
union ClusterUpgradeStrategy {
  string,

  /**
   * Upgrades are initiated manually by the customer.
   */
  Manual: "Manual",

  /**
   * Upgrades are performed automatically by AKS auto-upgrade.
   */
  AutoUpgrade: "AutoUpgrade",
}

/**
 * The category of a resource impacted by a detected upgrade issue.
 */
@added(Versions.v2026_07_02_preview)
union ImpactedResourceKind {
  string,

  /**
   * An Azure Resource Manager (ARM) resource, such as a subnet.
   */
  Arm: "Arm",

  /**
   * A Kubernetes resource, such as a PodDisruptionBudget.
   */
  Kubernetes: "Kubernetes",
}

/**
 * The type of upgrade evaluated by an upgrade insight.
 */
@added(Versions.v2026_07_02_preview)
union ClusterUpgradeType {
  string,

  /**
   * A managed cluster (control plane) Kubernetes version upgrade.
   */
  ControlPlane: "ControlPlane",

  /**
   * An agent pool (node pool) Kubernetes version upgrade.
   */
  NodePool: "NodePool",

  /**
   * A node OS image upgrade for an agent pool.
   */
  NodeImage: "NodeImage",
}

// =============================================================================
// UpgradeInsight models
// =============================================================================

/**
 * A recommended action to resolve a detected upgrade issue.
 */
@added(Versions.v2026_07_02_preview)
model UpgradeInsightRecommendedAction {
  /**
   * A short title describing the recommended action.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * A detailed description of the recommended action and how to perform it.
   */
  @visibility(Lifecycle.Read)
  details?: string;

  /**
   * A link to customer-facing documentation describing the available options
   * for remediating the issue.
   */
  @visibility(Lifecycle.Read)
  documentationLink?: string;
}

/**
 * The Azure or Kubernetes resource impacted by a detected upgrade issue.
 * Use the `kind` discriminator to determine whether this is an Azure Resource
 * Manager (ARM) resource or a Kubernetes resource.
 */
@added(Versions.v2026_07_02_preview)
@discriminator("kind")
model UpgradeInsightImpactedResource {
  /**
   * The category of the impacted resource, indicating whether it is an Azure
   * Resource Manager (ARM) resource or a Kubernetes resource.
   */
  @visibility(Lifecycle.Read)
  kind: ImpactedResourceKind;

  /**
   * The type of the impacted resource (for example,
   * Microsoft.Network/virtualNetworks/subnets for an ARM resource or
   * PodDisruptionBudget for a Kubernetes resource).
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;
}

/**
 * An Azure Resource Manager (ARM) resource impacted by a detected upgrade
 * issue, such as a subnet. Identified by its ARM resource ID.
 */
@added(Versions.v2026_07_02_preview)
model ArmImpactedResource extends UpgradeInsightImpactedResource {
  /**
   * The discriminator indicating the impacted resource is an ARM resource.
   */
  kind: ImpactedResourceKind.Arm;

  /**
   * The ARM resource ID of the impacted resource.
   */
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;
}

/**
 * A Kubernetes resource impacted by a detected upgrade issue, such as a
 * PodDisruptionBudget. Identified by its namespace and name.
 */
@added(Versions.v2026_07_02_preview)
model KubernetesImpactedResource extends UpgradeInsightImpactedResource {
  /**
   * The discriminator indicating the impacted resource is a Kubernetes resource.
   */
  kind: ImpactedResourceKind.Kubernetes;

  /**
   * The Kubernetes namespace of the impacted resource, if applicable.
   */
  @visibility(Lifecycle.Read)
  namespace?: string;

  /**
   * The name of the impacted Kubernetes resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * A detected upgrade issue for a managed cluster.
 */
@added(Versions.v2026_07_02_preview)
model DetectedUpgradeIssue {
  /**
   * The type of the detected upgrade issue.
   */
  @visibility(Lifecycle.Read)
  issueType?: UpgradeIssueType;

  /**
   * The severity of the detected issue.
   */
  @visibility(Lifecycle.Read)
  severity?: UpgradeIssueSeverity;

  /**
   * A human-readable description of the issue and why it may block or risk the upgrade.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The Azure or Kubernetes resource impacted by this issue.
   */
  @visibility(Lifecycle.Read)
  impactedResource?: UpgradeInsightImpactedResource;

  /**
   * The recommended action to resolve this issue, including a link to
   * customer-facing documentation describing the available remediation options.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: UpgradeInsightRecommendedAction;
}

/**
 * The evaluation payload shared by all upgrade insight results, containing the
 * overall status, evaluation time, summary, and any detected issues.
 */
@added(Versions.v2026_07_02_preview)
model UpgradeInsightEvaluation {
  /**
   * The overall upgrade insight status indicating whether issues were detected.
   */
  @visibility(Lifecycle.Read)
  status?: UpgradeInsightStatus;

  /**
   * The UTC time at which the upgrade insight evaluation was performed.
   */
  @visibility(Lifecycle.Read)
  evaluatedAt?: utcDateTime;

  /**
   * A human-readable message summarizing the upgrade insight evaluation and next
   * steps. For example: "Upgrade issues have been detected for the specified target
   * version. Upgrade checks were performed on a best-effort basis and reflect the
   * cluster state at {evaluatedAt}. Learn more:
   * https://learn.microsoft.com/azure/aks/upgradeinsights".
   */
  @visibility(Lifecycle.Read)
  summary?: string;

  /**
   * The list of detected upgrade issues, if any. Each issue includes the type, severity,
   * impacted resource, and recommended remediation actions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  detectedIssues?: DetectedUpgradeIssue[];
}

/**
 * The result of evaluating a Kubernetes version upgrade. Used for both the managed
 * cluster (control plane) upgrade and an agent pool Kubernetes version upgrade.
 */
@added(Versions.v2026_07_02_preview)
model KubernetesUpgradeInsight {
  /**
   * The target Kubernetes version that was evaluated.
   */
  @visibility(Lifecycle.Read)
  targetKubernetesVersion?: string;

  /**
   * The UTC time of the last successful Kubernetes version upgrade for this scope
   * (control plane or agent pool).
   */
  @visibility(Lifecycle.Read)
  lastSuccessfulUpgradeTime?: utcDateTime;

  /**
   * The number of days since the last successful upgrade for this scope. Failed
   * upgrade attempts do not reset this counter.
   */
  @visibility(Lifecycle.Read)
  daysSinceLastSuccessfulUpgrade?: int32;

  /**
   * The Kubernetes version support status for this scope, indicating whether
   * the running Kubernetes version is supported, approaching end-of-life, or unsupported.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersionSupportStatus?: KubernetesVersionSupportStatus;

  ...UpgradeInsightEvaluation;
}

/**
 * The result of evaluating a node OS image upgrade for an agent pool.
 */
@added(Versions.v2026_07_02_preview)
model NodeImageUpgradeInsight {
  /**
   * The target node image version that was evaluated.
   */
  @visibility(Lifecycle.Read)
  targetNodeImageVersion?: string;

  ...UpgradeInsightEvaluation;
}

/**
 * The upgrade insights for a single agent pool, covering both its Kubernetes
 * version upgrade and its node OS image upgrade.
 */
@added(Versions.v2026_07_02_preview)
model AgentPoolUpgradeInsight {
  /**
   * The name of the agent pool these insights apply to.
   */
  @visibility(Lifecycle.Read)
  agentPoolName?: string;

  /**
   * The insights for the agent pool's Kubernetes version upgrade.
   */
  @visibility(Lifecycle.Read)
  kubernetesUpgrade?: KubernetesUpgradeInsight;

  /**
   * The insights for the agent pool's node OS image upgrade.
   */
  @visibility(Lifecycle.Read)
  nodeImageUpgrade?: NodeImageUpgradeInsight;
}

/**
 * Cluster-wide contextual upgrade information for a managed cluster, such as the
 * next maintenance window and the current upgrade strategy.
 */
@added(Versions.v2026_07_02_preview)
model ClusterUpgradeContext {
  /**
   * The UTC start time of the next scheduled automatic upgrade maintenance window,
   * if automatic upgrades are configured.
   */
  @visibility(Lifecycle.Read)
  nextMaintenanceWindowTime?: utcDateTime;

  /**
   * The strategy currently used to upgrade the cluster, indicating whether upgrades
   * are performed manually by the customer or automatically by AKS auto-upgrade.
   */
  @visibility(Lifecycle.Read)
  currentUpgradeStrategy?: ClusterUpgradeStrategy;
}

/**
 * The result of an upgrade insights evaluation for a managed cluster, covering the
 * control plane, agent pools, and cluster-wide upgrade context.
 */
@added(Versions.v2026_07_02_preview)
model UpgradeInsightsResult {
  /**
   * The upgrade insights for the managed cluster control plane (Kubernetes version upgrade).
   */
  @visibility(Lifecycle.Read)
  controlPlane?: KubernetesUpgradeInsight;

  /**
   * The upgrade insights for each agent pool, covering the agent pool's Kubernetes
   * version upgrade and node OS image upgrade.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["agentPoolName"])
  agentPools?: AgentPoolUpgradeInsight[];

  /**
   * Contextual upgrade information for the cluster, including upcoming
   * maintenance windows, last successful upgrade time, and Kubernetes version compliance.
   */
  @visibility(Lifecycle.Read)
  upgradeContext?: ClusterUpgradeContext;
}

// =============================================================================
// UpgradeInsight operations
// =============================================================================

/**
 * Operations for evaluating upgrade insights for a managed cluster.
 */
@armResourceOperations(#{ omitTags: true })
@added(Versions.v2026_07_02_preview)
interface UpgradeInsights {
  /**
   * Evaluates upgrade insights for the specified managed cluster. Returns the
   * detected upgrade-blocking issues and contextual upgrade information for the
   * control plane and agent pools. Checks are performed on a best-effort basis and
   * reflect the cluster state at the time of evaluation.
   */
  @tag("ManagedClusters")
  @action("upgradeInsights")
  evaluateUpgradeInsights is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<UpgradeInsightsResult>,
    Parameters = {
      /**
       * The type of upgrade to evaluate. If not specified, the control plane
       * (managed cluster) upgrade is evaluated.
       */
      @query("upgradeType")
      upgradeType?: ClusterUpgradeType;

      /**
       * The name of the agent pool to evaluate. Applies to the NodePool and
       * NodeImage upgrade types; ignored for ControlPlane. If not specified, all
       * agent pools are evaluated and a separate result is returned for each.
       */
      @query("agentPoolName")
      agentPoolName?: string;

      /**
       * The target Kubernetes version to evaluate upgrade insights against.
       * Applies to the ControlPlane and NodePool upgrade types. If not specified,
       * the evaluation uses the next available upgrade version.
       */
      @query("targetKubernetesVersion")
      targetKubernetesVersion?: string;

      /**
       * The target node image version to evaluate upgrade insights against.
       * Applies to the NodeImage upgrade type. If not specified, the evaluation
       * uses the next available node image version.
       */
      @query("targetNodeImageVersion")
      targetNodeImageVersion?: string;
    }
  >;
}
