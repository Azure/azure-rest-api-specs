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
model ApprovalDeletionCallbackRequest {
  @doc("Resource request action indicating action which needed to be performed upon calling approval-deletion-callback post action")
  resourceRequestAction: "Create" | "Delete" | "Update" | string;
}

@doc("Response body after handling of approvalDeletionCallbackRequest")
model ApprovalDeletionCallbackResponse {
  @doc("Confirmation message indicating the result of the operation.")
  message: string;
}
