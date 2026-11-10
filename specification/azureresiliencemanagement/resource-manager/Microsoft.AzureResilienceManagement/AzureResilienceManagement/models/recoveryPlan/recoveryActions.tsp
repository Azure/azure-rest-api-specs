import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../../recoveryPlans.tsp";
import "./recoveryResource.tsp";
import "./recoveryConfigProfile.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Defines the set of operations that can be executed on a Recovery Orchestration Plan. These operations are applicable only to resources that meet the qualification criteria.")
union RecoveryOperationNames {
  @doc("Initiates a failover process to recover eligible resources to the target location.")
  Failover: "Failover",

  @doc("Commits the failover for resources that require an explicit commit after recovery.")
  FailoverCommit: "FailoverCommit",

  @doc("Performs re-protection or configuration changes for resources that have failed over, as required.")
  Reprotect: "Reprotect",

  @doc("Initiates a test failover process for qualified resources and those that support test failover.")
  TestFailover: "TestFailover",

  @doc("Cleans up resources and configurations created during a test failover, as required.")
  TestFailoverCleanup: "TestFailoverCleanup",

  string,
}

@doc("ValidateForOperation post action request to check if operation can be performed.")
model ValidateForOperationRequest {
  @doc("Operation Name to validate.")
  operationName: RecoveryOperationNames;
}

@doc("Protection details of resource.")
union NotQualifiedReasons {
  @doc("Resource is excluded from the Recovery Orchestration Plan.")
  InclusionStateExcluded: "InclusionStateExcluded",

  @doc("Resource Type does not support this operation.")
  ResourceTypeDoesNotSupportOperation: "ResourceTypeDoesNotSupportOperation",

  @doc("Resource current protection state does bot support this operation.")
  ResourceProtectionStateDoesNotSupportOperation: "ResourceProtectionStateDoesNotSupportOperation",

  @doc("Resource current active location does not match the input.")
  ResourceActiveLocationNotAsPerInput: "ResourceActiveLocationNotAsPerInput",

  string,
}

@doc("A state type that indicates qualification of a resource for an operation.")
union QualificationState {
  @doc("A state that indicates the qualification state is unknown.")
  Unknown: "Unknown",

  @doc("A state that indicates the resource is qualified for the operation.")
  Qualified: "Qualified",

  @doc("A state that indicates the resource is not qualified for the operation.")
  NotQualified: "NotQualified",

  @doc("A state that indicates the resource is excluded from the recovery plan itself.")
  Excluded: "Excluded",

  string,
}

@doc("Details of qualification for an operation.")
model OperationQualificationDetails {
  @doc("Resource qualification state for the operation.")
  qualificationState: QualificationState;

  @doc("Reasons for resource not qualified for the operation.")
  notQualifiedReasons?: string[];

  @added(Versions.v2026_08_31_preview)
  @doc("Advisory resource feasibility reviews. Absent when no review was evaluated for this resource.")
  @identifiers(#["feasibilityType", "resourceType"])
  @maxItems(10)
  resourceFeasibilityReviews?: ResourceFeasibilityReview[];
}

@doc("Details of resource and its qualification for an operation")
model RecoveryResourceQualification {
  @doc("Recovery orchestration resource.")
  recoveryResource: RecoveryResource;

  @doc("Details of qualification for the operation.")
  operationQualificationDetails: OperationQualificationDetails;
}

@doc("ValidateForRecoveryOperation post action response.")
model ValidateForRecoveryOperationBaseResponse {
  @identifiers(#[])
  @doc("Qualification details of resources for the operation.")
  recoveryResourceQualifications: RecoveryResourceQualification[];
}

@doc("Recovery Orchestration Plan post action response.")
model RecoveryPlanActionBaseResponse {
  @doc("JobId of the job triggered for Recovery Orchestration Plan.")
  jobId: string;
}

@added(Versions.v2026_12_30_preview)
@doc("Request options shared by Restore and ValidateForRestore. Selections and recovery point policies apply only to this request and do not modify the recovery plan or its saved recovery configuration profiles.")
model RecoveryPlanRestoreContent {
  @added(Versions.v2026_12_30_preview)
  @doc("An optional filter over the recovery plan's included resource catalog. Omission selects all included resources.")
  resourceFilter?: RestoreResourceFilter;

  @added(Versions.v2026_12_30_preview)
  @doc("The operation-wide recovery point policy. An explicit resource recoveryPointId or pointInTime takes precedence, followed by a recovery group policy, this operation policy, the associated profile policy, and finally Latest. All overrides are transient and do not modify saved profiles.")
  recoveryPointPolicy?: RecoveryPointPolicy;
}

@added(Versions.v2026_12_30_preview)
@doc("Whether matching resources are included in or excluded from this restore request.")
union RestoreFilterType {
  @added(Versions.v2026_12_30_preview)
  @doc("Selects the union of resources matching the supplied recovery resource, workload, and recovery group selectors within the plan's included resource catalog.")
  Include: "Include",

  @added(Versions.v2026_12_30_preview)
  @doc("Removes the union of resources matching the supplied selectors from the plan's included resource catalog.")
  Exclude: "Exclude",

  string,
}

@added(Versions.v2026_12_30_preview)
@doc("Selects included recovery plan resources by resource GUID, workload, or recovery group. Criteria form a union, not an intersection. Exclude removes that union and cannot specify recovery point IDs, point-in-time selections, or recovery group policy overrides.")
model RestoreResourceFilter {
  @added(Versions.v2026_12_30_preview)
  @doc("Whether matching resources are included in or excluded from the request.")
  filterType: RestoreFilterType;

  @added(Versions.v2026_12_30_preview)
  @doc("Recovery resource GUID selectors with optional per-resource recovery point IDs or point-in-time selections. Duplicate recoveryResourceId values are not allowed.")
  @identifiers(#["recoveryResourceId"])
  recoveryResources?: RecoveryResourcesInput[];

  @added(Versions.v2026_12_30_preview)
  @doc("Workload selectors combined with the recovery resource and recovery group selectors by union.")
  workloadTypes?: WorkloadType[];

  @added(Versions.v2026_12_30_preview)
  @doc("Recovery group selectors and optional request-only recovery point policy overrides. Duplicate recoveryGroupId values are not allowed.")
  @identifiers(#["recoveryGroupId"])
  recoveryGroups?: RecoveryGroupsInput[];
}

@added(Versions.v2026_12_30_preview)
@doc("Selects a recovery resource within the plan by GUID. The service resolves its backup protected items from the resource catalog. recoveryPointId and pointInTime are alternatives; the service rejects a request containing both for the same resource. Either selection overrides group, operation, and profile policies. When neither is supplied, policy precedence applies. Exclude selectors must omit both.")
model RecoveryResourcesInput {
  @added(Versions.v2026_12_30_preview)
  @doc("The GUID identifying the recovery resource within the selected recovery plan. This is not an Azure resource ID or a backup protected item ID.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryResourceId: string;

  @added(Versions.v2026_12_30_preview)
  @doc("An optional recovery point name or full recovery point Azure resource ID. The service verifies ownership against the selected resource's backup protected items. Mutually exclusive with pointInTime and not allowed in Exclude filters.")
  @minLength(1)
  recoveryPointId?: string;

  @added(Versions.v2026_12_30_preview)
  @doc("An optional UTC timestamp for point-in-time recovery of the selected resource. Mutually exclusive with recoveryPointId and not allowed in Exclude filters. The service validates that the resource supports point-in-time recovery and that the timestamp is recoverable.")
  pointInTime?: utcDateTime;
}

@added(Versions.v2026_12_30_preview)
@doc("Selects a recovery group in the recovery plan, with an optional request-only recovery point policy override. Used by Restore, ValidateForRestore, and FetchRecoveryPoints.")
model RecoveryGroupsInput {
  @added(Versions.v2026_12_30_preview)
  @doc("The GUID identifying the recovery group within the recovery plan.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryGroupId: string;

  @added(Versions.v2026_12_30_preview)
  @doc("A request-only recovery point policy for the selected recovery group. An explicit resource recovery point selection takes precedence; this policy overrides operation and profile defaults. Restore and ValidateForRestore Exclude filters cannot specify a recovery group policy.")
  recoveryPointPolicy?: RecoveryPointPolicy;
}

@added(Versions.v2026_12_30_preview)
@doc("Optional scope and request-only recovery point policy overrides for fetching recovery points. Overrides apply only to this request and do not modify the recovery plan or its saved recovery configuration profiles.")
model FetchRecoveryPointsRequest {
  @added(Versions.v2026_12_30_preview)
  @doc("The request-wide recovery point policy override.")
  recoveryPointPolicy?: RecoveryPointPolicy;

  @added(Versions.v2026_12_30_preview)
  @doc("Selected recovery groups and their optional recovery point policy overrides.")
  @identifiers(#["recoveryGroupId"])
  recoveryGroups?: RecoveryGroupsInput[];

  @added(Versions.v2026_12_30_preview)
  @doc("Selected sets of recovery resources, each with an optional shared recovery point policy override.")
  @identifiers(#[])
  recoveryResources?: RecoveryResourcePolicySet[];
}

@added(Versions.v2026_12_30_preview)
@doc("Recovery resource selectors that share one optional request-only recovery point policy override.")
model RecoveryResourcePolicySet {
  @added(Versions.v2026_12_30_preview)
  @doc("GUIDs identifying recovery resources within the recovery plan.")
  recoveryResourceIds: RecoveryResourceGuid[];

  @added(Versions.v2026_12_30_preview)
  @doc("The recovery point policy override shared by the recovery resources in this set.")
  recoveryPointPolicy?: RecoveryPointPolicy;
}

@added(Versions.v2026_12_30_preview)
@doc("The result of fetching recovery points for a recovery plan.")
model FetchRecoveryPointsResult {
  @added(Versions.v2026_12_30_preview)
  @doc("Selections that correlate recovery resources with their selected recovery points.")
  @identifiers(#["recoveryResourceId"])
  recoveryPoints?: RecoveryPointDetails[];
}

@added(Versions.v2026_12_30_preview)
@doc("The recovery point selected for a recovery resource.")
model RecoveryPointDetails {
  @added(Versions.v2026_12_30_preview)
  @doc("The GUID identifying the recovery resource within the recovery plan.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryResourceId?: string;

  @added(Versions.v2026_12_30_preview)
  @doc("The GUID of the recovery group that contains the recovery resource.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryGroupId?: string;

  @added(Versions.v2026_12_30_preview)
  @doc("The identifier of the selected backup service recovery point. This is a numeric (long) value represented as a string.")
  recoveryPointId?: string;

  @added(Versions.v2026_12_30_preview)
  @doc("The UTC time at which the selected recovery point was created.")
  recoveryPointTime?: utcDateTime;

  @added(Versions.v2026_12_30_preview)
  @doc("The consistency of the selected recovery point for virtual machine and Azure Files workloads.")
  recoveryPointType?: RecoveryPointType;

  @added(Versions.v2026_12_30_preview)
  @doc("The backup mechanism of the selected recovery point for database workloads.")
  backupType?: BackupType;

  @added(Versions.v2026_12_30_preview)
  @doc("The optional threat status reported by the backup service.")
  threatStatus?: string;
}

@added(Versions.v2026_12_30_preview)
@doc("The consistency of a recovery point.")
union RecoveryPointType {
  @added(Versions.v2026_12_30_preview)
  @doc("Application-consistent recovery point.")
  AppConsistent: "AppConsistent",

  @added(Versions.v2026_12_30_preview)
  @doc("Crash-consistent recovery point.")
  CrashConsistent: "CrashConsistent",

  @added(Versions.v2026_12_30_preview)
  @doc("File-system-consistent recovery point.")
  FileSystemConsistent: "FileSystemConsistent",

  string,
}

@added(Versions.v2026_12_30_preview)
@doc("A GUID identifying a recovery resource within a recovery plan.")
@pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
scalar RecoveryResourceGuid extends string;

@doc("TestFailoverCleanup post action request.")
model TestFailoverCleanupRequest {
  @doc("Comments for test failover cleanup.")
  @maxLength(1024)
  comments?: string;
}

@added(Versions.v2026_03_01_preview)
@doc("Request body for providing user input for a recovery action.")
model RecoveryActionRequest {
  @added(Versions.v2026_03_01_preview)
  @doc("User-provided input for the action.")
  @maxLength(100)
  description?: string;
}

@added(Versions.v2026_08_31_preview)
@doc("The resource feasibility review category for a recovery resource.")
union ResourceFeasibilityReviewType {
  @added(Versions.v2026_08_31_preview)
  @doc("SKU capacity availability check in the target region or zone.")
  SkuCapacity: "SkuCapacity",

  string,
}

@added(Versions.v2026_08_31_preview)
@doc("Outcome of a resource feasibility review for a recovery resource.")
union ResourceFeasibilityReviewStatus {
  @added(Versions.v2026_08_31_preview)
  @doc("The review could not complete. Advisory only; it never blocks failover.")
  Unavailable: "Unavailable",

  @added(Versions.v2026_08_31_preview)
  @doc("The review identified no risk.")
  Passed: "Passed",

  @added(Versions.v2026_08_31_preview)
  @doc("The review identified a risk the operator should consider.")
  Flagged: "Flagged",

  @added(Versions.v2026_08_31_preview)
  @doc("The review did not apply to this resource and was skipped.")
  NotApplicable: "NotApplicable",

  string,
}

@added(Versions.v2026_08_31_preview)
@doc("SKU details for a resource feasibility review, used for both the current target SKU and the recommended alternate SKUs.")
model SkuDetails {
  @added(Versions.v2026_08_31_preview)
  @doc("The Azure SKU name.")
  sku: string;

  @added(Versions.v2026_08_31_preview)
  @doc("Number of virtual CPUs for the SKU. Absent when SKU specifications are unavailable.")
  vCpu?: int32;

  @added(Versions.v2026_08_31_preview)
  @doc("Memory in GiB for the SKU. Absent when SKU specifications are unavailable.")
  ram?: int32;

  @added(Versions.v2026_08_31_preview)
  @doc("Estimated monthly price. Absent when pricing is unavailable.")
  monthlyPrice?: float64;

  @added(Versions.v2026_08_31_preview)
  @doc("ISO 4217 currency code for `monthlyPrice`.")
  currency?: string;

  @added(Versions.v2026_08_31_preview)
  @doc("Identifier of the Azure offering used to estimate `monthlyPrice`.")
  offeringId?: string;
}

@added(Versions.v2026_08_31_preview)
@doc("Result of a single feasibility review performed against one resource in a recovery plan.")
model ResourceFeasibilityReview {
  @added(Versions.v2026_08_31_preview)
  @doc("The resource feasibility review type.")
  feasibilityType: ResourceFeasibilityReviewType;

  @added(Versions.v2026_08_31_preview)
  @doc("Fully qualified ARM resource type evaluated, e.g. `Microsoft.Compute/virtualMachines`.")
  @pattern("^[a-zA-Z0-9]+\\.[a-zA-Z0-9]+(/[a-zA-Z0-9]+)+$")
  resourceType: string;

  @added(Versions.v2026_08_31_preview)
  @doc("The SKU the resource is currently configured to recover into, enriched for comparison against the recommendations. Absent when it could not be resolved, and always absent on `Passed` and `NotApplicable` reviews.")
  currentTargetSku?: SkuDetails;

  @added(Versions.v2026_08_31_preview)
  @doc("Outcome of this feasibility review.")
  status: ResourceFeasibilityReviewStatus;

  @added(Versions.v2026_08_31_preview)
  @doc("Alternative SKUs surfaced for this review. Absent or empty means a `Flagged` review has no alternatives, an `Unavailable` review has no applicable recommendations to surface, or the review has a minimal `Passed` / `NotApplicable` outcome. Callers should treat an absent array and an empty array identically.")
  @identifiers(#["sku"])
  @maxItems(5)
  recommendedTargetSkus?: SkuDetails[];
}
