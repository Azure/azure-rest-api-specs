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
 * The overall status of an upgrade insight readiness evaluation. This is a rollup of the
 * per-issue `severity` values in `detectedIssues`: any `Blocking` issue ⇒ `Failed`;
 * otherwise any `Warning` issue ⇒ `Warning`; otherwise (no issues) ⇒ `Passed`. The
 * scope-level vocabulary here (Passed/Warning/Failed) intentionally differs from the
 * issue-level `UpgradeIssueSeverity` (Blocking/Warning): a `Blocking` issue rolls up to
 * a `Failed` status, while `Warning` maps through unchanged.
 */
@added(Versions.v2026_08_02_preview)
union UpgradeInsightStatus {
  string,

  /** The evaluation completed and no upgrade issues were found for the target version; the scope appears ready to upgrade. */
  Passed: "Passed",

  /** The evaluation found one or more non-blocking warnings; the upgrade is expected to succeed but the warnings should be reviewed. */
  Warning: "Warning",

  /** The evaluation found one or more blocking issues that will prevent the upgrade from completing until they are resolved. This reflects the readiness result, not a failure of the compute operation itself (that is conveyed by provisioningState). */
  Failed: "Failed",
}

/** The type of a detected upgrade issue. */
@added(Versions.v2026_08_02_preview)
union UpgradeIssueType {
  string,

  /** A restrictive PodDisruptionBudget prevents node drain during upgrade. See https://aka.ms/aks/upgrade-insights/pdb-constraint for remediation guidance. */
  PDBConstraint: "PDBConstraint",

  /** The cluster subnet does not have sufficient available IP addresses for surge nodes during upgrade. See https://aka.ms/aks/upgrade-insights/subnet-ip-exhaustion for remediation guidance. */
  SubnetIPExhausted: "SubnetIPExhausted",

  /** Compute quota for the node pool VM SKU is insufficient to accommodate surge nodes during upgrade. See https://aka.ms/aks/upgrade-insights/quota-exceeded for remediation guidance. */
  QuotaExceeded: "QuotaExceeded",

  /** The cluster is using deprecated Kubernetes APIs that are removed in the target version. See https://aka.ms/aks/upgrade-insights/api-breaking-change for remediation guidance. */
  APIBreakingChange: "APIBreakingChange",

  /** An add-on or system component is not compatible with the target Kubernetes version. See https://aka.ms/aks/upgrade-insights/component-version-mismatch for remediation guidance. */
  ComponentVersionMismatch: "ComponentVersionMismatch",

  /** The cluster is running a Kubernetes version that is no longer supported. See https://aka.ms/aks/upgrade-insights/unsupported-kubernetes-version for remediation guidance. */
  UnsupportedKubernetesVersion: "UnsupportedKubernetesVersion",

  /** The cluster node image has not been upgraded within the required compliance interval. See https://aka.ms/aks/upgrade-insights/node-image-out-of-sla for remediation guidance. */
  NodeImageOutOfSLA: "NodeImageOutOfSLA",
}

/** The severity of a detected upgrade issue. */
@added(Versions.v2026_08_02_preview)
union UpgradeIssueSeverity {
  string,

  /** The issue will block the upgrade from completing successfully. */
  Blocking: "Blocking",

  /** The issue may cause problems with client applications or services on the cluster but will not necessarily prevent the upgrade from completing. */
  Warning: "Warning",
}

/**
 * The support status of the Kubernetes version the cluster is currently running. This is
 * intentionally binary — there is no discrete `ApproachingEOL` value. Proximity to end of
 * support is derived by clients from `kubernetesVersionEndOfSupportDate` (comparing it
 * against the current time), so no server-computed "approaching EOS" flag or message is
 * returned that could go stale in a cached record.
 */
@added(Versions.v2026_08_02_preview)
union KubernetesVersionSupportStatus {
  string,

  /** The scope is running a Kubernetes version that is still within its support window. */
  InSupport: "InSupport",

  /** The scope is running a Kubernetes version that is past its end of support. */
  OutOfSupport: "OutOfSupport",
}

/** The strategy currently used to perform an upgrade (manual or automatic). */
@added(Versions.v2026_08_02_preview)
union UpgradeInsightStrategy {
  string,

  /** Upgrades are initiated manually by the customer. */
  Manual: "Manual",

  /** Upgrades are performed automatically by AKS auto-upgrade. */
  Auto: "Auto",
}

/**
 * The type of upgrade an upgrade insight evaluates. Each upgrade insight resource
 * represents exactly one of these scopes; the scope is encoded in the resource name.
 */
@added(Versions.v2026_08_02_preview)
union UpgradeType {
  string,

  /** The control plane (managed cluster) Kubernetes version upgrade. */
  ControlPlane: "ControlPlane",

  /** An agent pool (node pool) Kubernetes version upgrade. */
  AgentPool: "AgentPool",

  /** An agent pool node OS image upgrade. NodeImage upgrade insights are evaluated per agent pool, mirroring the per-pool node-image upgrade API (.../agentPools/{name}), and cover the node OS image only; agent-pool Kubernetes version readiness is evaluated separately via the AgentPool or ControlPlaneAndAgentPools scopes. */
  NodeImage: "NodeImage",

  /** A combined evaluation of the control plane plus every agent pool for a single target Kubernetes version. This scope covers Kubernetes version upgrades only; node OS image upgrades are not included and must be evaluated separately using the NodeImage scope. */
  ControlPlaneAndAgentPools: "ControlPlaneAndAgentPools",
}

/** The auto-upgrade schedule that a maintenance window is derived from. */
@added(Versions.v2026_08_02_preview)
union MaintenanceWindowSource {
  string,

  /** The window is derived from the cluster auto-upgrade schedule (aksManagedAutoUpgradeSchedule), which governs Kubernetes version upgrades. */
  ClusterAutoUpgradeSchedule: "ClusterAutoUpgradeSchedule",

  /** The window is derived from the node OS auto-upgrade schedule (aksManagedNodeOSUpgradeSchedule), which governs node OS image upgrades. */
  NodeOSUpgradeSchedule: "NodeOSUpgradeSchedule",
}

/** The category of a resource impacted by a detected upgrade issue. */
@added(Versions.v2026_08_02_preview)
union ImpactedResourceKind {
  string,

  /** An Azure Resource Manager (ARM) resource. */
  Arm: "Arm",

  /** A Kubernetes resource. */
  Kubernetes: "Kubernetes",
}

// =============================================================================
// UpgradeInsight models
// =============================================================================

/** A recommended action to resolve a detected upgrade issue. */
@added(Versions.v2026_08_02_preview)
model UpgradeInsightRecommendedAction {
  /** A short title describing the recommended action. */
  @visibility(Lifecycle.Read)
  title?: string;

  /** A detailed description of the recommended action and how to perform it. */
  @visibility(Lifecycle.Read)
  details?: string;

  /** A link to customer-facing documentation describing the available options for remediating the issue. */
  @visibility(Lifecycle.Read)
  documentationLink?: url;
}

/**
 * A resource impacted by a detected upgrade issue. The concrete shape is determined
 * by `kind`: an ARM resource is identified by its ARM resource ID, while a Kubernetes
 * resource is identified by its namespace and name.
 */
@added(Versions.v2026_08_02_preview)
@discriminator("kind")
model UpgradeInsightImpactedResource {
  /** The category of the impacted resource. */
  @visibility(Lifecycle.Read)
  kind: ImpactedResourceKind;

  /** The type of the impacted resource (for example, Microsoft.Network/virtualNetworks/subnets or PodDisruptionBudget). */
  @visibility(Lifecycle.Read)
  resourceType?: string;
}

/** An Azure Resource Manager (ARM) resource impacted by a detected upgrade issue, identified by its ARM resource ID. */
@added(Versions.v2026_08_02_preview)
model ArmImpactedResource extends UpgradeInsightImpactedResource {
  /** The category of the impacted resource. */
  @visibility(Lifecycle.Read)
  kind: "Arm";

  /** The ARM resource ID of the impacted resource. */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;
}

/** A Kubernetes resource impacted by a detected upgrade issue, identified by its namespace and name. */
@added(Versions.v2026_08_02_preview)
model KubernetesImpactedResource extends UpgradeInsightImpactedResource {
  /** The category of the impacted resource. */
  @visibility(Lifecycle.Read)
  kind: "Kubernetes";

  /** The Kubernetes namespace of the impacted resource, if applicable. */
  @visibility(Lifecycle.Read)
  `namespace`?: string;

  /** The name of the impacted Kubernetes resource. */
  @visibility(Lifecycle.Read)
  name?: string;
}

/** A detected upgrade issue for a managed cluster. */
@added(Versions.v2026_08_02_preview)
model DetectedUpgradeIssue {
  /** The type of the detected upgrade issue. */
  @visibility(Lifecycle.Read)
  issueType?: UpgradeIssueType;

  /** The severity of the detected issue. */
  @visibility(Lifecycle.Read)
  severity?: UpgradeIssueSeverity;

  /** A human-readable description of the issue and why it may block or risk the upgrade. */
  @visibility(Lifecycle.Read)
  message?: string;

  /** The Azure or Kubernetes resources impacted by this issue. A single issue can affect multiple resources (for example, one removed Kubernetes API version affecting several objects). */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  impactedResources?: UpgradeInsightImpactedResource[];

  /**
   * The recommended actions to resolve this issue. Today this always contains a
   * single action whose documentation link covers all of the options the user could
   * take to remediate the issue; it is modeled as an array so that additional distinct
   * actions can be returned in the future without a breaking change.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendedActions?: UpgradeInsightRecommendedAction[];
}

/**
 * The evaluation payload shared by all upgrade insight results, containing the
 * overall status, evaluation time, and any detected issues. Whenever this object is
 * present the evaluation has run, so `status` and `evaluatedAt` are always populated;
 * the "not yet evaluated" state is signaled by the absence of this `evaluation` object
 * (and by `provisioningState`), never by a present evaluation with an absent status.
 */
@added(Versions.v2026_08_02_preview)
model UpgradeInsightEvaluation {
  /** The overall upgrade insight status indicating whether issues were detected. Always present when the evaluation has run; absence of the enclosing `evaluation` object—not an absent status—represents "not yet evaluated". */
  @visibility(Lifecycle.Read)
  status: UpgradeInsightStatus;

  /** The UTC time at which the upgrade insight evaluation was performed. */
  @visibility(Lifecycle.Read)
  evaluatedAt: utcDateTime;

  /** The list of detected upgrade issues, if any. Empty or absent for a `Passed` status. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  detectedIssues?: DetectedUpgradeIssue[];
}

/**
 * A scheduled maintenance window during which an automatic upgrade of this type is
 * expected to run. The window is derived from the maintenance configuration that
 * governs this upgrade type — the cluster auto-upgrade schedule for Kubernetes
 * version upgrades or the node OS upgrade schedule for node image upgrades — so the
 * same model describes both without duplicating types.
 */
@added(Versions.v2026_08_02_preview)
model UpgradeInsightMaintenanceWindow {
  /** The name of the maintenance configuration that governs this window (for example, aksManagedAutoUpgradeSchedule or aksManagedNodeOSUpgradeSchedule). */
  @visibility(Lifecycle.Read)
  maintenanceConfigurationName?: string;

  /** The auto-upgrade schedule that this window is derived from. */
  @visibility(Lifecycle.Read)
  source?: MaintenanceWindowSource;

  /** The UTC start time of the next scheduled maintenance window. */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** The UTC end time of the next scheduled maintenance window. */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;
}

/**
 * Contextual information for a specific upgrade type (Kubernetes version or node OS
 * image). Because the Kubernetes version and node OS image can be managed
 * independently — for example, auto-upgrade for the node image but manual for the
 * Kubernetes version — this context is reported per upgrade type rather than once
 * for the whole cluster.
 */
@added(Versions.v2026_08_02_preview)
model UpgradeContext {
  /** The strategy currently used to perform this type of upgrade (manual or auto-upgrade). */
  @visibility(Lifecycle.Read)
  currentUpgradeStrategy?: UpgradeInsightStrategy;

  /** The next scheduled automatic upgrade maintenance window for this upgrade type, if auto-upgrade is configured. */
  @visibility(Lifecycle.Read)
  nextMaintenanceWindow?: UpgradeInsightMaintenanceWindow;

  /**
   * The UTC time of the last successful upgrade of this type for this scope.
   * Clients can compute "days since last successful upgrade" from this value and the
   * current time; the server intentionally does not return a precomputed value so that
   * cached results do not go stale.
   */
  @visibility(Lifecycle.Read)
  lastSuccessfulUpgradeTime?: utcDateTime;
}

/**
 * The upgrade context and evaluation result shared by every upgrade insight scope,
 * regardless of upgrade type. Kept as a standalone model so that Kubernetes version and
 * node OS image insights reuse the exact same shape and cannot drift. All fields are
 * server-computed and read-only.
 */
@added(Versions.v2026_08_02_preview)
model EvaluationResultBase {
  /** Contextual information about how this upgrade is managed, such as the upgrade strategy, next maintenance window, and last successful upgrade time. */
  @visibility(Lifecycle.Read)
  context?: UpgradeContext;

  /** The evaluation result, including overall status, evaluation time, and any detected issues. */
  @visibility(Lifecycle.Read)
  evaluation?: UpgradeInsightEvaluation;
}

/**
 * The readiness evaluation details shared by a single scope: the support status of the
 * version the scope is currently running, the upgrade context, and the evaluation
 * result. All fields are server-computed and read-only.
 */
@added(Versions.v2026_08_02_preview)
model ScopeEvaluationResult {
  /** The Kubernetes version the scope was evaluated from (the upgrade source version the scope is currently running). Lets consumers read the result as "from X to targetKubernetesVersion" and detect a stale cached record by comparing against the live cluster version. Populated for Kubernetes version upgrades. */
  @visibility(Lifecycle.Read)
  currentKubernetesVersion?: string;

  /** The support status of the Kubernetes version the scope is currently running (not the target version). Populated for Kubernetes version upgrades. */
  @visibility(Lifecycle.Read)
  kubernetesVersionSupportStatus?: KubernetesVersionSupportStatus;

  /**
   * The date on which support ends for the Kubernetes version the scope is currently
   * running (its end-of-support date). Returned as an absolute date so clients can apply
   * their own "approaching end of support" threshold and compute the remaining days against
   * the current time; a precomputed remaining-days value is intentionally not returned so
   * that cached results do not go stale. Populated for Kubernetes version upgrades.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersionEndOfSupportDate?: plainDate;

  ...EvaluationResultBase;
}

/** The readiness evaluation for a single agent pool within a combined evaluation. */
@added(Versions.v2026_08_02_preview)
model AgentPoolScopeEvaluation {
  /** The name of the agent pool this evaluation applies to. */
  @visibility(Lifecycle.Read)
  agentPoolName?: string;

  ...ScopeEvaluationResult;
}

/**
 * The base properties of an upgrade insight. The concrete shape is determined by
 * `upgradeType`, which is encoded in the resource name: single-scope evaluations
 * (`ControlPlane`, `AgentPool`, `NodeImage`) carry a flat per-scope result, while a
 * combined evaluation (`ControlPlaneAndAgentPools`) carries a nested control plane
 * result plus a per-agent-pool array.
 */
@added(Versions.v2026_08_02_preview)
@discriminator("upgradeType")
model UpgradeInsightProperties {
  /** The provisioning state of the upgrade insight evaluation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /** The type of upgrade this insight evaluates. Derived from the resource name. */
  @visibility(Lifecycle.Read)
  upgradeType: UpgradeType;

  /**
   * The UTC time at which this upgrade insight was last computed (the last time the
   * compute operation ran for this resource). This is the resource-level "last run"
   * marker and, for a cached record, indicates how stale the stored evaluation is. For
   * a combined evaluation it is the umbrella run time across all scopes, whereas each
   * scope's `evaluation.evaluatedAt` records when that specific snapshot was produced.
   */
  @visibility(Lifecycle.Read)
  lastEvaluatedAt?: utcDateTime;

  /**
   * The UTC time at which this stored upgrade insight expires and is removed from the
   * data store (currently `lastEvaluatedAt` plus a 14-day retention window). After this
   * time a GET for the resource returns 404 Not Found and it no longer appears in the
   * list, indicating the caller should call the compute operation to produce a fresh
   * evaluation. Exposing the expiry lets clients decide when to recompute without
   * hardcoding the retention period.
   */
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;
}

/** Properties for a control plane (managed cluster) Kubernetes version upgrade insight. */
@added(Versions.v2026_08_02_preview)
model ControlPlaneUpgradeInsightProperties extends UpgradeInsightProperties {
  /** The type of upgrade this insight evaluates. */
  upgradeType: "ControlPlane";

  /** The target Kubernetes version that was evaluated. */
  @visibility(Lifecycle.Read)
  targetKubernetesVersion?: string;

  ...ScopeEvaluationResult;
}

/** Properties for a single agent pool Kubernetes version upgrade insight. */
@added(Versions.v2026_08_02_preview)
model AgentPoolUpgradeInsightProperties extends UpgradeInsightProperties {
  /** The type of upgrade this insight evaluates. */
  upgradeType: "AgentPool";

  /** The name of the agent pool this insight applies to. */
  @visibility(Lifecycle.Read)
  agentPoolName?: string;

  /** The target Kubernetes version that was evaluated. */
  @visibility(Lifecycle.Read)
  targetKubernetesVersion?: string;

  ...ScopeEvaluationResult;
}

/** Properties for a single agent pool node OS image upgrade insight. */
@added(Versions.v2026_08_02_preview)
model NodeImageUpgradeInsightProperties extends UpgradeInsightProperties {
  /** The type of upgrade this insight evaluates. */
  upgradeType: "NodeImage";

  /** The name of the agent pool this insight applies to. */
  @visibility(Lifecycle.Read)
  agentPoolName?: string;

  /** The node OS image version the agent pool was evaluated from (the upgrade source version it is currently running). Lets consumers read the result as "from X to targetNodeImageVersion" and detect a stale cached record by comparing against the live node image version. */
  @visibility(Lifecycle.Read)
  currentNodeImageVersion?: string;

  /** The target node OS image version that was evaluated. */
  @visibility(Lifecycle.Read)
  targetNodeImageVersion?: string;

  ...EvaluationResultBase;
}

/**
 * Properties for a combined control plane and agent pools Kubernetes version upgrade
 * insight: a single evaluation of the control plane plus every agent pool for one
 * target Kubernetes version. This scope is Kubernetes-version-only — node OS image
 * upgrades are never part of a combined evaluation and must be requested separately
 * with a `nodeImage-<agentPoolName>-<nodeImageVersion>` insight.
 */
@added(Versions.v2026_08_02_preview)
model ControlPlaneAndAgentPoolsUpgradeInsightProperties
  extends UpgradeInsightProperties {
  /** The type of upgrade this insight evaluates. */
  upgradeType: "ControlPlaneAndAgentPools";

  /** The target Kubernetes version that was evaluated for all scopes. */
  @visibility(Lifecycle.Read)
  targetKubernetesVersion?: string;

  /** The readiness evaluation for the control plane Kubernetes version upgrade. */
  @visibility(Lifecycle.Read)
  controlPlane?: ScopeEvaluationResult;

  /** The readiness evaluation for each agent pool Kubernetes version upgrade, one entry per agent pool. */
  @visibility(Lifecycle.Read)
  @identifiers(#["agentPoolName"])
  agentPools?: AgentPoolScopeEvaluation[];
}

/**
 * An upgrade insight for a managed cluster: an on-demand readiness evaluation for an
 * upgrade scope, produced by the generateUpgradeInsights action on the managed cluster
 * and addressable by a server-generated name. The name identifies
 * the scope and evaluated target —
 * `controlPlane-<targetKubernetesVersion>` (for example `controlPlane-1.33.5`),
 * `controlPlaneAndAgentPools-<targetKubernetesVersion>`,
 * `agentPool-<agentPoolName>-<targetKubernetesVersion>` (for example
 * `agentPool-nodepool1-1.33.5`), or
 * `nodeImage-<agentPoolName>-<nodeImageVersion>` (for example
 * `nodeImage-nodepool1-202607.01.0`). The node image segment contains only the numeric
 * image version, while `properties.targetNodeImageVersion` returns the full image name.
 * The resource itself
 * is read-only: GET returns the stored evaluation and LIST returns the stored
 * evaluations for the cluster. Evaluations are (re)generated via the managed cluster's
 * generateUpgradeInsights action, whose response body is the same UpgradeInsight
 * representation returned by GET.
 */
@added(Versions.v2026_08_02_preview)
@parentResource(ManagedCluster)
model UpgradeInsight is ProxyResource<UpgradeInsightProperties> {
  ...ResourceNameParameter<
    Resource = UpgradeInsight,
    KeyName = "upgradeInsightName",
    SegmentName = "upgradeInsights",
    NamePattern = "^[A-Za-z0-9]$|^[A-Za-z0-9][A-Za-z0-9._-]{0,126}[A-Za-z0-9]$"
  >;
}

// =============================================================================
// UpgradeInsight operations
// =============================================================================

/**
 * The base request body for the generateUpgradeInsights action. The concrete shape is
 * determined by `upgradeType`, so that each scope declares exactly the inputs it needs:
 * the schema itself enforces which of `targetKubernetesVersion`,
 * `targetNodeImageVersion`, and `agentPoolName` are required or optional, rather than
 * relying on documented conventions plus server-side validation. The server generates
 * (or refreshes) the corresponding UpgradeInsight and returns it.
 */
@added(Versions.v2026_08_02_preview)
@discriminator("upgradeType")
model GenerateUpgradeInsightsContent {
  /** The type of upgrade to evaluate. */
  upgradeType: UpgradeType;
}

/** Request body to evaluate a control plane (managed cluster) Kubernetes version upgrade. */
@added(Versions.v2026_08_02_preview)
model ControlPlaneGenerateUpgradeInsightsContent
  extends GenerateUpgradeInsightsContent {
  upgradeType: "ControlPlane";

  /** The target Kubernetes version to evaluate. */
  targetKubernetesVersion: string;
}

/** Request body to evaluate a single agent pool Kubernetes version upgrade. */
@added(Versions.v2026_08_02_preview)
model AgentPoolGenerateUpgradeInsightsContent
  extends GenerateUpgradeInsightsContent {
  upgradeType: "AgentPool";

  /** The name of the agent pool to evaluate. */
  agentPoolName: string;

  /** The target Kubernetes version to evaluate. */
  targetKubernetesVersion: string;
}

/** Request body to evaluate a single agent pool node OS image upgrade. */
@added(Versions.v2026_08_02_preview)
model NodeImageGenerateUpgradeInsightsContent
  extends GenerateUpgradeInsightsContent {
  upgradeType: "NodeImage";

  /** The name of the agent pool to evaluate. */
  agentPoolName: string;

  /** The target node OS image version to evaluate. If omitted, the server resolves and evaluates the latest available node image. The resolved full version is always returned in the generated insight's read-only `targetNodeImageVersion` property. */
  targetNodeImageVersion?: string;
}

/** Request body to evaluate the combined control plane and agent pools Kubernetes version upgrade. */
@added(Versions.v2026_08_02_preview)
model ControlPlaneAndAgentPoolsGenerateUpgradeInsightsContent
  extends GenerateUpgradeInsightsContent {
  upgradeType: "ControlPlaneAndAgentPools";

  /** The target Kubernetes version to evaluate for all scopes. */
  targetKubernetesVersion: string;
}

/** Operations for the stored upgrade insights of a managed cluster. */
@armResourceOperations
@added(Versions.v2026_08_02_preview)
interface UpgradeInsights {
  /**
   * Gets a stored upgrade insight for the managed cluster by its server-generated name.
   * This is a read-only operation: it returns the most recently generated readiness
   * evaluation for that scope from the data store, including the detected
   * upgrade-blocking issues and contextual upgrade information. It does not regenerate
   * the evaluation. If no non-expired evaluation exists for the name, it returns 404.
   */
  get is ArmResourceRead<UpgradeInsight>;

  /**
   * Lists the stored upgrade insights for the specified managed cluster, one entry per
   * scope that has been generated and not yet expired. This is a read-only operation and
   * does not regenerate any evaluation.
   */
  list is ArmResourceListByParent<UpgradeInsight>;

  /**
   * Generates (or refreshes) an upgrade readiness evaluation for the managed cluster.
   * The requested scope and target version(s) are supplied in the request body; the
   * server runs the readiness checks — the control plane Kubernetes version upgrade, a
   * single agent pool Kubernetes version upgrade, a single agent pool node OS image
   * upgrade, or the combined control plane and agent pools upgrade — persists the result
   * as an UpgradeInsight resource with a server-generated name, and returns that
   * resource. The response body is identical to a subsequent GET of the resource.
   */
  @action("generateUpgradeInsights")
  generate is ArmResourceActionSync<
    ManagedCluster,
    GenerateUpgradeInsightsContent,
    UpgradeInsight
  >;
}
