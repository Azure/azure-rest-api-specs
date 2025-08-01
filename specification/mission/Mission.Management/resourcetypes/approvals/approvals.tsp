import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Approval Status. It can be Approved, Rejected, Pending, Deleted or Expired.")
union ApprovalStatus {
  string,

  @doc("ApprovalStatus Type Approved")
  Approved: "Approved",

  @doc("ApprovalStatus Type Rejected")
  Rejected: "Rejected",

  @doc("ApprovalStatus Type Pending")
  Pending: "Pending",

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("ApprovalStatus Type Deleted")
  Deleted: "Deleted",

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("ApprovalStatus Type Expired")
  Expired: "Expired",
}

@doc("Specifies the action performed by the approver")
union ActionPerformed {
  string,

  @doc("Action was Approved")
  Approved: "Approved",

  @doc("Action was Rejected")
  Rejected: "Rejected",
}

@doc("Request Metadata for approvals request.")
model RequestMetadata {
  @doc("Resource Action of the item being approved or declined.")
  resourceAction: string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Route name for the approval callback")
  approvalCallbackRoute?: string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Payload to be sent upon any action on approval request")
  approvalCallbackPayload?: string;

  @doc("Status of the approval. Uses ApprovalStatus enum.")
  approvalStatus?: ApprovalStatus = ApprovalStatus.Pending;
}

@renamedFrom(Microsoft.Mission.Versions.v2024_12_01_preview, "Approvers")
@doc("Approver Metadata for approvals request.")
model Approver {
  @doc("Entra ObjectID of the approver")
  approverEntraId: string;

  @doc("Action Performed by approver")
  actionPerformed?: ActionPerformed;

  @doc("approval request last updated at")
  lastUpdatedAt: utcDateTime;
}

@doc("Approval Base model.")
model ApprovalBaseModel {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Parameter for optimizing query results")
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "parent1")
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string)
  parentResourceId?: armResourceIdentifier;

  @doc("Parameter for optimizing query results")
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "parent2")
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string)
  grandparentResourceId?: armResourceIdentifier;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @OpenAPI.extension("x-ms-identifiers", #["approverEntraId"])
  @doc("List of approvers for the approval request")
  approvers?: Approver[];

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

model ApprovalProperties is ApprovalBaseModel {
  @doc("Request metadata for the approval request.")
  requestMetadata: RequestMetadata;
}

@doc("Request Metadata patch properties.")
model RequestMetadataUpdatableProperties
  is UpdateableProperties<OmitDefaults<RequestMetadata>>;

@doc("Approvals patch properties.")
model ApprovalPatchProperties
  is UpdateableProperties<OmitDefaults<ApprovalBaseModel>> {
  @doc("Request metadata for the approval request.")
  requestMetadata: RequestMetadataUpdatableProperties;
}

@doc("Approvals patch model.")
model ApprovalPatchModel {
  @doc("Approval Patch properties")
  properties?: ApprovalPatchProperties;
}
