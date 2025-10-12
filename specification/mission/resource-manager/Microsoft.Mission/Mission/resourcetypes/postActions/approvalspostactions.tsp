import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Request body for calling post-action")
model ApprovalCallbackRequest {
  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Resource Id of the item being approved or rejected")
  resourceId: armResourceIdentifier;

  @doc("Resource request action indicating action which needed to be performed upon calling approval-callback post action")
  resourceRequestAction: "Create" | "Delete" | "Update" | "Reset" | string;

  @doc("Approval status indicating 'Approved' or 'Rejected'")
  approvalStatus: "Approved" | "Rejected" | string;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Payload requested by client upon approval action")
  approvalCallbackPayload?: string;
}

// Define a model for the approval initator callback request
@doc("Request body for calling post-action")
model ApprovalActionRequest {
  @doc("Approval status indicating 'Approved' or 'Rejected'")
  approvalStatus: "Approved" | "Rejected" | string;
}

// Define a model for the approval initator callback response
@doc("Response body after handling of approvalCallbackRequest")
model ApprovalActionResponse {
  @doc("Confirmation message indicating the result of the operation.")
  message: string;
}

@doc("Request body for calling post-action")
model ApprovalDeletionCallbackRequest {
  @doc("Resource request action indicating action which needed to be performed upon calling approval-deletion-callback post action")
  resourceRequestAction: "Create" | "Delete" | "Update" | string;
}
