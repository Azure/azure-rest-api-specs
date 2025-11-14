using Azure.ResourceManager;

namespace Microsoft.ContainerRegistry;

/**
 * The name of the credential.
 */
union CredentialName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Credential1: "Credential1",
}

/**
 * The health status of credential.
 */
union CredentialHealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

/**
 * The properties of a credential set resource.
 */
model CredentialSetProperties {
  /**
   * The credentials are stored for this upstream or login server.
   */
  loginServer?: string;

  /**
   * List of authentication credentials stored for an upstream.
   * Usually consists of a primary and an optional secondary credential.
   */
  @identifiers(#["name"])
  authCredentials?: AuthCredential[];

  /**
   * The creation date of credential store resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Authentication credential stored for an upstream.
 */
model AuthCredential {
  /**
   * The name of the credential.
   */
  name?: CredentialName;

  /**
   * KeyVault Secret URI for accessing the username.
   */
  usernameSecretIdentifier?: string;

  /**
   * KeyVault Secret URI for accessing the password.
   */
  passwordSecretIdentifier?: string;

  /**
   * This provides data pertaining to the health of the auth credential.
   */
  @visibility(Lifecycle.Read)
  credentialHealth?: CredentialHealth;
}

/**
 * The health of the auth credential.
 */
model CredentialHealth {
  /**
   * The health status of credential.
   */
  status?: CredentialHealthStatus;

  /**
   * Error code representing the health check error.
   */
  errorCode?: string;

  /**
   * Descriptive message representing the health check error.
   */
  errorMessage?: string;
}

/**
 * The parameters for updating a credential set
 */
model CredentialSetUpdateParameters {
  /**
   * The properties of the credential set update parameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: CredentialSetUpdateProperties;

  /**
   * Identities associated with the resource. This is used to access the KeyVault secrets.
   */
  identity?: IdentityProperties;
}

/**
 * The parameters for updating credential set properties.
 */
model CredentialSetUpdateProperties {
  /**
   * List of authentication credentials stored for an upstream.
   * Usually consists of a primary and an optional secondary credential.
   */
  @identifiers(#["name"])
  authCredentials?: AuthCredential[];
}

/**
 * The result of a request to list credential sets for a container registry.
 */
model CredentialSetListResult {
  /**
   * The list of credential sets. Since this list may be incomplete, the nextLink field should be used to request the next list of credential sets.
   */
  @pageItems
  value?: CredentialSet[];

  /**
   * The URI that can be used to request the next list of credential sets.
   */
  @nextLink
  nextLink?: string;
}
