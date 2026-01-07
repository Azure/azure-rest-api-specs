@doc("The FHIR Query configuration that is to be used when fetching the associated FHIR resources from the EMR FHIR endpoint.")
model FhirQueryProperties {
  @doc("The FHIR Server configuration.")
  fhirServerConfiguration: FhirServerProperties;
}

@doc("The FHIR Server configuration.")
@discriminator("emrSystem")
model FhirServerProperties {
  @doc("The type of EMR system.")
  emrSystem: EmrSystemType;

  @doc("The FHIR Server URL.")
  serviceEndpoint: url;
}

@doc("The EMR system types.")
union EmrSystemType {
  string,

  @doc("The Epic EMR system.")
  Epic: "Epic",
}

@doc("The Epic EMR system properties.")
model EpicFhirServerProperties extends FhirServerProperties {
  @doc("The Epic EMR system.")
  emrSystem: EmrSystemType.Epic;

  @doc("The Epic FHIR Server authentication configuration.")
  authenticationConfiguration: EpicFhirServerAuthenticationProperties;
}

@doc("The Epic FHIR Server authentication configuration.")
model EpicFhirServerAuthenticationProperties {
  @doc("The OAuth2 authorization URL.")
  authorizationEndpoint: url;

  @doc("The client ID to use to fetch the token.")
  clientId: string;

  @doc("The client secret credential to use to fetch the token.")
  clientSecret: Credential;
}

@discriminator("type")
@doc("The credential properties.")
model Credential {
  @doc("The type of the credential.")
  type: CredentialType;
}

@doc("The credential types.")
union CredentialType {
  string,

  @doc("Private key stored in KeyVault as key object.")
  KeyVaultKey: "KeyVaultKey",
}

@doc("KeyVault key credential properties")
model KeyVaultKeyCredential extends Credential {
  type: CredentialType.KeyVaultKey;

  @doc("The URI of the key vault key identifier.")
  keyVaultKeyIdentifier: url;
}
