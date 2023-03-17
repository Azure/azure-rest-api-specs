namespace DeveloperServicesAPI.Models;

model ConfirmationRequest {
  to: string;
}

model IdentityConfirmationRequest {
  to: string;
  reason: string;
}
