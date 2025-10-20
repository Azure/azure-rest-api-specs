import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTOperations;

/**
 * Model for RegistryEndpointAuthentication
 */
@discriminator("method")
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointAuthentication {
  /**
   * The authentication method.
   */
  method: RegistryEndpointAuthenticationMethod;
}

/**
 * The authentication method.
 */
@added(Versions.`2025-07-01-preview`)
union RegistryEndpointAuthenticationMethod {
  string,

  /**
   * System and User assigned identity authentication
   */
  ManagedIdentityMethod,

  /**
   * Anonymous authentication
   */
  AnonymousMethod,

  /**
   * Artifact Pull Secret authentication
   */
  ArtifactPullSecret,
}

/**
 * System assigned identity authentication
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointSystemAssignedIdentityAuthentication
  extends RegistryEndpointAuthentication {
  /**
   * The authentication method.
   */
  method: SystemAssignedManagedIdentity;

  /**
   * System assigned managed identity properties
   */
  systemAssignedManagedIdentitySettings: RegistryEndpointSystemAssignedManagedIdentitySettings;
}

/**
 * User assigned identity authentication
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointUserAssignedIdentityAuthentication
  extends RegistryEndpointAuthentication {
  /**
   * The authentication method.
   */
  method: UserAssignedManagedIdentity;

  /**
   * User assigned managed identity properties
   */
  userAssignedManagedIdentitySettings: RegistryEndpointUserAssignedManagedIdentitySettings;
}

/**
 * System assigned managed identity properties
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointSystemAssignedManagedIdentitySettings {
  ...BaseSystemAssignedManagedIdentity;
}

/**
 * User assigned managed identity properties
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointUserAssignedManagedIdentitySettings {
  ...BaseUserAssignedManagedIdentity;
}

/**
 * Anonymous authentication
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointAnonymousAuthentication
  extends RegistryEndpointAuthentication {
  /**
   * The authentication method.
   */
  method: Anonymous;

  /**
   * Anonymous authentication properties
   */
  anonymousSettings: RegistryEndpointAnonymousSettings;
}

/**
 * RegistryEndpoint Anonymous authentication properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "CRD type is modeled as empty object"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Prevents adding unwanted properties"
@added(Versions.`2025-07-01-preview`)
@extension("additionalProperties", false)
model RegistryEndpointAnonymousSettings {}

/**
 * Artifact Pull Secret authentication
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointArtifactPullSecretAuthentication
  extends RegistryEndpointAuthentication {
  /**
   * The authentication method.
   */
  method: ArtifactPullSecret;

  /**
   * Artifact Pull Secret authentication properties
   */
  artifactPullSecretSettings: RegistryEndpointArtifactPullSecretSettings;
}

/**
 * RegistryEndpoint Artifact Pull Secret authentication properties
 */
@added(Versions.`2025-07-01-preview`)
model RegistryEndpointArtifactPullSecretSettings {
  /**
   * The name of the kubernetes secret that contains the artifact pull secret.
   */
  secretRef: string;
}
