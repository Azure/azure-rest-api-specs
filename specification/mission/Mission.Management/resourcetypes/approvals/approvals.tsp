import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../shared/resourceid.tsp";
import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@doc("Approval Status Enum")
union ApprovalStatus {
  @doc("ApprovalStatus Type Approved")
  Approved: "Approved",

  @doc("ApprovalStatus Type Rejected")
  Rejected: "Rejected",

  @doc("ApprovalStatus Type Pending")
  Pending: "Pending",

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("ApprovalStatus Type Deleted")
  Deleted: "Deleted",

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("ApprovalStatus Type Expired")
  Expired: "Expired",

  string,
}

@doc("Specifies the action performed by the approver")
union ActionPerformed {
  @doc("ActionPerformed Type Approved")
  Approved: "Approved",

  @doc("ActionPerformed Type Rejected")
  Rejected: "Rejected",

  string,
}

@doc("Request Metadata for approvals request.")
model RequestMetadata {
  @doc("Resource Action of the item being approved or declined.")
  resourceAction: string;

  @doc("Approval status.")
  approvalStatus?: ApprovalStatus;

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Route name for the approval callback")
  approvalCallbackRoute?: string;

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("Payload to be sent upon any action on approval request")
  approvalCallbackPayload?: string;
}

@renamedFrom(Microsoft.Mission.Versions.v2024_12_01_preview, "Approvers")
@doc("Approver Metadata for approvals request.")
model Approver {
  @doc("EntraId of the approver")
  approverEntraId: string;

  @doc("Action Performed by approver")
  actionPerformed: ActionPerformed;

  @doc("approval request last updated at")
  lastUpdatedAt: utcDateTime;
}

@doc("Approvals Resource Properties")
model ApprovalProperties {
  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Parameter for optimizing query results")
  parent1?: string;

  @doc("Parameter for optimizing query results")
  parent2?: string;

  @doc("Request metadata for the approval request.")
  requestMetadata: RequestMetadata;

  @added(Microsoft.Mission.Versions.v2024_10_01_preview)
  @OpenAPI.extension("x-ms-identifiers", ["approverEntraId"])
  @doc("List of approvers for the approval request")
  approvers?: Approver[];

  @added(Microsoft.Mission.Versions.v2024_10_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @OpenAPI.extension("x-ms-identifiers", ["approverEntraId"])
  @doc("List of mandatory approvers for the approval request")
  mandatoryApprovers?: Approver[];

  @added(Microsoft.Mission.Versions.v2024_10_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Minimum number of approvers required for the approval request")
  minimumApproversRequired?: int64;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Ticket ID for the approval request")
  ticketId?: string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Approval request creation time")
  createdAt?: utcDateTime;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Approval request state change time, time at which approval request state changed from pending to approved or rejected.")
  stateChangedAt?: utcDateTime;
}
