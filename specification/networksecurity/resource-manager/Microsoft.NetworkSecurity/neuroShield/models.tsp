import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace NeuroShield.Management;

/**
 * Provisioning states shared by NeuroShield resources. The non-terminal states are used by
 * asynchronous protected-resource operations; synchronous NeuroShield operations return only
 * terminal states.
 */
@added(Versions.v2026_06_01_preview)
union ProvisioningStateNeuroShield {
  Azure.ResourceManager.ResourceProvisioningState,

  /**
   * Resource is being created.
   */
  Creating: "Creating",

  /**
   * Resource is being updated.
   */
  Updating: "Updating",

  /**
   * Resource is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * Properties of the NeuroShield resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldProperties {
  /**
   * Provisioning state of the NeuroShield resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateNeuroShield;

  /**
   * System-generated globally unique identifier (GUID) for the NeuroShield resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * Response mode that controls mitigation serving behavior.
   */
  responseMode?: NeuroShieldResponseMode;

  /**
   * Minimum severity level for mitigation generation.
   */
  severityThreshold?: NeuroShieldSeverityThreshold;

  /**
   * Human-readable description of the NeuroShield resource.
   */
  description?: string;
}

/**
 * Response modes for mitigation serving behavior.
 */
@added(Versions.v2026_06_01_preview)
union NeuroShieldResponseMode {
  string,

  /**
   * Automatically queues and serves mitigations.
   */
  Auto: "Auto",

  /**
   * Requires explicit customer approval before serving mitigations.
   */
  Manual: "Manual",

  /**
   * Detection only mode with no mitigation generation.
   */
  AlertOnly: "AlertOnly",
}

/**
 * Severity threshold used for finding and mitigation generation.
 */
@added(Versions.v2026_06_01_preview)
union NeuroShieldSeverityThreshold {
  string,

  /**
   * Critical severity threshold.
   */
  Critical: "Critical",

  /**
   * High severity threshold.
   */
  High: "High",

  /**
   * Medium severity threshold.
   */
  Medium: "Medium",

  /**
   * Low severity threshold.
   */
  Low: "Low",
}

/**
 * Properties to patch on a NeuroShield resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldPatchProperties {
  /**
   * Response mode that controls mitigation serving behavior.
   */
  responseMode?: NeuroShieldResponseMode;

  /**
   * Minimum severity level for mitigation generation.
   */
  severityThreshold?: NeuroShieldSeverityThreshold;

  /**
   * Human-readable description of the NeuroShield resource.
   */
  description?: string;
}

/**
 * Patch request body for updating a NeuroShield resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldPatch {
  ...ArmTagsProperty;

  /**
   * Patch properties for the NeuroShield resource.
   */
  properties?: NeuroShieldPatchProperties;
}

/**
 * Azure Resource Manager tracked resource representing a NeuroShield instance.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldResource is Azure.ResourceManager.TrackedResource<
  NeuroShieldProperties,
  false
> {
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("neuroShieldName")
  @segment("neuroShields")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;
}

@@encodedName(NeuroShieldResource.eTag, "application/json", "etag");

/**
 * Approximate Neuron agent liveness projected onto a protected resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldAgentHealth {
  /**
   * The most recent time a liveness signal was observed. The value is absent until the first signal is received.
   */
  @visibility(Lifecycle.Read)
  lastSeenTime?: utcDateTime;
}

/**
 * A server-owned request for the Neuron agents associated with a protected resource to upload fresh inventory.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldInventoryUploadRequestMetadata {
  /**
   * The stable identifier for the request.
   */
  @visibility(Lifecycle.Read)
  requestId: string;

  /**
   * The time when the resource provider accepted the request.
   */
  @visibility(Lifecycle.Read)
  requestedAt: utcDateTime;

  /**
   * The time after which Neuron agents must stop observing the request.
   */
  @visibility(Lifecycle.Read)
  expiresAt: utcDateTime;
}

/**
 * The result of requesting a fresh inventory upload.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldInventoryUploadRequestResult {
  /**
   * The stable identifier for the accepted request.
   */
  requestId: string;

  /**
   * The time when the resource provider accepted the request.
   */
  requestedAt: utcDateTime;

  /**
   * The time when the request expires.
   */
  expiresAt: utcDateTime;

  /**
   * Indicates whether an existing unexpired request was reused.
   */
  deduplicated: boolean;
}

/**
 * Properties of a protected resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldProtectedResourceProperties {
  /**
   * Provisioning state of the protected resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateNeuroShield;

  /**
   * Azure Resource Manager resource ID of the target virtual machine or virtual machine scale set.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  targetResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets";
    }
  ]>;

  /**
   * Approximate health of the Neuron agent, derived from its most recent authenticated data-plane signal.
   */
  @visibility(Lifecycle.Read)
  agentHealth?: NeuroShieldAgentHealth;

  /**
   * The current on-demand inventory upload request, when one is active.
   */
  @visibility(Lifecycle.Read)
  inventoryUploadRequest?: NeuroShieldInventoryUploadRequestMetadata;
}

/**
 * Azure Resource Manager proxy child resource representing a protected resource.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(NeuroShieldResource)
model NeuroShieldProtectedResource is Azure.ResourceManager.ProxyResource<
  NeuroShieldProtectedResourceProperties,
  false
> {
  /**
   * The customer VM or VMSS identity used by the Neuron agent. Specify SystemAssigned
   * to use the target resource's system-assigned identity, or UserAssigned with exactly
   * one user-assigned identity ARM resource ID mapped to an empty object. Principal,
   * client, and tenant IDs are resolved by the service and returned as read-only values.
   * None, combined system/user-assigned identity, and multiple user-assigned identities
   * are not supported. Changing the identity requires deleting and recreating the
   * protected resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This is the required form of the standard ManagedServiceIdentityProperty envelope. The explicit declaration changes only requiredness while retaining the standard ARM managed-identity type."
  @visibility(Lifecycle.Create, Lifecycle.Read)
  identity: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  /**
   * The name of the protected resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("protectedResourceName")
  @segment("protectedResources")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;
}

/**
 * Runtime operational status for findings.
 */
@added(Versions.v2026_06_01_preview)
union NeuroShieldFindingStatus {
  string,

  /**
   * Candidate mitigations were generated and are waiting for explicit approval.
   */
  AwaitingApproval: "AwaitingApproval",

  /**
   * No mitigation has resolved the finding yet.
   */
  Active: "Active",

  /**
   * One or more mitigation actions are currently running.
   */
  MitigationInProgress: "MitigationInProgress",

  /**
   * The finding has at least one successful mitigation.
   */
  Mitigated: "Mitigated",

  /**
   * Pre-execution validation determined that the vulnerability is no longer present.
   */
  Skipped: "Skipped",

  /**
   * All mitigations were attempted without successful resolution.
   */
  MitigationsExhausted: "MitigationsExhausted",

  /**
   * Mitigation execution is blocked by communication failure.
   */
  Unreachable: "Unreachable",
}

/**
 * Properties of a finding resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Findings are immutable service-generated observations. Their operational lifecycle is represented by status and they do not have a separate ARM provisioning lifecycle."
@added(Versions.v2026_06_01_preview)
model NeuroShieldFindingProperties {
  /**
   * Common Vulnerabilities and Exposures (CVE) identifier associated with this finding.
   */
  @visibility(Lifecycle.Read)
  cveId: string;

  /**
   * Fully qualified Azure Resource Manager resource ID of the affected virtual machine or virtual machine scale set instance.
   */
  @visibility(Lifecycle.Read)
  virtualMachineArmId: Azure.Core.armResourceIdentifier;

  /**
   * Severity of the finding.
   */
  @visibility(Lifecycle.Read)
  severity: NeuroShieldSeverityThreshold;

  /**
   * Description of the finding.
   */
  @visibility(Lifecycle.Read)
  description: string;

  /**
   * Explanation of why the virtual machine is affected, including the matching evidence.
   */
  @visibility(Lifecycle.Read)
  reason: string;

  /**
   * Detection timestamp for the finding.
   */
  @visibility(Lifecycle.Read)
  detectedTime?: utcDateTime;

  /**
   * Runtime operational status of the finding.
   */
  @visibility(Lifecycle.Read)
  status: NeuroShieldFindingStatus;
}

/**
 * Azure Resource Manager proxy child resource representing a finding.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(NeuroShieldProtectedResource)
model NeuroShieldFinding
  is Azure.ResourceManager.ProxyResource<NeuroShieldFindingProperties> {
  /**
   * The system-generated identifier of the finding.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("findingId")
  @segment("findings")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,126}[0-9a-zA-Z_])?$")
  name: string;
}

/**
 * Runtime operational status for mitigations.
 */
@added(Versions.v2026_06_01_preview)
union NeuroShieldMitigationStatus {
  string,

  /**
   * Mitigation is queued for execution.
   */
  Queued: "Queued",

  /**
   * Mitigation is waiting for explicit approval.
   */
  AwaitingApproval: "AwaitingApproval",

  /**
   * Mitigation execution is in progress.
   */
  InProgress: "InProgress",

  /**
   * Mitigation completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Mitigation was not applied because validation determined it was unnecessary.
   */
  Skipped: "Skipped",

  /**
   * Mitigation execution failed.
   */
  Failed: "Failed",

  /**
   * Rollback execution is in progress.
   */
  RollbackInProgress: "RollbackInProgress",

  /**
   * Mitigation rollback completed successfully.
   */
  RolledBack: "RolledBack",

  /**
   * Mitigation rollback failed.
   */
  RollbackFailed: "RollbackFailed",
}

/**
 * Properties of a mitigation resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Mitigations are immutable service-generated recommendations. Their execution lifecycle is represented by status and they do not have a separate ARM provisioning lifecycle."
@added(Versions.v2026_06_01_preview)
model NeuroShieldMitigationProperties {
  /**
   * Resource identifier of the associated finding.
   */
  @visibility(Lifecycle.Read)
  findingId: Azure.Core.armResourceIdentifier;

  /**
   * Common Vulnerabilities and Exposures (CVE) identifier addressed by this mitigation.
   */
  @visibility(Lifecycle.Read)
  cveId: string;

  /**
   * Fully qualified Azure Resource Manager resource ID of the virtual machine targeted by this mitigation.
   */
  @visibility(Lifecycle.Read)
  virtualMachineArmId: Azure.Core.armResourceIdentifier;

  /**
   * Execution score from 0 through 100, where a higher value indicates a safer and more complete mitigation.
   */
  @minValue(0)
  @maxValue(100)
  @visibility(Lifecycle.Read)
  score: int32;

  /**
   * User-friendly description of the commands executed by this mitigation.
   */
  @visibility(Lifecycle.Read)
  commandsSummary: string;

  /**
   * Indicates whether rollback is available for this mitigation.
   */
  @visibility(Lifecycle.Read)
  isRollbackable: boolean;

  /**
   * Runtime operational status of the mitigation.
   */
  @visibility(Lifecycle.Read)
  status: NeuroShieldMitigationStatus;

  /**
   * Human-readable details for the current mitigation status.
   */
  @visibility(Lifecycle.Read)
  statusDetails?: string;

  /**
   * Timestamp when the mitigation was applied.
   */
  @visibility(Lifecycle.Read)
  appliedTime?: utcDateTime;
}

/**
 * Azure Resource Manager proxy child resource representing a mitigation.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(NeuroShieldProtectedResource)
model NeuroShieldMitigation
  is Azure.ResourceManager.ProxyResource<NeuroShieldMitigationProperties> {
  /**
   * The system-generated identifier of the mitigation.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("mitigationId")
  @segment("mitigations")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,126}[0-9a-zA-Z_])?$")
  name: string;
}

/**
 * Mitigations updated by a Finding action.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldMitigationActionResult {
  /**
   * The complete set of mitigations updated by the action.
   */
  value: NeuroShieldMitigation[];
}

/**
 * Query parameters for paginated NeuroShield collections.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldPaginationParameters {
  /**
   * The maximum number of items to return.
   */
  @query("top")
  @minValue(1)
  top?: int32;

  /**
   * The continuation token used to retrieve the next page.
   */
  @query("skipToken")
  skipToken?: string;
}

/**
 * Aggregate fleet overview for a NeuroShield resource.
 */
@added(Versions.v2026_06_01_preview)
model NeuroShieldFleetSummary {
  /**
   * Azure Resource Manager resource ID of the NeuroShield resource.
   */
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * Number of protected resources.
   */
  @minValue(0)
  protectedCount: int32;

  /**
   * Number of protected resources with a current agent assessment.
   */
  @minValue(0)
  scannedProtectedCount: int32;

  /**
   * Number of active findings.
   */
  @minValue(0)
  activeFindings: int32;

  /**
   * Number of active critical-severity findings.
   */
  @minValue(0)
  criticalFindings: int32;

  /**
   * Number of active high-severity findings.
   */
  @minValue(0)
  highFindings: int32;

  /**
   * Number of active medium-severity findings.
   */
  @minValue(0)
  mediumFindings: int32;

  /**
   * Number of active low-severity findings.
   */
  @minValue(0)
  lowFindings: int32;

  /**
   * Number of findings blocked by agent communication failures.
   */
  @minValue(0)
  unreachableFindings: int32;

  /**
   * Number of mitigations awaiting customer approval.
   */
  @minValue(0)
  awaitingApprovalMitigations: int32;

  /**
   * Number of mitigations queued for execution.
   */
  @minValue(0)
  queuedMitigations: int32;

  /**
   * Number of mitigations whose execution is in progress.
   */
  @minValue(0)
  inProgressMitigations: int32;

  /**
   * Number of mitigations that completed successfully.
   */
  @minValue(0)
  succeededMitigations: int32;

  /**
   * Number of mitigations whose execution or rollback failed.
   */
  @minValue(0)
  failedMitigations: int32;

  /**
   * Number of mitigations whose rollback is in progress.
   */
  @minValue(0)
  rollbackInProgressMitigations: int32;
}
