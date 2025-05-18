import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@doc("Approval Status Enum")
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
union ActionPerformedEnum {
  string,

  @doc("ActionPerformedEnum Type Approved")
  Approved: "Approved",

  @doc("ActionPerformedEnum Type Rejected")
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

@doc("Request Metadata for approvals patch request.")
@withoutDefaultValues
model RequestMetadataPatchModel is RequestMetadata;

@renamedFrom(Microsoft.Mission.Versions.v2024_12_01_preview, "Approvers")
@doc("Approver Metadata for approvals request.")
model Approver {
  @doc("EntraId of the approver")
  approverEntraId: string;

  @doc("Action Performed by approver")
  actionPerformed: ActionPerformedEnum;

  @doc("approval request last updated at")
  lastUpdatedAt: utcDateTime;
}

@doc("Approval Base model.")
model ApprovalBaseModel {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Parameter for optimizing query results")
  parent1?: string;

  @doc("Parameter for optimizing query results")
  parent2?: string;

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

@doc("Approvals model.")
model ApprovalModel is ApprovalBaseModel {
  @doc("Request metadata for the approval request.")
  requestMetadata: RequestMetadata;
}

@doc("Approvals patch properties.")
model ApprovalPatchProperties is ApprovalBaseModel {
  @doc("Request metadata for the approval request without default values.")
  requestMetadata: RequestMetadataPatchModel;
}

@doc("Approvals patch model.")
model ApprovalPatchModel {
  @doc("Approval Patch properties")
  properties?: Update<ApprovalPatchProperties>;
}
