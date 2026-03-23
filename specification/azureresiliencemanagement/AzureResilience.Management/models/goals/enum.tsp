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
@doc("Enum for the solution provider name of a high availability solution.")
union SolutionProviderName {
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
  @doc("The solution provider name of the high availability solution.")
  solutionProviderName: SolutionProviderName;

  @doc("The confirmation status of the high availability solution.")
  confirmationStatus: ConfirmationStatus;

  @doc("The reason for requesting user confirmation for the high availability solution.")
  reasonForRequestingConfirmation?: ReasonForRequestingConfirmation;
}
