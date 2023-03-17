namespace DeveloperServicesAPI.Models;

model DelegationSettings {
  signin?: boolean;
  subscribe?: boolean;
}

model DelegationOperationRequest {
  returnUrl: string;
}

model DelegationOperationResponse {
  ssoUri: string;
}

model UserDelegationOperationRequest {
  productId: string;
  subscriptionId: string;
}

model UserDelegationOperationResponse {
  redirectUrl: string;
}
