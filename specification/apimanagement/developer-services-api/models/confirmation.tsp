namespace DeveloperServicesApi.Models;

@doc("API Management Notification Request.")
model ConfirmationRequest {
  @doc("The email address to send the confirmation to.")
  to: string;
}

@doc("API Management Notification Request")
model IdentityConfirmationRequest {
  @doc("The email address to send the confirmation to.")
  to: string;

  @doc("Confirmation reason.")
  reason: string;
}
