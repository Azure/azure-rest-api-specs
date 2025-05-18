// Define a model for the approval initator callback request
@doc("Request body for calling post-action")
model InitiatorCallbackRequest {
  @doc("Approval status indicating 'Approved' or 'Rejected'")
  approvalStatus: "Approved" | "Rejected" | string;
}

// Define a model for the approval initator callback response
@doc("Response body after handling of approvalCallbackRequest")
model InitiatorCallbackResponse {
  @doc("Confirmation message indicating the result of the operation.")
  message: string;
}
