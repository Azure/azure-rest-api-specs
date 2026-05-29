import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

// ─── Enums ───────────────────────────────────────────────────────────────────

/**
 * Provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /** Resource has been created successfully. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** Resource is being updated. */
  Updating: "Updating",
}

/**
 * Severity of a check or upgrade-assessment finding.
 */
union Severity {
  string,

  /** No issues found. */
  pass: "pass",

  /** Non-blocking issues found. */
  warning: "warning",

  /** Blocking issues found. */
  critical: "critical",

  /** Severity could not be determined. */
  Unknown: "unknown",
}

/**
 * Compatibility status of a cluster component with the target Kubernetes version.
 */
union CompatibilityStatus {
  string,

  /** Component is compatible with the target version. */
  compatible: "compatible",

  /** Compatibility with the target version has not been tested. */
  untested: "untested",

  /** Component is incompatible with the target version. */
  incompatible: "incompatible",

  /** Compatibility status is unknown. */
  Unknown: "unknown",
}

/**
 * Category of a cluster readiness check.
 */
union ReadinessCategory {
  string,

  /** Node status check. */
  NodeStatus: "NodeStatus",

  /** API server health check. */
  APIServerHealth: "APIServerHealth",

  /** Pod disruption budget check. */
  PodDisruptionBudget: "PodDisruptionBudget",

  /** Addon compatibility check. */
  Addon: "Addon",

  /** Storage compatibility check. */
  Storage: "Storage",

  /** Networking compatibility check. */
  Networking: "Networking",
}

// ─── Supporting models ────────────────────────────────────────────────────────

/**
 * Compatibility status of a single cluster component.
 */
model ComponentCompatibility {
  /** Component name (e.g., 'containerd', 'calico'). */
  name: string;

  /** Installed component version. */
  version: string;

  /** Compatibility status of the component with the target Kubernetes version. */
  compatibilityStatus: CompatibilityStatus;

  /** Severity associated with the compatibility result. */
  severity: Severity;

  /** Minimum component version known to be compatible with targetKubernetesVersion. */
  minCompatibleVersion?: string;

  /** Additional notes about compatibility. */
  notes?: string;
}

/**
 * A deprecated Kubernetes API still in use in the cluster.
 */
model DeprecatedApiUsage {
  /** API group (e.g., 'flowcontrol.apiserver.k8s.io'). */
  group: string;

  /** API version (e.g., 'v1beta3'). */
  version: string;

  /** Resource plural name (e.g., 'flowschemas'). */
  resource: string;

  /** Kubernetes release in which this API is removed (e.g., '1.32'). */
  removedRelease?: string;

  /** Lowercase HTTP verbs mapped to observed call counts. */
  usageMetrics?: Record<int64>;

  /** UTC timestamp of the last observed usage. */
  lastUsageObservedAt?: utcDateTime;

  /** Severity of this deprecated API usage. */
  severity: Severity;
}

/**
 * A single cluster readiness check result.
 */
model ReadinessCheck {
  /** Category of the readiness check. */
  category: ReadinessCategory;

  /**
   * Subject of the check (node name, workload namespace/name, etc.).
   * Optional for cluster-wide checks.
   */
  name?: string;

  /** Severity of the check result. */
  severity: Severity;

  /** Human-readable reason when severity is not 'pass'. */
  details?: string;
}

/**
 * Optional request body for the refresh action.
 */
model RefreshRequest {
  /**
   * Optional override for the target Kubernetes version.
   * If omitted, the cluster's default upgrade target is used.
   */
  targetKubernetesVersion?: string;
}

// ─── Resource properties ─────────────────────────────────────────────────────

/**
 * Properties of the KubeInventory resource.
 */
model KubeInventoryProperties {}

/**
 * Properties of the UpgradeAssessment resource.
 */
model UpgradeAssessmentProperties {
  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** UTC timestamp when the cluster computed this assessment. */
  @visibility(Lifecycle.Read)
  assessmentTime?: utcDateTime;

  /** Current Kubernetes version of the cluster (e.g., '1.29'). */
  kubernetesVersion: string;

  /** Target Kubernetes version evaluated for upgrade (e.g., '1.30'). */
  targetKubernetesVersion: string;

  /** Rolled-up severity across all checks. Highest severity wins. */
  overallSeverity?: Severity;

  /** Compatibility status of cluster components with the target version. */
  componentCompatibility?: ComponentCompatibility[];

  /** Deprecated Kubernetes APIs still in use in the cluster. */
  deprecatedApis?: DeprecatedApiUsage[];

  /** Cluster readiness check results. */
  readinessChecks?: ReadinessCheck[];
}
