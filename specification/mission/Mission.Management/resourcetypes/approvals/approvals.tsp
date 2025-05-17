import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../shared/resourceid.tsp";
import "../shared/provisioningstate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@doc("Approval Status Enum")
union ApprovalStatusEnum {
  @doc("ApprovalStatusEnum Type Approved")
  Approved: "Approved",

  @doc("ApprovalStatusEnum Type Rejected")
  Rejected: "Rejected",

  @doc("ApprovalStatusEnum Type Pending")
  Pending: "Pending",

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("ApprovalStatusEnum Type Deleted")
  Deleted: "Deleted",

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("ApprovalStatusEnum Type Expired")
  Expired: "Expired",

  string,
}

@doc("Specifies the action performed by the approver")
union ActionPerformedEnum {
  @doc("ActionPerformedEnum Type Approved")
  Approved: "Approved",

  @doc("ActionPerformedEnum Type Rejected")
  Rejected: "Rejected",

  string,
}

@doc("Request Metadata for approvals request.")
model RequestMetadataProperties {
  @doc("Resource Action of the item being approved or declined.")
  resourceAction: string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Route name for the approval callback")
  approvalCallbackRoute?: string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Payload to be sent upon any action on approval request")
  approvalCallbackPayload?: string;
}

@doc("Request Metadata for approvals request.")
model RequestMetadata {
  @doc("Status of the approval. Uses ApprovalStatusEnum enum.")
  approvalStatus?: ApprovalStatusEnum = ApprovalStatusEnum.Pending;

  ...RequestMetadataProperties;
}

@doc("Request Metadata for approvals request without default values.")
model RequestMetadataPatch {
  @doc("Status of the approval. Uses ApprovalStatusEnum enum.")
  approvalStatus?: ApprovalStatusEnum;

  ...RequestMetadataProperties;
}

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

@doc("Approvals properties.")
model ApprovalPropertiesBase {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningStateEnum;

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

@doc("Approvals properties with default values.")
model ApprovalProperties is ApprovalPropertiesBase {
  @doc("Request metadata for the approval request.")
  requestMetadata: RequestMetadata;
}

@doc("Approvals Properties without default values.")
model ApprovalPropertiesPatch is ApprovalPropertiesBase {
  @doc("Request metadata for the approval request without default values.")
  requestMetadata: RequestMetadataPatch;
}

@doc("Approvals properties for patching")
model ApprovalPatchModel {
  @doc("Approval Patch properties")
  properties?: Update<ApprovalPropertiesPatch>;
}
