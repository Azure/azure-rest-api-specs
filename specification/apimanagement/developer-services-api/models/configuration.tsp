namespace DeveloperServicesApi.Models;

@doc("Portal content settings.")
model ContentSettings {
  @doc("Specifies whether signin is required to access any content item.")
  signinRequired?: boolean;
}

@doc("The developer portal sign-up settings.")
model SignupConfiguration {
  @doc("Terms of service configuration.")
  termsOfService: TermsOfServiceConfiguration;
}

@doc("Terms of service configuration.")
model TermsOfServiceConfiguration {
  @doc("A terms of service text. Is required to not be null or empty to enable Terms of Service.")
  text: string;

  @doc("Are Terms of Service enabled. Will be enabled, if text exists.")
  enabled?: boolean = false;

  @doc("Ask user for consent to the terms of service.")
  requireConsent?: boolean = false;
}
