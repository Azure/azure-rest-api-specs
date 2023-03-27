namespace DeveloperServicesApi.Models;

@doc("Delegation settings.")
model DelegationSettings {
  @doc("Specifies whether signin is delegated to external system.")
  signin?: boolean;

  @doc("Specifies whether Product subscribe is delegated to external system.")
  subscribe?: boolean;
}

@doc("Delegation operation request")
model DelegationOperationRequest {
  @doc("The URL user gets redirected to after successful authentication.")
  returnUrl: string;
}

@doc("Delegation operation response")
model DelegationOperationResponse {
  @doc("Signed SSO Sign-in/Sign-up Uri")
  ssoUri: string;
}

@doc("User delegation operation request")
model UserDelegationOperationRequest {
  @doc("Id of product. Is not required for all operations.")
  productId: string;

  @doc("Id of subscription. Is not required for all operations.")
  subscriptionId: string;
}

@doc("User delegation operation response")
model UserDelegationOperationResponse {
  @doc("Redirect URL")
  redirectUrl: string;
}
