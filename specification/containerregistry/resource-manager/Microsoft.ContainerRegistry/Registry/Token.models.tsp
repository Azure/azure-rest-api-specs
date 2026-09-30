namespace Microsoft.ContainerRegistry;

using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TokenCertificateName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificate1: "certificate1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificate2: "certificate2",
}

/**
 * The password name "password1" or "password2"
 */
union TokenPasswordName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password1: "password1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password2: "password2",
}

/**
 * The status of the token example enabled or disabled.
 */
union TokenStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * The properties of a token.
 */
model TokenProperties {
  /**
   * The creation date of scope map.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;
}

/**
 * The properties of the credentials that can be used for authenticating the token.
 */
model TokenCredentialsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["thumbprint"])
  certificates?: TokenCertificate[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  passwords?: TokenPassword[];
}

/**
 * The properties of a certificate used for authenticating a token.
 */
model TokenCertificate {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: TokenCertificateName;

  /**
   * The expiry datetime of the certificate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The thumbprint of the certificate.
   */
  thumbprint?: string;

  /**
   * Base 64 encoded string of the public certificate1 in PEM format that will be used for authenticating the token.
   */
  encodedPemCertificate?: string;
}

/**
 * The password that will be used for authenticating the token of a container registry.
 */
model TokenPassword {
  /**
   * The creation datetime of the password.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The expiry datetime of the password.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The password name "password1" or "password2"
   */
  name?: TokenPasswordName;

  /**
   * The password value.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The parameters for updating a token.
 */
model TokenUpdateParameters {
  /**
   * The properties of the token update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: TokenUpdateProperties;
}

/**
 * The parameters for updating token properties.
 */
model TokenUpdateProperties {
  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;
}

/**
 * The parameters used to generate credentials for a specified token or user of a container registry.
 */
model GenerateCredentialsParameters {
  /**
   * The resource ID of the token for which credentials have to be generated.
   */
  tokenId?: string;

  /**
   * The expiry date of the generated credentials after which the credentials become invalid.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * Specifies name of the password which should be regenerated if any -- password1 or password2.
   */
  name?: TokenPasswordName;
}

/**
 * The response from the GenerateCredentials operation.
 */
model GenerateCredentialsResult {
  /**
   * The username for a container registry.
   */
  username?: string;

  /**
   * The list of passwords for a container registry.
   */
  @identifiers(#[])
  passwords?: TokenPassword[];
}

/**
 * The result of a request to list tokens for a container registry.
 */
model TokenListResult {
  /**
   * The list of tokens. Since this list may be incomplete, the nextLink field should be used to request the next list of tokens.
   */
  @pageItems
  value?: Token[];

  /**
   * The URI that can be used to request the next list of tokens.
   */
  @nextLink
  nextLink?: string;
}
