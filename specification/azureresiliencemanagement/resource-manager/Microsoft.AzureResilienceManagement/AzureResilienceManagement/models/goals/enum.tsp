import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AzureResilienceManagement;

@doc("Enum for the status of the resource in the goal.")
union ExclusionState {
  string,

  @doc("Resource is not included in the goals.")
  Excluded: "Excluded",

  @doc("Resource is excluded from the goals.")
  Included: "Included",
}

@doc("Enum for the attestation status of the resource in the goal.")
union AttestationState {
  string,

  @doc("Resource is not manually attested.")
  NotAttested: "NotAttested",

  @doc("Resource is manually attested.")
  ManuallyAttested: "ManuallyAttested",
}

@doc("Enum for the requirement status of the resource in the goal.")
union RequirementSelected {
  string,

  @doc("The resource is not required for the specified goal.")
  NotRequired: "NotRequired",

  @doc("The resource is required for the specified goal.")
  Required: "Required",
}

@doc("Supported type of goal assignment.")
union GoalAssignmentType {
  string,

  @doc("Resiliency goal assignment type.")
  Resiliency: "Resiliency",
}

@doc("Supported type of goal.")
union GoalType {
  string,

  @doc("Resiliency goal type.")
  Resiliency: "Resiliency",
}

@doc("Enum for the reason why a resource is excluded.")
union ExclusionReason {
  string,

  @doc("The resource was excluded by user selection.")
  UserSelectedExclusion: "UserSelectedExclusion",

  @doc("The resource failed over and is excluded.")
  FailedOverResource: "FailedOverResource",

  @doc("The resource is unsupported and excluded.")
  UnsupportedResource: "UnsupportedResource",
}

@added(Versions.v2026_03_01_preview)
@doc("Enum for the confirmation status of a high availability solution.")
union ConfirmationStatus {
  string,

  @doc("The high availability solution has been approved by the user.")
  ApprovedByUser: "ApprovedByUser",

  @doc("The high availability solution is pending approval from the user.")
  ApprovalPending: "ApprovalPending",

  @doc("The high availability solution does not require user approval.")
  ApprovalNotNeeded: "ApprovalNotNeeded",

  @doc("The high availability solution has been rejected by the user.")
  RejectedByUser: "RejectedByUser",
}

@added(Versions.v2026_03_01_preview)
@doc("Identifies a high-availability solution that can be applied to a resource (for example, zone-pinned VM with ZRS disk).")
union SolutionDisplayName {
  string,

  @doc("Zone pinned VM with ZRS disk.")
  ZonePinnedVmWithZrsDisk: "ZonePinnedVmWithZrsDisk",

  @doc("VM in multi-zone VMSS.")
  VmInMultiZoneVmss: "VmInMultiZoneVmss",
}

@added(Versions.v2026_03_01_preview)
@doc("Enum for the reason for requesting user confirmation for a high availability solution.")
union ReasonForRequestingConfirmation {
  string,

  @doc("Zone pinned ZRS data disks conditional.")
  ZonePinnedZrsDataDisksConditional: "ZonePinnedZrsDataDisksConditional",

  @doc("VM in multi-zone scale set stateless only.")
  VmInMultiZoneScaleSetStatelessOnly: "VmInMultiZoneScaleSetStatelessOnly",
}

@added(Versions.v2026_03_01_preview)
@doc("Represents a user confirmation for a high availability solution.")
model UserConfirmationForHighAvailabilityItem {
  @doc("The solution display name of the high availability solution.")
  solutionDisplayName: SolutionDisplayName;

  @doc("The confirmation status of the high availability solution.")
  confirmationStatus: ConfirmationStatus;

  @doc("The reason for requesting user confirmation for the high availability solution.")
  reasonForRequestingConfirmation?: ReasonForRequestingConfirmation;
}

@added(Versions.v2026_03_01_preview)
@doc("Classification of a resource's resiliency eligibility. Determines what guidance and alternate configurations are returned.")
union ResiliencyEligibilityCategory {
  string,

  @doc("This resource type is not yet covered by the resiliency capability catalog.")
  Unsupported: "Unsupported",

  @doc("The resource is eligible for resiliency in its current region and SKU. Review the steps field for enablement guidance.")
  ZrEligible: "ZrEligible",

  @doc("The resource's SKU supports resiliency but available capacity is limited. Consider the suggested SKUs or regions for better availability.")
  SkuCapacityConstrained: "SkuCapacityConstrained",

  @doc("The current SKU does not support resiliency in this region. Upgrade to one of the suggested SKUs to enable redundancy.")
  SkuIneligible: "SkuIneligible",

  @doc("The resource's current region does not support resiliency for this resource type. Migrate to one of the suggested regions.")
  RegionUnsupported: "RegionUnsupported",
}
