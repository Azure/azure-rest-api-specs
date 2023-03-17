namespace DeveloperServicesAPI.Models;

model ContentSettings {
  signinRequired?: boolean;
}

model SignupConfiguration {
  termsOfService: TermsOfServiceConfiguration;
}

model TermsOfServiceConfiguration {
  text: string;
  enabled?: boolean = false;
  requireConsent?: boolean = false;
}
