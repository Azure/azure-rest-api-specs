import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents the latest workspace discovery result.
 */
@parentResource(Workspace)
@singleton("latest")
model WorkspaceDiscovery is ProxyResource<WorkspaceDiscoveryProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceDiscovery,
    KeyName = "discoveryName",
    SegmentName = "discoveries",
    NamePattern = ""
  >;
}

/**
 * Model that represents the properties of the workspace discovery.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only singleton resource representing latest discovery status"
model WorkspaceDiscoveryProperties {
  /**
   * The discovery status.
   */
  @visibility(Lifecycle.Read)
  status: WorkspaceDiscoveryStatus;

  /**
   * The discovery UTC start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The discovery UTC end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * System or infrastructure errors encountered during discovery.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * The workspace ID this discovery belongs to.
   */
  @visibility(Lifecycle.Read)
  workspaceId: Azure.Core.armResourceIdentifier;

  /**
   * The resource snapshot ID produced by this discovery.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  resourceSnapshotId?: string;

  /**
   * The coverage established by the accepted discovery result for Azure Resource Manager scopes. Present with coverageSummary on newly produced snapshot results; absence is not Established or a known zero.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  completeness?: WorkspaceDiscoveryCompleteness;

  /**
   * Coverage facts for the accepted result. Scope counts, resource-occurrence counts, warning counts, and returned inventory-row counts are different units and must not be combined.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  coverageSummary?: WorkspaceDiscoveryCoverageSummary;

  /**
   * Confirmed access, missing-resource, or access-indeterminate guidance. System verification failures are reported in errors, not as permission warnings. The returned array may be a subset; use warningsTotalCount and warningsTruncated.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  warnings?: WorkspaceDiscoveryWarning[];

  /**
   * The deduplicated number of warning identities before sampling. Identity consists of the expanded scope, affected resource, and reason. Absent means no accepted warning population was recorded, not zero warnings.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  warningsTotalCount?: WorkspaceDiscoveryCount;

  /**
   * Whether warnings contains fewer entries than warningsTotalCount. False requires equality; true requires a smaller returned array. An accepted empty warning population is an empty array, zero total, and false.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  warningsTruncated?: boolean;
}

/**
 * Enum of the workspace discovery status.
 */
union WorkspaceDiscoveryStatus {
  string,

  /**
   * The discovery is pending and has not started.
   */
  Pending: "Pending",

  /**
   * The discovery has been accepted and is queued for execution.
   */
  Queued: "Queued",

  /**
   * The discovery is in progress.
   */
  InProgress: "InProgress",

  /**
   * The discovery completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Discovery produced an admissible result with an observed coverage shortfall. This status does not itself block scenario runs or evaluations; consumers requiring established coverage must also check completeness.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The discovery failed.
   */
  Failed: "Failed",

  /**
   * The discovery was canceled.
   */
  Canceled: "Canceled",
}

/**
 * A nonnegative count of the named discovery coverage unit. No resource-count maximum is defined.
 */
@minValue(0)
scalar WorkspaceDiscoveryCount extends int64;

/**
 * The coverage classification of the accepted Azure Resource Manager discovery result, independent of operation status and cause.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
union WorkspaceDiscoveryCompleteness {
  string,

  /** All attainable expected resource occurrences were classified and represented, with no observed shortfall. */
  Established: "Established",

  /** Required work completed without an observed gap, but a complete inventory denominator is structurally unavailable. */
  BaselineUnknown: "BaselineUnknown",

  /** Required system verification did not complete or a proven accessible required resource was not represented. */
  VerificationIncomplete: "VerificationIncomplete",

  /** Confirmed undelivered obligations remain and no required system-verification gap remains. */
  KnownPartial: "KnownPartial",
}

/**
 * Aggregate coverage of expanded Azure Resource Manager scope occurrences. Non-Azure Resource Manager discovery ingress is outside this population. VerificationIncomplete dominates KnownPartial, then BaselineUnknown, then Established.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryCoverageSummary {
  /** The scope-occurrence coverage partitions for this discovery result. */
  @visibility(Lifecycle.Read)
  scopes: WorkspaceDiscoveryScopeCoverageSummary;

  /**
   * Required resource occurrences only from scopes with a known complete expected inventory set. Absent exactly when knownExpectedSetCount is zero. Unknown is not a known empty set.
   */
  @visibility(Lifecycle.Read)
  resources?: WorkspaceDiscoveryResourceCoverageSummary;
}

/**
 * Two independent partitions of expanded scope occurrences after normalized-scope deduplication. Distinct service groups remain distinct even if their members coincide. The known/unknown counts and the four completeness counts each sum to totalCount.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryScopeCoverageSummary {
  /** The number of expanded Azure Resource Manager scope occurrences represented by the result. */
  @visibility(Lifecycle.Read)
  totalCount: WorkspaceDiscoveryCount;

  /** The number of scopes with an authoritative complete expected resource-occurrence set, including authoritatively empty sets. */
  @visibility(Lifecycle.Read)
  knownExpectedSetCount: WorkspaceDiscoveryCount;

  /**
   * The number of scopes whose complete expected inventory set is unavailable. A service group's known subscription or resource-group membership does not establish its descendant-resource denominator.
   */
  @visibility(Lifecycle.Read)
  unknownExpectedSetCount: WorkspaceDiscoveryCount;

  /** The number of scopes with Established coverage. */
  @visibility(Lifecycle.Read)
  establishedCount: WorkspaceDiscoveryCount;

  /** The number of scopes with a structurally unavailable denominator and no observed shortfall, including successful observed-empty container scans. */
  @visibility(Lifecycle.Read)
  baselineUnknownCount: WorkspaceDiscoveryCount;

  /** The number of scopes with required verification failure, unavailable required child enumeration, or a proven accessible required resource absent from the snapshot. */
  @visibility(Lifecycle.Read)
  verificationIncompleteCount: WorkspaceDiscoveryCount;

  /** The number of scopes with confirmed undelivered obligations and no remaining system-verification gap. */
  @visibility(Lifecycle.Read)
  knownPartialCount: WorkspaceDiscoveryCount;
}

/**
 * Required resource occurrences from known-set scopes, keyed by normalized scope and resource before global inventory-row deduplication. classifiedCount plus unclassifiedCount equals expectedCount, and coveredCount does not exceed classifiedCount.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryResourceCoverageSummary {
  /** The number of unique required resource occurrences across known-set scopes, not the number of service-group container members or listed inventory rows. */
  @visibility(Lifecycle.Read)
  expectedCount: WorkspaceDiscoveryCount;

  /** The number of expected occurrences with a terminal access or presence classification. */
  @visibility(Lifecycle.Read)
  classifiedCount: WorkspaceDiscoveryCount;

  /** The number of expected occurrences that required system verification could not classify. */
  @visibility(Lifecycle.Read)
  unclassifiedCount: WorkspaceDiscoveryCount;

  /** The number of classified expected occurrences actually represented in the produced snapshot. Access to a container or its descendants does not invent a resource occurrence. */
  @visibility(Lifecycle.Read)
  coveredCount: WorkspaceDiscoveryCount;
}

/**
 * The confirmed guidance reason. Unknown future reasons preserve the common warning fields and must not be interpreted as a permission denial.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
union WorkspaceDiscoveryWarningReason {
  string,

  /** The affected resource could not be read because of a confirmed authorization denial. */
  RbacValidationFailed: "RbacValidationFailed",

  /** The affected resource or configured membership was confirmed missing. */
  TargetNotFound: "TargetNotFound",

  /** Access versus absence could not be determined; guidance must state both possibilities. */
  AccessIndeterminate: "AccessIndeterminate",
}

/**
 * The common fields of a discovery guidance warning, discriminated by reason. Known reasons use their corresponding subtype; unknown future reasons retain these base fields.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@discriminator("reason")
model WorkspaceDiscoveryWarning {
  /** The normalized expanded source scope where the affected obligation was encountered. */
  @visibility(Lifecycle.Read)
  scopeId: Azure.Core.armResourceIdentifier;

  /** The source scope kind, such as Subscription, ResourceGroup, ServiceGroup, or Resource. */
  @visibility(Lifecycle.Read)
  scopeKind: string;

  /** The confirmed guidance reason, not a system-verification failure. */
  @visibility(Lifecycle.Read)
  reason: WorkspaceDiscoveryWarningReason;

  /** Human-readable guidance with attribution appropriate to the reason. */
  @visibility(Lifecycle.Read)
  message: string;
}

/**
 * Confirmed read-authorization guidance. Permission details are required composition, not an optional shell reused for other causes.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryPermissionWarning extends WorkspaceDiscoveryWarning {
  /** Identifies confirmed read-authorization guidance. */
  @visibility(Lifecycle.Read)
  reason: "RbacValidationFailed";

  /** The affected resource, required permissions, recommended roles, and optional identity details. */
  @visibility(Lifecycle.Read)
  permission: PermissionError;
}

/**
 * Guidance for a resource or membership confirmed missing.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryResourceWarning extends WorkspaceDiscoveryWarning {
  /** Identifies confirmed missing-resource guidance. */
  @visibility(Lifecycle.Read)
  reason: "TargetNotFound";

  /** The affected resource or member identity. */
  @visibility(Lifecycle.Read)
  resourceId: Azure.Core.armResourceIdentifier;
}

/**
 * Neutral guidance when access versus absence could not be established.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryAccessWarning extends WorkspaceDiscoveryWarning {
  /** Identifies neutral access-versus-absence guidance. */
  @visibility(Lifecycle.Read)
  reason: "AccessIndeterminate";

  /** The affected resource or member identity. */
  @visibility(Lifecycle.Read)
  resourceId: Azure.Core.armResourceIdentifier;
}
