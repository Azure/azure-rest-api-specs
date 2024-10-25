import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Request body for calling post-action")
model ApprovalCallbackRequest {
  @removed(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("Resource Id of the item being approved or rejected")
  resourceId: string;

  @doc("Resource request action indicating action which needed to be performed upon calling approval-callback post action")
  resourceRequestAction: "Create" | "Delete" | "Update" | "Reset" | string;

  @doc("Approval status indicating 'Approved', 'Rejected', 'Deleted' or 'Expired'")
  approvalStatus: "Approved" | "Rejected" | "Deleted" | "Expired" | string;

  @added(Microsoft.Mission.Versions.v2024_10_01_preview)
  @doc("Payload requested by client upon approval action")
  approvalCallbackPayload?: string;              
}

@doc("Response body after handling of approvalCallbackRequest")
model ApprovalCallbackResponse {
  @doc("Confirmation message indicating the result of the operation.")
  message: string;
}
