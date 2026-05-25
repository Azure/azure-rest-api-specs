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
@added(Versions.v2026_03_02_preview)
union UpgradeInsightStatus {
  string,

  /**
   * No upgrade issues were detected for the target version.
   */
  NoIssuesDetected: "NoIssuesDetected",

  /**
   * One or more upgrade issues were detected for the target version.
   */
  UpgradeIssueDetected: "UpgradeIssueDetected",
}

/**
 * The type of a detected upgrade issue.
 */
@added(Versions.v2026_03_02_preview)
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
@added(Versions.v2026_03_02_preview)
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
 * The Kubernetes version compliance posture of the cluster.
 */
@added(Versions.v2026_03_02_preview)
union KubernetesVersionCompliancePosture {
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

// =============================================================================
// UpgradeInsight models
// =============================================================================

/**
 * A recommended action to resolve a detected upgrade issue.
 */
@added(Versions.v2026_03_02_preview)
model UpgradeInsightRecommendedAction {
  /**
   * A short title describing the recommended action.
   */
  title?: string;

  /**
   * A detailed description of the recommended action and how to perform it.
   */
  details?: string;

  /**
   * A link to relevant documentation for the recommended action.
   */
  documentationLink?: string;
}

/**
 * The Azure or Kubernetes resource impacted by a detected upgrade issue.
 */
@added(Versions.v2026_03_02_preview)
model UpgradeInsightImpactedResource {
  /**
   * The type of the impacted resource (for example, Subnet or PodDisruptionBudget).
   */
  resourceType?: string;

  /**
   * The ARM resource ID of the impacted resource, if applicable.
   */
  resourceId?: string;

  /**
   * The Kubernetes namespace of the impacted resource, if applicable.
   */
  namespace?: string;

  /**
   * The name of the impacted Kubernetes resource, if applicable.
   */
  name?: string;
}

/**
 * A detected upgrade issue for a managed cluster.
 */
@added(Versions.v2026_03_02_preview)
model DetectedUpgradeIssue {
  /**
   * The type of the detected upgrade issue.
   */
  issueType?: UpgradeIssueType;

  /**
   * The severity of the detected issue.
   */
  severity?: UpgradeIssueSeverity;

  /**
   * A short error code identifying the issue.
   */
  code?: string;

  /**
   * A human-readable description of the issue and why it may block or risk the upgrade.
   */
  message?: string;

  /**
   * The Azure or Kubernetes resource impacted by this issue.
   */
  impactedResource?: UpgradeInsightImpactedResource;

  /**
   * A list of recommended actions the customer can safely perform to resolve the issue.
   */
  @identifiers(#[])
  recommendedActions?: UpgradeInsightRecommendedAction[];
}

/**
 * A summary of the upgrade insight evaluation result.
 */
@added(Versions.v2026_03_02_preview)
model UpgradeInsightSummary {
  /**
   * A human-readable message summarizing the upgrade insight evaluation and next steps.
   */
  message?: string;
}

/**
 * The result of an upgrade insight evaluation against a target Kubernetes version.
 */
@added(Versions.v2026_03_02_preview)
model UpgradeInsightResult {
  /**
   * The target Kubernetes version that was evaluated.
   */
  targetKubernetesVersion?: string;

  /**
   * The overall upgrade insight status indicating whether issues were detected.
   */
  upgradeInsight?: UpgradeInsightStatus;

  /**
   * The UTC time at which the upgrade insight evaluation was performed.
   */
  @visibility(Lifecycle.Read)
  evaluatedAt?: utcDateTime;

  /**
   * A summary of the upgrade insight evaluation result.
   */
  summary?: UpgradeInsightSummary;

  /**
   * The list of detected upgrade issues, if any. Each issue includes the type, severity,
   * impacted resource, and recommended remediation actions.
   */
  @identifiers(#[])
  detectedIssues?: DetectedUpgradeIssue[];
}

/**
 * Contextual upgrade posture information for a managed cluster, including
 * maintenance windows, upgrade history, and Kubernetes version compliance.
 */
@added(Versions.v2026_03_02_preview)
model UpgradePostureContext {
  /**
   * The UTC start time of the next scheduled automatic upgrade maintenance window,
   * if automatic upgrades are configured.
   */
  nextMaintenanceWindowTime?: utcDateTime;

  /**
   * The UTC time of the last successful Kubernetes version upgrade for this cluster.
   */
  lastSuccessfulUpgradeTime?: utcDateTime;

  /**
   * The number of days since the last successful upgrade. Failed upgrade attempts
   * do not reset this counter.
   */
  @visibility(Lifecycle.Read)
  daysSinceLastSuccessfulUpgrade?: int32;

  /**
   * The Kubernetes version compliance posture of the cluster, indicating whether
   * the cluster is within a supported, approaching end-of-life, or unsupported version.
   */
  kubernetesVersionCompliancePosture?: KubernetesVersionCompliancePosture;
}

/**
 * The properties of an upgrade insight evaluation for a managed cluster.
 */
@added(Versions.v2026_03_02_preview)
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "UpgradeInsight is a read-only evaluation result without provisioning state."
model UpgradeInsightProperties {
  /**
   * The upgrade insight evaluation result for the requested target Kubernetes version.
   */
  upgrades?: UpgradeInsightResult;

  /**
   * Contextual upgrade posture information for the cluster, including upcoming
   * maintenance windows, last successful upgrade time, and Kubernetes version compliance.
   */
  postureContext?: UpgradePostureContext;
}

// =============================================================================
// UpgradeInsight resource and operations
// =============================================================================

/**
 * Upgrade insight evaluation result for a managed cluster.
 * Provides a read-only view of upgrade readiness, detected blocking issues,
 * and cluster upgrade posture for a given target Kubernetes version.
 */
@added(Versions.v2026_03_02_preview)
@singleton("default")
@parentResource(ManagedCluster)
model UpgradeInsight
  is Azure.ResourceManager.ProxyResource<UpgradeInsightProperties, false> {
  ...ResourceNameParameter<
    Resource = UpgradeInsight,
    KeyName = "upgradeInsight",
    SegmentName = "upgradeInsights",
    NamePattern = ""
  >;
}

@@doc(UpgradeInsight.name, "");
@@doc(
  UpgradeInsight.properties,
  "The properties of the upgrade insight evaluation."
);

@armResourceOperations(#{ omitTags: true })
@added(Versions.v2026_03_02_preview)
interface UpgradeInsights {
  /**
   * Evaluates upgrade insights for the specified managed cluster against a target
   * Kubernetes version. Returns a list of detected upgrade-blocking issues and
   * contextual upgrade posture information. Checks are performed on a best-effort
   * basis and reflect the cluster state at the time of evaluation.
   */
  @tag("ManagedClusters")
  @action("evaluate")
  evaluateUpgradeInsight is ArmResourceActionSync<
    UpgradeInsight,
    void,
    ArmResponse<UpgradeInsight>,
    Parameters = {
      /**
       * The target Kubernetes version to evaluate upgrade insights against.
       * If not specified, the evaluation uses the next available upgrade version.
       */
      @query("targetKubernetesVersion")
      targetKubernetesVersion?: string;
    }
  >;
}
