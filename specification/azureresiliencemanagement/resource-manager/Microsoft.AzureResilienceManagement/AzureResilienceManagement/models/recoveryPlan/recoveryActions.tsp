import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../../recoveryPlans.tsp";
import "./recoveryResource.tsp";

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
