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

// ─── UpgradeAssessment enums ──────────────────────────────────────────────────

/** Severity of an upgrade-assessment finding or readiness check. */
union Severity {
  string,

  /** No issues found. */
  None: "None",

  /** Non-blocking issues found; upgrade is possible but action is recommended. */
  Warning: "Warning",

  /** Blocking issues found; upgrade should not proceed without remediation. */
  Critical: "Critical",

  /** Severity could not be determined. */
  Unknown: "Unknown",
}

/** Compatibility status of a cluster component with the target Kubernetes version. */
union CompatibilityStatus {
  string,

  /** Component is compatible with the target version. */
  Compatible: "Compatible",

  /** Compatibility with the target version has not been tested. */
  Untested: "Untested",

  /** Component is incompatible with the target version. */
  Incompatible: "Incompatible",

  /** Compatibility could not be determined due to insufficient information. */
  Unknown: "Unknown",
}

/** Category of a cluster readiness check. */
union ReadinessCategory {
  string,

  /** Node status check. */
  NodeStatus: "NodeStatus",

  /** API server health check. */
  APIServerHealth: "APIServerHealth",

  /** Pod disruption budget check. */
  PodDisruptionBudget: "PodDisruptionBudget",
}

// ─── UpgradeAssessment sub-models ─────────────────────────────────────────────

/** Compatibility status of a single cluster component with the target Kubernetes version. */
model ComponentCompatibility {
  /** Component name (e.g., 'containerd', 'calico'). */
  name: string;

  /** Installed component version. */
  version: string;

  /** Compatibility of the component with the target Kubernetes version. */
  compatibilityStatus: CompatibilityStatus;

  /** Severity associated with this compatibility result. */
  severity: Severity;

  /** Minimum component version known to be compatible with targetKubernetesVersion. */
  minCompatibleVersion?: string;

  /** Additional notes about compatibility. */
  notes?: string;
}

/** Observed call counts per HTTP verb for a deprecated Kubernetes API. */
model HttpVerbUsageMetrics {
  /** Number of GET requests observed. */
  get?: int64;

  /** Number of LIST requests observed. */
  list?: int64;

  /** Number of POST (create) requests observed. */
  post?: int64;

  /** Number of PUT (replace) requests observed. */
  put?: int64;

  /** Number of PATCH requests observed. */
  patch?: int64;

  /** Number of DELETE requests observed. */
  delete?: int64;

  /** Number of WATCH requests observed. */
  watch?: int64;
}

/** A deprecated Kubernetes API still in use in the cluster. */
model DeprecatedApiUsage {
  /** API group (e.g., 'flowcontrol.apiserver.k8s.io'). */
  group: string;

  /** API version (e.g., 'v1beta3'). */
  version: string;

  /** Resource plural name (e.g., 'flowschemas'). */
  resource: string;

  /** Kubernetes release in which this API is removed (e.g., '1.32'). */
  removedRelease?: string;

  /** HTTP verb call counts observed for this deprecated API. */
  usageMetrics?: HttpVerbUsageMetrics;

  /** UTC timestamp of the last observed usage. */
  lastUsageObservedAt?: utcDateTime;

  /** Severity of continued use of this deprecated API. */
  severity?: Severity;
}

/** A single cluster readiness check result. */
model ReadinessCheck {
  /** Category of the readiness check. */
  category: ReadinessCategory;

  /**
   * Subject of the check (node name, workload namespace/name, etc.).
   * Optional for cluster-wide checks.
   */
  name?: string;

  /** Severity of the check result. */
  severity?: Severity;

  /** Human-readable reason when severity is not 'None'. */
  details?: string;
}

// ─── ARM resource properties ──────────────────────────────────────────────────

/** Properties of a single UpgradeAssessment ARM resource. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "UpgradeAssessment is a read-only resource (GET/LIST only, no PUT) with no provisioning lifecycle, so provisioningState is intentionally omitted."
model UpgradeAssessmentProperties {
  /** Current Kubernetes version running on the cluster (e.g., '1.29'). */
  @visibility(Lifecycle.Read)
  currentKubernetesVersion?: string;

  /** Target Kubernetes version to evaluate for upgrade (e.g., '1.30'). */
  @visibility(Lifecycle.Read)
  targetKubernetesVersion?: string;

  /**
   * UTC timestamp when the in-cluster agent last computed this assessment.
   */
  @visibility(Lifecycle.Read)
  assessmentTime?: utcDateTime;

  /**
   * Rolled-up severity across all checks; highest severity wins.
   */
  @visibility(Lifecycle.Read)
  overallSeverity?: Severity;

  /**
   * Per-component compatibility results with the target Kubernetes version.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  componentCompatibility?: ComponentCompatibility[];

  /**
   * Deprecated Kubernetes APIs still in use in the cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  deprecatedApis?: DeprecatedApiUsage[];

  /**
   * Cluster readiness check results.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  readinessChecks?: ReadinessCheck[];
}
