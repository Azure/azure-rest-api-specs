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
